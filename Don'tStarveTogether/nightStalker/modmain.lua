PrefabFiles = {
	"swilson",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/swilson.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/swilson.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/swilson.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/swilson.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/swilson_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/swilson_silho.xml" ),

    Asset( "IMAGE", "bigportraits/swilson.tex" ),
    Asset( "ATLAS", "bigportraits/swilson.xml" ),
	
	Asset( "IMAGE", "images/map_icons/swilson.tex" ),
	Asset( "ATLAS", "images/map_icons/swilson.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_swilson.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_swilson.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_swilson.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_swilson.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.swilson = "Loves to wear top-hats!"
STRINGS.CHARACTER_NAMES.swilson = "Swilson"
STRINGS.CHARACTER_DESCRIPTIONS.swilson = "*Minor Glow at Night\n*Stronger but Slower than the average Wilson\n*Upgradeable (WIP)"
STRINGS.CHARACTER_QUOTES.swilson = "\"I don't play nice with other Shadow Creatures.\""

-- Custom speech strings
STRINGS.CHARACTERS.SWILSON = require "speech_swilson"

-- The character's name as appears in-game 
STRINGS.NAMES.SWILSON = "Swilson"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SWILSON = 
{
	GENERIC = "It's a monster!",
	ATTACKER = "That monster is vicious!",
	MURDERER = "Just like a Shadow Creature to kill!",
	REVIVER = "Just because it saved someone, doesn't mean I trust it.",
	GHOST = "I'll revive it if it doesn't bite my head off.",
}

-- Let the game know character is male, female, or robot
table.insert(GLOBAL.CHARACTER_GENDERS.MALE, "swilson")


AddMinimapAtlas("images/map_icons/swilson.xml")
AddModCharacter("swilson")

