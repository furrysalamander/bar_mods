import streamlit as st
import os
import json
from builder import build_modpack
import streamlit.components.v1 as components

# Set absolute path for directory
MODS_DIR = "./mods"
COLLECTIONS_FILE = "./collections.json"

st.set_page_config(page_title="BAR Modpack Manager", layout="wide")

def inject_custom_css():
    st.markdown("""
        <style>
        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap');

        html, body, [class*="css"] {
            font-family: 'Outfit', sans-serif;
        }

        h1, h2, h3 {
            background: -webkit-linear-gradient(45deg, #6A7CA0, #4F8CFF);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800 !important;
            letter-spacing: -0.5px;
        }

        .stButton > button {
            background: linear-gradient(45deg, #4F8CFF, #6A7CA0) !important;
            color: #F3F6FB !important;
            border: none !important;
            border-radius: 8px !important;
            font-weight: 600 !important;
            transition: all 0.3s ease !important;
            box-shadow: 0 4px 15px rgba(76, 140, 255, 0.12) !important;
        }
        .stButton > button:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 6px 20px rgba(76, 140, 255, 0.22) !important;
            filter: brightness(1.04);
            color: #F3F6FB !important;
        }

        .stAlert {
            background: #23272F !important;
            color: #A0A8B8 !important;
            border-radius: 8px !important;
            box-shadow: none !important;
            border: 1px solid #2B2F38 !important;
        }
        .stAlert .stMarkdown {
            background: #23272F !important;
            color: #6A7CA0 !important;
        }
        </style>
    """, unsafe_allow_html=True)

inject_custom_css()

def load_collections():
    if os.path.exists(COLLECTIONS_FILE):
        try:
            with open(COLLECTIONS_FILE, "r") as f:
                data = json.load(f)
                return data
        except Exception:
            pass
    return {}

def save_collections(collections):
    with open(COLLECTIONS_FILE, "w") as f:
        json.dump(collections, f, indent=4)

def get_last_collection(collections):
    return collections.get("__last__", None)

def set_last_collection(collections, name):
    collections["__last__"] = name
    save_collections(collections)

def apply_collection(collections, name, lua_mods):
    """Apply a collection's selections to session state."""
    new_selections = {k: v for k, v in collections[name].items() if k != "__last__"}
    st.session_state.selections = new_selections
    for mod in lua_mods:
        val = new_selections.get(mod, "Off")
        st.session_state[f"enable_{mod}"] = val in ["Normal", "Test"]
        st.session_state[f"test_{mod}"] = val == "Test"

def get_lua_files():
    files = [f for f in os.listdir(MODS_DIR) if f.endswith(".lua") and not f.endswith("_test.lua") and "modpack.lua" not in f]
    return sorted(files)

# UI layout
st.title("Beyond All Reason - Modpack Manager")

lua_mods = get_lua_files()

# Initialization
if "collections" not in st.session_state:
    st.session_state.collections = load_collections()
if "selections" not in st.session_state:
    st.session_state.selections = {}
    last = get_last_collection(st.session_state.collections)
    collection_names_init = [k for k in st.session_state.collections.keys() if k != "__last__"]
    if last and last in collection_names_init:
        apply_collection(st.session_state.collections, last, lua_mods)
        st.session_state["active_collection"] = last

# Sidebar: Collections
st.sidebar.header("Collections")

collection_names = [k for k in st.session_state.collections.keys() if k != "__last__"]
active = st.session_state.get("active_collection", "<None>")
default_idx = 0 if active == "<None>" else (collection_names.index(active) + 1 if active in collection_names else 0)
selected_collection = st.sidebar.selectbox("Select Collection", ["<None>"] + collection_names, index=default_idx)

col1, col2, col3 = st.sidebar.columns(3)
with col1:
    if st.button("Load", use_container_width=True):
        if selected_collection != "<None>":
            apply_collection(st.session_state.collections, selected_collection, lua_mods)
            st.session_state["active_collection"] = selected_collection
            set_last_collection(st.session_state.collections, selected_collection)
            st.sidebar.success(f"Loaded '{selected_collection}'")
            st.rerun()

with col2:
    if st.button("Save", use_container_width=True):
        if selected_collection != "<None>":
            st.session_state.collections[selected_collection] = st.session_state.selections.copy()
            save_collections(st.session_state.collections)
            st.sidebar.success(f"Overwrote '{selected_collection}'")

with col3:
    if st.button("New", use_container_width=True):
        st.session_state.selections = {}
        for mod in lua_mods:
            st.session_state[f"enable_{mod}"] = False
            st.session_state[f"test_{mod}"] = False
        st.session_state["active_collection"] = "<None>"
        st.sidebar.success("Cleared — ready for a new modpack")
        st.rerun()

st.sidebar.divider()
st.sidebar.subheader("New Collection")
new_collection_name = st.sidebar.text_input("Name to Save")
if st.sidebar.button("Save as New", use_container_width=True):
    if new_collection_name:
        st.session_state.collections[new_collection_name] = st.session_state.selections.copy()
        save_collections(st.session_state.collections)
        st.session_state["active_collection"] = new_collection_name
        set_last_collection(st.session_state.collections, new_collection_name)
        st.sidebar.success(f"Saved collection '{new_collection_name}'")

st.sidebar.divider()
if st.sidebar.button("Build Modpack", use_container_width=True):
    st.session_state.pop("build_status", None)
    st.session_state.pop("build_b64", None)
    st.session_state.pop("build_error", None)
    st.session_state.pop("clipboard_js", None)
    
    mod_selections = {k: v for k, v in st.session_state.selections.items() if v in ["Normal", "Test"]}
    st.sidebar.info("Building modpack...")
    try:
        output_path = build_modpack(mod_selections)
        b64_path = output_path.replace(".lua", ".b64")
        st.session_state.build_status = f"Modpack built and encoded! Saved at: {output_path} (Output automatically copied to clipboard!)"
        if os.path.exists(b64_path):
            with open(b64_path, "r") as f:
                b64_data = f.read()
                st.session_state.build_b64 = b64_data
                st.session_state.clipboard_js = f"""
                <script>
                parent.navigator.clipboard.writeText(`!bset tweakdefs {b64_data}`);
                </script>
                """
    except Exception as e:
        st.session_state.build_error = f"Error building modpack: {e}"

# Main pane
if "build_status" in st.session_state:
    st.success(st.session_state.build_status)
    if "clipboard_js" in st.session_state:
        components.html(st.session_state.clipboard_js, height=0)
    if "build_b64" in st.session_state:
        st.text_area("Base64 Output (!bset tweakdefs ...)", value=f"!bset tweakdefs {st.session_state.build_b64}", height=150)
if "build_error" in st.session_state:
    st.error(st.session_state.build_error)

list_col, preview_col = st.columns([1, 1], gap="large")

with list_col:
    st.header("Mod List")

    cols = st.columns([6, 1.3, 1.5], gap="small")
    cols[0].write("**Mod Name**")
    cols[1].write("**Enable**")
    cols[2].write("**Test Mode**")

    for mod in lua_mods:
        cols = st.columns([6, 1.3, 1.5], gap="small")
        
        if cols[0].button(mod, key=f"preview_btn_{mod}", use_container_width=True):
            st.session_state.preview_mod = mod
            
        enabled_key = f"enable_{mod}"
        test_key = f"test_{mod}"
        
        current_val = st.session_state.selections.get(mod, "Off")
        if enabled_key not in st.session_state:
            st.session_state[enabled_key] = current_val in ["Normal", "Test"]
        if test_key not in st.session_state:
            st.session_state[test_key] = current_val == "Test"
            
        is_enabled = cols[1].toggle("Enable", key=enabled_key, label_visibility="collapsed")
        is_test = cols[2].checkbox("Test Mode", key=test_key, disabled=not is_enabled, label_visibility="collapsed")
        
        if is_enabled:
            st.session_state.selections[mod] = "Test" if is_test else "Normal"
        else:
            st.session_state.selections[mod] = "Off"

with preview_col:
    if "preview_mod" in st.session_state:
        mod = st.session_state.preview_mod
        st.header(f"Preview: {mod}")
        try:
            with open(os.path.join(MODS_DIR, mod), "r") as f:
                code = f.read()
            st.code(code, language="lua")
        except Exception as e:
            st.error(f"Error loading file: {e}")
    else:
        st.header("Preview")
        st.info("Click a mod in the list to preview its code here.")
