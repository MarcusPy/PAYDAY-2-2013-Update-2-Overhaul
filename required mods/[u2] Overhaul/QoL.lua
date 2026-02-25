function MenuManager:show_question_start_tutorial( params ) end

-- enable chat in SP
function MenuManager:toggle_chatinput()
    if SystemInfo:platform() ~= Idstring("WIN32") then
        return
    end
    if self:active_menu() then
        return
    end
    if not managers.network:session() then
        return
    end
    if managers.hud then
        managers.hud:toggle_chatinput()
        return true
    end
end

function MenuComponentManager:_create_chat_gui()
    if SystemInfo:platform() == Idstring("WIN32") then
        self._lobby_chat_gui_active = false
        if self._game_chat_gui then
            self:show_game_chat_gui()
            return
        end
        self:add_game_chat()
    end
end

function MenuComponentManager:_create_lobby_chat_gui()
    if SystemInfo:platform() == Idstring("WIN32") then
        self._lobby_chat_gui_active = true
        if self._game_chat_gui then
            self:show_game_chat_gui()
            return
        end
        self:add_game_chat()
    end
end

-- removes 'are you sure'
function SkillTreeGui:place_point(item)
    local tree = item:tree()
    local tier = item:tier()
    local skill_id = item:skill_id()
    if tier and not managers.skilltree:tree_unlocked(tree) then
        self:flash_item(item)
        return
    end
    if managers.skilltree:skill_completed(skill_id) then
        return
    end
    if not tier and managers.skilltree:tree_unlocked(tree) then
        return
    end
    local params = {}
    local to_unlock = managers.skilltree:next_skill_step(skill_id)
    local talent = tweak_data.skilltree.skills[skill_id]
    local skill = talent[to_unlock]
    local points = Application:digest_value(skill.cost, false)
    local point_cost = managers.money:get_skillpoint_cost(tree, tier, points)
    local prerequisites = talent.prerequisites or {}
    for _, prerequisite in ipairs(prerequisites) do
        local unlocked = managers.skilltree:skill_step(prerequisite)
        if unlocked and unlocked == 0 then
            self:flash_item(item)
            return
        end
    end
    if not managers.money:can_afford_spend_skillpoint(tree, tier, points) then
        self:flash_item(item)
        return
    end
    if tier then
        if points > managers.skilltree:points() then
            self:flash_item(item)
            return
        end
        if managers.skilltree:tier_unlocked(tree, tier) then
            params.skill_name_localized = item._skill_name
            params.points = points
            params.cost = point_cost
            params.remaining_points = managers.skilltree:points()
            params.text_string = "dialog_allocate_skillpoint"
        end
    elseif points <= managers.skilltree:points() then
        params.skill_name_localized = item._skill_name
        params.points = points
        params.cost = point_cost
        params.remaining_points = managers.skilltree:points()
        params.text_string = "dialog_unlock_skilltree"
    end
    if params.text_string then
        --[[params.yes_func = callback(self, self, "_dialog_confirm_yes", item)
        params.no_func = callback(self, self, "_dialog_confirm_no")
        managers.menu:show_confirm_skillpoints(params)]]
        self:_dialog_confirm_yes(item)
    else
        self:flash_item(item)
    end
end

-- removes 'are you sure'
function SkillTreeGui:respec_tree(tree)
    SkillTreeGui._respec_tree(self, tree)
end