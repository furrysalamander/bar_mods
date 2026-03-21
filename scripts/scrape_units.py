import os
import time
import requests
import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse
from collections import defaultdict

BASE_URL = "https://www.beyondallreason.info"
SITEMAP_URL = f"{BASE_URL}/sitemap.xml"
OUTPUT_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "data", "units")

def get_soup(url):
    response = requests.get(url, headers={'User-Agent': 'Mozilla/5.0 (Bot)'})
    response.raise_for_status()
    # Be polite
    time.sleep(0.1)
    return BeautifulSoup(response.content, 'html.parser')

def fetch_sitemap_urls():
    print(f"Fetching sitemap {SITEMAP_URL}...")
    response = requests.get(SITEMAP_URL)
    response.raise_for_status()
    
    root = ET.fromstring(response.content)
    # XML namespaces usually apply
    namespace = {'ns': 'http://www.sitemaps.org/schemas/sitemap/0.9'}
    urls = []
    
    for url in root.findall('ns:url', namespace):
        loc = url.find('ns:loc', namespace)
        if loc is not None:
            urls.append(loc.text)
            
    # Fallback if no namespace
    if not urls:
        for url in root.findall('{http://www.sitemaps.org/schemas/sitemap/0.9}url'):
            loc = url.find('{http://www.sitemaps.org/schemas/sitemap/0.9}loc')
            if loc is not None:
                urls.append(loc.text)
                
    return urls

def discover_units(all_urls):
    """
    Finds all category pages and maps unit URLs to their faction and category.
    Returns: { unit_url: {'faction': str, 'category': str} }
    """
    category_pages = [u for u in all_urls if '/units/' in u and '-page=' not in u and '_page=' not in u]
    unit_mapping = {}
    
    for cat_url in category_pages:
        # e.g., https://.../units/armada-bots
        parts = cat_url.split('/')[-1].split('-')
        if len(parts) >= 2:
            faction = parts[0]
            category = "-".join(parts[1:])
        else:
            continue
            
        print(f"Discovering units in {faction}/{category}...")
        try:
            soup = get_soup(cat_url)
            # Find all links to units
            for a in soup.find_all('a', href=True):
                href = a['href']
                if href.startswith('/unit/'):
                    full_url = urljoin(BASE_URL, href)
                    # Base unit URL without query parameters
                    full_url = full_url.split('?')[0]
                    if full_url not in unit_mapping:
                        unit_mapping[full_url] = {'faction': faction, 'category': category}
        except Exception as e:
            print(f"Failed to process category {cat_url}: {e}")
            
    # Also add any orphaned units found in sitemap
    unit_pages = [u for u in all_urls if '/unit/' in u and '?' not in u]
    for u in unit_pages:
        if u not in unit_mapping:
            unit_id = u.split('/')[-1]
            faction = 'unknown'
            if unit_id.startswith('arm'): faction = 'armada'
            elif unit_id.startswith('cor'): faction = 'cortex'
            elif unit_id.startswith('leg'): faction = 'legion'
            unit_mapping[u] = {'faction': faction, 'category': 'uncategorized'}
            
    return unit_mapping

def scrape_unit(url, metadata):
    try:
        soup = get_soup(url)
        unit_data = metadata.copy()
        
        # Name
        name_el = soup.select_one('h1.us-unitname')
        unit_data['name'] = name_el.text.strip() if name_el else url.split('/')[-1]
        
        # Subtitle
        subtitle_el = soup.select_one('div.us-text')
        unit_data['subtitle'] = subtitle_el.text.strip() if subtitle_el else ''
        
        # Tier
        tier_el = soup.select_one('div.unit-special.techlevel')
        unit_data['tier'] = tier_el.text.strip() if tier_el else ''
        
        # Stats
        stats = {}
        for item in soup.select('div.us-stats-item'):
            name_el = item.select_one('div.us-stats-name')
            if name_el:
                name = name_el.text.strip()
                # Get the whole text and remove the name part, or get next sibling text
                full_text = item.text.strip()
                val = full_text[len(name):].strip()
                stats[name] = val
        unit_data['stats'] = stats
        
        # Lore / Description
        lore_section = soup.select_one('div.section.bg.extratop')
        if lore_section:
            # Get text from paragraphs
            paragraphs = [p.text.strip() for p in lore_section.find_all('p') if p.text.strip()]
            unit_data['description'] = "\n\n".join(paragraphs)
        else:
            unit_data['description'] = ""
            
        # Ordnance / Weapons
        weapons = []
        for w_heading in soup.select('div.weapon-name-text'):
            weapon_name = w_heading.text.strip()
            # The structure might be a sibling grid
            w_stats = {}
            parent = w_heading.parent
            if parent:
                # Naive text extraction for weapon stats
                # Try to find table-like divs or just sibling text
                # We'll just grab the next element if it contains text
                next_el = parent.find_next_sibling()
                if next_el:
                    w_stats['raw_details'] = " ".join(next_el.stripped_strings)
            weapons.append({'name': weapon_name, 'stats': w_stats})
        unit_data['weapons'] = weapons
        
        # Counterparts
        counterparts = []
        for a in soup.select('a[href^="/unit/"]'):
            href = a['href']
            # Ignore self-links or irrelevant links
            if href not in url:
                counterparts.append(href)
        # Deduplicate while preserving order
        unit_data['counterparts'] = list(dict.fromkeys(counterparts))
        
        return unit_data
    except Exception as e:
        print(f"Error scraping {url}: {e}")
        return None

def write_markdown(unit_data, unit_id):
    faction = unit_data['faction']
    category = unit_data['category']
    
    dir_path = os.path.join(OUTPUT_DIR, faction, category)
    os.makedirs(dir_path, exist_ok=True)
    
    filepath = os.path.join(dir_path, f"{unit_id}.md")
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(f"# {unit_data['name']}\n")
        f.write(f"> {unit_data['subtitle']}\n\n")
        f.write(f"**Faction:** {faction.capitalize()} | **Category:** {category.capitalize()} | **Tier:** {unit_data['tier']}\n\n")
        
        f.write("## Stats\n")
        f.write("| Stat | Value |\n")
        f.write("|------|-------|\n")
        for k, v in unit_data.get('stats', {}).items():
            f.write(f"| {k} | {v} |\n")
            
        if unit_data.get('weapons'):
            f.write("\n## Weapons\n")
            for w in unit_data['weapons']:
                f.write(f"### {w['name']}\n")
                if 'raw_details' in w['stats']:
                    f.write(f"{w['stats']['raw_details']}\n")
                    
        desc = unit_data.get('description', '')
        if desc:
            f.write(f"\n## Description\n{desc}\n")
            
        counterparts = unit_data.get('counterparts', [])
        if counterparts:
            f.write("\n## Related Units\n")
            for cp in counterparts:
                cp_id = cp.split('/')[-1]
                f.write(f"- [{cp_id}]({cp})\n")

def main():
    print("Starting BAR unit scraper...")
    urls = fetch_sitemap_urls()
    print(f"Found {len(urls)} URLs in sitemap.")
    
    mapping = discover_units(urls)
    print(f"Mapped {len(mapping)} unit URLs.")
    
    for i, (url, metadata) in enumerate(mapping.items(), 1):
        unit_id = url.split('/')[-1]
        print(f"({i}/{len(mapping)}) Scraping {unit_id} ({metadata['faction']}/{metadata['category']})...")
        data = scrape_unit(url, metadata)
        if data:
            write_markdown(data, unit_id)
            
    print(f"Finished. Data saved to {OUTPUT_DIR}")

if __name__ == "__main__":
    main()
