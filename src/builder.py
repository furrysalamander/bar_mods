import re
import os
import subprocess

MODS_DIR = "./mods"
OUTPUT_DIR = "./output"

test_injection_logic = """
    -- Test Mode Injection
    if MOD_ADDED_UNITS then
        for _, unit_name in ipairs(MOD_ADDED_UNITS) do
            local u = UnitDefs[unit_name]
            if u then
                u.metalcost = 1
                u.energycost = 1
                u.buildtime = 1
            end
        end
        for name, ud in pairs(UnitDefs) do
            if name:find("^armcom") or name:find("^corcom") or name:find("^legcom") then
                if ud.buildoptions then
                    for _, unit_name in ipairs(MOD_ADDED_UNITS) do
                        local already_added = false
                        for i, opt in ipairs(ud.buildoptions) do
                            if opt == unit_name then
                                already_added = true
                                break
                            end
                        end
                        if not already_added then
                            table.insert(ud.buildoptions, unit_name)
                        end
                    end
                end
            end
        end
    end
"""

def build_modpack(mod_selections):
    """
    mod_selections: dict of { filename: "Normal" | "Test" }
    """
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    combined_content = ""
    
    for filename, mode in mod_selections.items():
        filepath = os.path.join(MODS_DIR, filename)
        if not os.path.exists(filepath):
            continue
            
        with open(filepath, 'r') as f:
            content = f.read()
            
        combined_content += "--" + "="*40 + "\n"
        combined_content += f"-- Source Mod: {filename} (Mode: {mode})\n"
        combined_content += "--" + "="*40 + "\n"
        combined_content += "do\n"
        combined_content += "    local MOD_ADDED_UNITS = {}\n"
        combined_content += content
        
        if mode == "Test":
            combined_content += test_injection_logic
            
        combined_content += "\nend\n\n"
        
    output_lua = os.path.join(OUTPUT_DIR, "modpack.lua")
    with open(output_lua, 'w') as f:
        f.write(combined_content)
        
    import base64
    with open(output_lua, "rb") as f:
        data = f.read()
    encoded = base64.urlsafe_b64encode(data).decode('ascii').rstrip('=')
    output_b64 = os.path.join(OUTPUT_DIR, "modpack.b64")
    with open(output_b64, "w") as out:
        out.write(encoded)
    
    return output_lua

