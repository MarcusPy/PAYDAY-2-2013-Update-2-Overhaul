_G.HoloInfo = _G.HoloInfo or {}
HoloInfo.mod_path = ModPath
HoloInfo._data_path = SavePath .. "HoloInfo_savefile.txt"
HoloInfo.options = {} 
HoloInfo.options_menu = "HoloInfoOptions"

function HoloInfo:Save()
	local file = io.open( self._data_path, "w+" )
	if file then
		file:write( json.encode( self.options ) )
		file:close()
	end
end
function HoloInfo:Load()
	local file = io.open( self._data_path, "r" )
	if file then
		self.options = json.decode( file:read("*all") )
		file:close()
	end
end
function HoloInfo:clone( class )
    class.old = clone(class)
end
function HoloInfo:update()
    HoloInfoAlpha = HoloInfo.options.MainAlpha 
    Infotimer_enable = HoloInfo.options.Infotimer_enable
    enemies_enable = HoloInfo.options.enemies_enable --
    hostages_enable = HoloInfo.options.hostages_enable 
    civis_enable = HoloInfo.options.civis_enable --
    InfoTimers_max = HoloInfo.options.Infotimer_max 
    InfoTimers_size = HoloInfo.options.Infotimer_size
    InfoTimers_bg_color = HoloInfo.colors[HoloInfo.options.Infotimer_color].color
    InfoTimers_bg_jammed_color = HoloInfo.colors[HoloInfo.options.Infojammed_color].color
    InfoTimers_text_color = HoloInfo.textcolors[HoloInfo.options.Infotimer_text_color] 
    Infobox_text_color = HoloInfo.textcolors[HoloInfo.options.Infobox_text_color] 
    civis_bg_color = HoloInfo.colors[HoloInfo.options.civis_bg_color].color 
    enemies_bg_color = HoloInfo.colors[HoloInfo.options.enemies_bg_color].color 
    pagers_bg_color = HoloInfo.colors[HoloInfo.options.pagers_bg_color].color 
    Hostage_color = HoloInfo.colors[HoloInfo.options.hostagebox_color].color
	if HoloInfo._hudinfo then
		HoloInfo._hudinfo:update_infos()
	end
end
HoloInfoTextColors = {
    "HoloInfocolorWhite", 
    "HoloInfocolorBlack",  
}

if not HoloInfo.setup then
	HoloInfo.colors = { --You can add new ones 
		{color = Color(0.2, 0.6 ,1 ), menu_name = "Blue"},	  	 
		{color = Color(1,0.6 ,0 ), menu_name = "Orange"},
		{color = Color(0, 1, 0.1), menu_name = "Green"},	
		{color = Color(1, 0.25, 0.7), menu_name = "Pink"},				 
		{color = Color(0, 0, 0), menu_name = "Black"},		 		 
		{color = Color(0.15, 0.15, 0.15), menu_name = "Grey"},
		{color = Color(0.1, 0.1, 0.35), menu_name = "DarkBlue"},	
		{color = Color(1, 0.1, 0), menu_name = "Red"},	
		{color = Color(1, 0.8, 0.2), menu_name = "Yellow"},	
		{color = Color(1, 1, 1), menu_name = "White"},
		{color = Color(0, 1, 0.9), menu_name = "Cyan"},
		{color = Color(0.5, 0, 1), menu_name = "Purple"},
		{color = Color(0, 0.9, 0.5), menu_name = "SpringGreen"},
		{color = Color(0.6,0.8,0.85), menu_name = "Light Blue"},
		{color = Color(1, 0, 0.2), menu_name = "Crimson"},
		{color = Color(0.5,82,45), menu_name = "Brown"},
		{color = Color(0.7, 0.9, 0), menu_name = "Lime"}, 
	}
	HoloInfo.textcolors = {
		Color.white,	
		Color.black,	  	 	  
	} 
    HoloInfo:Load()
    HoloInfo.options.Defaults = {
        Infotimer_enable = true,
        ECMtimer_enable = true,
        Drilltimer_enable = true,
        Digitaltimer_enable = true,
        gagepacks_enable = false,
        Infotimer_color = 1,
        Infojammed_color = 8,
        Infotimer_text_color = 2,
        civis_bg_color = 1,
        hostages_enable = true,
        enemies_bg_color = 9,
        Infobox_text_color = 2,
        Infotimer_size = 48,
        Infotimer_max = 5,
        civis_enable = true,
        pagers_enable = true,
        gagepacks_bg_color = 1,
        pagers_bg_color = 1,
        enemies_enable = true,
        info_ypos = 90,
        info_xpos = 1235,
        Infobox_max = 3,
        hostagebox_color = 1,
        Frame_style = 1,
        MainAlpha = 0.8,
        truetime = false,
    }
    for option, value in pairs(HoloInfo.options.Defaults) do
        if HoloInfo.options[option] == nil then
            HoloInfo.options[option] = value
        end
    end
    HoloInfo:Load()
    HoloInfoAlpha = HoloInfo.options.MainAlpha 
    Infotimer_enable = HoloInfo.options.Infotimer_enable
    enemies_enable = HoloInfo.options.enemies_enable --
    hostages_enable = HoloInfo.options.hostages_enable 
    civis_enable = HoloInfo.options.civis_enable --
    InfoTimers_max = HoloInfo.options.Infotimer_max 
    InfoTimers_size = HoloInfo.options.Infotimer_size
    InfoTimers_bg_color = HoloInfo.colors[HoloInfo.options.Infotimer_color].color
    InfoTimers_bg_jammed_color = HoloInfo.colors[HoloInfo.options.Infojammed_color].color
    InfoTimers_text_color = HoloInfo.textcolors[HoloInfo.options.Infotimer_text_color] 
    Infobox_text_color = HoloInfo.textcolors[HoloInfo.options.Infobox_text_color] 
    civis_bg_color = HoloInfo.colors[HoloInfo.options.civis_bg_color].color 
    enemies_bg_color = HoloInfo.colors[HoloInfo.options.enemies_bg_color].color 
	pagers_bg_color = HoloInfo.colors[HoloInfo.options.pagers_bg_color].color 
    Hostage_color = HoloInfo.colors[HoloInfo.options.hostagebox_color].color
    gagepacks_bg_color = HoloInfo.colors[HoloInfo.options.gagepacks_bg_color].color
    
	HoloInfo.setup = true
end
local HoloInfoColors = {}