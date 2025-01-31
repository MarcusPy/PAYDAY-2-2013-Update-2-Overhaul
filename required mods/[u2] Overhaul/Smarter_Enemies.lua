-- original taken from https://modworkshop.net/mod/29403
if RequiredScript == "lib/managers/enemymanager" then
	function EnemyManager:reindex_tasks()
		local new_tasks_tbl = {}
		for i=1,#self._queued_tasks do
			local v = self._queued_tasks[i]
			if not v.was_executed then
				table.insert(new_tasks_tbl, v)
			end
		end
		self._queued_tasks = new_tasks_tbl
	end

	function EnemyManager:_update_queued_tasks(t)
		local tasks_executed = 0

		local max_tasks_this_frame = math.ceil(50000)

		-- Instead of breaking the loop when the default tickrate is reached, go up to n tasks per second. Waiting tasks don't count.
		-- Also don't use ipairs for performance-critical stuff, rawdog it with a for-loop

		-- DON'T use a "while tasks, do tasks" pattern. The majority of tasks will actually add more tasks to the queue when executed.
		-- Overkill intended for these to be handled one frame later.
		-- So don't do "while task do task", only go as far as the initial queue size
		-- (Or as far as the task allowance for this frame, whichever is smaller)
		-- If you handle them on the same frame that they were added, you may experience occasional crashes, with the crash log blaming a vanilla function somewhere.
		for i=1, #self._queued_tasks do
			local task_data = self._queued_tasks[i]

			if not task_data.t or task_data.t < t then
				self:_execute_queued_task(i)
				tasks_executed = tasks_executed + 1
			elseif task_data.asap then
				self:_execute_queued_task(i)
				tasks_executed = tasks_executed + 1
			end

			-- If we reached the max allowance, stop
			if tasks_executed > max_tasks_this_frame then
				break
			end

			i = i + 1
		end

		local all_clbks = self._delayed_clbks

		if all_clbks[1] and all_clbks[1][2] < t then
			local clbk = table.remove(all_clbks, 1)[3]

			clbk()
		end
		
		-- Clean up done tasks from the queue while preserving queue order
		-- The order of the task queue is EXTREMELY important, and pairs() and next() cannot guarantee ordering,
		-- while ipairs doesn't work nicely with nil values.
		-- So therefore, the only solution is to set a "done" flag on the task itself,
		-- then make a new table containing only the "not done" tasks and replace the queue with it.
		-- Vanilla uses table.remove but this is extremely slow, this was proven with a benchmark
		self:reindex_tasks()
	end

	-- Same as vanilla but no table.remove, that function is super super slow
	function EnemyManager:_execute_queued_task(i)
		local task = self._queued_tasks[i]
		if task.was_executed then
			-- This happens if a task was canceled/unqueued, don't worry about it
			return
		end

		task.was_executed = true
		
		self._queued_task_executed = true

		if task.v_cb then
			task.v_cb(task.id)
		end

		task.clbk(task.data)
	end

	-- No table.remove
	function EnemyManager:unqueue_task(id)
		local tasks = self._queued_tasks
		local i = #tasks

		while i > 0 do
			if tasks[i].id == id then
				tasks[i].was_executed = true
				return
			end

			i = i - 1
		end
	end
end


if RequiredScript == "lib/managers/group_ai_states/groupaistatebase" then
	-- Holds removed attention objects. This is necessary for maps that might switch from loud back to stealth.
	local removed_attention_objects = {}

	local function is_attention_obj_unnecessary_for_loud(attention_object)
		return not attention_object.nav_tracker and not attention_object.unit:vehicle_driving() or attention_object.unit:in_slot(1) or attention_object.unit:in_slot(17) and attention_object.unit:character_damage()
	end

	local function unregister_attention_objects(self)
		local ai_attention_objects = self:get_all_AI_attention_objects()

		for u_key, attention_object in pairs(ai_attention_objects) do
			if is_attention_obj_unnecessary_for_loud(attention_object) then
				removed_attention_objects[u_key] = attention_object
				attention_object.handler:set_attention(nil)
			end
		end
	end

	local function reregister_attention_objects(self)
		local ai_attention_objects = self:get_all_AI_attention_objects()

		for u_key, attention_object in pairs(removed_attention_objects) do
			-- First, check if the attention object was actually registered again in the meantime. If so, skip it.
			-- If not registered, check if it still exists and is valid.
			if ai_attention_objects[u_key] then
				removed_attention_objects[u_key] = nil
			elseif attention_object and alive(attention_object.unit) then
				self:register_AI_attention_object(attention_object.unit, attention_object.handler, attention_object.nav_tracker, attention_object.team, attention_object.SO_access)
				removed_attention_objects[u_key] = nil
			end
		end
	end

	-- When stealth is enabled/disabled, unregister or re-register "attention objects" that are only useful in stealth (broken windows, corpses, etc.)
	-- Thanks RedFlame for bringing this to my attention!
	Hooks:PostHook(GroupAIStateBase, "set_whisper_mode", "thinkfaster_unregister_attentionobjects_on_loud", function(self, enabled)
		-- Perform as server only
		if Network and not Network:is_server() then
			return
		end

		if enabled then
			-- Going stealth, register previously disabled attention objects again
			reregister_attention_objects(self)
		else
			-- Going loud, unregister useless attention objects
			unregister_attention_objects(self)
		end
	end)

	-- Additionally, when a new object is registered, check if it should actually be registered or not.
	local register_attention_obj_orig = GroupAIStateBase.register_AI_attention_object
	function GroupAIStateBase:register_AI_attention_object(unit, handler, nav_tracker, team, SO_access)
		-- In stealth, always register the object normally
		if managers.groupai:state():whisper_mode() then
			return register_attention_obj_orig(self, unit, handler, nav_tracker, team, SO_access)
		end

		local attention_obj = {
			unit = unit,
			handler = handler,
			nav_tracker = nav_tracker,
			team = team,
			SO_access = SO_access
		}

		if is_attention_obj_unnecessary_for_loud(attention_obj) then
			-- Object is unnecessary, add it to the local table of removed objects so that it could still be re-added later
			removed_attention_objects[unit:key()] = attention_obj
		else
			-- Object is necessary for loud, register it normally
			return register_attention_obj_orig(self, unit, handler, nav_tracker, team, SO_access)
		end    
	end
end