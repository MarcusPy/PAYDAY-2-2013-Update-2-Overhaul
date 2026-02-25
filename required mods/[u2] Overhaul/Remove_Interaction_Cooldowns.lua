local old_check_use = PlayerStandard._check_use_item
function PlayerStandard:_check_use_item(t, input)
	if input.btn_use_item_release and self._throw_time and t and t < self._throw_time then
		managers.player:drop_carry()
		self._throw_time = nil
		return true
	else return old_check_use(self, t, input) 
	end
end

if _G.u2_core.settings.gameplay.lose_remaining_clip_ammo then
	local old_PlayerStandard__start_action_reload = PlayerStandard._start_action_reload
	function PlayerStandard:_start_action_reload( t, ... )
		local weapon = self._equipped_unit:base()
		if weapon and weapon:can_reload() and not self:_is_reloading() and weapon:weapon_tweak_data()["name_id"] ~= "bm_w_r870" and weapon:weapon_tweak_data()["name_id"] ~= "bm_w_serbu" then --weapon:weapon_tweak_data()["category"] ~= "shotgun" then
			local ammo_mag_left = weapon:get_ammo_remaining_in_clip()
			local ammo_total_left = weapon:get_ammo_total()
			if ammo_mag_left >= 1 then
				weapon:set_ammo_total(1 + ammo_total_left - ammo_mag_left)
				weapon:set_ammo_remaining_in_clip(1)
			end
		end
		old_PlayerStandard__start_action_reload(self, t, ...)
	end
end

if _G.u2_core.settings.gameplay.no_headbob then
	function PlayerStandard:_get_walk_headbob()
		return 0
	end
end