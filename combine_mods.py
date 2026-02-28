#!/usr/bin/env python3

import sys
import os

def main():
    if len(sys.argv) < 3:
        print("Usage: python3 combine_mods.py <output_mod.lua> <input1.lua> <input2.lua> ...")
        sys.exit(1)
        
    output_file = sys.argv[1]
    input_files = sys.argv[2:]
    
    combined_content = ""
    
    for fpath in input_files:
        if not os.path.exists(fpath):
            print(f"Error: {fpath} does not exist.")
            sys.exit(1)
            
        with open(fpath, 'r') as f:
            content = f.read()
            
        combined_content += "--" + "="*40 + "\n"
        combined_content += f"-- Source Mod: {os.path.basename(fpath)}\n"
        combined_content += "--" + "="*40 + "\n"
        # Wrap each script in a do ... end block to prevent local variable collisions
        combined_content += "do\n"
        combined_content += content
        combined_content += "\nend\n\n"
        
    with open(output_file, 'w') as f:
        f.write(combined_content)
        
    print(f"Successfully combined {len(input_files)} mods into {output_file}")

if __name__ == "__main__":
    main()
