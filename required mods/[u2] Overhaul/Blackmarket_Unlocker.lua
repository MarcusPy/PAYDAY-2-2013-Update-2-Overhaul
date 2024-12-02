function BlackMarketManager:init()
	self:_setup()
	--self:unlock_all_weapons()
end

-- unlock all guns except saw
function BlackMarketManager:unlock_all_weapons()
	local function check(weapon)
		if weapon == "saw" then
			if managers.player:has_category_upgrade( "saw", "portable_saw" ) then
				return true
			else
				return false
			end
		else
			return true
		end
	end
	
	local weapons = {}
	Global.blackmarket_manager.weapons = weapons
	for weapon,data in pairs( tweak_data.weapon ) do
		if data.autohit then
			local selection_index = data.use_data.selection_index
			local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id( weapon )
			weapons[ weapon ] = { owned = false, unlocked = check(weapon), factory_id = factory_id, selection_index = selection_index }
		end
	end
end
