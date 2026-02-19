#!/usr/bin/env python3

"""
encode_mod.py: Base64-encode all Lua mod files in the current directory for BAR modding (URL-safe, no trailing '=')
Usage: python3 encode_mod.py
Outputs all encoded mods to the 'output' folder as <modname>.b64
"""
import os
import base64

MODS_DIR = os.path.dirname(os.path.abspath(__file__))
OUTPUT_DIR = os.path.join(MODS_DIR, 'output')
os.makedirs(OUTPUT_DIR, exist_ok=True)

for fname in os.listdir(MODS_DIR):
    if fname.endswith('.lua'):
        mod_path = os.path.join(MODS_DIR, fname)
        with open(mod_path, 'rb') as f:
            data = f.read()
        encoded = base64.urlsafe_b64encode(data).decode('ascii').rstrip('=')
        out_path = os.path.join(OUTPUT_DIR, fname.replace('.lua', '.b64'))
        with open(out_path, 'w') as out:
            out.write(encoded)
        print(f"Encoded {fname} -> {out_path}")
