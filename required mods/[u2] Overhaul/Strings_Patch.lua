local path = "mods/[u2] Overhaul/New_Strings.txt"
Hooks:Add("LocalizationManagerPostInit", "ADD_Strings_Patch", function(loc)
	loc:load_localization_file(path)
end)

Hooks:Add("LocalizationManagerPostInit", "CHANGE_Strings_Patch", function(loc)
    LocalizationManager:add_localized_strings({
		menu_inside_man_desc = "BASIC: ##$basic##\nUnlocks special Inside Man assets in the Job Overview menu.\n\nACE: ##$pro##\nHalves the cost of assets in the Job Overview menu.",
		menu_cable_guy_desc = "BASIC: ##$basic##\nYou are now able to tie down hostages faster.\n\nACE: ##$pro##\nYou gain an infinite supply of cable ties.",
		menu_medic_2x_desc = "BASIC: ##$basic##\nYour doctor bags now come with additional charges.\n\nACE: ##$pro##\nYou can now carry another doctor bag.",
		menu_ammo_2x_desc = "BASIC: ##$basic##\nYour ammo bags now come with additional magazines.\n\nACE: ##$pro##\nYou can now carry another ammo bag.",
		menu_shotgun_cqb_desc = "BASIC: ##$basic##\nIncreases your shotgun steel sight speed.\n\nACE: ##$pro##\nIncreases your shotgun reload speed.",
		menu_master_craftsman_desc = "BASIC: ##$basic##\nMask crafting is now free.\n\nACE: ##$pro##\nCost of weapon crafting is now reduced.",
		menu_sentry_gun_2x_desc = "BASIC: ##$basic##\nYou can now carry four senty guns.\n\nACE: ##$pro##\nYour sentry guns deal more damage.",
		menu_good_luck_charm_desc = "BASIC: ##$basic##\nYour odds of getting a higher quality item during PAYDAY are increased.\n\nACE: ##$pro##\nYou gain a small chance to regenerate one percent of your health every second.",
		menu_ammo_reservoir_desc = "BASIC: ##$basic##\nDirectly after you deploy an ammo bag, you can fire your weapon for several seconds without depleting your ammunition.\n\nACE: ##$pro##\nEvery shot you take has a moderate chance of not spending a cartridge.",
		menu_drill_expert_desc = "BASIC: ##$basic##\nIncreases your drill efficiency making it faster.\n\nACE: ##$pro##\nFurther increases your drill efficiency. Your thermal lance efficiency is increased.",

		menu_es_skill_points_info = "",
	})
end)
