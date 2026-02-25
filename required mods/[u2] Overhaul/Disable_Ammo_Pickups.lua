if RequiredScript == "lib/units/enemies/cop/copdamage" and _G.u2_core.settings.gameplay.ammo_pickup_changes then
	_G.kills_req = _G.kills_req or 75
	function CopDamage:drop_pickup()
		if not self._pickup then return end
		
		local tracker = self._unit:movement():nav_tracker()
		local position = tracker:lost() and tracker:field_position() or tracker:position()
		local rotation = self._unit:rotation()

		local chance_to_spawn = math.random(1, 10)

		if _G.kills_req <= 0 then
			local unit_name = "units/payday2/equipment/gen_equipment_ammobag/gen_equipment_ammobag"
			local unit = World:spawn_unit(Idstring(unit_name), position, rotation)
			managers.network:session():send_to_peers_synched("sync_ammo_bag_setup", unit, 0)
			unit:base():setup(0, Global.game_settings.single_player and 2 or 1) --solo gets 2 refills (50% ammo bag), online only 1
			_G.kills_req = 75
			return
		elseif chance_to_spawn == 10 then
			managers.game_play_central:spawn_pickup({ name = self._pickup, position = position, rotation = rotation })
		end

		_G.kills_req = _G.kills_req - 1
	end
end

if RequiredScript == "lib/units/equipment/ammo_bag/ammobagbase" then
	function AmmoBagBase:setup( ammo_upgrade_lvl, amount )
		self._ammo_amount = amount or (tweak_data.upgrades.ammo_bag_base + managers.player:upgrade_value_by_level( "ammo_bag", "ammo_increase", ammo_upgrade_lvl ))
			
		self:_set_visual_stage()  
		
		if Network:is_server() then
			local from_pos = self._unit:position() + self._unit:rotation():z() * 10
			local to_pos = self._unit:position() + self._unit:rotation():z() * -10
			local ray = self._unit:raycast( "ray", from_pos, to_pos, "slot_mask", managers.slot:get_mask( "world_geometry" ) )
			if ray then
				self._attached_data = {}
				self._attached_data.body = ray.body
				self._attached_data.position = ray.body:position()
				self._attached_data.rotation = ray.body:rotation()
				self._attached_data.index = 1
				self._attached_data.max_index = 3
				
				self._unit:set_extension_update_enabled( Idstring( "base" ), true )
			end
		end
	end
end