--TEMPORARY FIX FOR BLACK SCREEN IN MAIN MENU
--Combine with Ultrawide Fix for proper button interactions
--Upon entering main menu press F9 and Enter to enable frozen freecam

if RequiredScript == "lib/entry" then
	core:import("CoreFreeFlight")
	Global.DEBUG_MENU_ON = true

	function CoreFreeFlight.FreeFlight:_setup_actions()
		local FFA = CoreFreeFlight.CoreFreeFlightAction.FreeFlightAction
		local FFAT = CoreFreeFlight.CoreFreeFlightAction.FreeFlightActionToggle
		local yc = FFA:new( "YIELD CONTROL (F9 EXIT)", callback( self, self, "_yield_control" ) )
		self._actions = {yc}
		self._action_index = 1
	end

end