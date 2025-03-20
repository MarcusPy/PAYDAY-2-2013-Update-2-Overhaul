function MenuSceneManager:init()

	self._standard_fov = 55
	self._current_fov = 55
	self._camera_start_pos = Vector3()
	self._camera_start_rot = Rotation( -5, 0, 0 )
	
	self._active_lights = {}
	self._fade_down_lights = {}
	
	self._character_yaw = 0
	self._character_pitch = 0
	
	self._item_yaw = 0
	self._item_pitch = 0
	self._item_roll = 0
	self._item_rot = Rotation()
	self._item_rot_mod = Rotation( 0, 0, 0 )
	self._item_rot_temp = Rotation()
	self._use_item_grab = false
	self._use_character_grab = false
	
	self._current_scene_template = ""
	-- self:_set_up_templates()
	
	self._global_poses = {}
	self._global_poses.generic 			= { "husk_generic1", "husk_generic2", "husk_generic3", "husk_generic4" }
	self._global_poses.assault_rifle	= { "husk_rifle1", "husk_rifle2" }
	self._global_poses.pistol 			= { "husk_pistol1" }
	self._global_poses.saw 				= { "husk_saw1" }
	self._global_poses.shotgun			= { "husk_shotgun1" }
	
	self._weapon_units = {}
		
	self:_setup_bg()
	
	self:_set_up_templates()
		
	self:_setup_gui()
	
	self._transition_bezier = { 0, 0, 1, 1 }
	self._transition_time = 0
	self._weapon_transition_time = 0
	
	self._transition_done_callback_handler = CoreEvent.CallbackEventHandler:new()
end

function MenuSceneManager:_setup_bg()
	local yaw = 180
	
	self._bg_unit = World:spawn_unit( Idstring( "units/menu/menu_scene/menu_cylinder" ), Vector3( 0, 0, 0 ), Rotation( yaw ,0 ,0 ) )
	World:spawn_unit( Idstring( "units/menu/menu_scene/menu_cylinder_pattern" ), Vector3( 0, 0, 0 ), Rotation( yaw ,0 ,0 ) )
	World:spawn_unit( Idstring( "units/menu/menu_scene/menu_smokecylinder1" ), Vector3( 0, 0, 0 ), Rotation( yaw ,0 ,0 ) )
	World:spawn_unit( Idstring( "units/menu/menu_scene/menu_smokecylinder2" ), Vector3( 0, 0, 0 ), Rotation( yaw ,0 ,0 ) )
	World:spawn_unit( Idstring( "units/menu/menu_scene/menu_smokecylinder3" ), Vector3( 0, 0, 0 ), Rotation( yaw ,0 ,0 ) )
	--World:spawn_unit( Idstring( "units/menu/menu_scene/menu_logo" ), Vector3( 0, 0, 0 ), Rotation( yaw, 0 ,0 ) )
				
	for character_id,data in pairs( tweak_data.blackmarket.characters ) do
		if Global.blackmarket_manager.characters[ character_id ].equipped then
			self:set_character( character_id )
		end
	end
	
	self:_setup_lobby_characters()
end

-- remove the blue filter from main menu
local old_MenuSceneManager_setup_camera = MenuSceneManager.setup_camera
function MenuSceneManager:setup_camera(...)
	old_MenuSceneManager_setup_camera(self, ...)
	local gradings = { 
		"color_off", 
		"color_payday", 
		"color_heat", 
		"color_nice", 
		"color_sin", 
		"color_bhd", 
		"color_xgen", 
		"color_xxxgen", 
		"color_matrix" 
	}
	managers.environment_controller:set_default_color_grading( "color_off" )
	managers.environment_controller:refresh_render_settings()
end