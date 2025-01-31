function ObjectivesManager:activate_objective( id, load_data, data )
	if not id or not self._objectives[ id ] then
		Application:stack_dump_error( "Bad id to activate objective, "..tostring( id ).."." )
		return
	end
	
	if self._active_objectives[ id ] or self._completed_objectives[ id ]  then
		Application:error( "Tried to activate objective " .. tostring( id ) .. ". This objective is already active or completed" )
		-- self._completed_objectives[ id ] = nil
		-- return
	end
	
	local objective = self._objectives[ id ]
	
	for _,sub_objective in pairs( objective.sub_objectives ) do
		sub_objective.completed = false
	end
	
	objective.current_amount = (load_data and load_data.current_amount) or (data and data.amount and 0) or objective.current_amount
	objective.amount = (load_data and load_data.amount) or (data and data.amount) or objective.amount
	managers.hud:activate_objective( {  id 				= id, 
										text 			= objective.text, 
										sub_objectives 	= objective.sub_objectives, 
										amount 			= objective.amount, 
										current_amount 	= objective.current_amount, 
										amount_text 	= objective.amount_text 
										} )
	if not load_data then
		local title_message = data and data.title_message or managers.localization:text( "mission_objective_activated" )
		-- local text = title_message..objective.text
		local text = objective.text
		--managers.hud:present_mid_text( { text = text, title = title_message, time = 4, icon = nil, event = "stinger_objectivecomplete" } )
	end
	self._active_objectives[ id ] = objective
	self._remind_objectives[ id ] = { next_t = Application:time() + self.REMINDER_INTERVAL }
end