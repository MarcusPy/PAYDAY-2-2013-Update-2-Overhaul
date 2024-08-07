function HUDTeammate:start_timer( time )
	self._timer_paused = 0
	self._timer = time
	self._panel:child( "condition_timer" ):set_font_size( tweak_data.hud_players.timer_size )
	self._panel:child( "condition_timer" ):set_color( Color.white )
	self._panel:child( "condition_timer" ):stop()
	self._panel:child( "condition_timer" ):set_visible( false )
	self._panel:child( "condition_timer" ):animate( callback( self, self, "_animate_timer" ) )
end