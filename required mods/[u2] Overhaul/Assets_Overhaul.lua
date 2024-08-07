--[[

no_mystery - BOOL / displays asset's name upon selecting it
visible_if_locked - BOOL / use it with upgrade_lock / controls whether the asset is shown if condition isn't met

	upgrade_lock = { category="player", upgrade="additional_assets" } 
	visible_if_locked = false
	+/- no_mystery = false

]]

if RequiredScript == "lib/tweak_data/assetstweakdata" then
	local old_init = AssetsTweakData._init_assets
	function AssetsTweakData:_init_assets( tweak_data, ... )
		old_init(self, tweak_data, ...)
		
		--these values should be incremented respectively as the game updates and money earning gets easier
		local small = 4000
		local medium = 8000
		local big = 12000
		local huge = 16000
		
		-- self.welcome_to_safehouse = {}
		-- self.welcome_to_safehouse.name_id = "menu_asset_welcome_to_safehouse"
		-- self.welcome_to_safehouse.texture = "guis/textures/pd2/mission_briefing/assets/assets_risklevel_1"
		-- self.welcome_to_safehouse.stages = { "safehouse" }
		
		self.ukrainian_job_tiara = {}
		self.ukrainian_job_tiara.name_id = "menu_asset_test_jewelry_store_tiara"
		self.ukrainian_job_tiara.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset01"
		self.ukrainian_job_tiara.stages = { "ukrainian_job" }
		self.ukrainian_job_tiara.money_lock = small
		self.ukrainian_job_tiara.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.ukrainian_job_tiara.visible_if_locked = false
		self.ukrainian_job_tiara.unlock_desc_id = "u2_asset_desc"
		
		self.ukrainian_job_front = {}
		self.ukrainian_job_front.name_id = "menu_asset_test_jewelry_store_front"
		self.ukrainian_job_front.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset02"
		self.ukrainian_job_front.stages = { "ukrainian_job" }
		self.ukrainian_job_front.money_lock = small
		self.ukrainian_job_front.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.ukrainian_job_front.visible_if_locked = false
		self.ukrainian_job_front.unlock_desc_id = "u2_asset_desc"

		self.ukrainian_job_cam = {}
		self.ukrainian_job_cam.name_id = "menu_asset_cam"
		self.ukrainian_job_cam.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset07"
		self.ukrainian_job_cam.stages = { "ukrainian_job" }
		self.ukrainian_job_cam.money_lock = big
		self.ukrainian_job_cam.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.ukrainian_job_cam.visible_if_locked = false
		self.ukrainian_job_cam.unlock_desc_id = "u2_asset_desc"
		
		self.ukrainian_job_metal_detector = {}
		self.ukrainian_job_metal_detector.name_id = "menu_asset_test_jewelry_store_blueprint"
		self.ukrainian_job_metal_detector.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset05"
		self.ukrainian_job_metal_detector.stages = { "ukrainian_job" }
		self.ukrainian_job_metal_detector.money_lock = medium
		self.ukrainian_job_metal_detector.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.ukrainian_job_metal_detector.visible_if_locked = false
		self.ukrainian_job_metal_detector.unlock_desc_id = "u2_asset_desc"
		
		self.ukrainian_job_shutter = {}
		self.ukrainian_job_shutter.name_id = "menu_asset_test_jewelry_store_code"
		self.ukrainian_job_shutter.texture = "guis/textures/pd2/mission_briefing/assets/heist_vlad_asset03_df" --"guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.ukrainian_job_shutter.stages = { "ukrainian_job" }
		self.ukrainian_job_shutter.money_lock = medium
		self.ukrainian_job_shutter.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.ukrainian_job_shutter.visible_if_locked = false
		self.ukrainian_job_shutter.unlock_desc_id = "u2_asset_desc"
		
		--ukrainian_job safe blueprint
		self.security_safe_05x05 = {}
		self.security_safe_05x05.name_id = "menu_asset_test_jewelry_store_safe"
		self.security_safe_05x05.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset04"
		self.security_safe_05x05.stages = { "ukrainian_job" }
		self.security_safe_05x05.money_lock = small
		self.security_safe_05x05.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.security_safe_05x05.visible_if_locked = false
		self.security_safe_05x05.unlock_desc_id = "u2_asset_desc"




--nothing to change here really, could make those purchasable maybe
		self.welcome_to_the_jungle_keycard = {}
		self.welcome_to_the_jungle_keycard.name_id = "menu_asset_welcome_to_the_jungle_keycard"
		self.welcome_to_the_jungle_keycard.unlock_desc_id = "menu_asset_welcome_to_the_jungle_keycard_desc"
		self.welcome_to_the_jungle_keycard.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset07"
		self.welcome_to_the_jungle_keycard.stages = { "welcome_to_the_jungle_2" }
		self.welcome_to_the_jungle_keycard.job_lock = "keycard"

		self.welcome_to_the_jungle_shuttercode = {}
		self.welcome_to_the_jungle_shuttercode.name_id = "menu_asset_welcome_to_the_jungle_shuttercode"
		self.welcome_to_the_jungle_shuttercode.unlock_desc_id = "menu_asset_welcome_to_the_jungle_shuttercode_desc"
		self.welcome_to_the_jungle_shuttercode.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset02"
		self.welcome_to_the_jungle_shuttercode.stages = { "welcome_to_the_jungle_2" }
		self.welcome_to_the_jungle_shuttercode.job_lock = "shuttercode"

		self.welcome_to_the_jungle_plane_keys = {}
		self.welcome_to_the_jungle_plane_keys.name_id = "menu_asset_welcome_to_the_jungle_plane_keys"
		self.welcome_to_the_jungle_plane_keys.unlock_desc_id = "menu_asset_welcome_to_the_jungle_plane_keys_desc"
		self.welcome_to_the_jungle_plane_keys.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset05"
		self.welcome_to_the_jungle_plane_keys.stages = { "welcome_to_the_jungle_2" }
		self.welcome_to_the_jungle_plane_keys.job_lock = "planekeys"

		-- ASSET IMAGE MISSING
		self.welcome_to_the_jungle_blueprints = {}
		self.welcome_to_the_jungle_blueprints.name_id = "menu_asset_welcome_to_the_jungle_blueprints"
		self.welcome_to_the_jungle_blueprints.unlock_desc_id = "menu_asset_welcome_to_the_jungle_blueprints_desc"
		self.welcome_to_the_jungle_blueprints.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset09"
		self.welcome_to_the_jungle_blueprints.stages = { "welcome_to_the_jungle_2" }
		self.welcome_to_the_jungle_blueprints.job_lock = "blueprints"

		self.welcome_to_the_jungle_fusion = {}
		self.welcome_to_the_jungle_fusion.name_id = "menu_asset_welcome_to_the_jungle_fusion"
		self.welcome_to_the_jungle_fusion.unlock_desc_id = "menu_asset_welcome_to_the_jungle_fusion_desc"
		self.welcome_to_the_jungle_fusion.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset08"
		self.welcome_to_the_jungle_fusion.stages = { "welcome_to_the_jungle_2" }
		self.welcome_to_the_jungle_fusion.job_lock = "fusion"

		self.welcome_to_the_jungle_guards = {}
		self.welcome_to_the_jungle_guards.name_id = "menu_asset_welcome_to_the_jungle_guards"
		self.welcome_to_the_jungle_guards.unlock_desc_id = "menu_asset_welcome_to_the_jungle_guards_desc"
		self.welcome_to_the_jungle_guards.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset06"
		self.welcome_to_the_jungle_guards.stages = { "welcome_to_the_jungle_2" }
		self.welcome_to_the_jungle_guards.job_lock = "guards"

		self.welcome_to_the_jungle_rossy = {}
		self.welcome_to_the_jungle_rossy.name_id = "menu_asset_welcome_to_the_jungle_rossy"
		self.welcome_to_the_jungle_rossy.unlock_desc_id = "menu_asset_welcome_to_the_jungle_rossy_desc"
		self.welcome_to_the_jungle_rossy.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset04"
		self.welcome_to_the_jungle_rossy.stages = { "welcome_to_the_jungle_2" }
		self.welcome_to_the_jungle_rossy.job_lock = "rossy"
--until here






--unused for now
		-- CURRENTLY NOT IN RELEASE
		self.election_day_2_gold = {}
		self.election_day_2_gold.name_id = "menu_asset_election_day_2_gold"
		self.election_day_2_gold.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset05"
		self.election_day_2_gold.stages = { "election_day_2" }
		self.election_day_2_gold.visible_if_locked = true
		self.election_day_2_gold.unlock_desc_id = "menu_asset_election_day_2_gold_desc"
		self.election_day_2_gold.money_lock = tweak_data:get_value( "money_manager", "mission_asset_cost_small", 4 ) --   tweak_data.money_manager.mission_asset_cost_small[4]
		self.election_day_2_gold.no_mystery = true
		
		self.election_day_2_money = {}
		self.election_day_2_money.name_id = "menu_asset_election_day_2_money"
		self.election_day_2_money.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.election_day_2_money.stages = { "election_day_2" }
		self.election_day_2_money.visible_if_locked = true
		self.election_day_2_money.unlock_desc_id = "menu_asset_election_day_2_money_desc"
		self.election_day_2_money.no_mystery = true
		self.election_day_2_money.money_lock = tweak_data:get_value( "money_manager", "mission_asset_cost_small", 3 ) --   tweak_data.money_manager.mission_asset_cost_small[3]
		
		self.election_day_2_painting = {}
		self.election_day_2_painting.name_id = "menu_asset_election_day_2_painting"
		self.election_day_2_painting.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.election_day_2_painting.stages = { "election_day_2" }
		self.election_day_2_painting.visible_if_locked = true
		self.election_day_2_painting.unlock_desc_id = "menu_asset_election_day_2_painting_desc"
		self.election_day_2_painting.no_mystery = true
		self.election_day_2_painting.money_lock = tweak_data:get_value( "money_manager", "mission_asset_cost_small", 2 ) --   tweak_data.money_manager.mission_asset_cost_small[2]
--until here






		-- AMMO BAGSC:\Projects\payday2\trunk\assets\guis\textures\pd2\mission_briefing\assets\watch_dogs\day1
		self.watchdogs_1_ammo = {}
		self.watchdogs_1_ammo.name_id = "menu_asset_ammo"
		self.watchdogs_1_ammo.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset01"
		self.watchdogs_1_ammo.stages = { "watchdogs_1" }
		self.watchdogs_1_ammo.money_lock = big
		self.watchdogs_1_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.watchdogs_1_ammo.visible_if_locked = false
		self.watchdogs_1_ammo.unlock_desc_id = "u2_asset_desc"

		self.watchdogs_1_health = {}
		self.watchdogs_1_health.name_id = "menu_asset_health"
		self.watchdogs_1_health.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset02"
		self.watchdogs_1_health.stages = { "watchdogs_1" }
		self.watchdogs_1_health.money_lock = big
		self.watchdogs_1_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.watchdogs_1_health.visible_if_locked = false
		self.watchdogs_1_health.unlock_desc_id = "u2_asset_desc"

		self.watchdogs_1_escape_car = {}
		self.watchdogs_1_escape_car.name_id = "menu_asset_watchdogs_escape"
		self.watchdogs_1_escape_car.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/escapecar"
		self.watchdogs_1_escape_car.stages = { "watchdogs_1" }
		self.watchdogs_1_escape_car.money_lock = huge
		self.watchdogs_1_escape_car.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.watchdogs_1_escape_car.visible_if_locked = false
		self.watchdogs_1_escape_car.unlock_desc_id = "u2_asset_desc"

		--[[
		--deprecated?
		self.watchdogs_1_hatch = {}
		self.watchdogs_1_hatch.name_id = "menu_asset_watchdogs_hatch"
		self.watchdogs_1_hatch.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset03"
		self.watchdogs_1_hatch.stages = { "watchdogs_1" }
		self.watchdogs_1_hatch.visible_if_locked = true
		self.watchdogs_1_hatch.unlock_desc_id = "menu_asset_watchdogs_hatch_desc"
		self.watchdogs_1_hatch.no_mystery = true
		self.watchdogs_1_hatch.money_lock = tweak_data.money_manager.mission_asset_cost_small[2]
		]]

		self.watchdogs_2_ammo = {}
		self.watchdogs_2_ammo.name_id = "menu_asset_ammo"
		self.watchdogs_2_ammo.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day2/assets_watchdogs2_ammo"
		self.watchdogs_2_ammo.stages = { "watchdogs_2" }
		self.watchdogs_2_ammo.money_lock = big
		self.watchdogs_2_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.watchdogs_2_ammo.visible_if_locked = false
		self.watchdogs_2_ammo.unlock_desc_id = "u2_asset_desc"

		self.watchdogs_2_health = {}
		self.watchdogs_2_health.name_id = "menu_asset_health"
		self.watchdogs_2_health.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day2/assets_watchdogs2_medic"
		self.watchdogs_2_health.stages = { "watchdogs_2" }
		self.watchdogs_2_health.money_lock = big
		self.watchdogs_2_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.watchdogs_2_health.visible_if_locked = false
		self.watchdogs_2_health.unlock_desc_id = "u2_asset_desc"

		self.watchdogs_2_sniper = {}
		self.watchdogs_2_sniper.name_id = "menu_asset_sniper"
		self.watchdogs_2_sniper.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day2/assets_watchdogs_sniper"
		self.watchdogs_2_sniper.stages = { "watchdogs_2" }
		self.watchdogs_2_sniper.money_lock = huge
		self.watchdogs_2_sniper.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.watchdogs_2_sniper.visible_if_locked = false
		self.watchdogs_2_sniper.unlock_desc_id = "u2_asset_desc"










		self.firestarter_1_ammo = {}
		self.firestarter_1_ammo.name_id = "menu_asset_ammo"
		self.firestarter_1_ammo.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset01"
		self.firestarter_1_ammo.stages = { "firestarter_1" }
		self.firestarter_1_ammo.money_lock = big
		self.firestarter_1_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_1_ammo.visible_if_locked = false
		self.firestarter_1_ammo.unlock_desc_id = "u2_asset_desc"

		self.firestarter_1_health = {}
		self.firestarter_1_health.name_id = "menu_asset_health"
		self.firestarter_1_health.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset02"
		self.firestarter_1_health.stages = { "firestarter_1" }
		self.firestarter_1_health.money_lock = big
		self.firestarter_1_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_1_health.visible_if_locked = false
		self.firestarter_1_health.unlock_desc_id = "u2_asset_desc"

--requires testing to see if it even works
		self.firestarter_2_ammo = {}
		self.firestarter_2_ammo.name_id = "menu_asset_ammo"
		self.firestarter_2_ammo.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.firestarter_2_ammo.stages = { "firestarter_2" }
		self.firestarter_2_ammo.money_lock = big
		self.firestarter_2_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_2_ammo.visible_if_locked = false
		self.firestarter_2_ammo.unlock_desc_id = "u2_asset_desc"

		self.firestarter_2_health = {}
		self.firestarter_2_health.name_id = "menu_asset_health"
		self.firestarter_2_health.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.firestarter_2_health.stages = { "firestarter_2" }
		self.firestarter_2_health.money_lock = big
		self.firestarter_2_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_2_health.visible_if_locked = false
		self.firestarter_2_health.unlock_desc_id = "u2_asset_desc"
--until here

		self.firestarter_2_cam = {}
		self.firestarter_2_cam.name_id = "menu_asset_cam"
		self.firestarter_2_cam.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset03"
		self.firestarter_2_cam.stages = { "firestarter_2" }
		self.firestarter_2_cam.money_lock = huge
		self.firestarter_2_cam.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_2_cam.visible_if_locked = false
		self.firestarter_2_cam.unlock_desc_id = "u2_asset_desc"

--requires testing to see if it even works
		self.firestarter_3_ammo = {}
		self.firestarter_3_ammo.name_id = "menu_asset_ammo"
		self.firestarter_3_ammo.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.firestarter_3_ammo.stages = { "firestarter_3" }
		self.firestarter_3_ammo.money_lock = big
		self.firestarter_3_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_3_ammo.visible_if_locked = false
		self.firestarter_3_ammo.unlock_desc_id = "u2_asset_desc"

		self.firestarter_3_health = {}
		self.firestarter_3_health.name_id = "menu_asset_health"
		self.firestarter_3_health.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.firestarter_3_health.stages = { "firestarter_3" }
		self.firestarter_3_health.money_lock = big
		self.firestarter_3_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_3_health.visible_if_locked = false
		self.firestarter_3_health.unlock_desc_id = "u2_asset_desc"

		self.firestarter_3_cam = {}
		self.firestarter_3_cam.name_id = "menu_asset_cam"
		self.firestarter_3_cam.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.firestarter_3_cam.stages = { "firestarter_3" }
		self.firestarter_3_cam.money_lock = big
		self.firestarter_3_cam.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_3_cam.visible_if_locked = false
		self.firestarter_3_cam.unlock_desc_id = "u2_asset_desc"
--until here

		self.firestarter_3_insiderinfo = {}
		self.firestarter_3_insiderinfo.name_id = "menu_asset_branchbank_insiderinfo"
		self.firestarter_3_insiderinfo.texture = "guis/textures/pd2/mission_briefing/assets/bank/assets_bank_insiderinfo"
		self.firestarter_3_insiderinfo.stages = { "firestarter_3" }
		self.firestarter_3_insiderinfo.money_lock = medium
		self.firestarter_3_insiderinfo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_3_insiderinfo.visible_if_locked = false
		self.firestarter_3_insiderinfo.unlock_desc_id = "u2_asset_desc"

		self.firestarter_3_map_basic = {}
		self.firestarter_3_map_basic.name_id = "menu_asset_branchbank_blueprint"
		self.firestarter_3_map_basic.texture = "guis/textures/pd2/mission_briefing/assets/bank/assets_bank_blueprint"
		self.firestarter_3_map_basic.stages = { "firestarter_3" }
		self.firestarter_3_map_basic.money_lock = medium
		self.firestarter_3_map_basic.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.firestarter_3_map_basic.visible_if_locked = false
		self.firestarter_3_map_basic.unlock_desc_id = "u2_asset_desc"








		self.framing_frame_1_blueprint = {}
		self.framing_frame_1_blueprint.name_id = "menu_asset_framing_frame_1_blueprint"
		self.framing_frame_1_blueprint.texture = "guis/textures/pd2/mission_briefing/assets/framing_frame/day1/assets_framingframe_blueprint"
		self.framing_frame_1_blueprint.stages = { "framing_frame_1" }
		self.framing_frame_1_blueprint.money_lock = medium
		self.framing_frame_1_blueprint.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_1_blueprint.visible_if_locked = false
		self.framing_frame_1_blueprint.unlock_desc_id = "u2_asset_desc"
		
		self.framing_frame_1_ammo = {}
		self.framing_frame_1_ammo.name_id = "menu_asset_ammo"
		self.framing_frame_1_ammo.texture = "guis/textures/pd2/mission_briefing/assets/framing_frame/day1/assets_framingframe_ammo"
		self.framing_frame_1_ammo.stages = { "framing_frame_1" }
		self.framing_frame_1_ammo.money_lock = big
		self.framing_frame_1_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_1_ammo.visible_if_locked = false
		self.framing_frame_1_ammo.unlock_desc_id = "u2_asset_desc"

		self.framing_frame_1_health = {}
		self.framing_frame_1_health.name_id = "menu_asset_health"
		self.framing_frame_1_health.texture = "guis/textures/pd2/mission_briefing/assets/framing_frame/day1/assets_framingframe_medic"
		self.framing_frame_1_health.stages = { "framing_frame_1" }
		self.framing_frame_1_health.money_lock = big
		self.framing_frame_1_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_1_health.visible_if_locked = false
		self.framing_frame_1_health.unlock_desc_id = "u2_asset_desc"

		self.framing_frame_1_cam = {}
		self.framing_frame_1_cam.name_id = "menu_asset_cam"
		self.framing_frame_1_cam.texture = "guis/textures/pd2/mission_briefing/assets/framing_frame/day1/assets_framingframe_cam"
		self.framing_frame_1_cam.stages = { "framing_frame_1" }
		self.framing_frame_1_cam.money_lock = big
		self.framing_frame_1_cam.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_1_cam.visible_if_locked = false
		self.framing_frame_1_cam.unlock_desc_id = "u2_asset_desc"

		self.framing_frame_1_keycard = {}
		self.framing_frame_1_keycard.name_id = "menu_asset_framing_frame_1_keycard"
		self.framing_frame_1_keycard.texture = "guis/textures/pd2/mission_briefing/assets/framing_frame/day1/assets_framingframe_keycard"
		self.framing_frame_1_keycard.stages = { "framing_frame_1" }
		self.framing_frame_1_keycard.money_lock = huge
		self.framing_frame_1_keycard.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_1_keycard.visible_if_locked = false
		self.framing_frame_1_keycard.unlock_desc_id = "u2_asset_desc"

		self.framing_frame_1_art = {}
		self.framing_frame_1_art.name_id = "menu_asset_framing_frame_art"
		self.framing_frame_1_art.texture = "guis/textures/pd2/mission_briefing/assets/framing_frame/day1/assets_framingframe_art"
		self.framing_frame_1_art.stages = { "framing_frame_1" }
		self.framing_frame_1_art.money_lock = small
		self.framing_frame_1_art.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_1_art.visible_if_locked = false
		self.framing_frame_1_art.unlock_desc_id = "u2_asset_desc"

		self.framing_frame_1_truck = {}
		self.framing_frame_1_truck.name_id = "menu_asset_framing_frame_truck"
		self.framing_frame_1_truck.texture = "guis/textures/pd2/mission_briefing/assets/framing_frame/day1/assets_framingframe_roofaccess"
		self.framing_frame_1_truck.stages = { "framing_frame_1" }
		self.framing_frame_1_truck.money_lock = small
		self.framing_frame_1_truck.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_1_truck.visible_if_locked = false
		self.framing_frame_1_truck.unlock_desc_id = "u2_asset_desc"

		self.framing_frame_2_sniper = {}
		self.framing_frame_2_sniper.name_id = "menu_asset_sniper"
		self.framing_frame_2_sniper.texture = "guis/textures/pd2/mission_briefing/assets/framing_frame/day2/asset01"
		self.framing_frame_2_sniper.stages = { "framing_frame_2" }
		self.framing_frame_2_sniper.money_lock = big
		self.framing_frame_2_sniper.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_2_sniper.visible_if_locked = false
		self.framing_frame_2_sniper.unlock_desc_id = "u2_asset_desc"

		self.framing_frame_3_ammo = {}
		self.framing_frame_3_ammo.name_id = "menu_asset_ammo"
		self.framing_frame_3_ammo.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset01"
		self.framing_frame_3_ammo.stages = { "framing_frame_3" }
		self.framing_frame_3_ammo.money_lock = big
		self.framing_frame_3_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_3_ammo.visible_if_locked = false
		self.framing_frame_3_ammo.unlock_desc_id = "u2_asset_desc"

		self.framing_frame_3_health = {}
		self.framing_frame_3_health.name_id = "menu_asset_health"
		self.framing_frame_3_health.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset02"
		self.framing_frame_3_health.stages = { "framing_frame_3" }
		self.framing_frame_3_health.money_lock = big
		self.framing_frame_3_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_3_health.visible_if_locked = false
		self.framing_frame_3_health.unlock_desc_id = "u2_asset_desc"

		self.framing_frame_3_vent = {}
		self.framing_frame_3_vent.name_id = "menu_asset_framing3_vent"
		self.framing_frame_3_vent.texture = "guis/textures/pd2/mission_briefing/assets/framing_frame/day3/asset01"
		self.framing_frame_3_vent.stages = { "framing_frame_3" }
		self.framing_frame_3_vent.money_lock = medium
		self.framing_frame_3_vent.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.framing_frame_3_vent.visible_if_locked = false
		self.framing_frame_3_vent.unlock_desc_id = "u2_asset_desc"







--unused for now
		-- NOT IN LAUNCH BUILD 
		self.election_day_2_ammo = {}
		self.election_day_2_ammo.name_id = "menu_asset_ammo"
		self.election_day_2_ammo.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.election_day_2_ammo.stages = { "election_day_2" }
		self.election_day_2_ammo.visible_if_locked = true
		self.election_day_2_ammo.unlock_desc_id = "menu_asset_ammo_desc"
		self.election_day_2_ammo.no_mystery = true
		self.election_day_2_ammo.money_lock = tweak_data:get_value( "money_manager", "mission_asset_cost_small", 2 ) --   tweak_data.money_manager.mission_asset_cost_small[2]

		self.election_day_2_health = {}
		self.election_day_2_health.name_id = "menu_asset_h"
		self.election_day_2_health.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.election_day_2_health.stages = { "election_day_2" }
		self.election_day_2_health.visible_if_locked = true
		self.election_day_2_health.unlock_desc_id = "menu_asset_health_desc"
		self.election_day_2_health.no_mystery = true
		self.election_day_2_health.money_lock = tweak_data:get_value( "money_manager", "mission_asset_cost_small", 2 ) --   tweak_data.money_manager.mission_asset_cost_small[2]

		self.election_day_3_ammo = {}
		self.election_day_3_ammo.name_id = "menu_asset_ammo"
		self.election_day_3_ammo.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.election_day_3_ammo.stages = { "election_day_3" }
		self.election_day_3_ammo.visible_if_locked = true
		self.election_day_3_ammo.unlock_desc_id = "menu_asset_ammo_desc"
		self.election_day_3_ammo.no_mystery = true
		self.election_day_3_ammo.money_lock = tweak_data:get_value( "money_manager", "mission_asset_cost_small", 2 ) --   tweak_data.money_manager.mission_asset_cost_small[2]

		self.election_day_3_health = {}
		self.election_day_3_health.name_id = "menu_asset_health"
		self.election_day_3_health.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.election_day_3_health.stages = { "election_day_3" }
		self.election_day_3_health.visible_if_locked = true
		self.election_day_3_health.unlock_desc_id = "menu_asset_health_desc"
		self.election_day_3_health.no_mystery = true
		self.election_day_3_health.money_lock = tweak_data:get_value( "money_manager", "mission_asset_cost_small", 2 ) --   tweak_data.money_manager.mission_asset_cost_small[2]
--until now







--jungle = big oil (welcome_to_the_jungle_x)
		self.jungle_1_bikers = {}
		self.jungle_1_bikers.name_id = "menu_asset_big_oil_1_bikers"
		self.jungle_1_bikers.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day1/big_oil_1_biker_gang"
		self.jungle_1_bikers.stages = { "welcome_to_the_jungle_1" }
		self.jungle_1_bikers.money_lock = small
		self.jungle_1_bikers.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.jungle_1_bikers.visible_if_locked = false
		self.jungle_1_bikers.unlock_desc_id = "u2_asset_desc"


		self.jungle_2_gas = {}
		self.jungle_2_gas.name_id = "menu_asset_jungle_2_gas"
		self.jungle_2_gas.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset01"
		self.jungle_2_gas.stages = { "welcome_to_the_jungle_2" }
		self.jungle_2_gas.money_lock = medium
		self.jungle_2_gas.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.jungle_2_gas.visible_if_locked = false
		self.jungle_2_gas.unlock_desc_id = "u2_asset_desc"

		self.jungle_2_cam = {}
		self.jungle_2_cam.name_id = "menu_asset_cam"
		self.jungle_2_cam.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset03"
		self.jungle_2_cam.stages = { "welcome_to_the_jungle_2" }
		self.jungle_2_cam.money_lock = medium
		self.jungle_2_cam.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.jungle_2_cam.visible_if_locked = false
		self.jungle_2_cam.unlock_desc_id = "u2_asset_desc"

		self.jungle_2_ammo = {}
		self.jungle_2_ammo.name_id = "menu_asset_jungle_2_ammo"
		self.jungle_2_ammo.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset01"
		self.jungle_2_ammo.stages = { "welcome_to_the_jungle_2" }
		self.jungle_2_ammo.money_lock = small
		self.jungle_2_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.jungle_2_ammo.visible_if_locked = false
		self.jungle_2_ammo.unlock_desc_id = "u2_asset_desc"

--requires testing to see if it works
		self.jungle_2_health = {}
		self.jungle_2_health.name_id = "menu_asset_health"
		self.jungle_2_health.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.jungle_2_health.stages = { "welcome_to_the_jungle_2" }
		self.jungle_2_health.money_lock = medium
		self.jungle_2_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.jungle_2_health.visible_if_locked = false
		self.jungle_2_health.unlock_desc_id = "u2_asset_desc"

		self.jungle_1_ammo = {}
		self.jungle_1_ammo.name_id = "menu_asset_ammo"
		self.jungle_1_ammo.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.jungle_1_ammo.stages = { "welcome_to_the_jungle_1" }
		self.jungle_1_ammo.money_lock = big
		self.jungle_1_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.jungle_1_ammo.visible_if_locked = false
		self.jungle_1_ammo.unlock_desc_id = "u2_asset_desc"

		self.jungle_1_health = {}
		self.jungle_1_health.name_id = "menu_asset_health"
		self.jungle_1_health.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		self.jungle_1_health.stages = { "welcome_to_the_jungle_1" }
		self.jungle_1_health.money_lock = big
		self.jungle_1_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.jungle_1_health.visible_if_locked = false
		self.jungle_1_health.unlock_desc_id = "u2_asset_desc"
--until here









		self.branchbank_ammo = {}
		self.branchbank_ammo.name_id = "menu_asset_branchbank_ammo"
		self.branchbank_ammo.texture = "guis/textures/pd2/mission_briefing/assets/bank/assets_bank_ammo"
		self.branchbank_ammo.stages = { "branchbank" }
		self.branchbank_ammo.money_lock = big
		self.branchbank_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.branchbank_ammo.visible_if_locked = false
		self.branchbank_ammo.unlock_desc_id = "u2_asset_desc"

		self.branchbank_health = {}
		self.branchbank_health.name_id = "menu_asset_health"
		self.branchbank_health.texture = "guis/textures/pd2/mission_briefing/assets/bank/assets_bank_medicbag"
		self.branchbank_health.stages = { "branchbank" }
		self.branchbank_health.money_lock = big
		self.branchbank_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.branchbank_health.visible_if_locked = false
		self.branchbank_health.unlock_desc_id = "u2_asset_desc"

		self.branchbank_cam = {}
		self.branchbank_cam.name_id = "menu_asset_cam"
		self.branchbank_cam.texture = "guis/textures/pd2/mission_briefing/assets/big_oil/day2/asset03"
		self.branchbank_cam.stages = { "branchbank" }
		self.branchbank_cam.money_lock = big
		self.branchbank_cam.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.branchbank_cam.visible_if_locked = false
		self.branchbank_cam.unlock_desc_id = "u2_asset_desc"
		
		self.branchbank_insiderinfo = {}
		self.branchbank_insiderinfo.name_id = "menu_asset_branchbank_insiderinfo"
		self.branchbank_insiderinfo.texture = "guis/textures/pd2/mission_briefing/assets/bank/assets_bank_insiderinfo"
		self.branchbank_insiderinfo.stages = { "branchbank" }
		self.branchbank_insiderinfo.money_lock = medium
		self.branchbank_insiderinfo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.branchbank_insiderinfo.visible_if_locked = false
		self.branchbank_insiderinfo.unlock_desc_id = "u2_asset_desc"

		self.branchbank_map_basic = {}
		self.branchbank_map_basic.name_id = "menu_asset_branchbank_blueprint"
		self.branchbank_map_basic.texture = "guis/textures/pd2/mission_briefing/assets/bank/assets_bank_blueprint"
		self.branchbank_map_basic.stages = { "branchbank" }
		self.branchbank_map_basic.money_lock = small
		self.branchbank_map_basic.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.branchbank_map_basic.visible_if_locked = false
		self.branchbank_map_basic.unlock_desc_id = "u2_asset_desc"










		self.rat_1_ammo = {}
		self.rat_1_ammo.name_id = "menu_asset_ammo"
		self.rat_1_ammo.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset01"
		self.rat_1_ammo.stages = { "alex_1" }
		self.rat_1_ammo.money_lock = big
		self.rat_1_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.rat_1_ammo.visible_if_locked = false
		self.rat_1_ammo.unlock_desc_id = "u2_asset_desc"

		self.rat_1_health = {}
		self.rat_1_health.name_id = "menu_asset_health"
		self.rat_1_health.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset02"
		self.rat_1_health.stages = { "alex_1" }
		self.rat_1_health.money_lock = big
		self.rat_1_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.rat_1_health.visible_if_locked = false
		self.rat_1_health.unlock_desc_id = "u2_asset_desc"

		self.rat_1_lights = {}
		self.rat_1_lights.name_id = "menu_asset_lights"
		self.rat_1_lights.texture = "guis/textures/pd2/mission_briefing/assets/rat/day1/asset01"
		self.rat_1_lights.stages = { "alex_1" }
		self.rat_1_lights.money_lock = small
		self.rat_1_lights.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.rat_1_lights.visible_if_locked = false
		self.rat_1_lights.unlock_desc_id = "u2_asset_desc"

		self.rat_3_pilot = {}
		self.rat_3_pilot.name_id = "menu_asset_pilot"
		self.rat_3_pilot.texture = "guis/textures/pd2/mission_briefing/assets/rat/day3/asset01"
		self.rat_3_pilot.stages = { "alex_3" }
		self.rat_3_pilot.money_lock = huge
		self.rat_3_pilot.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.rat_3_pilot.visible_if_locked = false
		self.rat_3_pilot.unlock_desc_id = "u2_asset_desc"
		
		
		
		
		
		
		
		
		

		self.mallcrasher_ammo = {}
		self.mallcrasher_ammo.name_id = "menu_asset_ammo"
		self.mallcrasher_ammo.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset01"
		self.mallcrasher_ammo.stages = { "mallcrasher" }
		self.mallcrasher_ammo.money_lock = big
		self.mallcrasher_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.mallcrasher_ammo.visible_if_locked = false
		self.mallcrasher_ammo.unlock_desc_id = "u2_asset_desc"

		self.mallcrasher_health = {}
		self.mallcrasher_health.name_id = "menu_asset_health"
		self.mallcrasher_health.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset02"
		self.mallcrasher_health.stages = { "mallcrasher" }
		self.mallcrasher_health.money_lock = big
		self.mallcrasher_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.mallcrasher_health.visible_if_locked = false
		self.mallcrasher_health.unlock_desc_id = "u2_asset_desc"

		self.mallcrasher_gascan_south = {}
		self.mallcrasher_gascan_south.name_id = "menu_asset_mallcrasher_gascan_south"
		self.mallcrasher_gascan_south.texture = "guis/textures/pd2/mission_briefing/assets/mallcrasher/asset01"
		self.mallcrasher_gascan_south.stages = { "mallcrasher" }
		self.mallcrasher_gascan_south.money_lock = small
		self.mallcrasher_gascan_south.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.mallcrasher_gascan_south.visible_if_locked = false
		self.mallcrasher_gascan_south.unlock_desc_id = "u2_asset_desc"

		self.mallcrasher_gascan_north = {}
		self.mallcrasher_gascan_north.name_id = "menu_asset_mallcrasher_gascan_north"
		self.mallcrasher_gascan_north.texture = "guis/textures/pd2/mission_briefing/assets/mallcrasher/asset02"
		self.mallcrasher_gascan_north.stages = { "mallcrasher" }
		self.mallcrasher_gascan_north.money_lock = small
		self.mallcrasher_gascan_north.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.mallcrasher_gascan_north.visible_if_locked = false
		self.mallcrasher_gascan_north.unlock_desc_id = "u2_asset_desc"
		
		
		
		
		
		
		
		
		

		self.nightclub_ammo = {}
		self.nightclub_ammo.name_id = "menu_asset_ammo"
		self.nightclub_ammo.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset01"
		self.nightclub_ammo.stages = { "nightclub" }
		self.nightclub_ammo.money_lock = big
		self.nightclub_ammo.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.nightclub_ammo.visible_if_locked = false
		self.nightclub_ammo.unlock_desc_id = "u2_asset_desc"

		self.nightclub_health = {}
		self.nightclub_health.name_id = "menu_asset_health"
		self.nightclub_health.texture = "guis/textures/pd2/mission_briefing/assets/watch_dogs/day1/asset02"
		self.nightclub_health.stages = { "nightclub" }
		self.nightclub_health.money_lock = big
		self.nightclub_health.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.nightclub_health.visible_if_locked = false
		self.nightclub_health.unlock_desc_id = "u2_asset_desc"

		self.nightclub_fire1 = {}
		self.nightclub_fire1.name_id = "menu_asset_nightclub_fire1"
		self.nightclub_fire1.texture = "guis/textures/pd2/mission_briefing/assets/nightclub/asset04"
		self.nightclub_fire1.stages = { "nightclub" }
		self.nightclub_fire1.money_lock = small
		self.nightclub_fire1.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.nightclub_fire1.visible_if_locked = false
		self.nightclub_fire1.unlock_desc_id = "u2_asset_desc"

		self.nightclub_fire2 = {}
		self.nightclub_fire2.name_id = "menu_asset_nightclub_fire2"
		self.nightclub_fire2.texture = "guis/textures/pd2/mission_briefing/assets/nightclub/asset03"
		self.nightclub_fire2.stages = { "nightclub" }
		self.nightclub_fire2.money_lock = small
		self.nightclub_fire2.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.nightclub_fire2.visible_if_locked = false
		self.nightclub_fire2.unlock_desc_id = "u2_asset_desc"

		self.nightclub_badmusic = {}
		self.nightclub_badmusic.name_id = "menu_asset_nightclub_badmusic"
		self.nightclub_badmusic.texture = "guis/textures/pd2/mission_briefing/assets/nightclub/asset02"
		self.nightclub_badmusic.stages = { "nightclub" }
		self.nightclub_badmusic.money_lock = medium
		self.nightclub_badmusic.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.nightclub_badmusic.visible_if_locked = false
		self.nightclub_badmusic.unlock_desc_id = "u2_asset_desc"

		--deprecated
		-- self.nightclub_goodmusic = {}
		-- self.nightclub_goodmusic.name_id = "menu_asset_nightclub_goodmusic"
		-- self.nightclub_goodmusic.texture = "guis/textures/pd2/mission_briefing/assets/ukranian_job/asset06"
		-- self.nightclub_goodmusic.stages = { "nightclub" }
		-- self.nightclub_goodmusic.visible_if_locked = true
		-- self.nightclub_goodmusic.unlock_desc_id = "menu_asset_nightclub_goodmusic_desc"
		-- self.nightclub_goodmusic.no_mystery = true
		-- self.nightclub_goodmusic.money_lock = tweak_data.money_manager.mission_asset_cost_small[2]

		self.nightclub_lootpickup = {}
		self.nightclub_lootpickup.name_id = "menu_asset_nightclub_lootpickup"
		self.nightclub_lootpickup.texture = "guis/textures/pd2/mission_briefing/assets/nightclub/asset01"
		self.nightclub_lootpickup.stages = { "nightclub" }
		self.nightclub_lootpickup.money_lock = huge
		self.nightclub_lootpickup.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.nightclub_lootpickup.visible_if_locked = false
		self.nightclub_lootpickup.unlock_desc_id = "u2_asset_desc"









		self.four_stores_overview = {}
		self.four_stores_overview.name_id = "menu_asset_four_stores_overview"
		self.four_stores_overview.texture = "guis/textures/pd2/mission_briefing/assets/four_stores/asset01"
		self.four_stores_overview.stages = { "four_stores" }
		self.four_stores_overview.money_lock = small
		self.four_stores_overview.upgrade_lock = { category="player", upgrade="additional_assets" } 
		self.four_stores_overview.visible_if_locked = false
		self.four_stores_overview.unlock_desc_id = "u2_asset_desc"
	end
end