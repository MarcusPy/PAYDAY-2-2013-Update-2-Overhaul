HUDInfo = HUDInfo or class()

local res = RenderSettings.resolution
local aspect = res.x / res.y
local y_pos = 10
local x_pos = (720 * aspect) - 10

function HUDInfo:init(hud)
    self._full_hud = hud
    self._infos = {}
    self._active_infos = {}
    managers.hud:add_updator("InfoUpdate", callback(self, self, "InfoUpdater"))
    self._info_panel = self._full_hud:panel({
        name = "info_panel",
        valign = "top",
        halign = "right",
        layer = -11,
        w = 512,
        h = 84,
    })
    self:create_info({
        name = "hostages",
        color = Hostage_color,
        option = "hostages_enable",
        icon = "guis/textures/pd2/skilltree/icons_atlas",
        func = "CountHostages",
        icon_rect = {255,449,64,64}
    })
    self:create_info({
        name = "civis",
        color = civis_bg_color,
        hide = true,
        func = "CountInfo",
        option = "civis_enable",
        icon = "guis/textures/pd2/skilltree/icons_atlas",
        icon_rect = {386,447,64,64},
        info = managers.enemy:all_civilians(),
        count = true
    })
    self:create_info({
        name = "enemies",
        color = enemies_bg_color,
        hide = true,
        option = "enemies_enable",
        func = "CountInfo",
        icon = "guis/textures/pd2/skilltree/icons_atlas",
        icon_rect = {2,319,64,64},
        info = managers.enemy:all_enemies(),
        count = true
    })
    self._info_panel:set_top(y_pos)
    self._info_panel:set_right(x_pos)
end

function HUDInfo:create_info(config)
    config.visible = true
    info_box = HUDBGBox_create(self._info_panel,{
        name = config.name,
        w = 28,
        h = 28,
        x = 0,
        y = 0
    },{color = Color.white, alpha = 0})
    info_text = info_box:text({
        name = "text",
        text = "0",
        valign = "center",
        align = "center",
        vertical = "center",
        w = info_box:w(),
        h = info_box:h(),
        layer = 1,
        color = Color.white,
        font = tweak_data.hud_corner.assault_font,
        font_size = tweak_data.hud_corner.numhostages_size
    })
    info_icon = self._info_panel:bitmap({
        name = config.name.."_icon",
        texture = config.icon,
        texture_rect = config.icon_rect or {0,0},
        w = info_box:w(),
        h = info_box:h(),
        valign = "top",
        layer = 2
    })
    info_box:set_right(info_box:parent():w())
    info_icon:set_right( info_box:left() )
    table.insert(self._infos, config)
end

function HUDInfo:update_infos()
    for i, config in ipairs(self._infos) do
        if self._info_panel:child(config.name) then
            if config.name == "enemies" then
                self._info_panel:child(config.name):child("bg"):set_color(enemies_bg_color)
            elseif config.name == "civis" then
                self._info_panel:child(config.name):child("bg"):set_color(civis_bg_color)
            elseif config.name == "hostages" then
                self._info_panel:child(config.name):child("bg"):set_color(Hostage_color)
            end
            self._info_panel:child(config.name):child("text"):set_color(Color.white)
            self._info_panel:child(config.name):child("bg"):set_alpha(0)
        end
    end
    self._info_panel:set_top(y_pos)
    self._info_panel:set_right(x_pos)
end

function HUDInfo:InfoUpdater()
    if #self._infos > 0 then
        for k, config in pairs(self._infos) do
            HUDInfo[config.func](self, config)
        end
        self:layout_infos()
    end
end

function HUDInfo:CountInfo(config)
    local info_text = self._info_panel:child(config.name):child("text")
    local info_num = 0
    for k, v in pairs(config.info) do
        info_num = info_num + 1
    end
    if info_num == 0 then
        config.visible = false
    else
        config.visible = true
    end
    if tonumber(info_text:text()) ~= info_num then
        info_text:set_text(info_num)
        info_text:animate(callback(self, self, "flash_text"))
    end
end

function HUDInfo:SetTop(rect, Top , icon)
    local t = 0
    local top = rect:top()
    while t < 0.5 do
        t = t + coroutine.yield()
        local n = 1 - math.sin((t / 2) * 350)
        rect:set_top(math.lerp(Top, top, n))
        if icon then
            icon:set_top(math.lerp(Top, top, n))
        end
    end
    rect:set_top(Top)
    if icon then
        icon:set_top(Top)
    end
end

function HUDInfo:SetRight(rect, Right, icon)
    local t = 0
    local right = rect:right()
    while t < 0.5 do
        t = t + coroutine.yield()
        local n = 1 - math.sin((t / 2) * 350)
        rect:set_right(math.lerp(Right, right, n))
        if icon then
            icon:set_right(rect:left())
        end
    end
    rect:set_right(Right)
    if icon then
        icon:set_right(rect:left())
    end
end

function HUDInfo:SetAlpha(rect, Alpha, icon)
    local t = 0
    local alpha = rect:alpha()
    while t < 0.5 do
        t = t + coroutine.yield()
        local n = 1 - math.sin((t / 2) * 350)
        rect:set_alpha(math.lerp(Alpha, alpha, n))
        if icon then
            icon:set_alpha(math.lerp(Alpha, alpha, n))
        end
    end
    rect:set_alpha(Alpha)
    if icon then
        icon:set_alpha(Alpha)
    end
end

function HUDInfo:SetTopRight(rect, Top, Right, icon)
    local t = 0
    local top = rect:top()
    local right = rect:right()
    while t < 0.5 do
        t = t + coroutine.yield()
        local n = 1 - math.sin((t / 2) * 350)
        rect:set_righttop(math.lerp(Right, right, n), math.lerp(Top, top, n))
        if icon then
            icon:set_righttop(rect:left(), math.lerp(Top, top, n))
        end
    end
    rect:set_righttop(Right, Top)
    if icon then
        icon:set_righttop(rect:left(), Top)
    end
end

function HUDInfo:CountHostages(config)
    local info_text = self._info_panel:child(config.name):child("text")
    local info_num = managers.groupai:state()._hostage_headcount
    if tonumber(info_text:text()) ~= info_num then
        info_text:set_text(info_num)
        info_text:animate(callback(self, self, "flash_text"))
    end
end

function HUDInfo:layout_infos()
    local i = 0
    local times = 0
    for _, config in pairs(self._infos) do
        infobox = self._info_panel:child(config.name)
        info_icon = self._info_panel:child(config.name.."_icon")
        if config.visible then
            infobox:stop()
            info_icon:stop()
            infobox:animate(callback(self, self, "SetAlpha"), 1)
            info_icon:animate(callback(self, self, "SetAlpha"), 1)
            i = i + 1
            if i > (3 * times) + 3 then
                times = times + 1
            end
            infobox:animate(callback(self, self, "SetTopRight"), times * 45, infobox:parent():w() - (infobox:w() + 45) * (( i - (3 * times )) - 1), info_icon)
        else
            infobox:animate(callback(self, self, "SetAlpha"), 0)
            info_icon:animate(callback(self, self, "SetAlpha"), 0)
        end
    end

    self._info_panel:set_h(44 * (times + 1))
end

function HUDInfo:flash_text(text)
    local t = 0.5
    while t > 0 do
        t = t - coroutine.yield()
        local alpha = math.round(math.abs((math.sin(t * 360 * 3))))
        text:set_alpha(alpha)
    end
    text:set_alpha(1)
end


  