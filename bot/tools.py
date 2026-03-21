"""Tool definitions for the Discord bot's LLM function-calling interface.

Each tool is defined in OpenAI-compatible function-calling JSON schema format.
These are sent to the llama.cpp server so the LLM can decide which action to take.
"""

TOOLS = [
    {
        "type": "function",
        "function": {
            "name": "clarify_request",
            "description": (
                "Ask the user a clarifying question before generating a mod. "
                "Use this when the request is too vague — e.g. the user says "
                "'make a cool unit' without specifying what kind."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "question": {
                        "type": "string",
                        "description": "The clarifying question to ask the user.",
                    },
                },
                "required": ["question"],
                "additionalProperties": False,
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "generate_mod",
            "description": (
                "Start a new opencode session to generate a BAR mod from a "
                "description. Use this once you have a clear understanding "
                "of what the user wants. Pass the user's request as "
                "literally as possible — do NOT decide whether to clone or "
                "modify in-place, and do NOT invent specific unit names the "
                "user didn't say. The coding agent has full access to the "
                "game source and modding guide and will make those decisions."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "prompt": {
                        "type": "string",
                        "description": (
                            "The user's mod request, relayed as literally as "
                            "possible. Describe what the user wants changed or "
                            "created without interpreting unit names or deciding "
                            "implementation approach (clone vs modify). The "
                            "coding agent will determine the right approach."
                        ),
                    },
                    "filename": {
                        "type": "string",
                        "description": (
                            "The filename for the generated mod (e.g. 'mega_tank.lua'). "
                            "Must end in .lua."
                        ),
                    },
                },
                "required": ["prompt", "filename"],
                "additionalProperties": False,
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "refine_mod",
            "description": (
                "Send a follow-up message to an existing opencode session to "
                "refine or fix a previously generated mod. Use this when the user "
                "reports a bug, wants a tweak, or when the first attempt needs "
                "adjustment."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "session_id": {
                        "type": "string",
                        "description": "The opencode session ID to continue.",
                    },
                    "feedback": {
                        "type": "string",
                        "description": (
                            "The refinement instructions — what to fix or change "
                            "about the previously generated mod."
                        ),
                    },
                },
                "required": ["session_id", "feedback"],
                "additionalProperties": False,
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "build_modpack",
            "description": (
                "Build a base64-encoded modpack string from selected mods, "
                "ready for in-game use with !bset tweakdefs. Can build a single "
                "mod or combine multiple mods. Each mod can be in Normal or Test mode."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "mods": {
                        "type": "object",
                        "description": (
                            "A mapping of mod filenames to their mode. "
                            "Example: {\"mega_tank.lua\": \"Test\", \"epic_radars.lua\": \"Normal\"}"
                        ),
                        "additionalProperties": {
                            "type": "string",
                            "enum": ["Normal", "Test"],
                        },
                    },
                    "message": {
                        "type": "string",
                        "description": (
                            "Optional message to send alongside the modpack delivery. "
                            "Use this to describe what the mod does, how to use it, "
                            "or any other helpful context for the user."
                        ),
                    },
                },
                "required": ["mods"],
                "additionalProperties": False,
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "list_mods",
            "description": (
                "List all available mods in the mods directory. Returns the "
                "filenames of all .lua mod files."
            ),
            "parameters": {
                "type": "object",
                "properties": {},
                "additionalProperties": False,
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "respond",
            "description": (
                "Send a plain text response to the user. Use this for greetings, "
                "help messages, status updates, or when no tool action is needed."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "message": {
                        "type": "string",
                        "description": "The message to send to the user.",
                    },
                },
                "required": ["message"],
                "additionalProperties": False,
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "search_units",
            "description": (
                "Search the BAR unit database for unit stats, descriptions, "
                "and details. Use this to answer questions about units, find "
                "the right unit to base a mod on, compare units, or look up "
                "stats like health, speed, DPS, range, and cost. "
                "Searches by unit name, ID, faction (armada/cortex/legion), "
                "or category (bots/vehicles/aircraft/ships/buildings/etc)."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "query": {
                        "type": "string",
                        "description": (
                            "A unit name, ID, faction, category, or keyword to "
                            "search for. Examples: 'pawn', 'armcom', 'cortex bots', "
                            "'t2 artillery', 'commander'."
                        ),
                    },
                },
                "required": ["query"],
                "additionalProperties": False,
            },
        },
    },
]
