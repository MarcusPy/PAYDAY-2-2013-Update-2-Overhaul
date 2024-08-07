core:module("CoreSubtitlePresenter")
function OverlayPresenter:show_text(text, duration)
	self._bg_mode = 2
	self.__font_name = "fonts/font_medium_mf"
	self._text_scale = 0.9
	local label = self.__subtitle_panel:child("label") or self.__subtitle_panel:text({
		name = "label",
		font = self.__font_name,
		font_size = self.__font_size * self._text_scale,
		color = Color.white,
		align = "center",
		vertical = "bottom",
		layer = 1,
		wrap = true,
		word_wrap = true
	})
	local shadow = self.__subtitle_panel:child("shadow") or self.__subtitle_panel:text({
		name = "shadow",
		x = 1,
		y = 1,
		font = self.__font_name,
		font_size = self.__font_size * self._text_scale,
		color = Color.black:with_alpha(1),
		align = "center",
		vertical = "bottom",
		layer = 0,
		wrap = true,
		word_wrap = true
	})
	label:set_text(text)
	shadow:set_text(text)	
	label:set_font_size(self.__font_size * self._text_scale)
	shadow:set_font_size(self.__font_size * self._text_scale)
	shadow:set_visible(self._bg_mode == 2)
	local background = self.__subtitle_panel:child("background") or self.__subtitle_panel:bitmap({
		name = "background",
		color = Color.black,
		alpha = 0.5,
		w = 0,
		h = 0,
		layer = -1
	})
	background:set_visible(self._bg_mode == 3)
		local blur = self.__subtitle_panel:child("blur") or self.__subtitle_panel:bitmap({
		name = "blur",
		texture = "guis/textures/test_blur_df",
		render_template = "VertexColorTexturedBlur3D",
		w = 0,
		h = 0,
		layer = -2
	})
	blur:set_visible(self._bg_mode == 3)
	local x, y, w, h = label:text_rect()
	background:set_shape(x-4, y-4, w+8, h+8)
	blur:set_shape(x-4, y-4, w+8, h+8)
end