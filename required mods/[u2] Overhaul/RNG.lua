local log = _G.u2_core.debug.debug_log and log or function(...) end

if RequiredScript == "core/lib/managers/mission/coreelementlogicchance" then
	core:module("CoreElementLogicChance")
	local on_executed = ElementLogicChance.on_executed
	function ElementLogicChance:on_executed(...)
		local heist = tostring(Global.game_settings.level_id)
		local roll = math.random(100)
		if Global.game_settings then
			if heist == "four_stores" then
					log("ElementLogicChance: four_stores")
					if self._id == 102422 or self._id == 102423 or self._id == 102424 then --safes
						self._chance = math.huge
					end
				elseif heist == "branchbank" then
					log("ElementLogicChance: branchbank")
					if self._id == 102194 then --chanceOfNoSafe
						self._chance = -math.huge
					end
				elseif heist == "mallcrasher" then
					
				elseif heist == "firestarter_1" then
					
				elseif heist == "firestarter_2" then
					log("ElementLogicChance: firestarter_2")
					if self._id == 102658 then --chanceOfNoSafe
						self._chance = -math.huge
					elseif self._id == 102747 then --gold
						self._chance = math.huge
					elseif self._id == 102731 then --cash
						self._chance = math.huge
					elseif self._id == 102728 then --coke
						self._chance = math.huge
					elseif self._id == 102743 then --wep
						self._chance = math.huge
					elseif self._id == 102836 then --ammo
						self._chance = math.huge
					elseif self._id == 102624 then --fence
						self._chance = -math.huge
					end
				elseif heist == "firestarter_3" then
					log("ElementLogicChance: firestarter_3")
					if self._id == 102194 then --chanceOfNoSafe
						self._chance = -math.huge
					end
				elseif heist == "jewelry_store" then
					log("ElementLogicChance: jewelry_store")
					if self._id == 102056 then --hotdog
						self._chance = math.huge
					end
				elseif heist == "ukrainian_job" then
					log("ElementLogicChance: ukrainian_job")
					if self._id == 102056 then --hotdog
						self._chance = math.huge
					elseif self._id == 100518 then --detector
						self._chance = math.huge
					end
				elseif heist == "framing_frame_1" then
					
				elseif heist == "framing_frame_2" then
					log("ElementLogicChance: framing_frame_2")
					if self._id == 101781 then --ambush
						self._chance = math.huge
					elseif self._id == 101141 then --fence
						self._chance = -math.huge
					elseif self._id == 102012 then --chanceForClosedDoors
						self._chance = math.huge
					end
				elseif heist == "framing_frame_3" then

				elseif heist == "watchdogs_1" then
					log("ElementLogicChance: watchdogs_1")
					if self._id == 102640 then --gate
						self._chance = math.huge
					end
				elseif heist == "watchdogs_2" then
					
				elseif heist == "alex_1" then
					
				elseif heist == "alex_2" then
					log("ElementLogicChance: alex_2")
					if self._id == 104515 then --fbi ambush
						self._chance = math.huge
					elseif self._id == 103294 then --gangster ambush
						self._chance = math.huge
					end
				elseif heist == "alex_3" then

				elseif heist == "welcome_to_the_jungle_1" then
					log("ElementLogicChance: welcome_to_the_jungle_1")
					if self._id == 103270 then --coke trade
						self._chance = math.huge
					elseif self._id == 103324 then --ammo bag
						self._chance = math.huge
					elseif self._id == 103325 then --med bag
						self._chance = math.huge
					elseif self._id == 103356 then --shock fence
						self._chance = math.huge
					end
				elseif heist == "welcome_to_the_jungle_2" then
					log("ElementLogicChance: welcome_to_the_jungle_2")
					if self._id == 103241 then --ammo bag
						self._chance = math.huge
					end
				elseif heist == "nightclub" then

				end
		end
		return on_executed(self, ...)
	end
end

if RequiredScript == "core/lib/managers/mission/coremissionscriptelement" then
	core:module("CoreMissionScriptElement")
	core:import("CoreXml")
	core:import("CoreCode")
	core:import("CoreClass")
	local on_executed = MissionScriptElement.on_executed
	function MissionScriptElement:on_executed(...)
		on_executed(self, ...)
		local heist = tostring(Global.game_settings.level_id)
		if Global.game_settings then
			if heist == "four_stores" then

			elseif heist == "branchbank" then
				log("MissionScriptElement: branchbank")
				--gold amount
				managers.mission._scripts["default"]._elements[104535]._values.amount = 10
				managers.mission._scripts["default"]._elements[104536]._values.amount = 10
				managers.mission._scripts["default"]._elements[104537]._values.amount = 10
				managers.mission._scripts["default"]._elements[104538]._values.amount = 10
				--money amount
				managers.mission._scripts["default"]._elements[104529]._values.amount = 10
				managers.mission._scripts["default"]._elements[104530]._values.amount = 10
				managers.mission._scripts["default"]._elements[104531]._values.amount = 10
				managers.mission._scripts["default"]._elements[104532]._values.amount = 10
				managers.mission._scripts["default"]._elements[104533]._values.amount = 10

			elseif heist == "mallcrasher" then
				
			elseif heist == "firestarter_1" then
				log("MissionScriptElement: firestarter_1")
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
			elseif heist == "firestarter_2" then
				log("MissionScriptElement: firestarter_2")
				--prevent despawn of loot
				managers.mission._scripts["default"]._elements[102827]._values.enabled = false
			elseif heist == "firestarter_3" then

			elseif heist == "jewelry_store" then
				log("MissionScriptElement: jewelry_store")
				--spawn all loot
				managers.mission._scripts["default"]._elements[101615]._values.enabled = false
				managers.mission._scripts["default"]._elements[101611]._values.enabled = false
			elseif heist == "ukrainian_job" then
				log("MissionScriptElement: ukrainian_job")
				--spawn all loot
				managers.mission._scripts["default"]._elements[101615]._values.enabled = false
				managers.mission._scripts["default"]._elements[101611]._values.enabled = false
			elseif heist == "framing_frame_1" then
				
			elseif heist == "framing_frame_2" then

			elseif heist == "framing_frame_3" then

			elseif heist == "watchdogs_1" then

			elseif heist == "watchdogs_2" then
				
			elseif heist == "alex_1" then
				log("MissionScriptElement: alex_1")
				--planks
				managers.mission._scripts["default"]._elements[100803]._values.enabled = false
				managers.mission._scripts["default"]._elements[100822]._values.amount = 18
				--chems
				managers.mission._scripts["default"]._elements[101205]._values.amount = 16
				managers.mission._scripts["default"]._elements[101206]._values.amount = 15
				managers.mission._scripts["default"]._elements[101207]._values.amount = 12
			elseif heist == "alex_2" then
				log("MissionScriptElement: alex_2")
				--show all money
				managers.mission._scripts["default"]._elements[104407]._values.enabled = false
			elseif heist == "alex_3" then

			elseif heist == "welcome_to_the_jungle_1" then

			elseif heist == "welcome_to_the_jungle_2" then

			elseif heist == "nightclub" then

			end
		end
	end
end
