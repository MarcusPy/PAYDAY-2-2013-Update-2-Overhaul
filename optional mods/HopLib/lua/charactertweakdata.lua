-- Custom maps often break the character_map, need to be safe when adding to it
local logged_error
local function safe_add(char_map_table, element)
	if not char_map_table or not char_map_table.list then
		if not logged_error then
			logged_error = true
			log("[HopLib] WARNING: CharacterTweakData:character_map has missing data! One of your mods uses outdated code, check for mods overriding this function!")
		end
		return
	end
	table.insert(char_map_table.list, element)
end