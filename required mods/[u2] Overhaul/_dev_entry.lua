if _G.u2_core.debug.dev_features then
	if Global.game_settings then
		core:module("CoreMissionScriptElement")
		core:import("CoreXml")
		core:import("CoreCode")
		core:import("CoreClass")
		
		MissionScriptElement = MissionScriptElement or class()
		local orig_MissionScriptElement_on_executed = MissionScriptElement.on_executed
		
		if Global.game_settings.level_id == "firestarter_1" then
			log("firestarter_1")
			function MissionScriptElement:on_executed(...)
				orig_MissionScriptElement_on_executed(self, ...)
				--no instant alarm
				managers.mission._scripts["default"]._elements[100943]._values.enabled = false
				--4 hangars
				managers.mission._scripts["default"]._elements[102208]._values.amount = 4
				managers.mission._scripts["default"]._elements[103819]._values.enabled = false
				managers.mission._scripts["default"]._elements[102626]._values.enabled = false
				managers.mission._scripts["default"]._elements[101895]._values.enabled = false
				managers.mission._scripts["default"]._elements[103079]._values.enabled = false
				--4 gas tanks
				managers.mission._scripts["default"]._elements[102794]._values.amount = 4
			end
		elseif Global.game_settings.level_id == "firestarter_2" then
			log("firestarter_2")
			function MissionScriptElement:on_executed(...)
				orig_MissionScriptElement_on_executed(self, ...)
				--loot
				managers.mission._scripts["default"]._elements[102728]._values.chance = 100
				managers.mission._scripts["default"]._elements[102731]._values.chance = 100
				managers.mission._scripts["default"]._elements[102743]._values.chance = 100
				managers.mission._scripts["default"]._elements[102747]._values.chance = 100

				managers.mission._scripts["default"]._elements[102622]._values.execute_on_startup = true

				--escape days?
				managers.mission._scripts["default"]._elements[107285]._values.enabled = true
				managers.mission._scripts["default"]._elements[107286]._values.enabled = true
			end
		elseif Global.game_settings.level_id == "firestarter_3" then
			log("firestarter_3")
			function MissionScriptElement:on_executed(...)
				orig_MissionScriptElement_on_executed(self, ...)
				--manager
				managers.mission._scripts["default"]._elements[101344]._values.enabled = true
				-- some rng nonsense
				managers.mission._scripts["default"]._elements[101075]._values.chance = 100
				managers.mission._scripts["default"]._elements[104515]._values.chance = 100 --gold/money
				managers.mission._scripts["default"]._elements[104517]._values.chance = 100 --gold
				managers.mission._scripts["default"]._elements[102194]._values.chance = 100 --chanceOfNoSafe
				managers.mission._scripts["default"]._elements[102194]._values.chance = 100 --chanceOfNoSafe
				managers.mission._scripts["default"]._elements[100631]._values.chance = 100
				managers.mission._scripts["default"]._elements[102299]._values.chance = 100
				managers.mission._scripts["default"]._elements[103350]._values.chance = 100
				managers.mission._scripts["default"]._elements[105277]._values.chance = 100 --chanceAmbush3
				managers.mission._scripts["default"]._elements[105291]._values.chance = 100
				managers.mission._scripts["default"]._elements[100630]._values.chance = 100
				managers.mission._scripts["default"]._elements[105327]._values.chance = 100
				managers.mission._scripts["default"]._elements[101133]._values.chance = 100 --chanceOfParkingCiv
				managers.mission._scripts["default"]._elements[105496]._values.chance = 100 --chanceAtAll
				managers.mission._scripts["default"]._elements[105585]._values.chance = 100
				managers.mission._scripts["default"]._elements[100195]._values.chance = 100 --chanceExtraDoor
				managers.mission._scripts["default"]._elements[100196]._values.chance = 100 --chanceExtraDoor
				managers.mission._scripts["default"]._elements[101481]._values.chance = 100 --restart
				managers.mission._scripts["default"]._elements[102517]._values.chance = 100
				managers.mission._scripts["default"]._elements[103072]._values.chance = 100 --enableAmbush
			end
		elseif Global.game_settings.level_id == "four_stores" then
			log("four_stores")
			--all big safes spawn
			function MissionScriptElement:on_executed(...)
				orig_MissionScriptElement_on_executed(self, ...)
				
				managers.mission._scripts["drillingMission"]._elements[101447]._values.amount = 999
				
				managers.mission._scripts["drillingMission"]._elements[101479]._values.execute_on_startup = true
				managers.mission._scripts["drillingMission"]._elements[101480]._values.execute_on_startup = true
				managers.mission._scripts["drillingMission"]._elements[101481]._values.execute_on_startup = true
				managers.mission._scripts["drillingMission"]._elements[101482]._values.execute_on_startup = true
				managers.mission._scripts["drillingMission"]._elements[101483]._values.execute_on_startup = true
				
				managers.mission._scripts["drillingMission"]._elements[101774]._values.enabled = false
				managers.mission._scripts["drillingMission"]._elements[101775]._values.enabled = false
				managers.mission._scripts["drillingMission"]._elements[101776]._values.enabled = false
				managers.mission._scripts["drillingMission"]._elements[101777]._values.enabled = false
				managers.mission._scripts["drillingMission"]._elements[101778]._values.enabled = false
				
				managers.mission._scripts["drillingMission"]._elements[102424]._values.chance = 100
				managers.mission._scripts["drillingMission"]._elements[102423]._values.chance = 100
				managers.mission._scripts["drillingMission"]._elements[102422]._values.chance = 100
			end
		elseif Global.game_settings.level_id == "ukrainian_job" then
			log("ukrainian_job")
			--spawn max loot
			function MissionScriptElement:on_executed(...)
				orig_MissionScriptElement_on_executed(self, ...)
				
				managers.mission._scripts["default"]._elements[101615]._values.enabled = false
			end
		elseif Global.game_settings.level_id == "jewelry_store" then
			log("jewelry_store")
			--spawn max loot
			function MissionScriptElement:on_executed(...)
				orig_MissionScriptElement_on_executed(self, ...)
				
				managers.mission._scripts["default"]._elements[101615]._values.enabled = false
			end
		elseif Global.game_settings.level_id == "alex_1" then
			log("alex_1")
			--spawn all planks and chems
			function MissionScriptElement:on_executed(...)
				orig_MissionScriptElement_on_executed(self, ...)
				
				managers.mission._scripts["default"]._elements[100803]._values.enabled = false
				managers.mission._scripts["default"]._elements[100822]._values.amount = 18
				
				managers.mission._scripts["default"]._elements[101205]._values.amount = 16
				managers.mission._scripts["default"]._elements[101206]._values.amount = 15
				managers.mission._scripts["default"]._elements[101207]._values.amount = 12
			end
		elseif Global.game_settings.level_id == "alex_2" then
			log("alex_2")
			--spawn all money, fbi ambush
			function MissionScriptElement:on_executed(...)
				orig_MissionScriptElement_on_executed(self, ...)
				
				managers.mission._scripts["default"]._elements[104407]._values.enabled = false
				
				managers.mission._scripts["default"]._elements[104515]._values.chance = 100
			end
		elseif Global.game_settings.level_id == "branchbank" then
			log("branchbank")
			--spawn all gold or cash, but foce the inner gate to be closed
			function MissionScriptElement:on_executed(...)
				orig_MissionScriptElement_on_executed(self, ...)
				
				managers.mission._scripts["default"]._elements[104535]._values.amount = 5
				managers.mission._scripts["default"]._elements[104536]._values.amount = 5
				managers.mission._scripts["default"]._elements[104537]._values.amount = 5
				managers.mission._scripts["default"]._elements[104538]._values.amount = 5
				
				managers.mission._scripts["default"]._elements[104529]._values.amount = 10
				managers.mission._scripts["default"]._elements[104530]._values.amount = 10
				managers.mission._scripts["default"]._elements[104531]._values.amount = 10
				managers.mission._scripts["default"]._elements[104532]._values.amount = 10
				managers.mission._scripts["default"]._elements[104533]._values.amount = 10
				
				managers.mission._scripts["default"]._elements[100645]._values.enabled = false
			end
		end
	end
	
	-- big oil day 2 stealth until heli lands
	if Global.game_settings and Global.game_settings.level_id == 'welcome_to_the_jungle_2' then
		log("oil")
		core:module("CoreElementUnitSequence")
		core:import("CoreMissionScriptElement")
		core:import("CoreCode")
		core:import("CoreUnit")

		ElementUnitSequence = ElementUnitSequence or class(CoreMissionScriptElement.MissionScriptElement)

		function ElementUnitSequence:init(...)
			ElementUnitSequence.super.init(self, ...)
			--fix lab door
			if tostring(self._id) == '100267' then
				self._values.trigger_list[1].notify_unit_sequence = 'state_door_open'
			end
			--hide pcs after hack
			if tostring(self._id) == '100080' then
				table.insert(self._values.trigger_list, {time=0,notify_unit_id=101602,name='run_sequence',notify_unit_sequence='hide'})
				table.insert(self._values.trigger_list, {time=0,notify_unit_id=101365,name='run_sequence',notify_unit_sequence='state_reset'})
				table.insert(self._values.trigger_list, {time=0,notify_unit_id=101365,name='run_sequence',notify_unit_sequence='state_hide'})
				table.insert(self._values.trigger_list, {time=0,notify_unit_id=101862,name='run_sequence',notify_unit_sequence='hide'})
				table.insert(self._values.trigger_list, {time=0,notify_unit_id=101863,name='run_sequence',notify_unit_sequence='state_reset'})
				table.insert(self._values.trigger_list, {time=0,notify_unit_id=101863,name='run_sequence',notify_unit_sequence='state_hide'})
				table.insert(self._values.trigger_list, {time=0,notify_unit_id=100162,name='run_sequence',notify_unit_sequence='hide'})
				table.insert(self._values.trigger_list, {time=0,notify_unit_id=103320,name='run_sequence',notify_unit_sequence='state_reset'})
				table.insert(self._values.trigger_list, {time=0,notify_unit_id=103320,name='run_sequence',notify_unit_sequence='state_hide'})
			end
			self._unit = CoreUnit.safe_spawn_unit('core/units/run_sequence_dummy/run_sequence_dummy', self._values.position)
			managers.worlddefinition:add_trigger_sequence(self._unit, self._values.trigger_list)
		end
	end
end

-- tested features, ready to be made into their own modules / moved from here
if RequiredScript == "lib/entry" then

end