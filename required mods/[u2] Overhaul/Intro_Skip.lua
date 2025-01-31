if _G.u2_core.settings.misc.skip_intro then
    if RequiredScript == "lib/setups/menusetup" then
        local init_game_actual = MenuSetup.init_game
        function MenuSetup:init_game(...)
            local result = init_game_actual(self, ...)
            game_state_machine:set_boot_intro_done(true)
            game_state_machine:change_state_by_name("menu_titlescreen")
            return result
        end
    end

    if RequiredScript == "lib/states/menutitlescreenstate" then
        local silenced = false
        local get_start_pressed_controller_index_actual = MenuTitlescreenState.get_start_pressed_controller_index
        function MenuTitlescreenState:get_start_pressed_controller_index(...)

            local num_connected = 0
            local keyboard_index = nil

            for index, controller in ipairs(self._controller_list) do
                if controller._was_connected then
                    num_connected = num_connected + 1
                end
                if controller._default_controller_id == "keyboard" then
                    keyboard_index = index
                end
            end

            if num_connected == 1 and keyboard_index ~= nil then
                silenced = true
                return keyboard_index
            else
                return get_start_pressed_controller_index_actual(self, ...)
            end
        end

        local _load_savegames_done_actual = MenuTitlescreenState._load_savegames_done
        function MenuTitlescreenState:_load_savegames_done(...)
            if silenced then
                self:gsm():change_state_by_name("menu_main")
            else
                _load_savegames_done_actual(self, ...)
            end
        end
    end
end