if _G.u2_core.settings.gameplay.no_weapon_sway then
	local old_PlayerTweakData_init = PlayerTweakData.init 
	function PlayerTweakData:init(...)
		old_PlayerTweakData_init(self, ...)
		for k, v in pairs(self.stances) do
			v.steelsight.shakers.breathing.amplitude = 0
		end
	end
end