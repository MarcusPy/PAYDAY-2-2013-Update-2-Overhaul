function CopDamage:drop_pickup()
	if self._pickup then
		local tracker = self._unit:movement():nav_tracker()
		local position = tracker:lost() and tracker:field_position() or tracker:position()
		local rotation = self._unit:rotation()
		--managers.game_play_central:spawn_pickup( { name = self._pickup, position = position, rotation = rotation } )

		local chance_to_spawn = math.random(1,100)
		if chance_to_spawn == 69 then
			local unit_name = "units/payday2/equipment/gen_equipment_ammobag/gen_equipment_ammobag"
			local unit = World:spawn_unit( Idstring( unit_name ), position, rotation )
			managers.network:session():send_to_peers_synched( "sync_ammo_bag_setup", unit, 0 )
			unit:base():setup( 0 )
		end
	end
end