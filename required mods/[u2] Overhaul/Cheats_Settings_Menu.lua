_G.u2_cheats = _G.u2_cheats or {
    unlock_all_items = nil,
    unlock_items_category = nil,
    get_global_value = nil
}

Hooks:Add("LocalizationManagerPostInit", "CheatsMenuStrings", function(loc)
	LocalizationManager:add_localized_strings( {
		["cheats_menu_title"]  = "Cheats Menu",
		["addMaskItems_title"] = "Unlock All Mask Items",
		["addAllItems_title"]  = "Unlock All Items",
	} )
end)



u2_cheats.unlock_all_items = function()
	local types = { "weapon_mods", "masks", "materials", "textures", "colors" }
	for _, item_type in pairs( types ) do
		u2_cheats.unlock_items_category( item_type )
	end
end

u2_cheats.unlock_items_category = function( item_type )
	for id, data in pairs( tweak_data.blackmarket[ item_type ] ) do
		if data.infamy_lock then
			data.infamy_lock = false
		end
		
		local global_value = u2_cheats.get_global_value( data )
		managers.blackmarket:add_to_inventory( global_value, item_type, id )
	end
end

u2_cheats.get_global_value = function( data )
	if data.global_value then
		return data.global_value
	elseif data.infamous then
		return "infamous"
	elseif data.dlcs or data.dlc then
		local dlcs = data.dlcs or {}
		
		if data.dlc then 
			table.insert( dlcs, data.dlc )
		end
		
		return dlcs[ math.random( #dlcs ) ]
	else
		return "normal"
	end
end
