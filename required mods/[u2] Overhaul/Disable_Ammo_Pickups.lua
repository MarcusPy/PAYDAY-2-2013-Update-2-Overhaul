-- ammo drops have a low chance of dropping, but there is a 1% chance an ammo bag is dropped instead with a cooldown of 10 method invokation

if _G.u2_core.settings.gameplay.ammo_pickup_changes then
	function CopDamage:drop_pickup()
		--self.until_bag_can_spawn = self.until_bag_can_spawn or 25
		if self._pickup then
			--log(self.until_bag_can_spawn)
			local tracker = self._unit:movement():nav_tracker()
			local position = tracker:lost() and tracker:field_position() or tracker:position()
			local rotation = self._unit:rotation()

			local chance_to_spawn = math.random(1,100)
			--log(chance_to_spawn)
			if chance_to_spawn == 69 then --and until_bag_can_spawn == 0 then
				local unit_name = "units/payday2/equipment/gen_equipment_ammobag/gen_equipment_ammobag"
				local unit = World:spawn_unit( Idstring( unit_name ), position, rotation )
				managers.network:session():send_to_peers_synched( "sync_ammo_bag_setup", unit, 0 )
				unit:base():setup( 0 )
				--self.until_bag_can_spawn = 25
			elseif chance_to_spawn > 80 then
				managers.game_play_central:spawn_pickup( { name = self._pickup, position = position, rotation = rotation } )
			end
			--self.until_bag_can_spawn = math.max(self.until_bag_can_spawn - 1, 0)
		end
	end
end