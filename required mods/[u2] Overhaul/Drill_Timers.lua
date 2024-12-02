-- maybe change more drills?
function TimerGui:start( timer )
	timer = (self._override_timer or timer) * (self._timer_multiplier or 1)
	if self._jammed then
		self:_set_jammed( false )
		return
	end
	
	if not self._powered then
		self:_set_powered( true )
		return
	end
	
	if self._started then
		return
	end
	
	-- thermal lance
	if timer == 360 then
		timer = 600
	end
	
	self:_start( timer )
	if managers.network:session() then
		managers.network:session():send_to_peers_synched( "start_timer_gui", self._unit, timer )
	end
end