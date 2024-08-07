dofile("mods/HoloInfo/lua/HudInfo.lua")     
local _o_hide_mission_briefing_hud = HUDManager.hide_mission_briefing_hud
function HUDManager:hide_mission_briefing_hud(...)
	_o_hide_mission_briefing_hud(self, ...)
    HoloInfo._hudinfo = HUDInfo:new(managers.gui_data:create_fullscreen_workspace():panel())
end
