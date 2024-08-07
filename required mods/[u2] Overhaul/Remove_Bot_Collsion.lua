local init_original = RaycastWeaponBase.init
local setup_original = RaycastWeaponBase.setup

function RaycastWeaponBase:init(...)
	init_original(self, ...)
	self._bullet_slotmask = self._bullet_slotmask - World:make_slot_mask(16)
end

function RaycastWeaponBase:setup(...)
	setup_original(self, ...)
	self._bullet_slotmask = self._bullet_slotmask - World:make_slot_mask(16)
end

-- extra step to make sure ammo pickups dont trigger
function RaycastWeaponBase:add_ammo()	
	return false
end

-- make this a skill, gives the user a moderate chance not to spend the round he has just fired
function RaycastWeaponBase:fire( from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit )
	
	if not managers.player:has_activate_temporary_upgrade( "temporary", "no_ammo_cost" ) then
		if self:get_ammo_remaining_in_clip() == 0 then	-- clip is empty. cannot fire
			return
		end
		
		local chance_to_spawn = math.random(1,5)
		if chance_to_spawn ~= 5 then
			self:set_ammo_remaining_in_clip( self:get_ammo_remaining_in_clip() - 1 )
			self:set_ammo_total( self:get_ammo_total() - 1 )
		end
	end
		
	local user_unit = self._setup.user_unit
	self:_check_ammo_total( user_unit )
	
	if alive( self._obj_fire ) then	
		World:effect_manager():spawn( self._muzzle_effect_table ) -- , normal = col_ray.normal } )
	end 
		
	if self._use_shell_ejection_effect then
		World:effect_manager():spawn( self._shell_ejection_effect_table )
	end
	
	local ray_res = self:_fire_raycast( user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul, target_unit )
	if self._alert_events and ray_res.rays then
		self:_check_alert( ray_res.rays, from_pos, direction, user_unit )
	end
	
	if ray_res.enemies_in_cone then
		for enemy_data, dis_error in pairs( ray_res.enemies_in_cone ) do
			if not enemy_data.unit:movement():cool() then -- cannot suppress ppl who have no idea that there is combat
				enemy_data.unit:character_damage():build_suppression( suppr_mul * dis_error * self._suppression )
			end
		end
	end
	
	return ray_res
end