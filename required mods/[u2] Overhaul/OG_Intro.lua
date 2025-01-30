-- sweet and concise intro
function BootupState:setup()
	local res = RenderSettings.resolution
	local safe_rect_pixels = managers.gui_data:scaled_size() -- managers.viewport:get_safe_rect_pixels()
	local gui = Overlay:gui()
	
	self._full_workspace = gui:create_screen_workspace()
	self._workspace = managers.gui_data:create_saferect_workspace() -- gui:create_screen_workspace()
	self._back_drop_gui = MenuBackdropGUI:new()
	self._back_drop_gui:hide()
	self._workspace:hide()
	self._full_workspace:hide()
	managers.gui_data:layout_workspace( self._workspace )
	
	self._play_data_list = {
		{ layer = 1, video = "movies/company_logo", width = res.x, height = res.y, padding = 200, can_skip = true }
	}
	
	self._full_panel = self._full_workspace:panel()
	self._panel = self._workspace:panel()
	
	self._controller_list = {}
	for index=1, managers.controller:get_wrapper_count() do
		local con = managers.controller:create_controller( "boot_" .. index, index, false )
		con:enable()
		self._controller_list[ index ] = con
	end
end