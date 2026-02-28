import streamlit as st
import os
import json
from builder import build_modpack

# Set absolute path for directory
MODS_DIR = "/home/mike/source/bar_mods"
COLLECTIONS_FILE = os.path.join(MODS_DIR, "collections.json")

st.set_page_config(page_title="BAR Modpack Manager", layout="wide")

def load_collections():
    if os.path.exists(COLLECTIONS_FILE):
        try:
            with open(COLLECTIONS_FILE, "r") as f:
                return json.load(f)
        except Exception:
            pass
    return {}

def save_collections(collections):
    with open(COLLECTIONS_FILE, "w") as f:
        json.dump(collections, f, indent=4)

def get_lua_files():
    files = [f for f in os.listdir(MODS_DIR) if f.endswith(".lua") and not f.endswith("_test.lua") and "modpack.lua" not in f]
    return sorted(files)

# UI layout
st.title("Beyond All Reason - Modpack Manager")

# Initialization
if "collections" not in st.session_state:
    st.session_state.collections = load_collections()
if "selections" not in st.session_state:
    st.session_state.selections = {}

lua_mods = get_lua_files()

# Sidebar: Collections
st.sidebar.header("Collections")

collection_names = list(st.session_state.collections.keys())
selected_collection = st.sidebar.selectbox("Load Collection", ["<None>"] + collection_names)

if st.sidebar.button("Load"):
    if selected_collection != "<None>":
        new_selections = st.session_state.collections[selected_collection].copy()
        st.session_state.selections = new_selections
        for mod in lua_mods:
            val = new_selections.get(mod, "Off")
            st.session_state[f"radio_{mod}"] = val
        st.sidebar.success(f"Loaded '{selected_collection}'")
        st.rerun()

new_collection_name = st.sidebar.text_input("Name to Save")
if st.sidebar.button("Save Current Selection"):
    if new_collection_name:
        st.session_state.collections[new_collection_name] = st.session_state.selections.copy()
        save_collections(st.session_state.collections)
        st.sidebar.success(f"Saved collection '{new_collection_name}'")

st.sidebar.divider()
if st.sidebar.button("Build Modpack"):
    st.session_state.pop("build_status", None)
    st.session_state.pop("build_b64", None)
    st.session_state.pop("build_error", None)
    
    mod_selections = {k: v for k, v in st.session_state.selections.items() if v in ["Normal", "Test"]}
    st.sidebar.info("Building modpack...")
    try:
        output_path = build_modpack(mod_selections)
        b64_path = output_path.replace(".lua", ".b64")
        st.session_state.build_status = f"Modpack built and encoded! Saved at: {output_path}"
        if os.path.exists(b64_path):
            with open(b64_path, "r") as f:
                st.session_state.build_b64 = f.read()
    except Exception as e:
        st.session_state.build_error = f"Error building modpack: {e}"

# Main pane
if "build_status" in st.session_state:
    st.success(st.session_state.build_status)
    if "build_b64" in st.session_state:
        st.text_area("Base64 Output (!bset tweakdefs ...)", value=f"!bset tweakdefs {st.session_state.build_b64}", height=150)
if "build_error" in st.session_state:
    st.error(st.session_state.build_error)

st.header("Mod List")

cols = st.columns([3, 2, 1])
cols[0].write("**Mod Name**")
cols[1].write("**Mode**")
cols[2].write("**Preview**")

for mod in lua_mods:
    cols = st.columns([3, 2, 1])
    cols[0].write(mod)
    
    # Initialize session state for radio if it doesn't exist
    radio_key = f"radio_{mod}"
    if radio_key not in st.session_state:
        st.session_state[radio_key] = st.session_state.selections.get(mod, "Off")
        
    mode = cols[1].radio(
        f"Mode for {mod}", 
        options=["Off", "Normal", "Test"], 
        key=radio_key, 
        horizontal=True,
        label_visibility="collapsed"
    )
    st.session_state.selections[mod] = mode
    
    if cols[2].button("View", key=f"view_{mod}"):
        st.session_state.preview_mod = mod

if "preview_mod" in st.session_state:
    st.divider()
    mod = st.session_state.preview_mod
    st.subheader(f"Preview: {mod}")
    try:
        with open(os.path.join(MODS_DIR, mod), "r") as f:
            code = f.read()
        st.code(code, language="lua")
    except Exception as e:
        st.error(f"Error loading file: {e}")
