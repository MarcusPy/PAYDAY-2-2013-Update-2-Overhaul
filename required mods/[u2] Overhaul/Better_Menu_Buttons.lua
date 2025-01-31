function MenuRenderer:show_node( node )
	local gui_class = MenuNodeGui
	if node:parameters().gui_class then
		gui_class = CoreSerialize.string_to_classtable( node:parameters().gui_class )
	end
	local parameters = { 	
		font = tweak_data.menu.eroded_font,
		row_item_color = tweak_data.hud.prime_color, -- :with_alpha(0.5), 
		row_item_hightlight_color = Color.red, 
		-- row_item_color = tweak_data.menu.default_font_row_item_color, -- 
		-- row_item_hightlight_color = tweak_data.menu.default_hightlight_row_item_color, -- 
		row_item_blend_mode = "add",
		font_size = tweak_data.menu.pd2_medium_font_size,
		-- texture = { texture = "guis/textures/menu_background", width = 1024, height = 512 }, --, padding = 50 },
		node_gui_class = gui_class, 
		spacing = node:parameters().spacing,
		marker_alpha = 0,
		marker_color = tweak_data.screen_colors.button_stage_3:with_alpha(0.2),
		align = "left",
		to_upper = true,
	}
	MenuRenderer.super.show_node( self, node, parameters )
end

function MenuRenderer:_create_bottom_text()
end