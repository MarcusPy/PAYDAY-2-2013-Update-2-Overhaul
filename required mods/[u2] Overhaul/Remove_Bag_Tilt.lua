if _G.u2_core.settings.gameplay.no_bag_tilt then
    local old_enter = PlayerCarry.enter
    function PlayerCarry:enter( state_data, enter_data, ... )
        old_enter(self, state_data, enter_data, ...)
        self._unit:camera():camera_unit():base():set_target_tilt(0)
    end
end