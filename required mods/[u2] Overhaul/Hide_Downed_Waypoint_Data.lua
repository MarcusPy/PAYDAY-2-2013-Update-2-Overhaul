local wp_pos = Vector3()
local wp_dir = Vector3()
local wp_dir_normalized = Vector3()
local wp_cam_forward = Vector3()
local wp_onscreen_direction = Vector3()
local wp_onscreen_target_pos = Vector3()

function HUDManager:_update_waypoints( t, dt )
	-- local id = Profiler:start( "_update_waypoints" )
	local cam = managers.viewport:get_current_camera()
	if not cam then
		return
	end
	
	local cam_pos = managers.viewport:get_current_camera_position()
	local cam_rot = managers.viewport:get_current_camera_rotation()
	mrotation.y( cam_rot, wp_cam_forward )
		
	for id,data in pairs( self._hud.waypoints ) do
		-- local w_id = Profiler:start( "waypoint" )
		local panel = data.bitmap:parent()
		
		if data.state == "dirty" then
		end
	
		if data.state == "sneak_present" then
			data.current_position = Vector3( panel:center_x(), panel:center_y() )
			data.bitmap:set_center_x( data.current_position.x )
			data.bitmap:set_center_y( data.current_position.y )
			
			data.slot = nil
			data.current_scale = 1.0
			data.state = "present_ended"
				
			data.text_alpha = 0.5
			data.in_timer = 0
			data.target_scale = 1.0
			
			if data.distance then
				data.distance:set_visible( true )
			end
		
		elseif data.state == "present" then
			data.current_position = Vector3( panel:center_x()+data.slot_x, panel:center_y() + panel:center_y()/2 )
			data.bitmap:set_center_x( data.current_position.x )
			data.bitmap:set_center_y( data.current_position.y )
			
			data.text:set_center_x( data.bitmap:center_x() )
			data.text:set_top( data.bitmap:bottom() )
			data.present_timer = data.present_timer - dt
			
			if data.present_timer <= 0 then
				data.slot = nil
				data.current_scale = 1.0
				data.state = "present_ended"
				
				data.text_alpha = 0.5
				data.in_timer = 0
				data.target_scale = 1.0
				
				if data.distance then
					data.distance:set_visible( true )
				end
			end
		else
			
			if data.text_alpha ~= 0 then
				data.text_alpha = math.clamp( data.text_alpha - dt, 0 , 1 )
				data.text:set_color( data.text:color():with_alpha( data.text_alpha ) )
			end
			
			data.position = data.unit and data.unit:position() or data.position
			mvector3.set( wp_pos, self._saferect:world_to_screen( cam, data.position ) )
			mvector3.set( wp_dir, data.position )
			mvector3.subtract( wp_dir, cam_pos )
			
			mvector3.set( wp_dir_normalized, wp_dir ) 
			mvector3.normalize( wp_dir_normalized )
			local dot = mvector3.dot( wp_cam_forward, wp_dir_normalized )
			
			-- Before mutable
			-- local pos = self._saferect:world_to_screen( cam, data.position )
			-- local dir = data.position - cam_pos
			-- local dot = cam_rot:y():dot( dir:normalized() )
						
			-- local safe_rect_pixels = managers.viewport:get_safe_rect_pixels()
			-- local check_panel = managers.hud:script( PlayerBase.PLAYER_HUD ).panel
			-- if dot < 0 or check_panel:outside( mvector3.x( wp_pos ) - safe_rect_pixels.x, mvector3.y( wp_pos ) - safe_rect_pixels.y ) then -- Offscreen
			if dot < 0 or panel:outside( mvector3.x( wp_pos ), mvector3.y( wp_pos ) ) then -- Offscreen
				if data.state ~= "offscreen" then	-- Enter offscreen
					data.state = "offscreen"
					data.arrow:set_visible( true )
					data.bitmap:set_color( data.bitmap:color():with_alpha( 0.75 ) )	 -- was 0.50
					data.off_timer = 0 - (1-data.in_timer)
					data.target_scale = 0.75
					if data.distance then
						data.distance:set_visible( false )
					end
					if data.timer_gui then
						data.timer_gui:set_visible( false )
					end
				end
								 
				local direction = wp_onscreen_direction
				local panel_center_x, panel_center_y = panel:center()
				mvector3.set_static( direction, wp_pos.x-panel_center_x, wp_pos.y-panel_center_y, 0 )
				mvector3.normalize( direction )
								
				--[[ Old calculation using polar
				local polar = wp_cam_forward:to_polar_with_reference( wp_dir, math.UP )
				local direction = wp_onscreen_direction 		-- mutable
				mvector3.set_static( direction, polar.spin, polar.pitch, 0 )
				mvector3.normalize( direction )]]
				
				local distance = data.radius * tweak_data.scale.hud_crosshair_offset_multiplier
								
				local target_pos = wp_onscreen_target_pos  		-- mutable
				mvector3.set_static( target_pos, panel_center_x + mvector3.x( direction )*distance, panel_center_y + mvector3.y( direction )*distance, 0 )
				
				data.off_timer = math.clamp( data.off_timer + dt/data.move_speed, 0, 1 )
				if data.off_timer ~= 1 then
					mvector3.set( data.current_position, math.bezier( { data.current_position, data.current_position, target_pos, target_pos }, data.off_timer ) )
					data.current_scale =  math.bezier( { data.current_scale, data.current_scale, data.target_scale, data.target_scale }, data.off_timer )
					data.bitmap:set_size( data.size.x * data.current_scale, data.size.y * data.current_scale )
				else
					mvector3.set( data.current_position, target_pos )
				end
							
				data.bitmap:set_center( mvector3.x( data.current_position ), mvector3.y( data.current_position ) )
				
				data.arrow:set_center( mvector3.x( data.current_position ) + direction.x * 24,  mvector3.y( data.current_position ) + direction.y * 24 )
				local angle = math.X:angle( direction ) * math.sign( direction.y )
				data.arrow:set_rotation( angle )
				
				if data.text_alpha ~= 0 then
					data.text:set_center_x( data.bitmap:center_x() )
					data.text:set_top( data.bitmap:bottom() )
				end
			else
				if data.state == "offscreen" then -- Enter onscreen
					data.state = "onscreen"
					data.arrow:set_visible( false )
					data.bitmap:set_color( data.bitmap:color():with_alpha( 1 ) )
					data.in_timer = 0 - (1-data.off_timer)
					data.target_scale = 1.0
					if data.distance then
						data.distance:set_visible( true )
					end
					if data.timer_gui then
						data.timer_gui:set_visible( true )
					end
				end
		
				local alpha = 0.8									-- Default alpha
				if dot > 0.99 then									-- Adjust alpha if looking directly at it
					alpha = math.clamp( (1-dot)/0.01, 0.4, alpha )
				end
				
				if data.bitmap:color().alpha ~= alpha then
					data.bitmap:set_color( data.bitmap:color():with_alpha( alpha ) )
					if data.distance then
						data.distance:set_color( data.distance:color():with_alpha( alpha ) )
					end
					if data.timer_gui then
						data.timer_gui:set_color( data.bitmap:color():with_alpha( alpha ) )
					end
				end
		
				if data.in_timer ~= 1 then
					data.in_timer = math.clamp( data.in_timer + dt/data.move_speed, 0, 1 )
					mvector3.set( data.current_position, math.bezier( { data.current_position, data.current_position, wp_pos, wp_pos }, data.in_timer ) )
					
					data.current_scale = math.bezier( { data.current_scale, data.current_scale, data.target_scale, data.target_scale }, data.in_timer )
					data.bitmap:set_size( data.size.x * data.current_scale, data.size.y * data.current_scale )
				else
					mvector3.set( data.current_position, wp_pos )
				end
								
				data.bitmap:set_center( mvector3.x( data.current_position ), mvector3.y( data.current_position ) )
				
				if data.text_alpha ~= 0 then
					data.text:set_center_x( data.bitmap:center_x() )
					data.text:set_top( data.bitmap:bottom() )
				end
								
				if data.distance then
					local length = wp_dir:length()
					data.distance:set_text( "" )
					data.distance:set_center_x( data.bitmap:center_x() )
					-- data.distance:set_bottom( data.bitmap:top() )
					data.distance:set_top( data.bitmap:bottom() )
				end
			end
			
		end
				
		if data.timer_gui then 
			data.timer_gui:set_center_x( data.bitmap:center_x() )
			data.timer_gui:set_bottom( data.bitmap:top() )
			if data.pause_timer == 0 then
				data.timer = data.timer - dt 
				local text = "" --data.timer < 0 and "00" or (math.round( data.timer ) < 10 and "0" or "")..math.round( data.timer )
				data.timer_gui:set_text( text )
			end
		end
		-- Profiler:stop( w_id )
	end
	-- Profiler:stop( id )
end