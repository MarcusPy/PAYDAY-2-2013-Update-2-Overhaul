local old_init = HudIconsTweakData.init

local enable_basic_waypoints = false

if (enable_basic_waypoints == true) then

	function HudIconsTweakData:init()
		old_init(self)
		
		self.wp_arrow = {				
			texture = "guis/textures/hud_icons",
			texture_rect = {},
		}
		
		self.wp_revive = {				
			texture = "guis/textures/hud_icons",
			texture_rect = {},
		}

	end

elseif (enable_basic_waypoints == false) then

	function HudIconsTweakData:init()
		old_init(self)
		
		self.pd2_lootdrop = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_escape = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_talk = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_kill = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_drill = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_generic_look = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_phone = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_c4 = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_power = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_door = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
			}
		self.pd2_computer = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_wirecutter = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_fire = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_loot = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_methlab = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_generic_interact = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.pd2_goto = {				
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {},
		}
		self.wp_arrow = {				
			texture = "guis/textures/hud_icons",
			texture_rect = {},
		}
		self.wp_revive = {				
			texture = "guis/textures/hud_icons",
			texture_rect = {},
		}

	end

end