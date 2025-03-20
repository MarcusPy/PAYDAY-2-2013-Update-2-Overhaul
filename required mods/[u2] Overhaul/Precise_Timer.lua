if RequiredScript == "lib/managers/hud/hudheisttimer" then
	function HUDHeistTimer:set_time(time)
		--[[local inverted = false

		if time < 0 then
			inverted = true
			time = math.abs(time)
		end

		if not self._enabled or not inverted and time < self._last_time then
			return
		end]]

		self._last_time = time

		local hours = math.floor(time / 3600)
		time = time - hours * 3600
				
		local minutes = math.floor(time / 60)
		time = time - minutes * 60
		
		local text = hours > 0 and (hours < 10 and "0" .. hours or hours) .. ":" or "" .. string.format("%02d:%05.2f", minutes, time)
		self._timer_text:set_text(text)
		
		--local text = hours > 0 and (hours < 10 and "0" .. hours or hours) .. ":" or "" .. string.format("%02d:%04.1f", minutes, time)
		--self._timer_text:set_text(text)
	end
end