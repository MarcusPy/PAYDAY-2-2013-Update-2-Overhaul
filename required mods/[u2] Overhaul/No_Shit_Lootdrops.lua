if RequiredScript == "lib/tweak_data/lootdroptweakdata" then
	-- remove junk from PAYDAY loot drop pool, leaving only cash and weapon mods
	local old_init = LootDropTweakData.init
	function LootDropTweakData:init( tweak_data, ... )
		old_init(self, tweak_data, ...)

		self.WEIGHTED_TYPE_CHANCE = {}
		local min = 10
		local max = 100

		local range = { 
			cash = {25, 25}, 
			weapon_mods = {75, 75}, 
			colors = {0, 0}, 
			textures = {0, 0}, 
			materials = {0, 0}, 
			masks = {0, 0} 
		}

		for i = min, max, 10 do
			local cash = math.lerp(range.cash[1], range.cash[2], i / max)
			local weapon_mods = math.lerp(range.weapon_mods[1], range.weapon_mods[2], i / max)
			local colors = math.lerp(range.colors[1], range.colors[2], i / max)
			local textures = math.lerp(range.textures[1], range.textures[2], i / max)
			local materials = math.lerp(range.materials[1], range.materials[2], i / max)
			local masks = math.lerp(range.masks[1], range.masks[2], i / max)
		
			self.WEIGHTED_TYPE_CHANCE[i] = { 
				cash = cash, 
				weapon_mods = weapon_mods, 
				colors = colors, 
				textures = textures, 
				materials = materials, 
				masks = masks 
			}
		end
	end
end

if RequiredScript == "lib/managers/lootdropmanager" then
	function LootDropManager:_setup_items()
		local pc_items = {}
		
		Global.lootdrop_manager.pc_items = pc_items
		
		local sort_pc = function( type, data )
			--log(type)
			for id,item_data in pairs( data ) do
				local dlcs = {} --item_data.dlcs or {}
				local dlc = true --item_data.dlc
				
				if dlc then
					table.insert( dlcs, dlc )
				end
				local has_dlc = true --#dlcs == 0
				for _, dlc in pairs( dlcs ) do
					has_dlc = has_dlc or managers.dlc:has_dlc( dlc )
				end
				
				if has_dlc then
					if item_data.pc then
						pc_items[ item_data.pc ] = pc_items[ item_data.pc ] or {}
						pc_items[ item_data.pc ][ type ] = pc_items[ item_data.pc ][ type ] or {}
						table.insert( pc_items[ item_data.pc ][ type ], id )
					end
					if item_data.pcs then
						for _,pc in ipairs( item_data.pcs ) do
							pc_items[ pc ] = pc_items[ pc ] or {}
							pc_items[ pc ][ type ] = pc_items[ pc ][ type ] or {}
							table.insert( pc_items[ pc ][ type ], id )
						end
					end
				end
			end
		end
		
		for type, data in pairs( tweak_data.blackmarket ) do
			if type == "weapon_mods" or type == "cash" then
				sort_pc( type, data )
			end
		end
	end
	
	function LootDropManager:_make_drop( debug, add_to_inventory, debug_stars, return_data )
		local human_players = managers.network:game() and managers.network:game():amount_of_alive_players() or 1
		local all_humans = human_players == 4
		local plvl = managers.experience:current_level()
		
		local stars = debug_stars or managers.job:current_job_stars() -- Get it from the JOB
			return_data = return_data or {}
			return_data.job_stars = stars
			return_data.player_level = plvl
		
		local difficulty = Global.game_settings.difficulty or "easy"
		local difficulty_id = math.max( 0, ( tweak_data:difficulty_to_index( difficulty ) or 0 ) - 2 )
		
		stars = stars + difficulty_id
		
		local player_stars = math.max( math.ceil( plvl / 10 ), 1 )
		
		difficulty_id = math.min( difficulty_id, stars - return_data.job_stars )
		stars = player_stars
		return_data.player_stars = player_stars
		return_data.difficulty_stars = difficulty_id
		return_data.total_stars = stars
		
		local pc = math.lerp( 0, 100, stars/10 )
		return_data.payclass = pc
		
		local drop_pc = stars * 10
		local pcs = tweak_data.lootdrop.STARS[ stars ].pcs
		
		if math.rand(1) <= tweak_data.lootdrop.joker_chance then
			pcs = deep_clone(pcs)
			for i=1, #pcs do
				local new_value = pcs[i] + math.random(5)*10 - 30
				if new_value >= 5 and new_value <= 100 then
					pcs[i] = new_value
				end
			end
			return_data.joker = true
		end
		local chance_risk_mod = tweak_data.lootdrop.risk_pc_multiplier[ difficulty_id ] or 0
		local chance_curve = tweak_data.lootdrop.STARS_CURVES[ stars ] -- - chance_risk_mod
		local start_chance = tweak_data.lootdrop.PC_CHANCE[ stars ] -- * ( tweak_data.lootdrop.risk_pc_multiplier[difficulty_id] or 1 )
		local no_pcs = #pcs
		local pc
		for i = 1, no_pcs do
			local chance = math.lerp( start_chance, 1, math.pow((i-1)/(no_pcs-1), chance_curve) )
			local roll = math.rand(1)
			if roll <= chance then
				pc = pcs[i]
					return_data.item_payclass = pc
				break
			end
		end
		
		local pc_items = self._global.pc_items[ pc ]
		
if pc_items == nil then
	log("pc_items is nil" .. tostring(pc))
	pc = 40
	pc_items = self._global.pc_items[pc]
end
		
		local i_pc_items = {}
		local weighted_type_chance = tweak_data.lootdrop.WEIGHTED_TYPE_CHANCE[ pc ]
		local sum = 0
		
		for type,items in pairs( pc_items ) do
			sum = sum + weighted_type_chance[ type ]
		end
		
		local normalized_chance = {}
		for type,items in pairs( pc_items ) do
			normalized_chance[ type ] = weighted_type_chance[ type ]/sum
		end

		local has_result
		while not has_result do
			local type_items = self:_get_type_items( normalized_chance, debug )	
			local items = pc_items[ type_items ]
			local item_entry = items[ math.random( #items ) ]
			
			local global_value = "normal"
			if not tweak_data.blackmarket[ type_items ][ item_entry ].qlvl or
				tweak_data.blackmarket[ type_items ][ item_entry ].qlvl <= plvl then		
				local global_value_chance = math.rand( 1 )
				local quality_mul = managers.player:upgrade_value( "player", "passive_loot_drop_multiplier", 1 ) * managers.player:upgrade_value( "player", "loot_drop_multiplier", 1 )
				if tweak_data.blackmarket[ type_items ][ item_entry ].infamous and 
					global_value_chance < tweak_data.lootdrop.global_values.infamous.chance*quality_mul then
					global_value = "infamous"
				else
					local dlcs = tweak_data.blackmarket[ type_items ][ item_entry ].dlcs or {}
					
					do
						local dlc = tweak_data.blackmarket[ type_items ][ item_entry ].dlc
						if dlc then
							table.insert( dlcs, dlc )
						end
					end
					
					local dlc_global_values = {}
					for _, dlc in pairs( dlcs ) do
						if managers.dlc:has_dlc( dlc ) then
							table.insert( dlc_global_values, dlc )
						end
					end			
					
					if #dlc_global_values > 0 then
						global_value = dlc_global_values[ math.random( #dlc_global_values ) ]
					end
				end
				
				if tweak_data.blackmarket[ type_items ][ item_entry ].max_in_inventory and managers.blackmarket:get_item_amount( global_value, type_items, item_entry ) >= tweak_data.blackmarket[ type_items ][ item_entry ].max_in_inventory then
				elseif not tweak_data.blackmarket[ type_items ][ item_entry ].infamous or global_value == "infamous" then
					has_result = true
					if add_to_inventory then
						if type_items == "cash" then
							managers.blackmarket:add_to_inventory( global_value, type_items, item_entry )
						else
							managers.blackmarket:add_to_inventory( global_value, type_items, item_entry )
						end
						return_data.global_value = global_value
						return_data.type_items = type_items
						return_data.item_entry = item_entry
					end
					return global_value, type_items, item_entry, pc
					
				end
			end
		end
	end
end