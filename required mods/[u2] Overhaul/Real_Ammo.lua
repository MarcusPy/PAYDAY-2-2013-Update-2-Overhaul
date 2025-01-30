local set_teammate_ammo_amount_original = HUDManager.set_teammate_ammo_amount
function HUDManager:set_teammate_ammo_amount(id, selection_index, max_clip, current_clip, current_left, max)
	if id == 4 then
		return set_teammate_ammo_amount_original(self, id, selection_index, max_clip, current_clip, math.max(current_left - current_clip, 0), math.max(current_left - current_clip, 0))
	else
		return set_teammate_ammo_amount_original(self, id, selection_index, max_clip, current_clip, current_left, max)
	end
end