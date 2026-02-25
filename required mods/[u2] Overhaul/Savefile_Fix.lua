SavefileManager.SETTING_SLOT = 2
SavefileManager.PROGRESS_SLOT = SystemInfo:platform() == Idstring("WIN32") and 2


function SavefileManager:clbk_result_iterate_savegame_slots(task_data, result_data)
	print("[SavefileManager:clbk_result_iterate_savegame_slots]", inspect(task_data), inspect(result_data))
	if not self:_on_task_completed(task_data) then
		return
	end
	self._save_slots_to_load = {}
	local found_progress_slot
	if type_name(result_data) == "table" then
		for slot, slot_data in pairs(result_data) do
			print("slot:", slot, "\n", inspect(slot_data))
			if slot == self.SETTING_SLOT then
				self._save_slots_to_load[slot] = true
				self:load_settings()
			elseif slot == self.PROGRESS_SLOT then
				self._save_slots_to_load[slot] = true
				found_progress_slot = true
				self:load_progress()
			end
		end
	else
		Application:error("[SavefileManager:clbk_result_iterate_savegame_slots] error:", result_data)
	end
	if not found_progress_slot and self._backup_data then
		self._save_slots_to_load[self.PROGRESS_SLOT] = true
		self:_ask_load_backup("no_progress", true)
	end
end

function SavefileManager:is_in_loading_sequence()
    return false
end