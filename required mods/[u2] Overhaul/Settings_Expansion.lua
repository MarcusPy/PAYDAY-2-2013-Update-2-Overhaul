local caps = {
	145,
	165,
	240,
	1000
}

local modify_adv_video_actual = MenuOptionInitiator.modify_adv_video
function MenuOptionInitiator:modify_adv_video(node, ...)
	for id=1, 4 do
		node:item("choose_fps_cap"):add_option(CoreMenuItemOption.ItemOption:new({
			_meta = "option",
			text_id = tostring(caps[id]),
			value = caps[id],
			localize = false
		}))
		node:item("choose_fps_cap"):_show_options()
	end

	node:item("fov_multiplier")._max = 2
	return modify_adv_video_actual(self, node, ...)
end