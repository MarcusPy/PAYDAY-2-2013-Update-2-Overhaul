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

--[[ ULTRAWIDE FIX

local width = 32
local height = 9

function MenuSceneManager:_set_dimensions()
	local aspect_ratio = self:_real_aspect_ratio()
	local y = (1-(aspect_ratio / (width/height)))/2
	local h = aspect_ratio / (width/height)
	self._vp._vp:set_dimensions( 0, y, 1, h )
end

function MenuSceneManager:setup_camera()
	if self._camera_values then
		return
	end
	
	local ref = self._bg_unit:get_object( Idstring( "a_camera_reference" ) )
	local target_pos = Vector3( 0, 0, ref:position().z )
	
	self._camera_values = {}
	self._camera_values.camera_pos_current = ref:position():rotate_with( Rotation( 90 ) )
	self._camera_values.camera_pos_target = self._camera_values.camera_pos_current
	self._camera_values.target_pos_current = target_pos
	self._camera_values.target_pos_target = self._camera_values.target_pos_current
	self._camera_values.fov_current = self._standard_fov
	self._camera_values.fov_target = self._camera_values.fov_current

	self._camera_object = World:create_camera()
	self._camera_object:set_near_range( 3 )
	self._camera_object:set_far_range( 250000 )
	self._camera_object:set_fov( 55 )
	self._camera_object:set_rotation( self._camera_start_rot )

	self._vp = managers.viewport:new_vp( 0, 0, 1, 1, "menu_main" )
	self._vp:set_width_mul_enabled()
	self._director = self._vp:director()
	self._shaker = self._director:shaker()
	self._camera_controller = self._director:make_camera( self._camera_object, Idstring("menu") )
	self._director:set_camera( self._camera_controller )
	self._director:position_as( self._camera_object )
	self._camera_controller:set_both( self._camera_object )
	self._camera_controller:set_target( self._camera_start_rot:y() * 100 + self._camera_start_rot:x() * 6 )
	self:_set_camera_position( self._camera_values.camera_pos_current )
	self:_set_target_position( self._camera_values.camera_pos_target )
	self._vp:set_camera( self._camera_object )managers.viewport:preload_environment( "environments/env_menu/env_menu" )
	
	managers.environment_area:set_default_environment( "environments/env_menu/env_menu" )
	
	self._vp:set_environment( managers.environment_area:default_environment() )
	
	self._vp:set_active( true )
	
	managers.environment_controller:refresh_render_settings()
	
	self._vp:camera():set_width_multiplier(CoreMath.width_mul( width/height ) )
	
	self:_set_dimensions()
	
	self._shaker:play( "breathing", 0.2 )
	
	self._resolution_changed_callback_id = managers.viewport:add_resolution_changed_func( callback( self, self, "_resolution_changed" ) )
	
	self._environment_modifier_id = managers.viewport:viewports()[1]:create_environment_modifier(false, function(interface) return self:_sky_rotation_modifier(interface) end, "sky_orientation")
end
]]