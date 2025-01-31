local old_init = HUDTemp.init
function HUDTemp:init( hud )
	old_init(self, hud)
	self._bg_box:set_alpha(0)
	self._bg_box:hide()
	self._bg_box:set_size(0,0)
	local bag_panel = self._temp_panel:child("bag_panel")
	bag_panel:child("bag_text"):configure({
		visible = true,
		text = "JEWELRY\n$250,000",
		font = "fonts/font_medium_noshadow_mf",
		layer = 2
	})
	local carry_bag = bag_panel:bitmap({name = "carry_bag", texture_rect = {28, 52, 201, 161}, layer = 1, halign = "scale", valign = "scale", texture = "guis/textures/pd2/skilltree/padlock"})
	carry_bag:set_size(carry_bag:w() * 0.5, carry_bag:h() * 0.5)
	bag_panel:set_size(carry_bag:size())
	carry_bag:set_size(bag_panel:size())
	bag_panel:set_bottom(self._temp_panel:h() - 152)
	self._stamina_panel:set_alpha(1)
	self._bag_panel_w, self._bag_panel_h = bag_panel:size()
end

function HUDTemp:show_carry_bag(carry_id, value)
	local bag_panel = self._temp_panel:child("bag_panel")
	local carry_data = tweak_data.carry[carry_id]
	local type_text = carry_data.name_id and managers.localization:text(carry_data.name_id)
	local bag_text = bag_panel:child("bag_text")
	bag_text:set_text(utf8.to_upper(type_text))
	bag_panel:set_x(self._temp_panel:parent():w() / 2)
	bag_panel:set_visible(true)
	bag_panel:stop()
	bag_panel:animate(callback(self, self, "_animate_show_bag_panel"))
end

function HUDTemp:hide_carry_bag()
	local bag_panel = self._temp_panel:child("bag_panel")
	bag_panel:stop()
	bag_panel:set_visible(false)
	self._temp_panel:child("throw_instruction"):set_visible(false)
end

function HUDTemp:_animate_show_bag_panel(bag_panel)
	local w, h = self._bag_panel_w, self._bag_panel_h
	local scx = self._temp_panel:w() / 2
	local ecx = self._temp_panel:w() - w / 2
	local scy = self._temp_panel:h() / 2
	local ecy = (self._temp_panel:h() - 152) - self._bag_panel_h / 2
	scy = ecy
	local bottom = bag_panel:bottom()
	local center_y = bag_panel:center_y()
	local scale = 2
	bag_panel:set_size(w * scale, h * scale)
	local font_size = 24
	local bag_text = bag_panel:child("bag_text")
	bag_text:set_font_size(font_size * scale)
	bag_text:set_rotation(360)
	local _, _, tw, th = bag_text:text_rect()
	font_size = font_size * math.min(1, bag_panel:w() / (tw * 1.15))
	local TOTAL_T = 0.25
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local wm = math.lerp(0, w * scale, 1 - t / TOTAL_T)
		local hm = math.lerp(0, h * scale, 1 - t / TOTAL_T)
		bag_panel:set_size(wm, hm)
		bag_panel:set_center_x(scx)
		bag_panel:set_center_y(scy)
		bag_text:set_font_size(math.lerp(0, font_size * scale, 1 - t / TOTAL_T))
	end
	wait(0.5)
	local TOTAL_T = 0.5
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local wm = math.lerp(w * scale, w, 1 - t / TOTAL_T)
		local hm = math.lerp(h * scale, h, 1 - t / TOTAL_T)
		bag_panel:set_size(wm, hm)
		bag_panel:set_center_x(math.lerp(scx, ecx, 1 - t / TOTAL_T))
		bag_panel:set_center_y(math.lerp(scy, ecy, 1 - t / TOTAL_T))
		bag_text:set_font_size(math.lerp(font_size * scale, font_size, 1 - t / TOTAL_T))
	end
	bag_panel:set_size(w, h)
	bag_panel:set_center_x(ecx)
	bag_panel:set_center_y(ecy)
	bag_text:set_font_size(font_size)
end

function HUDTemp:set_throw_bag_text()
	self._temp_panel:child("throw_instruction"):set_text(utf8.to_upper(managers.localization:text("hud_instruct_throw_bag", {BTN_USE_ITEM = managers.localization:btn_macro("use_item")})))
end