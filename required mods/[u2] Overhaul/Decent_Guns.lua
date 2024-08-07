local _init_new_weapons_orig = WeaponTweakData._init_new_weapons
function WeaponTweakData:_init_new_weapons(autohit_rifle_default, autohit_pistol_default, autohit_shotgun_default, damage_melee_default, damage_melee_effect_multiplier_default, aim_assist_rifle_default, aim_assist_pistol_default, aim_assist_shotgun_default, ...)
	--_init_new_weapons_orig(self, autohit_rifle_default, autohit_pistol_default, autohit_shotgun_default, damage_melee_default, damage_melee_effect_multiplier_default, aim_assist_rifle_default, aim_assist_pistol_default, aim_assist_shotgun_default, ...)
	local total_damage_primary = 300
	local total_damage_secondary = 150
	
	-- This relates to 2 in damage like this
	-- m4 max_clip_count_max = math.round((total_damage(300)/damage(2)) * max_clip_size_max)
	-- m4 max_ammo = max_clip_size_max * m4 max_clip_count_max
	
	self.new_m4 = {}
	self.new_m4.category = "assault_rifle"
	
	self.new_m4.damage_melee = damage_melee_default
	self.new_m4.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.new_m4.sounds = {}
	self.new_m4.sounds.fire = "m4_fire"
	self.new_m4.sounds.stop_fire = "m4_stop"
	self.new_m4.sounds.dryfire = "m4_dryfire"
	self.new_m4.sounds.enter_steelsight = "m4_tighten"

	self.new_m4.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.new_m4.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.new_m4.timers = {}
	self.new_m4.timers.reload_not_empty = 2.25 -- 1.6 
	self.new_m4.timers.reload_empty = 3.0 -- 2.2
	self.new_m4.timers.unequip = 0.7
	self.new_m4.timers.equip = 0.66
	
	self.new_m4.name_id = "bm_w_m4"
	self.new_m4.desc_id = "bm_w_m4_desc"
	-- self.new_m4.hud_icon = "guis/textures/weapon_m4_rifle"
	self.new_m4.hud_icon = "m4"
	self.new_m4.description_id = "des_m4"
	
	self.new_m4.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.new_m4.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.new_m4.use_data = {}
	self.new_m4.use_data.selection_index = 2
	self.new_m4.DAMAGE = 2.25
	
	self.new_m4.CLIP_AMMO_MAX = 30
	self.new_m4.NR_CLIPS_MAX = math.round((total_damage_primary/2) / self.new_m4.CLIP_AMMO_MAX)
	self.new_m4.AMMO_MAX = self.new_m4.CLIP_AMMO_MAX * self.new_m4.NR_CLIPS_MAX
	self.new_m4.AMMO_PICKUP = self:_pickup_chance( self.new_m4.AMMO_MAX, 2 )
	
	self.new_m4.auto = {}			  -- Defines the weapons fire mode
	self.new_m4.auto.fire_rate =  0.11 -- Lower than 1 lets loose 2 bullets at a time to much for rifles, sound is made with 1.1 in this case too
	
	self.new_m4.spread = {}
	self.new_m4.spread.standing = 3.5
	self.new_m4.spread.crouching = self.new_m4.spread.standing
	self.new_m4.spread.steelsight = 1
	self.new_m4.spread.moving_standing = self.new_m4.spread.standing
	self.new_m4.spread.moving_crouching = self.new_m4.spread.standing
	self.new_m4.spread.moving_steelsight = self.new_m4.spread.steelsight * 2
	
	-- kick up, down, left, right
	self.new_m4.kick = {}
	-- self.new_m4.kick.standing = { -0.1, 0.2, -0.25, 0.2 }
	-- self.new_m4.kick.crouching = { -0.1, 0.2, -0.25, 0.2 }
	-- self.new_m4.kick.steelsight = { -0.1, 0.2, -0.25, 0.2 }
	
	self.new_m4.kick.standing = { 0.9, 1, -1, 1 }
	self.new_m4.kick.crouching = self.new_m4.kick.standing
	self.new_m4.kick.steelsight = self.new_m4.kick.standing
	
	self.new_m4.shake = {}
	self.new_m4.shake.fire_multiplier = 1
	self.new_m4.shake.fire_steelsight_multiplier = -1
	
	self.new_m4.autohit = autohit_rifle_default
	self.new_m4.aim_assist = aim_assist_rifle_default
	
	self.new_m4.animations = {}
	-- self.new_m4.animations.fire = "recoil"
	self.new_m4.animations.reload = "reload"
	self.new_m4.animations.reload_not_empty = "reload_not_empty"
	self.new_m4.animations.equip_id = "equip_m4"
	self.new_m4.animations.recoil_steelsight = false
	
	self.new_m4.transition_duration = 0.02
	
	--[[self.new_m4.challenges = {}
	self.new_m4.challenges.group = "rifle"
	self.new_m4.challenges.weapon = "m4"]]
	
	-- self.new_m4.alert_size = 5000
	
	self.new_m4.stats = {
		damage = 10,
		spread = 6,
		recoil = 10,
		spread_moving = 7,
		zoom = 3,
		concealment = 8 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- Glock 17 ---------------------------------------
	self.glock_17 = {}
	self.glock_17.category = "pistol"
	
	self.glock_17.damage_melee = damage_melee_default
	self.glock_17.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.glock_17.sounds = {}
	self.glock_17.sounds.fire = "g17_fire"
	self.glock_17.sounds.dryfire = "g17_dryfire"
	self.glock_17.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.glock_17.sounds.leave_steelsight = "pistol_steel_sight_exit"
	-- self.glock_17.sounds.stop_fire = "m4_stop"
	
	self.glock_17.single = {}					-- Defines the weapons fire mode
	self.glock_17.single.fire_rate = 0.12
	
	self.glock_17.timers = {}
	self.glock_17.timers.reload_not_empty = 1.47 -- 2.1 
	self.glock_17.timers.reload_empty = 2.12 -- 2.7
	self.glock_17.timers.unequip = 0.5
	self.glock_17.timers.equip = 0.5
	
	self.glock_17.name_id = "bm_w_glock_17"
	self.glock_17.desc_id = "bm_w_glock_17_desc"
	self.glock_17.hud_icon = "c45"
	self.glock_17.description_id = "des_glock_17"
	self.glock_17.hud_ammo = "guis/textures/ammo_9mm"
	
	self.glock_17.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.glock_17.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.glock_17.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	
	self.glock_17.use_data = {}
	self.glock_17.use_data.selection_index = 1
	
	self.glock_17.DAMAGE = 1
	
	self.glock_17.CLIP_AMMO_MAX = 17
	self.glock_17.NR_CLIPS_MAX = math.round((total_damage_secondary/1.15) / self.glock_17.CLIP_AMMO_MAX)
	self.glock_17.AMMO_MAX = self.glock_17.CLIP_AMMO_MAX * self.glock_17.NR_CLIPS_MAX
	self.glock_17.AMMO_PICKUP = self:_pickup_chance( self.glock_17.AMMO_MAX, 1 )
	
	self.glock_17.spread = {}
	--[[
	self.glock_17.spread.standing = 1 -- 4.5
	self.glock_17.spread.crouching = 1 -- 4.5
	self.glock_17.spread.steelsight = 0.5 -- 1.7
	self.glock_17.spread.moving_standing = 1.5 -- 4.5
	self.glock_17.spread.moving_crouching = 1.5 -- 4.5
	self.glock_17.spread.moving_steelsight = 0.5
	]]
	
	self.glock_17.spread.standing = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.crouching = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.steelsight = self.new_m4.spread.steelsight
	self.glock_17.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.glock_17.kick = {}
	self.glock_17.kick.standing = { 1.2, 1.8, -0.5, 0.5 }
	self.glock_17.kick.crouching = self.glock_17.kick.standing
	self.glock_17.kick.steelsight = self.glock_17.kick.standing
	
	self.glock_17.crosshair = {}
	self.glock_17.crosshair.standing = {}
	self.glock_17.crosshair.crouching = {}
	self.glock_17.crosshair.steelsight = {}
	
	self.glock_17.crosshair.standing.offset = 0.175
	self.glock_17.crosshair.standing.moving_offset = 0.6
	self.glock_17.crosshair.standing.kick_offset = 0.4
	
	self.glock_17.crosshair.crouching.offset = 0.1
	self.glock_17.crosshair.crouching.moving_offset = 0.6
	self.glock_17.crosshair.crouching.kick_offset = 0.3
	
	self.glock_17.crosshair.steelsight.hidden = true
	self.glock_17.crosshair.steelsight.offset = 0
	self.glock_17.crosshair.steelsight.moving_offset = 0
	self.glock_17.crosshair.steelsight.kick_offset = 0.1
		
	self.glock_17.shake = {}
	self.glock_17.shake.fire_multiplier = 1
	self.glock_17.shake.fire_steelsight_multiplier = 1
	
	self.glock_17.autohit = autohit_pistol_default
	self.glock_17.aim_assist = aim_assist_pistol_default
	
	self.glock_17.weapon_hold = "glock" -- REUSE
	self.glock_17.animations = {}
	--[[self.glock_17.animations.fire = "recoil"
	self.glock_17.animations.reload = "reload"
	self.glock_17.animations.reload_not_empty = "reload_not_empty"]]
	self.glock_17.animations.equip_id = "equip_glock"
	self.glock_17.animations.recoil_steelsight = true
	
	--[[self.glock_17.challenges = {}
	-- self.glock_17.challenges.prefix = "handgun"
	self.glock_17.challenges.group = "handgun"
	self.glock_17.challenges.weapon = "c45"]]
	
	self.glock_17.transition_duration = 0
	-- self.glock_17.alert_size = 2500
	self.glock_17.stats = {
		damage = 4,
		spread = 3,
		recoil = 4,
		spread_moving = 7,
		zoom = 1,
		concealment = 10 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- Mp9 ---------------------------------------
	self.mp9 = {}
	self.mp9.category = "smg"
	
	self.mp9.damage_melee = damage_melee_default
	self.mp9.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.mp9.sounds = {}
	self.mp9.sounds.fire = "mp9_fire"
	self.mp9.sounds.stop_fire = "mp9_stop"
	self.mp9.sounds.dryfire = "mk11_dryfire"

	self.mp9.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.mp9.sounds.leave_steelsight = "secondary_steel_sight_exit"
	
	self.mp9.timers = {}
	self.mp9.timers.reload_not_empty = 1.7 -- 2.35 
	self.mp9.timers.reload_empty = 2.6 -- 3.35
	self.mp9.timers.unequip = 0.75
	self.mp9.timers.equip = 0.5
	
	self.mp9.name_id = "bm_w_mp9"
	self.mp9.desc_id = "bm_w_mp9_desc"
	self.mp9.hud_icon = "mac11"
	self.mp9.description_id = "des_mp9"
	self.mp9.hud_ammo = "guis/textures/ammo_small_9mm"
	
	self.mp9.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.mp9.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.mp9.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	
	self.mp9.use_data = {}
	self.mp9.use_data.selection_index = 1
	
	self.mp9.DAMAGE = 1
	
	self.mp9.CLIP_AMMO_MAX = 30
	self.mp9.NR_CLIPS_MAX = math.round((total_damage_secondary/1.15) / self.mp9.CLIP_AMMO_MAX)
	self.mp9.AMMO_MAX = self.mp9.CLIP_AMMO_MAX * self.mp9.NR_CLIPS_MAX
	self.mp9.AMMO_PICKUP = self:_pickup_chance( self.mp9.AMMO_MAX, 1 )
	
	self.mp9.auto = {}					-- Defines the weapons fire mode
	self.mp9.auto.fire_rate = 0.07
	
	self.mp9.spread = {}
	--[[
	self.mp9.spread.standing = 1 -- 4
	self.mp9.spread.crouching = 0.8 -- 3
	self.mp9.spread.steelsight = 0.4 -- 2.2
	self.mp9.spread.moving_standing = 1.5 -- 5
	self.mp9.spread.moving_crouching = 1 -- 4
	self.mp9.spread.moving_steelsight = 0.66
	]]
	self.mp9.spread.standing = self.new_m4.spread.standing * 0.75
	self.mp9.spread.crouching = self.new_m4.spread.standing * 0.75
	self.mp9.spread.steelsight = self.new_m4.spread.steelsight
	self.mp9.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.mp9.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.mp9.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.mp9.kick = {}
	self.mp9.kick.standing = { -1.2, 1.2, -1, 1 }
	self.mp9.kick.crouching = self.mp9.kick.standing
	self.mp9.kick.steelsight = self.mp9.kick.standing
	
	self.mp9.crosshair = {}
	self.mp9.crosshair.standing = {}
	self.mp9.crosshair.crouching = {}
	self.mp9.crosshair.steelsight = {}
	
	self.mp9.crosshair.standing.offset = 0.4
	self.mp9.crosshair.standing.moving_offset = 0.7
	self.mp9.crosshair.standing.kick_offset = 0.6
	
	self.mp9.crosshair.crouching.offset = 0.3
	self.mp9.crosshair.crouching.moving_offset = 0.6
	self.mp9.crosshair.crouching.kick_offset = 0.4
	
	self.mp9.crosshair.steelsight.hidden = true
	self.mp9.crosshair.steelsight.offset = 0
	self.mp9.crosshair.steelsight.moving_offset = 0
	self.mp9.crosshair.steelsight.kick_offset = 0.4
	
	self.mp9.shake = {}
	self.mp9.shake.fire_multiplier = 1
	self.mp9.shake.fire_steelsight_multiplier = -1
	
	self.mp9.autohit = autohit_pistol_default
	self.mp9.aim_assist = aim_assist_pistol_default
	
	self.mp9.weapon_hold = "mac11" -- REUSE
	self.mp9.animations = {}
	--[[self.mp9.animations.fire = "recoil"
	self.mp9.animations.reload = "reload"
	self.mp9.animations.reload_not_empty = "reload_not_empty"]]
	self.mp9.animations.equip_id = "equip_mac11_rifle"
	self.mp9.animations.recoil_steelsight = false
	
	-- self.mp9.challenges = {}
	-- self.mp9.challenges.group = "sub_machingun"
	-- self.mp9.challenges.weapon = "mac11"
	
	-- self.mp9.alert_size = 300
	self.mp9.stats = {
		damage = 5,
		spread = 2,
		recoil = 6,
		spread_moving = 7,
		zoom = 3,
		concealment = 9 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- R870 ---------------------------------------
	self.r870 = {}
	self.r870.category = "shotgun"
	
	self.r870.damage_melee = damage_melee_default
	self.r870.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.r870.sounds = {}
	self.r870.sounds.fire = "remington_fire"
	self.r870.sounds.dryfire = "remington_dryfire"
	-- self.r870.sounds.stop_fire = ""
	
	self.r870.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.r870.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.r870.timers = {}
	-- Shotgun reload timers are calculated in the script depending on how many shells to reload
	self.r870.timers.unequip = 0.7
	self.r870.timers.equip = 0.6
	
	self.r870.name_id = "bm_w_r870"
	self.r870.desc_id = "bm_w_r870_desc"
	-- self.r870.hud_icon = "guis/textures/weapon_r870_shotgun"
	self.r870.hud_icon = "r870_shotgun"
	self.r870.description_id = "des_r870"
	self.r870.hud_ammo = "guis/textures/ammo_shell"
	
	self.r870.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.r870.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug_semi"
	
	self.r870.use_data = {}
	self.r870.use_data.selection_index = 2
	self.r870.use_data.align_place = "right_hand"
	
	self.r870.DAMAGE = 6 -- 1.5
	self.r870.damage_near = 700
	self.r870.damage_far = 2000
	self.r870.rays = 5
	
	self.r870.CLIP_AMMO_MAX = 6
	self.r870.NR_CLIPS_MAX = math.round((total_damage_primary/6.5) / self.r870.CLIP_AMMO_MAX)
	self.r870.AMMO_MAX = self.r870.CLIP_AMMO_MAX * self.r870.NR_CLIPS_MAX
	self.r870.AMMO_PICKUP = self:_pickup_chance( self.r870.AMMO_MAX, 2 )
	
	self.r870.single = {}					-- Defines the weapons fire mode
	-- self.r870.single.fire_rate = 0.375
	self.r870.single.fire_rate = 0.575
	
	self.r870.spread = {}
	--[[
	self.r870.spread.standing = 1.5 -- 4
	self.r870.spread.crouching = 1 -- 4
	self.r870.spread.steelsight = 0.1 -- 3
	self.r870.spread.moving_standing = 2.5 -- 4
	self.r870.spread.moving_crouching = 1.5 -- 4
	self.r870.spread.moving_steelsight = 0.8
	]]
	
	self.r870.spread.standing = self.new_m4.spread.standing * 1
	self.r870.spread.crouching = self.new_m4.spread.standing * 1
	self.r870.spread.steelsight = self.new_m4.spread.standing * 0.8
	self.r870.spread.moving_standing = self.new_m4.spread.standing * 1
	self.r870.spread.moving_crouching = self.new_m4.spread.standing * 1
	self.r870.spread.moving_steelsight = self.new_m4.spread.standing * 0.8
	
	-- kick up, down, left, right
	self.r870.kick = {}
	self.r870.kick.standing = { 1.9, 2, -0.2, 0.2 }
	self.r870.kick.crouching = self.r870.kick.standing
	self.r870.kick.steelsight = { 1.5, 1.7, -0.2, 0.2 }
	
	self.r870.crosshair = {}
	self.r870.crosshair.standing = {}
	self.r870.crosshair.crouching = {}
	self.r870.crosshair.steelsight = {}
	
	self.r870.crosshair.standing.offset = 0.7
	self.r870.crosshair.standing.moving_offset = 0.7
	self.r870.crosshair.standing.kick_offset = 0.8
	
	self.r870.crosshair.crouching.offset = 0.65
	self.r870.crosshair.crouching.moving_offset = 0.65
	self.r870.crosshair.crouching.kick_offset = 0.75
	
	self.r870.crosshair.steelsight.hidden = true
	self.r870.crosshair.steelsight.offset = 0
	self.r870.crosshair.steelsight.moving_offset = 0
	self.r870.crosshair.steelsight.kick_offset = 0
	
	self.r870.shake = {}
	self.r870.shake.fire_multiplier = 1
	self.r870.shake.fire_steelsight_multiplier = -1
	
	self.r870.autohit = autohit_shotgun_default
	self.r870.aim_assist = aim_assist_shotgun_default
	
	self.r870.weapon_hold = "r870_shotgun" -- REUSE
	self.r870.animations = {}
	--[[self.r870.animations.fire = "recoil"
	self.r870.animations.fire_steelsight = "recoil_zoom"
	self.r870.animations.reload_exit = "reload"]]
	self.r870.animations.equip_id = "equip_r870_shotgun"
	self.r870.animations.recoil_steelsight = true
	
	--[[self.r870.challenges = {}
	self.r870.challenges.group = "shotgun"
	self.r870.challenges.weapon = "reinbeck"]]
	
	-- self.r870.alert_size = 4500
	self.r870.stats = {
		damage = 24,
		spread = 7,
		recoil = 3,
		spread_moving = 7,
		zoom = 3,
		concealment = 7 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- Glock 18c ---------------------------------------
	self.glock_18c = {}
	self.glock_18c.category = "pistol"
	
	self.glock_18c.damage_melee = damage_melee_default
	self.glock_18c.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.glock_18c.sounds = {}
	self.glock_18c.sounds.fire = "g18c_fire"
	self.glock_18c.sounds.stop_fire = "g18c_stop"
	self.glock_18c.sounds.dryfire = "stryk_dryfire"
	self.glock_18c.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.glock_18c.sounds.leave_steelsight = "pistol_steel_sight_exit"
	-- self.beretta92.sounds.stop_fire = "m4_stop"
	
	self.glock_18c.timers = {}
	self.glock_18c.timers.reload_not_empty = 1.47 -- 2.1
	self.glock_18c.timers.reload_empty = 2.12 -- 2.7
	self.glock_18c.timers.unequip = 0.55
	self.glock_18c.timers.equip = 0.55
	
	self.glock_18c.name_id = "bm_w_glock_18c"
	self.glock_18c.desc_id = "bm_w_glock_18c_desc"
	-- self.beretta92.hud_icon = "guis/textures/weapon_beretta92"
	self.glock_18c.hud_icon = "glock"
	self.glock_18c.description_id = "des_glock"
	
	self.glock_18c.hud_ammo = "guis/textures/ammo_small_9mm"
	
	self.glock_18c.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.glock_18c.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.glock_18c.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	
	self.glock_18c.use_data = {}
	self.glock_18c.use_data.selection_index = 1
	
	self.glock_18c.DAMAGE = 1
	
	self.glock_18c.CLIP_AMMO_MAX = 20
	self.glock_18c.NR_CLIPS_MAX = math.round((total_damage_secondary/1.15) / self.glock_18c.CLIP_AMMO_MAX)
	self.glock_18c.AMMO_MAX = self.glock_18c.CLIP_AMMO_MAX * self.glock_18c.NR_CLIPS_MAX
	self.glock_18c.AMMO_PICKUP = self:_pickup_chance( self.glock_18c.AMMO_MAX, 1 )
	
	self.glock_18c.auto = {}						-- Defines the weapons fire mode
	self.glock_18c.auto.fire_rate = 0.055
	
	self.glock_18c.spread = {}
	--[[
	self.glock_18c.spread.standing = 1.5 -- 4
	self.glock_18c.spread.crouching = 1.5 -- 4
	self.glock_18c.spread.steelsight = 0.75 -- 1.6
	self.glock_18c.spread.moving_standing = 2. -- 4
	self.glock_18c.spread.moving_crouching = 1.5 -- 4
	self.glock_18c.spread.moving_steelsight = 0.8
	]]
	
	self.glock_18c.spread.standing = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.crouching = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.steelsight = self.new_m4.spread.steelsight
	self.glock_18c.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.glock_18c.kick = {}
	self.glock_18c.kick.standing = self.glock_17.kick.standing
	self.glock_18c.kick.crouching = self.glock_18c.kick.standing
	self.glock_18c.kick.steelsight = self.glock_18c.kick.standing
	
	self.glock_18c.crosshair = {}
	self.glock_18c.crosshair.standing = {}
	self.glock_18c.crosshair.crouching = {}
	self.glock_18c.crosshair.steelsight = {}
	
	self.glock_18c.crosshair.standing.offset = 0.3
	self.glock_18c.crosshair.standing.moving_offset = 0.5
	self.glock_18c.crosshair.standing.kick_offset = 0.6
	
	self.glock_18c.crosshair.crouching.offset = 0.2
	self.glock_18c.crosshair.crouching.moving_offset = 0.5
	self.glock_18c.crosshair.crouching.kick_offset = 0.3
	
	self.glock_18c.crosshair.steelsight.hidden = true
	self.glock_18c.crosshair.steelsight.offset = 0.2
	self.glock_18c.crosshair.steelsight.moving_offset = 0.2
	self.glock_18c.crosshair.steelsight.kick_offset = 0.3
	
	self.glock_18c.shake = {}
	self.glock_18c.shake.fire_multiplier = 1
	self.glock_18c.shake.fire_steelsight_multiplier = 1
	
	self.glock_18c.autohit = autohit_pistol_default
	self.glock_18c.aim_assist = aim_assist_pistol_default
	
	self.glock_18c.weapon_hold = "glock" -- REUSE
	self.glock_18c.animations = {}
	self.glock_18c.animations.fire = "recoil"
	self.glock_18c.animations.reload = "reload"
	self.glock_18c.animations.reload_not_empty = "reload_not_empty"
	self.glock_18c.animations.equip_id = "equip_glock"
	self.glock_18c.animations.recoil_steelsight = true
	
	self.glock_18c.challenges = {}
	self.glock_18c.challenges.group = "handgun"
	self.glock_18c.challenges.weapon = "glock"
	
	self.glock_18c.transition_duration = 0
	
	-- self.glock_18c.alert_size = 5000
	self.glock_18c.stats = {
		damage = 5,
		spread = 3,
		recoil = 6,
		spread_moving = 7,
		zoom = 1,
		concealment = 10 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- AMCAR
	self.amcar = {}
	self.amcar.category = "assault_rifle"
	
	self.amcar.damage_melee = damage_melee_default
	self.amcar.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.amcar.sounds = {}
	self.amcar.sounds.fire = "amcar_fire"
	self.amcar.sounds.stop_fire = "amcar_stop"
	self.amcar.sounds.dryfire = "m4_dryfire"
	self.amcar.sounds.enter_steelsight = "m4_tighten"

	self.amcar.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.amcar.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.amcar.timers = {}
	self.amcar.timers.reload_not_empty = 2.25 -- 1.6 
	self.amcar.timers.reload_empty = 3.0 -- 2.2
	self.amcar.timers.unequip = 0.8
	self.amcar.timers.equip = 0.7
	
	self.amcar.name_id = "bm_w_amcar"
	self.amcar.desc_id = "bm_w_amcar_desc"
	-- self.amcar.hud_icon = "guis/textures/weapon_m4_rifle"
	self.amcar.hud_icon = "m4"
	self.amcar.description_id = "des_m4"
	
	self.amcar.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.amcar.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.amcar.use_data = {}
	self.amcar.use_data.selection_index = 2
	self.amcar.DAMAGE = 1
	
	self.amcar.CLIP_AMMO_MAX = 20
	self.amcar.NR_CLIPS_MAX = math.round((total_damage_primary/1.60) / self.amcar.CLIP_AMMO_MAX)
	self.amcar.AMMO_MAX = self.amcar.CLIP_AMMO_MAX * self.amcar.NR_CLIPS_MAX
	self.amcar.AMMO_PICKUP = self:_pickup_chance( self.amcar.AMMO_MAX, 2 )
	
	self.amcar.auto = {}					-- Defines the weapons fire mode
	self.amcar.auto.fire_rate = 0.11
	
	self.amcar.spread = {}
	--[[
	self.amcar.spread.standing = 2 -- 4
	self.amcar.spread.crouching = 1.5 -- 3
	self.amcar.spread.steelsight = 0.35 -- 1
	self.amcar.spread.moving_standing = 2.25 -- 6
	self.amcar.spread.moving_crouching = 2 -- 5
	self.amcar.spread.moving_steelsight = 0.725
	]]
	self.amcar.spread.standing = self.new_m4.spread.standing
	self.amcar.spread.crouching = self.new_m4.spread.standing
	self.amcar.spread.steelsight = self.new_m4.spread.steelsight
	self.amcar.spread.moving_standing = self.new_m4.spread.standing
	self.amcar.spread.moving_crouching = self.new_m4.spread.standing
	self.amcar.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.amcar.kick = {}
	self.amcar.kick.standing = self.new_m4.kick.standing
	self.amcar.kick.crouching = self.amcar.kick.standing
	self.amcar.kick.steelsight = self.amcar.kick.standing
	
	self.amcar.crosshair = {}
	self.amcar.crosshair.standing = {}
	self.amcar.crosshair.crouching = {}
	self.amcar.crosshair.steelsight = {}
	
	self.amcar.crosshair.standing.offset = 0.16
	self.amcar.crosshair.standing.moving_offset = 0.8
	self.amcar.crosshair.standing.kick_offset = 0.6
	
	-- self.amcar.crosshair.standing.offset = 40
	-- self.amcar.crosshair.standing.kick_offset = 60
	
	self.amcar.crosshair.crouching.offset = 0.08
	self.amcar.crosshair.crouching.moving_offset = 0.7
	self.amcar.crosshair.crouching.kick_offset = 0.4
	
	self.amcar.crosshair.steelsight.hidden = true
	self.amcar.crosshair.steelsight.offset = 0
	self.amcar.crosshair.steelsight.moving_offset = 0
	self.amcar.crosshair.steelsight.kick_offset = 0.1
	
	self.amcar.shake = {}
	self.amcar.shake.fire_multiplier = 1
	self.amcar.shake.fire_steelsight_multiplier = -1
	
	self.amcar.autohit = autohit_rifle_default
	self.amcar.aim_assist = aim_assist_rifle_default
	
	self.amcar.weapon_hold = "m4" -- REUSE
	self.amcar.animations = {}
	-- self.amcar.animations.fire = "recoil"
	self.amcar.animations.reload = "reload"
	self.amcar.animations.reload_not_empty = "reload_not_empty"
	self.amcar.animations.equip_id = "equip_m4"
	self.amcar.animations.recoil_steelsight = false
	
	--[[self.amcar.challenges = {}
	self.amcar.challenges.group = "rifle"
	self.amcar.challenges.weapon = "m4"]]
	
	-- self.amcar.alert_size = 5000
	self.amcar.stats = {
		damage = 7,
		spread = 5,
		recoil = 8,
		spread_moving = 7,
		zoom = 3,
		concealment = 8 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- M16
	self.m16 = {}
	self.m16.category = "assault_rifle"
	
	self.m16.damage_melee = damage_melee_default
	self.m16.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.m16.sounds = {}
	self.m16.sounds.fire = "m16_fire"
	self.m16.sounds.stop_fire = "m16_stop"
	self.m16.sounds.dryfire = "m4_dryfire"
	self.m16.sounds.enter_steelsight = "m4_tighten"

	self.m16.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.m16.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.m16.timers = {}
	self.m16.timers.reload_not_empty = 2.25 -- 1.6 
	self.m16.timers.reload_empty = 3.0 -- 2.2
	self.m16.timers.unequip = 0.85
	self.m16.timers.equip = 0.75

	self.m16.name_id = "bm_w_m16"
	self.m16.desc_id = "bm_w_m16_desc"
	-- self.m16.hud_icon = "guis/textures/weapon_m4_rifle"
	self.m16.hud_icon = "m4"
	self.m16.description_id = "des_m4"
	
	self.m16.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.m16.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.m16.use_data = {}
	self.m16.use_data.selection_index = 2
	self.m16.DAMAGE = 1
	
	self.m16.CLIP_AMMO_MAX = 30
	self.m16.NR_CLIPS_MAX = math.round((total_damage_primary/3) / self.m16.CLIP_AMMO_MAX)
	self.m16.AMMO_MAX = self.m16.CLIP_AMMO_MAX * self.m16.NR_CLIPS_MAX
	self.m16.AMMO_PICKUP = self:_pickup_chance( self.m16.AMMO_MAX, 2 )
	
	self.m16.auto = {}					-- Defines the weapons fire mode
	self.m16.auto.fire_rate = 0.1 -- TODO
	
	self.m16.spread = {}
	--[[
	self.m16.spread.standing = 2.5 -- 4
	self.m16.spread.crouching = 2 -- 3
	self.m16.spread.steelsight = 0.1 -- 1
	self.m16.spread.moving_standing = 3 -- 6
	self.m16.spread.moving_crouching = 2.5 -- 5
	self.m16.spread.moving_steelsight = 0.5
	]]
	self.m16.spread.standing = self.new_m4.spread.standing
	self.m16.spread.crouching = self.new_m4.spread.standing
	self.m16.spread.steelsight = self.new_m4.spread.steelsight
	self.m16.spread.moving_standing = self.new_m4.spread.standing
	self.m16.spread.moving_crouching = self.new_m4.spread.standing
	self.m16.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	
	-- kick up, down, left, right
	self.m16.kick = {}
	self.m16.kick.standing = self.new_m4.kick.standing
	self.m16.kick.crouching = self.m16.kick.standing
	self.m16.kick.steelsight = self.m16.kick.standing
	
	self.m16.crosshair = {}
	self.m16.crosshair.standing = {}
	self.m16.crosshair.crouching = {}
	self.m16.crosshair.steelsight = {}
	
	self.m16.crosshair.standing.offset = 0.16
	self.m16.crosshair.standing.moving_offset = 0.8
	self.m16.crosshair.standing.kick_offset = 0.6
	
	-- self.m16.crosshair.standing.offset = 40
	-- self.m16.crosshair.standing.kick_offset = 60
	
	self.m16.crosshair.crouching.offset = 0.08
	self.m16.crosshair.crouching.moving_offset = 0.7
	self.m16.crosshair.crouching.kick_offset = 0.4
	
	self.m16.crosshair.steelsight.hidden = true
	self.m16.crosshair.steelsight.offset = 0
	self.m16.crosshair.steelsight.moving_offset = 0
	self.m16.crosshair.steelsight.kick_offset = 0.1
	
	self.m16.shake = {}
	self.m16.shake.fire_multiplier = 1
	self.m16.shake.fire_steelsight_multiplier = -1
	
	self.m16.autohit = autohit_rifle_default
	self.m16.aim_assist = aim_assist_rifle_default
	
	self.m16.weapon_hold = "m4" -- REUSE
	self.m16.animations = {}
	-- self.m16.animations.fire = "recoil"
	self.m16.animations.reload = "reload"
	self.m16.animations.reload_not_empty = "reload_not_empty"
	self.m16.animations.equip_id = "equip_m4"
	self.m16.animations.recoil_steelsight = false
	
	--[[self.m16.challenges = {}
	self.m16.challenges.group = "rifle"
	self.m16.challenges.weapon = "m4"]]
	
	-- self.m16.alert_size = 5000
	self.m16.stats = {
		damage = 13,
		spread = 6,
		recoil = 8,
		spread_moving = 7,
		zoom = 4,
		concealment = 7 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- OLYMPIC
	self.olympic = {}
	self.olympic.category = "smg"
	
	self.olympic.damage_melee = damage_melee_default
	self.olympic.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.olympic.sounds = {}
	self.olympic.sounds.fire = "m4_olympic_fire"
	self.olympic.sounds.stop_fire = "m4_olympic_stop"
	self.olympic.sounds.dryfire = "m4_dryfire"
	self.olympic.sounds.enter_steelsight = "m4_tighten"

	self.olympic.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.olympic.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.olympic.timers = {}
	self.olympic.timers.reload_not_empty = 2.535 -- 1.6 
	self.olympic.timers.reload_empty = 3.49 -- 2.2
	self.olympic.timers.unequip = 0.6
	self.olympic.timers.equip = 0.5
	
	self.olympic.name_id = "bm_w_olympic"
	self.olympic.desc_id = "bm_w_olympic_desc"
	-- self.olympic.hud_icon = "guis/textures/weapon_m4_rifle"
	self.olympic.hud_icon = "m4"
	self.olympic.description_id = "des_m4"
	
	self.olympic.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.olympic.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.olympic.use_data = {}
	self.olympic.use_data.selection_index = 1
	self.olympic.DAMAGE = 1
	
	self.olympic.CLIP_AMMO_MAX = 25
	self.olympic.NR_CLIPS_MAX = math.round((total_damage_secondary/1.6) / self.olympic.CLIP_AMMO_MAX)
	self.olympic.AMMO_MAX = self.olympic.CLIP_AMMO_MAX * self.olympic.NR_CLIPS_MAX
	self.olympic.AMMO_PICKUP = self:_pickup_chance( self.olympic.AMMO_MAX, 1 )
	
	self.olympic.auto = {}					-- Defines the weapons fire mode
	self.olympic.auto.fire_rate = 0.12
	
	self.olympic.spread = {}
	--[[
	self.olympic.spread.standing = 2.5 -- 4
	self.olympic.spread.crouching = 2 -- 3
	self.olympic.spread.steelsight = 0.275 -- 1
	self.olympic.spread.moving_standing = 3.0 -- 6
	self.olympic.spread.moving_crouching = 2.5 -- 5
	self.olympic.spread.moving_steelsight = 1.15
	]]
	self.olympic.spread.standing = self.new_m4.spread.standing * 0.8
	self.olympic.spread.crouching = self.new_m4.spread.standing * 0.8
	self.olympic.spread.steelsight = self.new_m4.spread.steelsight
	self.olympic.spread.moving_standing = self.new_m4.spread.standing * 0.8
	self.olympic.spread.moving_crouching = self.new_m4.spread.standing * 0.8
	self.olympic.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.olympic.kick = {}
	-- self.olympic.kick.standing = { 0.2, 0.5, -0.5, 0.5 }
	self.olympic.kick.standing = self.new_m4.kick.standing
	self.olympic.kick.crouching = self.olympic.kick.standing
	self.olympic.kick.steelsight = self.olympic.kick.standing
	
	self.olympic.crosshair = {}
	self.olympic.crosshair.standing = {}
	self.olympic.crosshair.crouching = {}
	self.olympic.crosshair.steelsight = {}
	
	self.olympic.crosshair.standing.offset = 0.16
	self.olympic.crosshair.standing.moving_offset = 0.8
	self.olympic.crosshair.standing.kick_offset = 0.6
	
	-- self.olympic.crosshair.standing.offset = 40
	-- self.olympic.crosshair.standing.kick_offset = 60
	
	self.olympic.crosshair.crouching.offset = 0.08
	self.olympic.crosshair.crouching.moving_offset = 0.7
	self.olympic.crosshair.crouching.kick_offset = 0.4
	
	self.olympic.crosshair.steelsight.hidden = true
	self.olympic.crosshair.steelsight.offset = 0
	self.olympic.crosshair.steelsight.moving_offset = 0
	self.olympic.crosshair.steelsight.kick_offset = 0.1
	
	self.olympic.shake = {}
	self.olympic.shake.fire_multiplier = 1
	self.olympic.shake.fire_steelsight_multiplier = -1
	
	self.olympic.autohit = autohit_rifle_default
	self.olympic.aim_assist = aim_assist_rifle_default
	
	self.olympic.weapon_hold = "m4" -- REUSE
	self.olympic.animations = {}
	-- self.olympic.animations.fire = "recoil"
	self.olympic.animations.reload = "reload"
	self.olympic.animations.reload_not_empty = "reload_not_empty"
	self.olympic.animations.equip_id = "equip_mp5"
	self.olympic.animations.recoil_steelsight = false
	
	--[[self.olympic.challenges = {}
	self.olympic.challenges.group = "rifle"
	self.olympic.challenges.weapon = "m4"]]
	
	-- self.olympic.alert_size = 5000
	self.olympic.stats = {
		damage = 7,
		spread = 4,
		recoil = 5,
		spread_moving = 7,
		zoom = 3,
		concealment = 9 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- AK 74 ---------------------------------------
	self.ak74 = {}
	self.ak74.category = "assault_rifle"
	
	self.ak74.damage_melee = damage_melee_default
	self.ak74.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.ak74.sounds = {}
	self.ak74.sounds.fire = "ak74_fire"
	self.ak74.sounds.stop_fire = "ak74_stop"
	self.ak74.sounds.dryfire = "ak47_dryfire"
	-- self.ak74.sounds.enter_steelsight = "m4_tighten"

	self.ak74.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.ak74.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.ak74.timers = {}
	self.ak74.timers.reload_not_empty = 2.3 -- 1.6 
	self.ak74.timers.reload_empty = 3.40 -- 2.2
	self.ak74.timers.unequip = 0.7
	self.ak74.timers.equip = 0.5
	
	self.ak74.name_id = "bm_w_ak74"
	self.ak74.desc_id = "bm_w_ak74_desc"
	-- self.ak47.hud_icon = "guis/textures/weapon_m4_rifle"
	self.ak74.hud_icon = "ak"
	self.ak74.description_id = "des_ak47"
	
	self.ak74.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.ak74.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.ak74.use_data = {}
	self.ak74.use_data.selection_index = 2
	self.ak74.DAMAGE = 1
	
	self.ak74.CLIP_AMMO_MAX = 30
	self.ak74.NR_CLIPS_MAX = math.round((total_damage_primary/2.5) / self.ak74.CLIP_AMMO_MAX)
	self.ak74.AMMO_MAX = self.ak74.CLIP_AMMO_MAX * self.ak74.NR_CLIPS_MAX
	self.ak74.AMMO_PICKUP = self:_pickup_chance( self.ak74.AMMO_MAX, 2 )
	
	self.ak74.auto = {}					-- Defines the weapons fire mode
	self.ak74.auto.fire_rate = 0.14
	
	self.ak74.spread = {}
	--[[
	self.ak74.spread.standing = 2.75 -- 5
	self.ak74.spread.crouching = 2.25 -- 4
	self.ak74.spread.steelsight = 0.275 -- 1.5
	self.ak74.spread.moving_standing = 2 -- 6
	self.ak74.spread.moving_crouching = 2 -- 5.5
	self.ak74.spread.moving_steelsight = 1
	]]
	
	self.ak74.spread.standing = self.new_m4.spread.standing
	self.ak74.spread.crouching = self.new_m4.spread.standing
	self.ak74.spread.steelsight = self.new_m4.spread.steelsight
	self.ak74.spread.moving_standing = self.new_m4.spread.standing
	self.ak74.spread.moving_crouching = self.new_m4.spread.standing
	self.ak74.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.ak74.kick = {}
	self.ak74.kick.standing = self.new_m4.kick.standing
	self.ak74.kick.crouching = self.ak74.kick.standing
	self.ak74.kick.steelsight = self.ak74.kick.standing
	
	self.ak74.crosshair = {}
	self.ak74.crosshair.standing = {}
	self.ak74.crosshair.crouching = {}
	self.ak74.crosshair.steelsight = {}
	
	self.ak74.crosshair.standing.offset = 0.16
	self.ak74.crosshair.standing.moving_offset = 0.8
	self.ak74.crosshair.standing.kick_offset = 0.6
	
	-- self.ak74.crosshair.standing.offset = 40
	-- self.ak74.crosshair.standing.kick_offset = 60
	
	self.ak74.crosshair.crouching.offset = 0.08
	self.ak74.crosshair.crouching.moving_offset = 0.7
	self.ak74.crosshair.crouching.kick_offset = 0.4
	
	self.ak74.crosshair.steelsight.hidden = true
	self.ak74.crosshair.steelsight.offset = 0
	self.ak74.crosshair.steelsight.moving_offset = 0
	self.ak74.crosshair.steelsight.kick_offset = 0.1
	
	self.ak74.shake = {}
	self.ak74.shake.fire_multiplier = 1
	self.ak74.shake.fire_steelsight_multiplier = -1
	
	self.ak74.autohit = autohit_rifle_default
	self.ak74.aim_assist = aim_assist_rifle_default
	
	self.ak74.weapon_hold = "ak47" -- REUSE
	self.ak74.animations = {}
	--[[self.ak74.animations.fire = "recoil"
	self.ak74.animations.reload = "reload"
	self.ak74.animations.reload_not_empty = "reload_not_empty"]]
	self.ak74.animations.equip_id = "equip_ak47"
	self.ak74.animations.recoil_steelsight = false
	
	self.ak74.challenges = {}
	self.ak74.challenges.group = "rifle"
	self.ak74.challenges.weapon = "ak47"
	
	-- self.ak74.alert_size = 5000
	self.ak74.stats = {
		damage = 11,
		spread = 6,
		recoil = 9,
		spread_moving = 7,
		zoom = 3,
		concealment = 6 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- AKM ---------------------------------------
	self.akm = {}
	self.akm.category = "assault_rifle"
	
	self.akm.damage_melee = damage_melee_default
	self.akm.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.akm.sounds = {}
	self.akm.sounds.fire = "akm_fire"
	self.akm.sounds.stop_fire = "akm_stop"
	self.akm.sounds.dryfire = "ak47_dryfire"
	-- self.akm.sounds.enter_steelsight = "m4_tighten"

	self.akm.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.akm.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.akm.timers = {}
	self.akm.timers.reload_not_empty = 2.3 -- 1.6 
	self.akm.timers.reload_empty = 3.4 -- 2.2
	self.akm.timers.unequip = 0.8
	self.akm.timers.equip = 0.5
	
	self.akm.name_id = "bm_w_akm"
	self.akm.desc_id = "bm_w_akm_desc"
	-- self.ak47.hud_icon = "guis/textures/weapon_m4_rifle"
	self.akm.hud_icon = "ak"
	self.akm.description_id = "des_ak47"
	
	self.akm.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.akm.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.akm.use_data = {}
	self.akm.use_data.selection_index = 2
	self.akm.DAMAGE = 1.25
	
	self.akm.CLIP_AMMO_MAX = 30
	self.akm.NR_CLIPS_MAX = math.round((total_damage_primary/4) / self.akm.CLIP_AMMO_MAX)
	self.akm.AMMO_MAX = self.akm.CLIP_AMMO_MAX * self.akm.NR_CLIPS_MAX
	self.akm.AMMO_PICKUP = self:_pickup_chance( self.akm.AMMO_MAX, 2 )
	
	self.akm.auto = {}					-- Defines the weapons fire mode
	self.akm.auto.fire_rate = 0.16
	
	self.akm.spread = {}
	--[[
	self.akm.spread.standing = 3 -- 5
	self.akm.spread.crouching = 2 -- 4
	self.akm.spread.steelsight = 0.4 -- 1.5
	self.akm.spread.moving_standing = 1.5 -- 6
	self.akm.spread.moving_crouching = 1.0 -- 5.5
	self.akm.spread.moving_steelsight = 0.85
	]]
	
	self.akm.spread.standing = self.new_m4.spread.standing
	self.akm.spread.crouching = self.new_m4.spread.standing
	self.akm.spread.steelsight = self.new_m4.spread.steelsight
	self.akm.spread.moving_standing = self.new_m4.spread.standing
	self.akm.spread.moving_crouching = self.new_m4.spread.standing
	self.akm.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.akm.kick = {}
	self.akm.kick.standing = self.new_m4.kick.standing
	self.akm.kick.crouching = self.akm.kick.standing
	self.akm.kick.steelsight = self.akm.kick.standing
	
	self.akm.crosshair = {}
	self.akm.crosshair.standing = {}
	self.akm.crosshair.crouching = {}
	self.akm.crosshair.steelsight = {}
	
	self.akm.crosshair.standing.offset = 0.16
	self.akm.crosshair.standing.moving_offset = 0.8
	self.akm.crosshair.standing.kick_offset = 0.6
	
	-- self.akm.crosshair.standing.offset = 40
	-- self.akm.crosshair.standing.kick_offset = 60
	
	self.akm.crosshair.crouching.offset = 0.08
	self.akm.crosshair.crouching.moving_offset = 0.7
	self.akm.crosshair.crouching.kick_offset = 0.4
	
	self.akm.crosshair.steelsight.hidden = true
	self.akm.crosshair.steelsight.offset = 0
	self.akm.crosshair.steelsight.moving_offset = 0
	self.akm.crosshair.steelsight.kick_offset = 0.1
	
	self.akm.shake = {}
	self.akm.shake.fire_multiplier = 1
	self.akm.shake.fire_steelsight_multiplier = -1
	
	self.akm.autohit = autohit_rifle_default
	self.akm.aim_assist = aim_assist_rifle_default
	
	self.akm.weapon_hold = "ak47" -- REUSE
	self.akm.animations = {}
	--[[self.akm.animations.fire = "recoil"
	self.akm.animations.reload = "reload"
	self.akm.animations.reload_not_empty = "reload_not_empty"]]
	self.akm.animations.equip_id = "equip_ak47"
	self.akm.animations.recoil_steelsight = false
	
	self.akm.challenges = {}
	self.akm.challenges.group = "rifle"
	self.akm.challenges.weapon = "ak47"
		
	-- self.akm.alert_size = 5000
	self.akm.stats = {
		damage = 17,
		spread = 5,
		recoil = 7,
		spread_moving = 7,
		zoom = 3,
		concealment = 6 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- AKMSU ---------------------------------------
	self.akmsu = {}
	self.akmsu.category = "smg"
	
	self.akmsu.damage_melee = damage_melee_default
	self.akmsu.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.akmsu.sounds = {}
	self.akmsu.sounds.fire = "akmsu_fire"
	self.akmsu.sounds.stop_fire = "akmsu_stop"
	self.akmsu.sounds.dryfire = "ak47_dryfire"
	-- self.akmsu.sounds.enter_steelsight = "m4_tighten"

	self.akmsu.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.akmsu.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.akmsu.timers = {}
	self.akmsu.timers.reload_not_empty = 2.3 -- 1.6 
	self.akmsu.timers.reload_empty = 3.40 -- 2.2
	
	-- self.akm.timers.reload_not_empty = 2.3 -- 1.6 
	-- self.akm.timers.reload_empty = 3.1 -- 2.2
	
	self.akmsu.timers.unequip = 0.65
	self.akmsu.timers.equip = 0.5

	self.akmsu.name_id = "bm_w_akmsu"
	self.akmsu.desc_id = "bm_w_akmsu_desc"
	-- self.ak47.hud_icon = "guis/textures/weapon_m4_rifle"
	self.akmsu.hud_icon = "ak"
	self.akmsu.description_id = "des_ak47"
	
	self.akmsu.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.akmsu.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.akmsu.use_data = {}
	self.akmsu.use_data.selection_index = 1
	self.akmsu.DAMAGE = 1.0
	
	self.akmsu.CLIP_AMMO_MAX = 30
	self.akmsu.NR_CLIPS_MAX = math.round((total_damage_secondary/2.75) / self.akmsu.CLIP_AMMO_MAX)
	self.akmsu.AMMO_MAX = self.akmsu.CLIP_AMMO_MAX * self.akmsu.NR_CLIPS_MAX
	self.akmsu.AMMO_PICKUP = self:_pickup_chance( self.akmsu.AMMO_MAX, 1 )
	
	self.akmsu.auto = {}					-- Defines the weapons fire mode
	self.akmsu.auto.fire_rate = 0.12
	
	self.akmsu.spread = {}
	--[[
	self.akmsu.spread.standing = 2 -- 5
	self.akmsu.spread.crouching = 1.5 -- 4
	self.akmsu.spread.steelsight = 0.45 -- 1.5
	self.akmsu.spread.moving_standing = 2.5-- 6
	self.akmsu.spread.moving_crouching = 2.0 -- 5.5
	self.akmsu.spread.moving_steelsight = 0.9
	]]
	self.akmsu.spread.standing = self.new_m4.spread.standing
	self.akmsu.spread.crouching = self.new_m4.spread.standing
	self.akmsu.spread.steelsight = self.new_m4.spread.steelsight
	self.akmsu.spread.moving_standing = self.new_m4.spread.standing
	self.akmsu.spread.moving_crouching = self.new_m4.spread.standing
	self.akmsu.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.akmsu.kick = {}
	self.akmsu.kick.standing = self.new_m4.kick.standing
	self.akmsu.kick.crouching = self.akmsu.kick.standing
	self.akmsu.kick.steelsight = self.akmsu.kick.standing
	
	self.akmsu.crosshair = {}
	self.akmsu.crosshair.standing = {}
	self.akmsu.crosshair.crouching = {}
	self.akmsu.crosshair.steelsight = {}
	
	self.akmsu.crosshair.standing.offset = 0.16
	self.akmsu.crosshair.standing.moving_offset = 0.8
	self.akmsu.crosshair.standing.kick_offset = 0.6
	
	-- self.akmsu.crosshair.standing.offset = 40
	-- self.akmsu.crosshair.standing.kick_offset = 60
	
	self.akmsu.crosshair.crouching.offset = 0.08
	self.akmsu.crosshair.crouching.moving_offset = 0.7
	self.akmsu.crosshair.crouching.kick_offset = 0.4
	
	self.akmsu.crosshair.steelsight.hidden = true
	self.akmsu.crosshair.steelsight.offset = 0
	self.akmsu.crosshair.steelsight.moving_offset = 0
	self.akmsu.crosshair.steelsight.kick_offset = 0.1
	
	self.akmsu.shake = {}
	self.akmsu.shake.fire_multiplier = 1
	self.akmsu.shake.fire_steelsight_multiplier = -1
	
	self.akmsu.autohit = autohit_rifle_default
	self.akmsu.aim_assist = aim_assist_rifle_default
	
	self.akmsu.weapon_hold = "ak47" -- REUSE
	self.akmsu.animations = {}
	--[[self.akmsu.animations.fire = "recoil"
	self.akmsu.animations.reload = "reload"
	self.akmsu.animations.reload_not_empty = "reload_not_empty"]]
	self.akmsu.animations.equip_id = "equip_ak47"
	self.akmsu.animations.recoil_steelsight = false
	
	self.akmsu.challenges = {}
	self.akmsu.challenges.group = "rifle"
	self.akmsu.challenges.weapon = "ak47"
	
	-- self.akmsu.alert_size = 5000
	self.akmsu.stats = {
		damage = 12,
		spread = 3,
		recoil = 4,
		spread_moving = 7,
		zoom = 3,
		concealment = 8 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- SAIGA ---------------------------------------
	self.saiga = {}
	self.saiga.category = "shotgun"
	
	self.saiga.damage_melee = damage_melee_default
	self.saiga.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.saiga.sounds = {}
	self.saiga.sounds.fire = "saiga_play"
	self.saiga.sounds.dryfire = "remington_dryfire"
	self.saiga.sounds.stop_fire = "saiga_stop"

	self.saiga.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.saiga.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.saiga.timers = {}
	self.saiga.timers.reload_not_empty = 2.3 -- 1.6 
	self.saiga.timers.reload_empty = 3.4 -- 2.2
	self.saiga.timers.unequip = 0.8
	self.saiga.timers.equip = 0.8

	self.saiga.name_id = "bm_w_saiga"
	self.saiga.desc_id = "bm_w_saiga_desc"
	-- self.saiga.hud_icon = "guis/textures/weapon_saiga"
	self.saiga.hud_icon = "r870_shotgun"
	self.saiga.description_id = "des_saiga"
	self.saiga.hud_ammo = "guis/textures/ammo_shell"
	
	self.saiga.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.saiga.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug"
	
	self.saiga.use_data = {}
	self.saiga.use_data.selection_index = 2
	self.saiga.use_data.align_place = "right_hand"
	
	self.saiga.DAMAGE = 4.5 -- 1.5
	self.saiga.damage_near = 50
	self.saiga.damage_far = 2000
	self.saiga.rays = 4
	
	self.saiga.CLIP_AMMO_MAX = 7
	self.saiga.NR_CLIPS_MAX = math.round((total_damage_primary/4.5) / self.saiga.CLIP_AMMO_MAX)
	self.saiga.AMMO_MAX = self.saiga.CLIP_AMMO_MAX * self.saiga.NR_CLIPS_MAX
	self.saiga.AMMO_PICKUP = self:_pickup_chance( self.saiga.AMMO_MAX, 2 )
	
	--self.saiga.single = {}					-- Defines the weapons fire mode
	--self.saiga.single.fire_rate = 0.275
	
	self.saiga.auto = {}					-- Defines the weapons fire mode
	self.saiga.auto.fire_rate = 0.225
	
	self.saiga.spread = {}
	--[[
	self.saiga.spread.standing = 1.3 -- 4
	self.saiga.spread.crouching = 1.0 -- 4
	self.saiga.spread.steelsight = 0.4 -- 3
	self.saiga.spread.moving_standing = 2 -- 4
	self.saiga.spread.moving_crouching = 1.5 -- 4
	self.saiga.spread.moving_steelsight = 0.875
	]]
	
	self.saiga.spread.standing = self.r870.spread.standing
	self.saiga.spread.crouching = self.r870.spread.crouching
	self.saiga.spread.steelsight = self.r870.spread.steelsight
	self.saiga.spread.moving_standing = self.r870.spread.moving_standing
	self.saiga.spread.moving_crouching = self.r870.spread.moving_crouching
	self.saiga.spread.moving_steelsight = self.r870.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.saiga.kick = {}
	self.saiga.kick.standing = self.r870.kick.standing
	self.saiga.kick.crouching = self.saiga.kick.standing
	self.saiga.kick.steelsight = self.r870.kick.steelsight
	
	self.saiga.crosshair = {}
	self.saiga.crosshair.standing = {}
	self.saiga.crosshair.crouching = {}
	self.saiga.crosshair.steelsight = {}
	
	self.saiga.crosshair.standing.offset = 0.7
	self.saiga.crosshair.standing.moving_offset = 0.7
	self.saiga.crosshair.standing.kick_offset = 0.8
	
	self.saiga.crosshair.crouching.offset = 0.65
	self.saiga.crosshair.crouching.moving_offset = 0.65
	self.saiga.crosshair.crouching.kick_offset = 0.75
	
	self.saiga.crosshair.steelsight.hidden = true
	self.saiga.crosshair.steelsight.offset = 0
	self.saiga.crosshair.steelsight.moving_offset = 0
	self.saiga.crosshair.steelsight.kick_offset = 0
	
	self.saiga.shake = {}
	self.saiga.shake.fire_multiplier = 2
	self.saiga.shake.fire_steelsight_multiplier = 1.25
	
	self.saiga.autohit = autohit_shotgun_default
	self.saiga.aim_assist = aim_assist_shotgun_default
	
	self.saiga.weapon_hold = "ak47" -- REUSE
	self.saiga.animations = {}
	--[[self.saiga.animations.fire = "recoil"
	self.saiga.animations.fire_steelsight = "recoil_zoom"
	self.saiga.animations.reload_exit = "reload"]]
	self.saiga.animations.equip_id = "equip_r870_shotgun"
	self.saiga.animations.recoil_steelsight = true
	
	--[[self.saiga.challenges = {}
	self.saiga.challenges.group = "shotgun"
	self.saiga.challenges.weapon = "reinbeck"]]
	
	
	-- self.saiga.alert_size = 4500
	self.saiga.stats = {
		damage = 19,
		spread = 5,
		recoil = 5,
		spread_moving = 7,
		zoom = 3,
		concealment = 6 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- AK5
	self.ak5 = {}
	self.ak5.category = "assault_rifle"
	
	self.ak5.damage_melee = damage_melee_default
	self.ak5.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.ak5.sounds = {}
	self.ak5.sounds.fire = "ak5_fire"
	self.ak5.sounds.stop_fire = "ak5_stop"
	self.ak5.sounds.dryfire = "m4_dryfire"
	self.ak5.sounds.enter_steelsight = "m4_tighten"

	self.ak5.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.ak5.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.ak5.timers = {}
	self.ak5.timers.reload_not_empty = 2.25 -- 1.6 
	self.ak5.timers.reload_empty = 3.47 -- 2.2
	self.ak5.timers.unequip = 0.7
	self.ak5.timers.equip = 0.5
	
	self.ak5.name_id = "bm_w_ak5"
	self.ak5.desc_id = "bm_w_ak5_desc"
	-- self.ak5.hud_icon = "guis/textures/weapon_m4_rifle"
	self.ak5.hud_icon = "m4"
	self.ak5.description_id = "des_m4"
	
	self.ak5.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.ak5.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.ak5.use_data = {}
	self.ak5.use_data.selection_index = 2
	self.ak5.DAMAGE = 1
	
	self.ak5.CLIP_AMMO_MAX = 30
	self.ak5.NR_CLIPS_MAX = math.round((total_damage_primary/2) / self.ak5.CLIP_AMMO_MAX)
	self.ak5.AMMO_MAX = self.ak5.CLIP_AMMO_MAX * self.ak5.NR_CLIPS_MAX
	self.ak5.AMMO_PICKUP = self:_pickup_chance( self.ak5.AMMO_MAX, 2 )
	
	self.ak5.auto = {}					-- Defines the weapons fire mode
	self.ak5.auto.fire_rate = 0.13
	
	self.ak5.spread = {}
	--[[
	self.ak5.spread.standing = 2	-- 4
	self.ak5.spread.crouching = 1.75 -- 3
	self.ak5.spread.steelsight = 0.275 -- 1
	self.ak5.spread.moving_standing = 2.25 -- 6
	self.ak5.spread.moving_crouching = 2.25 -- 5
	self.ak5.spread.moving_steelsight = 0.75
	]]
	
	self.ak5.spread.standing = self.new_m4.spread.standing
	self.ak5.spread.crouching = self.new_m4.spread.standing
	self.ak5.spread.steelsight = self.new_m4.spread.steelsight
	self.ak5.spread.moving_standing = self.new_m4.spread.standing
	self.ak5.spread.moving_crouching = self.new_m4.spread.standing
	self.ak5.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.ak5.kick = {}
	self.ak5.kick.standing = self.new_m4.kick.standing
	self.ak5.kick.crouching = self.ak5.kick.standing
	self.ak5.kick.steelsight = self.ak5.kick.standing
	
	self.ak5.crosshair = {}
	self.ak5.crosshair.standing = {}
	self.ak5.crosshair.crouching = {}
	self.ak5.crosshair.steelsight = {}
	
	self.ak5.crosshair.standing.offset = 0.16
	self.ak5.crosshair.standing.moving_offset = 0.8
	self.ak5.crosshair.standing.kick_offset = 0.6
	
	-- self.ak5.crosshair.standing.offset = 40
	-- self.ak5.crosshair.standing.kick_offset = 60
	
	self.ak5.crosshair.crouching.offset = 0.08
	self.ak5.crosshair.crouching.moving_offset = 0.7
	self.ak5.crosshair.crouching.kick_offset = 0.4
	
	self.ak5.crosshair.steelsight.hidden = true
	self.ak5.crosshair.steelsight.offset = 0
	self.ak5.crosshair.steelsight.moving_offset = 0
	self.ak5.crosshair.steelsight.kick_offset = 0.1
	
	self.ak5.shake = {}
	self.ak5.shake.fire_multiplier = 1
	self.ak5.shake.fire_steelsight_multiplier = 1
	
	self.ak5.autohit = autohit_rifle_default
	self.ak5.aim_assist = aim_assist_rifle_default
	
	self.ak5.weapon_hold = "m4" -- REUSE
	self.ak5.animations = {}
	-- self.ak5.animations.fire = "recoil"
	self.ak5.animations.reload_not_empty = "reload_not_empty"
	self.ak5.animations.reload = "reload"
	self.ak5.animations.equip_id = "equip_m4"
	self.ak5.animations.recoil_steelsight = false
	
	--[[self.ak5.challenges = {}
	self.ak5.challenges.group = "rifle"
	self.ak5.challenges.weapon = "m4"]]
	
	-- self.ak5.alert_size = 5000
	self.ak5.stats = {
		damage = 9,
		spread = 5,
		recoil = 11,
		spread_moving = 7,
		zoom = 3,
		concealment = 7 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- AUG ---------------------------------------
	self.aug = {}
	self.aug.category = "assault_rifle"
	
	self.aug.damage_melee = damage_melee_default
	self.aug.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.aug.sounds = {}
	self.aug.sounds.fire = "aug_fire"
	self.aug.sounds.stop_fire = "aug_stop"
	self.aug.sounds.dryfire = "mp5_dryfire"

	self.aug.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.aug.sounds.leave_steelsight = "secondary_steel_sight_exit"
	
	self.aug.timers = {}
	self.aug.timers.reload_not_empty = 2.5 
	self.aug.timers.reload_empty = 3.3 -- 2.9
	self.aug.timers.unequip = 0.72
	self.aug.timers.equip = 0.6
	
	self.aug.name_id = "bm_w_aug"
	self.aug.desc_id = "bm_w_aug_desc"
	self.aug.hud_icon = "mp5"
	self.aug.description_id = "des_aug"
	self.aug.hud_ammo = "guis/textures/ammo_9mm"
	
	self.aug.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.aug.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.aug.use_data = {}
	self.aug.use_data.selection_index = 2
	
	self.aug.DAMAGE = 1
	
	self.aug.CLIP_AMMO_MAX = 30
	self.aug.NR_CLIPS_MAX = math.round((total_damage_primary/2.25) / self.aug.CLIP_AMMO_MAX)
	self.aug.AMMO_MAX = self.aug.CLIP_AMMO_MAX * self.aug.NR_CLIPS_MAX
	self.aug.AMMO_PICKUP = self:_pickup_chance( self.aug.AMMO_MAX, 2 )
	
	self.aug.auto = {}					-- Defines the weapons fire mode
	self.aug.auto.fire_rate = 0.12
	
	self.aug.spread = {}
	--[[
	self.aug.spread.standing = 2.0 -- 3.5
	self.aug.spread.crouching = 1.5 -- 2.5
	self.aug.spread.steelsight = 0.175 -- 1.7
	self.aug.spread.moving_standing = 2.5 -- 4.5
	self.aug.spread.moving_crouching = 2.0 -- 3.8
	self.aug.spread.moving_steelsight = 1.0
	]]
	
	self.aug.spread.standing = self.new_m4.spread.standing * 2.5
	self.aug.spread.crouching = self.new_m4.spread.standing * 2.5
	self.aug.spread.steelsight = self.new_m4.spread.steelsight
	self.aug.spread.moving_standing = self.new_m4.spread.standing * 3.5
	self.aug.spread.moving_crouching = self.new_m4.spread.standing * 3.5
	self.aug.spread.moving_steelsight = self.new_m4.spread.moving_steelsight * 1.5
	
	-- kick up, down, left, right
	self.aug.kick = {}
	self.aug.kick.standing = self.new_m4.kick.standing
	self.aug.kick.crouching = self.aug.kick.standing
	self.aug.kick.steelsight = self.aug.kick.standing
	
	self.aug.crosshair = {}
	self.aug.crosshair.standing = {}
	self.aug.crosshair.crouching = {}
	self.aug.crosshair.steelsight = {}
	
	self.aug.crosshair.standing.offset = 0.5
	self.aug.crosshair.standing.moving_offset = 0.6
	self.aug.crosshair.standing.kick_offset = 0.7
	
	self.aug.crosshair.crouching.offset = 0.4
	self.aug.crosshair.crouching.moving_offset = 0.5
	self.aug.crosshair.crouching.kick_offset = 0.6
	
	self.aug.crosshair.steelsight.hidden = true
	self.aug.crosshair.steelsight.offset = 0
	self.aug.crosshair.steelsight.moving_offset = 0
	self.aug.crosshair.steelsight.kick_offset = 0
	
	self.aug.shake = {}
	self.aug.shake.fire_multiplier = 1
	self.aug.shake.fire_steelsight_multiplier = 1
	
	self.aug.autohit = autohit_pistol_default
	self.aug.aim_assist = aim_assist_pistol_default
		
	self.aug.animations = {}
	--[[self.aug.animations.fire = "recoil"
	self.aug.animations.reload = "reload"
	self.aug.animations.reload_not_empty = "reload_not_empty"]]
	self.aug.animations.equip_id = "equip_mp5_rifle"
	self.aug.animations.recoil_steelsight = false
	
	--[[self.aug.challenges = {}
	self.aug.challenges.group = "sub_machingun"
	self.aug.challenges.weapon = "mp5"]]
	
	-- self.aug.alert_size = 2500
	self.aug.stats = {
		damage = 10,
		spread = 8,
		recoil = 6,
		spread_moving = 7,
		zoom = 3,
		concealment = 8 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- G36
	self.g36 = {}
	self.g36.category = "assault_rifle"
	
	self.g36.damage_melee = damage_melee_default
	self.g36.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.g36.sounds = {}
	self.g36.sounds.fire = "g36_fire"
	self.g36.sounds.stop_fire = "g36_stop"
	self.g36.sounds.dryfire = "m4_dryfire"
	self.g36.sounds.enter_steelsight = "m4_tighten"

	self.g36.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.g36.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.g36.timers = {}
	self.g36.timers.reload_not_empty = 2.5 -- 1.6 
	self.g36.timers.reload_empty = 3.45 -- 2.2
	self.g36.timers.unequip = 0.75
	self.g36.timers.equip = 0.5
	
	self.g36.name_id = "bm_w_g36"
	self.g36.desc_id = "bm_w_g36_desc"
	-- self.g36.hud_icon = "guis/textures/weapon_m4_rifle"
	self.g36.hud_icon = "m4"
	self.g36.description_id = "des_m4"
	
	self.g36.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.g36.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.g36.use_data = {}
	self.g36.use_data.selection_index = 2
	self.g36.DAMAGE = 1
	
	self.g36.CLIP_AMMO_MAX = 30
	self.g36.NR_CLIPS_MAX = math.round((total_damage_primary/1.75) / self.g36.CLIP_AMMO_MAX)
	self.g36.AMMO_MAX = self.g36.CLIP_AMMO_MAX * self.g36.NR_CLIPS_MAX
	self.g36.AMMO_PICKUP = self:_pickup_chance( self.g36.AMMO_MAX, 2 )
	
	self.g36.auto = {}					-- Defines the weapons fire mode
	self.g36.auto.fire_rate = 0.115
	
	self.g36.spread = {}
	--[[
	self.g36.spread.standing = 1.75 -- 4
	self.g36.spread.crouching = 1.5 -- 3
	self.g36.spread.steelsight = 0.325 -- 1
	self.g36.spread.moving_standing = 2.5 -- 6
	self.g36.spread.moving_crouching = 2 -- 5
	self.g36.spread.moving_steelsight = 0.7
	]]
	
	self.g36.spread.standing = self.new_m4.spread.standing * 0.8
	self.g36.spread.crouching = self.new_m4.spread.standing * 0.8
	self.g36.spread.steelsight = self.new_m4.spread.steelsight
	self.g36.spread.moving_standing = self.new_m4.spread.standing * 0.8
	self.g36.spread.moving_crouching = self.new_m4.spread.standing * 0.8
	self.g36.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.g36.kick = {}
	self.g36.kick.standing = self.new_m4.kick.standing
	self.g36.kick.crouching = self.g36.kick.standing
	self.g36.kick.steelsight = self.g36.kick.standing
	
	self.g36.crosshair = {}
	self.g36.crosshair.standing = {}
	self.g36.crosshair.crouching = {}
	self.g36.crosshair.steelsight = {}
	
	self.g36.crosshair.standing.offset = 0.16
	self.g36.crosshair.standing.moving_offset = 0.8
	self.g36.crosshair.standing.kick_offset = 0.6
	
	-- self.g36.crosshair.standing.offset = 40
	-- self.g36.crosshair.standing.kick_offset = 60
	
	self.g36.crosshair.crouching.offset = 0.08
	self.g36.crosshair.crouching.moving_offset = 0.7
	self.g36.crosshair.crouching.kick_offset = 0.4
	
	self.g36.crosshair.steelsight.hidden = true
	self.g36.crosshair.steelsight.offset = 0
	self.g36.crosshair.steelsight.moving_offset = 0
	self.g36.crosshair.steelsight.kick_offset = 0.1
	
	self.g36.shake = {}
	self.g36.shake.fire_multiplier = 1
	self.g36.shake.fire_steelsight_multiplier = -1
	
	self.g36.autohit = autohit_rifle_default
	self.g36.aim_assist = aim_assist_rifle_default
	
	-- self.g36.weapon_hold = "m4" -- REUSE
	self.g36.animations = {}
	-- self.g36.animations.fire = "recoil"
	-- self.g36.animations.reload = "reload"
	-- self.g36.animations.reload_not_empty = "reload_not_empty"
	self.g36.animations.equip_id = "equip_m4"
	self.g36.animations.recoil_steelsight = false
	
	--[[self.g36.challenges = {}
	self.g36.challenges.group = "rifle"
	self.g36.challenges.weapon = "m4"]]
	
	-- self.g36.alert_size = 5000
	self.g36.stats = {
		damage = 8,
		spread = 6,
		recoil = 11,
		spread_moving = 7,
		zoom = 3,
		concealment = 7 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- P90 ---------------------------------------
	self.p90 = {}
	self.p90.category = "smg"
	
	self.p90.damage_melee = damage_melee_default
	self.p90.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.p90.sounds = {}
	self.p90.sounds.fire = "p90_fire"
	self.p90.sounds.stop_fire = "p90_stop"
	self.p90.sounds.dryfire = "m4_dryfire"

	self.p90.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.p90.sounds.leave_steelsight = "secondary_steel_sight_exit"
	
	self.p90.timers = {}
	self.p90.timers.reload_not_empty = 2.9 -- 2.35 
	self.p90.timers.reload_empty = 3.9 -- 3.35
	self.p90.timers.unequip = 0.7
	self.p90.timers.equip = 0.5

	self.p90.name_id = "bm_w_p90"
	self.p90.desc_id = "bm_w_p90_desc"
	self.p90.hud_icon = "mac11"
	self.p90.description_id = "des_p90"
	self.p90.hud_ammo = "guis/textures/ammo_small_9mm"
	
	self.p90.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.p90.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.p90.use_data = {}
	self.p90.use_data.selection_index = 1
	
	self.p90.DAMAGE = 1.0
	
	self.p90.CLIP_AMMO_MAX = 50
	self.p90.NR_CLIPS_MAX = math.round((total_damage_secondary/1.45) / self.p90.CLIP_AMMO_MAX)
	self.p90.AMMO_MAX = self.p90.CLIP_AMMO_MAX * self.p90.NR_CLIPS_MAX
	self.p90.AMMO_PICKUP = self:_pickup_chance( self.p90.AMMO_MAX, 1 )
	
	self.p90.auto = {}					-- Defines the weapons fire mode
	self.p90.auto.fire_rate = 0.09 -- Slightly higher than the m4, for difference in between the smgs
	
	self.p90.spread = {}
	--[[
	self.p90.spread.standing = 1.0 -- 4
	self.p90.spread.crouching = 0.75 -- 3
	self.p90.spread.steelsight = 0.5 -- 2.2
	self.p90.spread.moving_standing = 1.5 -- 5
	self.p90.spread.moving_crouching = 1.25 -- 4
	self.p90.spread.moving_steelsight = 0.5
	]]
	self.p90.spread.standing = self.new_m4.spread.standing * 1.35
	self.p90.spread.crouching = self.new_m4.spread.standing * 1.35
	self.p90.spread.steelsight = self.new_m4.spread.steelsight
	self.p90.spread.moving_standing = self.new_m4.spread.standing * 1.35
	self.p90.spread.moving_crouching = self.new_m4.spread.standing * 1.35
	self.p90.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.p90.kick = {}
	self.p90.kick.standing = self.new_m4.kick.standing
	self.p90.kick.crouching = self.p90.kick.standing
	self.p90.kick.steelsight = self.p90.kick.standing
	
	self.p90.crosshair = {}
	self.p90.crosshair.standing = {}
	self.p90.crosshair.crouching = {}
	self.p90.crosshair.steelsight = {}
	
	self.p90.crosshair.standing.offset = 0.4
	self.p90.crosshair.standing.moving_offset = 0.7
	self.p90.crosshair.standing.kick_offset = 0.6
	
	self.p90.crosshair.crouching.offset = 0.3
	self.p90.crosshair.crouching.moving_offset = 0.6
	self.p90.crosshair.crouching.kick_offset = 0.4
	
	self.p90.crosshair.steelsight.hidden = true
	self.p90.crosshair.steelsight.offset = 0
	self.p90.crosshair.steelsight.moving_offset = 0
	self.p90.crosshair.steelsight.kick_offset = 0.4
	
	self.p90.shake = {}
	self.p90.shake.fire_multiplier = 1
	self.p90.shake.fire_steelsight_multiplier = 1
	
	self.p90.autohit = autohit_pistol_default
	self.p90.aim_assist = aim_assist_pistol_default
	
	self.p90.animations = {}
	--[[self.p90.animations.fire = "recoil"
	self.p90.animations.reload = "reload"
	self.p90.animations.reload_not_empty = "reload_not_empty"]]
	self.p90.animations.equip_id = "equip_mac11_rifle"
	self.p90.animations.recoil_steelsight = false
	
	-- self.p90.challenges = {}
	-- self.p90.challenges.group = "sub_machingun"
	-- self.p90.challenges.weapon = "mac11"
	
	-- self.p90.alert_size = 300
	self.p90.stats = {
		damage = 6,
		spread = 6,
		recoil = 6,
		spread_moving = 7,
		zoom = 3,
		concealment = 8 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- New M14 ---------------------------------------
	self.new_m14 = {}
	self.new_m14.category = "assault_rifle"
	
	self.new_m14.damage_melee = damage_melee_default
	self.new_m14.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.new_m14.sounds = {}
	self.new_m14.sounds.fire = "m14_fire"
	-- self.new_m14.sounds.stop_fire = "m4_stop"
	self.new_m14.sounds.dryfire = "m14_dryfire"

	self.new_m14.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.new_m14.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.new_m14.timers = {}
	self.new_m14.timers.reload_not_empty = 1.97 -- 1.78
	self.new_m14.timers.reload_empty = 3.1 -- 2.65
	self.new_m14.timers.unequip = 0.8
	self.new_m14.timers.equip = 0.65
	
	self.new_m14.name_id = "bm_w_m14"
	self.new_m14.desc_id = "bm_w_m14_desc"
	self.new_m14.hud_icon = "m14"
	self.new_m14.description_id = "des_m14"

	self.new_m14.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.new_m14.shell_ejection = "effects/payday2/particles/weapons/shells/shell_556"
	
	self.new_m14.use_data = {}
	self.new_m14.use_data.selection_index = 2
	self.new_m14.DAMAGE = 2
	
	self.new_m14.CLIP_AMMO_MAX = 10
	self.new_m14.NR_CLIPS_MAX = math.round((total_damage_primary/8) / self.new_m14.CLIP_AMMO_MAX)
	self.new_m14.AMMO_MAX = self.new_m14.CLIP_AMMO_MAX * self.new_m14.NR_CLIPS_MAX
	self.new_m14.AMMO_PICKUP = self:_pickup_chance( self.new_m14.AMMO_MAX, 2 )
	
	--self.new_m14.auto = {}					-- Defines the weapons fire mode
	--self.new_m14.auto.fire_rate = 0.225
	
	self.new_m14.single = {}					-- Defines the weapons fire mode
	self.new_m14.single.fire_rate = 0.14
	
	self.new_m14.spread = {}
	--[[
	self.new_m14.spread.standing = 3.5 -- 7
	self.new_m14.spread.crouching = 3.0 -- 6
	self.new_m14.spread.steelsight = 0.0167	-- 0.1
	self.new_m14.spread.moving_standing = 4.5 -- 10
	self.new_m14.spread.moving_crouching = 4 -- 8
	self.new_m14.spread.moving_steelsight = 1.5
 	]]
	
	self.new_m14.spread.standing = self.new_m4.spread.standing * 2
	self.new_m14.spread.crouching = self.new_m4.spread.standing * 2
	self.new_m14.spread.steelsight = self.new_m4.spread.steelsight
	self.new_m14.spread.moving_standing = self.new_m4.spread.standing * 2.5
	self.new_m14.spread.moving_crouching = self.new_m4.spread.standing * 2.5
	self.new_m14.spread.moving_steelsight = self.new_m4.spread.moving_steelsight * 1.5
	
	-- kick up, down, left, right
	self.new_m14.kick = {}
	self.new_m14.kick.standing = self.new_m4.kick.standing
	self.new_m14.kick.crouching = self.new_m14.kick.standing
	self.new_m14.kick.steelsight = self.new_m14.kick.standing
	
	self.new_m14.crosshair = {}
	self.new_m14.crosshair.standing = {}
	self.new_m14.crosshair.crouching = {}
	self.new_m14.crosshair.steelsight = {}
	
	self.new_m14.crosshair.standing.offset = 0.16
	self.new_m14.crosshair.standing.moving_offset = 0.8
	self.new_m14.crosshair.standing.kick_offset = 0.6
	
	self.new_m14.crosshair.crouching.offset = 0.08
	self.new_m14.crosshair.crouching.moving_offset = 0.7
	self.new_m14.crosshair.crouching.kick_offset = 0.4
	
	self.new_m14.crosshair.steelsight.hidden = true
	self.new_m14.crosshair.steelsight.offset = 0
	self.new_m14.crosshair.steelsight.moving_offset = 0
	self.new_m14.crosshair.steelsight.kick_offset = 0.1
	
	self.new_m14.shake = {}
	self.new_m14.shake.fire_multiplier = 1
	self.new_m14.shake.fire_steelsight_multiplier = 1
	
	self.new_m14.autohit = autohit_rifle_default
	self.new_m14.aim_assist = aim_assist_rifle_default
	

	self.new_m14.animations = {}
	self.new_m14.animations.fire = "recoil"
	-- self.new_m14.animations.reload = "reload"
	-- self.new_m14.animations.reload_not_empty = "reload_not_empty"]]
	self.new_m14.animations.equip_id = "equip_m14_rifle"
	self.new_m14.animations.recoil_steelsight = true
	
	--[[self.new_m14.challenges = {}
	self.new_m14.challenges.group = "rifle"
	self.new_m14.challenges.weapon = "new_m14"]]
	
	-- self.new_m14.alert_size = 5000
	self.new_m14.stats = {
		damage = 27,
		spread = 8,
		recoil = 2,
		spread_moving = 7,
		zoom = 3,
		concealment = 6 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- DEAGLE ---------------------------------------
	self.deagle = {}
	self.deagle.category = "pistol"
	
	self.deagle.damage_melee = damage_melee_default
	self.deagle.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.deagle.sounds = {}
	self.deagle.sounds.fire = "deagle_fire"
	self.deagle.sounds.dryfire = "c45_dryfire"
	self.deagle.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.deagle.sounds.leave_steelsight = "pistol_steel_sight_exit"
	-- self.deagle.sounds.stop_fire = "m4_stop"
	
	self.deagle.single = {}					-- Defines the weapons fire mode
	self.deagle.single.fire_rate = 0.15
	
	self.deagle.timers = {}
	self.deagle.timers.reload_not_empty = 1.47
	self.deagle.timers.reload_empty = 2.12
	self.deagle.timers.unequip = 0.6
	self.deagle.timers.equip = 0.6
	
	self.deagle.name_id = "bm_w_deagle"
	self.deagle.desc_id = "bm_w_deagle_desc"
	self.deagle.hud_icon = "c45"
	self.deagle.description_id = "des_deagle"
	self.deagle.hud_ammo = "guis/textures/ammo_9mm"
	
	self.deagle.muzzleflash = "effects/payday2/particles/weapons/556_auto_fps"
	self.deagle.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	
	self.deagle.use_data = {}
	self.deagle.use_data.selection_index = 1
	
	self.deagle.DAMAGE = 2
	
	self.deagle.CLIP_AMMO_MAX = 10
	self.deagle.NR_CLIPS_MAX = math.round((total_damage_secondary/4.5) / self.deagle.CLIP_AMMO_MAX)
	self.deagle.AMMO_MAX = self.deagle.CLIP_AMMO_MAX * self.deagle.NR_CLIPS_MAX
	self.deagle.AMMO_PICKUP = self:_pickup_chance( self.deagle.AMMO_MAX, 1 )
	
	self.deagle.spread = {}
	--[[
	self.deagle.spread.standing = 1.0-- 4.5
	self.deagle.spread.crouching = 1.0 -- 4.5
	self.deagle.spread.steelsight = 0.4 -- 1.7
	self.deagle.spread.moving_standing = 1.5 -- 4.5
	self.deagle.spread.moving_crouching = 1.5 -- 4.5
	self.deagle.spread.moving_steelsight = 1
	]]
	self.deagle.spread.standing = self.new_m4.spread.standing
	self.deagle.spread.crouching = self.new_m4.spread.standing
	self.deagle.spread.steelsight = self.new_m4.spread.steelsight
	self.deagle.spread.moving_standing = self.new_m4.spread.standing
	self.deagle.spread.moving_crouching = self.new_m4.spread.standing
	self.deagle.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	
	self.deagle.kick = {}
	self.deagle.kick.standing = self.glock_17.kick.standing
	self.deagle.kick.crouching = self.deagle.kick.standing
	self.deagle.kick.steelsight = self.deagle.kick.standing
	
	self.deagle.crosshair = {}
	self.deagle.crosshair.standing = {}
	self.deagle.crosshair.crouching = {}
	self.deagle.crosshair.steelsight = {}
	
	self.deagle.crosshair.standing.offset = 0.2
	self.deagle.crosshair.standing.moving_offset = 0.6
	self.deagle.crosshair.standing.kick_offset = 0.4
	
	self.deagle.crosshair.crouching.offset = 0.1
	self.deagle.crosshair.crouching.moving_offset = 0.6
	self.deagle.crosshair.crouching.kick_offset = 0.3
	
	self.deagle.crosshair.steelsight.hidden = true
	self.deagle.crosshair.steelsight.offset = 0
	self.deagle.crosshair.steelsight.moving_offset = 0
	self.deagle.crosshair.steelsight.kick_offset = 0.1
	
	self.deagle.shake = {}
	self.deagle.shake.fire_multiplier = -1
	self.deagle.shake.fire_steelsight_multiplier = -1
	
	self.deagle.autohit = autohit_pistol_default
	self.deagle.aim_assist = aim_assist_pistol_default
	
	
	self.deagle.animations = {}
	--[[self.deagle.animations.fire = "recoil"
	self.deagle.animations.reload = "reload"
	self.deagle.animations.reload_not_empty = "reload_not_empty"]]
	self.deagle.animations.equip_id = "equip_glock"
	self.deagle.animations.recoil_steelsight = true
	
	--[[self.deagle.challenges = {}
	-- self.deagle.challenges.prefix = "handgun"
	self.deagle.challenges.group = "handgun"
	self.deagle.challenges.weapon = "c45"]]
	
	-- self.deagle.alert_size = 2500
	self.deagle.stats = {
		damage = 19,
		spread = 4,
		recoil = 2,
		spread_moving = 7,
		zoom = 3,
		concealment = 9 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- NEW MP5 ---------------------------------------
	self.new_mp5 = {}
	self.new_mp5.category = "smg"
	
	self.new_mp5.damage_melee = damage_melee_default
	self.new_mp5.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.new_mp5.sounds = {}
	self.new_mp5.sounds.fire = "mp5_fire"
	self.new_mp5.sounds.stop_fire = "mp5_stop"
	self.new_mp5.sounds.dryfire = "mp5_dryfire"

	self.new_mp5.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.new_mp5.sounds.leave_steelsight = "secondary_steel_sight_exit"
	
	self.new_mp5.timers = {}
	self.new_mp5.timers.reload_not_empty = 2.4
	self.new_mp5.timers.reload_empty = 3.3 -- 2.9
	self.new_mp5.timers.unequip = 0.7
	self.new_mp5.timers.equip = 0.5
	
	self.new_mp5.name_id = "bm_w_mp5"
	self.new_mp5.desc_id = "bm_w_mp5_desc"
	-- self.new_mp5.hud_icon = "guis/textures/weapon_mp5"
	self.new_mp5.hud_icon = "mp5"
	self.new_mp5.description_id = "des_mp5"
	self.new_mp5.hud_ammo = "guis/textures/ammo_9mm"
	
	self.new_mp5.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.new_mp5.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.new_mp5.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	
	self.new_mp5.use_data = {}
	self.new_mp5.use_data.selection_index = 1
	
	self.new_mp5.DAMAGE = 1
	
	self.new_mp5.CLIP_AMMO_MAX = 30
	self.new_mp5.NR_CLIPS_MAX = math.round((total_damage_secondary/1) / self.new_mp5.CLIP_AMMO_MAX)
	self.new_mp5.AMMO_MAX = self.new_mp5.CLIP_AMMO_MAX * self.new_mp5.NR_CLIPS_MAX
	self.new_mp5.AMMO_PICKUP = self:_pickup_chance( self.new_mp5.AMMO_MAX, 1 )
	
	self.new_mp5.auto = {}					-- Defines the weapons fire mode
	self.new_mp5.auto.fire_rate = 0.13
	
	self.new_mp5.spread = {}
	--[[
	self.new_mp5.spread.standing = 1.25 -- 3.5
	self.new_mp5.spread.crouching = 0.75 -- 2.5
	self.new_mp5.spread.steelsight = 0.325 -- 1.7
	self.new_mp5.spread.moving_standing = 1.28 -- 4.5
	self.new_mp5.spread.moving_crouching = 1.08 -- 3.8
	self.new_mp5.spread.moving_steelsight = 0.75
	]]
	self.new_mp5.spread.standing = self.new_m4.spread.standing
	self.new_mp5.spread.crouching = self.new_m4.spread.standing
	self.new_mp5.spread.steelsight = self.new_m4.spread.steelsight
	self.new_mp5.spread.moving_standing = self.new_m4.spread.standing
	self.new_mp5.spread.moving_crouching = self.new_m4.spread.standing
	self.new_mp5.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.new_mp5.kick = {}
	self.new_mp5.kick.standing = self.new_m4.kick.standing
	self.new_mp5.kick.crouching = self.new_mp5.kick.standing
	self.new_mp5.kick.steelsight = self.new_mp5.kick.standing
	
	self.new_mp5.crosshair = {}
	self.new_mp5.crosshair.standing = {}
	self.new_mp5.crosshair.crouching = {}
	self.new_mp5.crosshair.steelsight = {}
	
	self.new_mp5.crosshair.standing.offset = 0.5
	self.new_mp5.crosshair.standing.moving_offset = 0.6
	self.new_mp5.crosshair.standing.kick_offset = 0.7
	
	self.new_mp5.crosshair.crouching.offset = 0.4
	self.new_mp5.crosshair.crouching.moving_offset = 0.5
	self.new_mp5.crosshair.crouching.kick_offset = 0.6
	
	self.new_mp5.crosshair.steelsight.hidden = true
	self.new_mp5.crosshair.steelsight.offset = 0
	self.new_mp5.crosshair.steelsight.moving_offset = 0
	self.new_mp5.crosshair.steelsight.kick_offset = 0
	
	self.new_mp5.shake = {}
	self.new_mp5.shake.fire_multiplier = 1
	self.new_mp5.shake.fire_steelsight_multiplier = 0.5
	
	self.new_mp5.autohit = autohit_pistol_default
	self.new_mp5.aim_assist = aim_assist_pistol_default
	
	self.new_mp5.weapon_hold = "mp5" -- REUSE
	self.new_mp5.animations = {}
	-- self.new_mp5.animations.fire = "recoil"
	-- self.new_mp5.animations.reload = "reload"
	-- self.new_mp5.animations.reload_not_empty = "reload_not_empty"]]
	
	self.new_mp5.animations.equip_id = "equip_mp5_rifle"
	self.new_mp5.animations.recoil_steelsight = false
	
	--[[self.new_mp5.challenges = {}
	-- self.new_mp5.challenges.prefix = "sub_machingun"
	self.new_mp5.challenges.group = "sub_machingun"
	self.new_mp5.challenges.weapon = "mp5"]]
	
	-- self.new_mp5.alert_size = 2500
	self.new_mp5.stats = {
		damage = 5,
		spread = 6,
		recoil = 9,
		spread_moving = 7,
		zoom = 3,
		concealment = 8 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- COLT 1911 ---------------------------------------
	self.colt_1911 = {}
	self.colt_1911.category = "pistol"
	
	self.colt_1911.damage_melee = damage_melee_default
	self.colt_1911.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.colt_1911.sounds = {}
	self.colt_1911.sounds.fire = "c45_fire"
	self.colt_1911.sounds.dryfire = "c45_dryfire"
	self.colt_1911.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.colt_1911.sounds.leave_steelsight = "pistol_steel_sight_exit"
	-- self.colt_1911.sounds.stop_fire = "m4_stop"
	
	self.colt_1911.single = {}					-- Defines the weapons fire mode
	self.colt_1911.single.fire_rate = 0.12
	
	self.colt_1911.timers = {}
	self.colt_1911.timers.reload_not_empty = 1.47 -- 2.1 
	self.colt_1911.timers.reload_empty = 2.12 -- 2.7
	self.colt_1911.timers.unequip = 0.5
	self.colt_1911.timers.equip = 0.5
	
	self.colt_1911.name_id = "bm_w_colt_1911"
	self.colt_1911.desc_id = "bm_w_colt_1911_desc"
	self.colt_1911.hud_icon = "c45"
	self.colt_1911.description_id = "des_colt_1911"
	self.colt_1911.hud_ammo = "guis/textures/ammo_9mm"
	
	self.colt_1911.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.colt_1911.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.colt_1911.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	
	self.colt_1911.use_data = {}
	self.colt_1911.use_data.selection_index = 1
	
	self.colt_1911.DAMAGE = 1
	
	self.colt_1911.CLIP_AMMO_MAX = 10
	self.colt_1911.NR_CLIPS_MAX = math.round((total_damage_secondary/2.5) / self.colt_1911.CLIP_AMMO_MAX)
	self.colt_1911.AMMO_MAX = self.colt_1911.CLIP_AMMO_MAX * self.colt_1911.NR_CLIPS_MAX
	self.colt_1911.AMMO_PICKUP = self:_pickup_chance( self.colt_1911.AMMO_MAX, 1 )
	
	self.colt_1911.spread = {}
	--[[
	self.colt_1911.spread.standing = 1 -- 4.5
	self.colt_1911.spread.crouching = 1 -- 4.5
	self.colt_1911.spread.steelsight = 0.38 -- 1.7
	self.colt_1911.spread.moving_standing = 1 -- 4.5
	self.colt_1911.spread.moving_crouching = 1 -- 4.5
	self.colt_1911.spread.moving_steelsight = 0.38
	]]
	
	self.colt_1911.spread.standing = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.crouching = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.steelsight = self.new_m4.spread.steelsight
	self.colt_1911.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.colt_1911.kick = {}
	self.colt_1911.kick.standing = self.glock_17.kick.standing
	self.colt_1911.kick.crouching = self.colt_1911.kick.standing
	self.colt_1911.kick.steelsight = self.colt_1911.kick.standing
	
	self.colt_1911.crosshair = {}
	self.colt_1911.crosshair.standing = {}
	self.colt_1911.crosshair.crouching = {}
	self.colt_1911.crosshair.steelsight = {}
	
	self.colt_1911.crosshair.standing.offset = 0.2
	self.colt_1911.crosshair.standing.moving_offset = 0.6
	self.colt_1911.crosshair.standing.kick_offset = 0.4
	
	self.colt_1911.crosshair.crouching.offset = 0.1
	self.colt_1911.crosshair.crouching.moving_offset = 0.6
	self.colt_1911.crosshair.crouching.kick_offset = 0.3
	
	self.colt_1911.crosshair.steelsight.hidden = true
	self.colt_1911.crosshair.steelsight.offset = 0
	self.colt_1911.crosshair.steelsight.moving_offset = 0
	self.colt_1911.crosshair.steelsight.kick_offset = 0.1
	
	self.colt_1911.shake = {}
	self.colt_1911.shake.fire_multiplier = 1
	self.colt_1911.shake.fire_steelsight_multiplier = -1
	
	self.colt_1911.autohit = autohit_pistol_default
	self.colt_1911.aim_assist = aim_assist_pistol_default
	
	self.colt_1911.animations = {}
	--self.colt_1911.animations.fire = "recoil"
	self.colt_1911.animations.reload = "reload"
	self.colt_1911.animations.reload_not_empty = "reload_not_empty"
	self.colt_1911.animations.equip_id = "equip_glock"
	self.colt_1911.animations.recoil_steelsight = true
	
	--[[self.colt_1911.challenges = {}
	-- self.colt_1911.challenges.prefix = "handgun"
	self.colt_1911.challenges.group = "handgun"
	self.colt_1911.challenges.weapon = "c45"]]
	
	-- self.colt_1911.alert_size = 2500
	self.colt_1911.stats = {
		damage = 11,
		spread = 4,
		recoil = 2,
		spread_moving = 7,
		zoom = 3,
		concealment = 10 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- MAC10 ---------------------------------------
	self.mac10 = {}
	self.mac10.category = "smg"
	
	self.mac10.damage_melee = damage_melee_default
	self.mac10.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.mac10.sounds = {}
	self.mac10.sounds.fire = "mac10_fire"
	self.mac10.sounds.stop_fire = "mac10_stop"
	self.mac10.sounds.dryfire = "mk11_dryfire"

	self.mac10.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.mac10.sounds.leave_steelsight = "secondary_steel_sight_exit"
	
	self.mac10.timers = {}
	self.mac10.timers.reload_not_empty = 1.7 -- 2.35 
	self.mac10.timers.reload_empty = 2.5 -- 3.35
	self.mac10.timers.unequip = 0.7
	self.mac10.timers.equip = 0.5

	self.mac10.name_id = "bm_w_mac10"
	self.mac10.desc_id = "bm_w_mac10_desc"
	self.mac10.hud_icon = "mac11"
	self.mac10.description_id = "des_mac10"
	self.mac10.hud_ammo = "guis/textures/ammo_small_9mm"
	
	self.mac10.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.mac10.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.mac10.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	
	self.mac10.use_data = {}
	self.mac10.use_data.selection_index = 1
	
	self.mac10.DAMAGE = 1
	
	self.mac10.CLIP_AMMO_MAX = 40
	self.mac10.NR_CLIPS_MAX = math.round((total_damage_secondary/2.25) / self.mac10.CLIP_AMMO_MAX)
	self.mac10.AMMO_MAX = self.mac10.CLIP_AMMO_MAX * self.mac10.NR_CLIPS_MAX
	self.mac10.AMMO_PICKUP = self:_pickup_chance( self.mac10.AMMO_MAX, 1 )
	
	self.mac10.auto = {}					-- Defines the weapons fire mode
	self.mac10.auto.fire_rate = 0.065
	
	self.mac10.spread = {}
	--[[
	self.mac10.spread.standing = 1.25 -- 4
	self.mac10.spread.crouching = 1 -- 3
	self.mac10.spread.steelsight = 0.6 -- 2.2
	self.mac10.spread.moving_standing = 1.25 -- 5
	self.mac10.spread.moving_crouching = 1.25 -- 4
	self.mac10.spread.moving_steelsight = 0.6
	]]
	self.mac10.spread.standing = self.new_m4.spread.standing * 0.75
	self.mac10.spread.crouching = self.new_m4.spread.standing * 0.75
	self.mac10.spread.steelsight = self.new_m4.spread.steelsight
	self.mac10.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.mac10.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.mac10.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.mac10.kick = {}
	self.mac10.kick.standing = self.mp9.kick.standing
	self.mac10.kick.crouching = self.mac10.kick.standing
	self.mac10.kick.steelsight = self.mac10.kick.standing
	
	self.mac10.crosshair = {}
	self.mac10.crosshair.standing = {}
	self.mac10.crosshair.crouching = {}
	self.mac10.crosshair.steelsight = {}
	
	self.mac10.crosshair.standing.offset = 0.4
	self.mac10.crosshair.standing.moving_offset = 0.7
	self.mac10.crosshair.standing.kick_offset = 0.6
	
	self.mac10.crosshair.crouching.offset = 0.3
	self.mac10.crosshair.crouching.moving_offset = 0.6
	self.mac10.crosshair.crouching.kick_offset = 0.4
	
	self.mac10.crosshair.steelsight.hidden = true
	self.mac10.crosshair.steelsight.offset = 0
	self.mac10.crosshair.steelsight.moving_offset = 0
	self.mac10.crosshair.steelsight.kick_offset = 0.4
	
	self.mac10.shake = {}
	self.mac10.shake.fire_multiplier = 1
	self.mac10.shake.fire_steelsight_multiplier = -1
	
	self.mac10.autohit = autohit_pistol_default
	self.mac10.aim_assist = aim_assist_pistol_default
	
	self.mac10.weapon_hold = "mac11" -- REUSE
	self.mac10.animations = {}
	--[[self.mac10.animations.fire = "recoil"
	self.mac10.animations.reload = "reload"
	self.mac10.animations.reload_not_empty = "reload_not_empty"]]
	self.mac10.animations.equip_id = "equip_mac11_rifle"
	self.mac10.animations.recoil_steelsight = false
	
	-- self.mac10.challenges = {}
	-- self.mac10.challenges.group = "sub_machingun"
	-- self.mac10.challenges.weapon = "mac11"
	
	-- self.mac10.alert_size = 3000
	self.mac10.stats = {
		damage = 10,
		spread = 2,
		recoil = 4,
		spread_moving = 7,
		zoom = 3,
		concealment = 9 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	
	-- serbu ---------------------------------------
	self.serbu = {}
	self.serbu.category = "shotgun"
	
	self.serbu.damage_melee = damage_melee_default
	self.serbu.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.serbu.sounds = {}
	self.serbu.sounds.fire = "serbu_fire"
	self.serbu.sounds.dryfire = "remington_dryfire"
	-- self.serbu.sounds.stop_fire = ""

	self.serbu.sounds.enter_steelsight = "primary_steel_sight_enter"
	self.serbu.sounds.leave_steelsight = "primary_steel_sight_exit"
	
	self.serbu.timers = {}
	-- Shotgun reload timers are calculated in the script depending on how many shells to reload
	self.serbu.timers.unequip = 0.7
	self.serbu.timers.equip = 0.6
	
	self.serbu.name_id = "bm_w_serbu"
	self.serbu.desc_id = "bm_w_serbu_desc"
	-- self.serbu.hud_icon = "guis/textures/weapon_r870_shotgun"
	self.serbu.hud_icon = "r870_shotgun"
	self.serbu.description_id = "des_r870"
	self.serbu.hud_ammo = "guis/textures/ammo_shell"
	
	self.serbu.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.serbu.shell_ejection = "effects/payday2/particles/weapons/shells/shell_slug_semi"
	
	self.serbu.use_data = {}
	self.serbu.use_data.selection_index = 1
	self.serbu.use_data.align_place = "right_hand"
	
	self.serbu.DAMAGE = 6 -- 1.5
	self.serbu.damage_near = 100
	self.serbu.damage_far = 3000
	self.serbu.rays = 6
	
	self.serbu.CLIP_AMMO_MAX = 6
	self.serbu.NR_CLIPS_MAX = math.round((total_damage_secondary/5.5) / self.serbu.CLIP_AMMO_MAX)
	self.serbu.AMMO_MAX = self.serbu.CLIP_AMMO_MAX * self.serbu.NR_CLIPS_MAX
	self.serbu.AMMO_PICKUP = self:_pickup_chance( self.serbu.AMMO_MAX, 1 )
	
	self.serbu.single = {}					-- Defines the weapons fire mode
	-- self.serbu.single.fire_rate = 0.375
	self.serbu.single.fire_rate = 0.375
	
	self.serbu.spread = {}
	--[[
	self.serbu.spread.standing = 1.5 -- 4
	self.serbu.spread.crouching = 1 -- 4
	self.serbu.spread.steelsight = 0.1 -- 3
	self.serbu.spread.moving_standing = 2.5 -- 4
	self.serbu.spread.moving_crouching = 1.5 -- 4
	self.serbu.spread.moving_steelsight = 0.8
	]]
	
	self.serbu.spread.standing = self.r870.spread.standing
	self.serbu.spread.crouching = self.r870.spread.crouching
	self.serbu.spread.steelsight = self.r870.spread.steelsight
	self.serbu.spread.moving_standing = self.r870.spread.moving_standing
	self.serbu.spread.moving_crouching = self.r870.spread.moving_crouching
	self.serbu.spread.moving_steelsight = self.r870.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.serbu.kick = {}
	self.serbu.kick.standing = self.r870.kick.standing
	self.serbu.kick.crouching = self.serbu.kick.standing
	self.serbu.kick.steelsight = self.serbu.kick.standing
	
	self.serbu.crosshair = {}
	self.serbu.crosshair.standing = {}
	self.serbu.crosshair.crouching = {}
	self.serbu.crosshair.steelsight = {}
	
	self.serbu.crosshair.standing.offset = 0.7
	self.serbu.crosshair.standing.moving_offset = 0.7
	self.serbu.crosshair.standing.kick_offset = 0.8
	
	self.serbu.crosshair.crouching.offset = 0.65
	self.serbu.crosshair.crouching.moving_offset = 0.65
	self.serbu.crosshair.crouching.kick_offset = 0.75
	
	self.serbu.crosshair.steelsight.hidden = true
	self.serbu.crosshair.steelsight.offset = 0
	self.serbu.crosshair.steelsight.moving_offset = 0
	self.serbu.crosshair.steelsight.kick_offset = 0
	
	self.serbu.shake = {}
	self.serbu.shake.fire_multiplier = 1
	self.serbu.shake.fire_steelsight_multiplier = -1
	
	self.serbu.autohit = autohit_shotgun_default
	self.serbu.aim_assist = aim_assist_shotgun_default
	
	self.serbu.weapon_hold = "r870_shotgun" -- REUSE
	self.serbu.animations = {}
	--[[self.serbu.animations.fire = "recoil"
	self.serbu.animations.fire_steelsight = "recoil_zoom"
	self.serbu.animations.reload_exit = "reload"]]
	self.serbu.animations.equip_id = "equip_r870_shotgun"
	self.serbu.animations.recoil_steelsight = true
	
	--[[self.serbu.challenges = {}
	self.serbu.challenges.group = "shotgun"
	self.serbu.challenges.weapon = "reinbeck"]]
	
	-- self.serbu.alert_size = 4500
	self.serbu.stats = {
		damage = 22,
		spread = 5,
		recoil = 5,
		spread_moving = 7,
		zoom = 3,
		concealment = 8 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	

	
	-- Huntsman ---------------------------------------
	self.huntsman = {}
	self.huntsman.category = "shotgun"
	self.huntsman.upgrade_blocks = { weapon = { "clip_ammo_increase" } }
	
	self.huntsman.damage_melee = damage_melee_default
	self.huntsman.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.huntsman.sounds = {}
	self.huntsman.sounds.fire = "huntsman_fire"
	-- self.huntsman.sounds.stop_fire = "m4_stop"
	self.huntsman.sounds.dryfire = "remington_dryfire"

	self.huntsman.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.huntsman.sounds.leave_steelsight = "secondary_steel_sight_exit"
	
	self.huntsman.timers = {}
	self.huntsman.timers.reload_not_empty = 2.5 -- 1.78
	self.huntsman.timers.reload_empty = self.huntsman.timers.reload_not_empty
	self.huntsman.timers.unequip = 0.7
	self.huntsman.timers.equip = 0.6
	
	self.huntsman.name_id = "bm_w_huntsman"
	self.huntsman.desc_id = "bm_w_huntsman_desc"
	self.huntsman.hud_icon = "m79"
	self.huntsman.description_id = "des_huntsman"
	self.huntsman.hud_ammo = "guis/textures/ammo_grenade"
	
	self.huntsman.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps" -- "effects/payday2/particles/weapons/shotgun/sho_muzzleflash"
	self.huntsman.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
	
	self.huntsman.use_data = {}
	self.huntsman.use_data.selection_index = 2
	self.huntsman.use_data.align_place = "right_hand"
	
	--[[
	self.huntsman.DAMAGE = 30
	self.huntsman.damage_near = 500
	self.huntsman.damage_far = 3000
	self.huntsman.rays = 12
	]]
	
	self.huntsman.DAMAGE = 6 -- 1.5
	self.huntsman.damage_near = 1000
	self.huntsman.damage_far = 3000
	self.huntsman.rays = 6
	
	-- self.huntsman.EXPLOSION_RANGE = 500
	-- self.huntsman.DAMAGE_CURVE_POW = 5
	
	self.huntsman.CLIP_AMMO_MAX = 2
	self.huntsman.NR_CLIPS_MAX = math.round((total_damage_primary/12) / self.huntsman.CLIP_AMMO_MAX)
	self.huntsman.AMMO_MAX = self.huntsman.CLIP_AMMO_MAX * self.huntsman.NR_CLIPS_MAX
	self.huntsman.AMMO_PICKUP = self:_pickup_chance( self.huntsman.AMMO_MAX, 1 )
	
	-- self.huntsman.auto = {}					-- Defines the weapons fire mode
	-- self.huntsman.auto.fire_rate = 0.1
	
	self.huntsman.single = {}					-- Defines the weapons fire mode
	self.huntsman.single.fire_rate = 0.12
	
	self.huntsman.spread = {}
	--[[
	self.huntsman.spread.standing = 2 -- 8
	self.huntsman.spread.crouching = 1.5 -- 8
	self.huntsman.spread.steelsight = 0.75 -- 8
	self.huntsman.spread.moving_standing = 2.25 -- 8
	self.huntsman.spread.moving_crouching = 2.25 -- 8
	self.huntsman.spread.moving_steelsight = 0.75
	]]
	
	self.huntsman.spread.standing = self.r870.spread.standing
	self.huntsman.spread.crouching = self.r870.spread.crouching
	self.huntsman.spread.steelsight = self.r870.spread.steelsight
	self.huntsman.spread.moving_standing = self.r870.spread.moving_standing
	self.huntsman.spread.moving_crouching = self.r870.spread.moving_crouching
	self.huntsman.spread.moving_steelsight = self.r870.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.huntsman.kick = {}
	self.huntsman.kick.standing = {2.9, 3, -0.5, 0.5}
	self.huntsman.kick.crouching = self.huntsman.kick.standing
	self.huntsman.kick.steelsight = self.huntsman.kick.standing
	
	self.huntsman.crosshair = {}
	self.huntsman.crosshair.standing = {}
	self.huntsman.crosshair.crouching = {}
	self.huntsman.crosshair.steelsight = {}
	
	self.huntsman.crosshair.standing.offset = 0.16
	self.huntsman.crosshair.standing.moving_offset = 0.8
	self.huntsman.crosshair.standing.kick_offset = 0.6
	self.huntsman.crosshair.standing.hidden = true
	
	self.huntsman.crosshair.crouching.offset = 0.08
	self.huntsman.crosshair.crouching.moving_offset = 0.7
	self.huntsman.crosshair.crouching.kick_offset = 0.4
	self.huntsman.crosshair.crouching.hidden = true
	
	self.huntsman.crosshair.steelsight.hidden = true
	self.huntsman.crosshair.steelsight.offset = 0
	self.huntsman.crosshair.steelsight.moving_offset = 0
	self.huntsman.crosshair.steelsight.kick_offset = 0.1
	
	self.huntsman.shake = {}
	self.huntsman.shake.fire_multiplier = 2
	self.huntsman.shake.fire_steelsight_multiplier = 2
	
	self.huntsman.autohit = autohit_rifle_default
	self.huntsman.aim_assist = aim_assist_rifle_default
	
	self.huntsman.animations = {}
	self.huntsman.animations.fire = "recoil"
	self.huntsman.animations.reload = "reload"
	self.huntsman.animations.reload_not_empty = "reload"
	self.huntsman.animations.equip_id = "equip_huntsman"
	self.huntsman.animations.recoil_steelsight = true
	
	--[[ self.huntsman.challenges = {}
	self.huntsman.challenges.group = "grenade_launcher"
	self.huntsman.challenges.weapon = "m79" ]]
	
	-- self.huntsman.alert_size = 5000
	self.huntsman.stats = {
		damage = 35,
		spread = 8,
		recoil = 6,
		spread_moving = 7,
		zoom = 3,
		concealment = 7 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- Beretta b92fs---------------------------------------
	self.b92fs = {}
	self.b92fs.category = "pistol"
	
	self.b92fs.damage_melee = damage_melee_default
	self.b92fs.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.b92fs.sounds = {}
	self.b92fs.sounds.fire = "beretta_fire"
	self.b92fs.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.b92fs.sounds.leave_steelsight = "pistol_steel_sight_exit"
	self.b92fs.sounds.dryfire = "beretta_dryfire"
	-- self.b92fs.sounds.stop_fire = " _stop"
	
	self.b92fs.timers = {}
	self.b92fs.timers.reload_not_empty = 1.47 -- 2.1
	self.b92fs.timers.reload_empty = 2.12 -- 2.7
	self.b92fs.timers.unequip = 0.55
	self.b92fs.timers.equip = 0.55
	
	self.b92fs.name_id = "bm_w_b92fs"
	self.b92fs.desc_id = "bm_w_b92fs_desc"
	self.b92fs.hud_icon = "beretta92"
	self.b92fs.description_id = "des_b92fs"
	
	self.b92fs.hud_ammo = "guis/textures/ammo_9mm"
	
	self.b92fs.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.b92fs.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	self.b92fs.shell_ejection = "effects/payday2/particles/weapons/shells/shell_9mm"
	
	self.b92fs.use_data = {}
	self.b92fs.use_data.selection_index = 1
	
	self.b92fs.DAMAGE = 1
	
	self.b92fs.CLIP_AMMO_MAX = 14
	self.b92fs.NR_CLIPS_MAX = math.round((total_damage_secondary/1) / self.b92fs.CLIP_AMMO_MAX)
	self.b92fs.AMMO_MAX = self.b92fs.CLIP_AMMO_MAX * self.b92fs.NR_CLIPS_MAX
	self.b92fs.AMMO_PICKUP = self:_pickup_chance( self.b92fs.AMMO_MAX, 1 )
	
	self.b92fs.single = {}					-- Defines the weapons fire mode
	self.b92fs.single.fire_rate = 0.09
	
	self.b92fs.spread = {}
	--[[
	self.b92fs.spread.standing = 1 -- 3.5
	self.b92fs.spread.crouching = 0.8 -- 3
	self.b92fs.spread.steelsight = 0.4 -- 1.4
	self.b92fs.spread.moving_standing = 1.25 -- 3.5
	self.b92fs.spread.moving_crouching = 1 -- 3.5
	self.b92fs.spread.moving_steelsight = 0.4
	]]
	self.b92fs.spread.standing = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.crouching = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.steelsight = self.new_m4.spread.steelsight
	self.b92fs.spread.moving_standing = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.moving_crouching = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.b92fs.kick = {}
	self.b92fs.kick.standing = self.glock_17.kick.standing
	self.b92fs.kick.crouching = self.b92fs.kick.standing
	self.b92fs.kick.steelsight = self.b92fs.kick.standing
	
	self.b92fs.crosshair = {}
	self.b92fs.crosshair.standing = {}
	self.b92fs.crosshair.crouching = {}
	self.b92fs.crosshair.steelsight = {}
	
	self.b92fs.crosshair.standing.offset = 0.2
	self.b92fs.crosshair.standing.moving_offset = 0.6
	self.b92fs.crosshair.standing.kick_offset = 0.4
	
	self.b92fs.crosshair.crouching.offset = 0.1
	self.b92fs.crosshair.crouching.moving_offset = 0.6
	self.b92fs.crosshair.crouching.kick_offset = 0.3
	
	self.b92fs.crosshair.steelsight.hidden = true
	self.b92fs.crosshair.steelsight.offset = 0
	self.b92fs.crosshair.steelsight.moving_offset = 0
	self.b92fs.crosshair.steelsight.kick_offset = 0.1
	
	self.b92fs.shake = {}
	self.b92fs.shake.fire_multiplier = 1
	self.b92fs.shake.fire_steelsight_multiplier = -1
	
	self.b92fs.autohit = autohit_pistol_default
	self.b92fs.aim_assist = aim_assist_pistol_default
		
	self.b92fs.weapon_hold = "glock" -- REUSE
	self.b92fs.animations = {}
	--[[self.b92fs.animations.fire = "recoil"
	self.b92fs.animations.reload = "reload"
	self.b92fs.animations.reload_not_empty = "reload_not_empty"]]
	self.b92fs.animations.equip_id = "equip_glock"
	self.b92fs.animations.recoil_steelsight = true
	
	--[[self.b92fs.challenges = {}
	self.b92fs.challenges.group = "handgun"
	self.b92fs.challenges.weapon = "beretta92"]]
	
	-- self.b92fs.alert_size = 300
	self.b92fs.stats = {
		damage = 5,
		spread = 5,
		recoil = 6,
		spread_moving = 7,
		zoom = 3,
		concealment = 10 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- New Raging Bull ---------------------------------------
	self.new_raging_bull = {}
	self.new_raging_bull.category = "pistol"
	self.new_raging_bull.upgrade_blocks = { weapon = { "clip_ammo_increase" } }
	
	self.new_raging_bull.damage_melee = damage_melee_default
	self.new_raging_bull.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.new_raging_bull.sounds = {}
	self.new_raging_bull.sounds.fire = "rbull_fire"
	self.new_raging_bull.sounds.dryfire = "rbull_dryfire"
	self.new_raging_bull.sounds.enter_steelsight = "pistol_steel_sight_enter"
	self.new_raging_bull.sounds.leave_steelsight = "pistol_steel_sight_exit"
	-- self.new_raging_bull.sounds.stop_fire = "m4_stop"
	
	self.new_raging_bull.timers = {}
	self.new_raging_bull.timers.reload_not_empty = 2.25 -- 4.8 
	self.new_raging_bull.timers.reload_empty = 2.25 -- 5.6
	self.new_raging_bull.timers.unequip = 0.5
	self.new_raging_bull.timers.equip = 0.5
	
	self.new_raging_bull.single = {}					-- Defines the weapons fire mode
	self.new_raging_bull.single.fire_rate = 0.21
	
	self.new_raging_bull.name_id = "bm_w_raging_bull"
	self.new_raging_bull.desc_id = "bm_w_raging_bull_desc"
	self.new_raging_bull.hud_icon = "raging_bull"
	self.new_raging_bull.description_id = "des_new_raging_bull"
	self.new_raging_bull.hud_ammo = "guis/textures/ammo_9mm"
	
	self.new_raging_bull.muzzleflash = "effects/payday2/particles/weapons/762_auto_fps"
	self.new_raging_bull.shell_ejection = "effects/payday2/particles/weapons/shells/shell_empty"
	
	self.new_raging_bull.use_data = {}
	self.new_raging_bull.use_data.selection_index = 1
	
	self.new_raging_bull.DAMAGE = 2
	
	self.new_raging_bull.CLIP_AMMO_MAX = 6
	self.new_raging_bull.NR_CLIPS_MAX = math.round((total_damage_secondary/4.7) / self.new_raging_bull.CLIP_AMMO_MAX)
	self.new_raging_bull.AMMO_MAX = self.new_raging_bull.CLIP_AMMO_MAX * self.new_raging_bull.NR_CLIPS_MAX
	self.new_raging_bull.AMMO_PICKUP = self:_pickup_chance( self.new_raging_bull.AMMO_MAX, 1 )
	
	self.new_raging_bull.spread = {}
	--[[
	self.new_raging_bull.spread.standing = 1.0 -- 2.5
	self.new_raging_bull.spread.crouching = 1.0 -- 2.5
	self.new_raging_bull.spread.steelsight = 0.3 -- 1.8
	self.new_raging_bull.spread.moving_standing = 2.0 -- 2.5
	self.new_raging_bull.spread.moving_crouching = 1.5 -- 2.5
	self.new_raging_bull.spread.moving_steelsight = 0.3
	]]
	self.new_raging_bull.spread.standing = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.crouching = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.steelsight = self.new_m4.spread.steelsight
	self.new_raging_bull.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.moving_steelsight = self.new_m4.spread.moving_steelsight
	
	-- kick up, down, left, right
	self.new_raging_bull.kick = {}
	self.new_raging_bull.kick.standing = self.glock_17.kick.standing
	self.new_raging_bull.kick.crouching = self.new_raging_bull.kick.standing
	self.new_raging_bull.kick.steelsight = self.new_raging_bull.kick.standing

	self.new_raging_bull.crosshair = {}
	self.new_raging_bull.crosshair.standing = {}
	self.new_raging_bull.crosshair.crouching = {}
	self.new_raging_bull.crosshair.steelsight = {}
	
	self.new_raging_bull.crosshair.standing.offset = 0.2
	self.new_raging_bull.crosshair.standing.moving_offset = 0.6
	self.new_raging_bull.crosshair.standing.kick_offset = 0.4
	
	self.new_raging_bull.crosshair.crouching.offset = 0.1
	self.new_raging_bull.crosshair.crouching.moving_offset = 0.6
	self.new_raging_bull.crosshair.crouching.kick_offset = 0.3
	
	self.new_raging_bull.crosshair.steelsight.hidden = true
	self.new_raging_bull.crosshair.steelsight.offset = 0
	self.new_raging_bull.crosshair.steelsight.moving_offset = 0
	self.new_raging_bull.crosshair.steelsight.kick_offset = 0.1
	
	self.new_raging_bull.shake = {}
	self.new_raging_bull.shake.fire_multiplier = 1
	self.new_raging_bull.shake.fire_steelsight_multiplier = -1
	
	self.new_raging_bull.autohit = autohit_pistol_default
	self.new_raging_bull.aim_assist = aim_assist_pistol_default
	
	self.new_raging_bull.weapon_hold = "raging_bull"
	self.new_raging_bull.animations = {}
	--[[self.new_raging_bull.animations.fire = "recoil"
	self.new_raging_bull.animations.reload = "reload"
	self.new_raging_bull.animations.reload_not_empty = "reload_not_empty"]]
	self.new_raging_bull.animations.equip_id = "equip_raging_bull"
	self.new_raging_bull.animations.recoil_steelsight = true
	
	--[[self.new_raging_bull.challenges = {}
	self.new_raging_bull.challenges.group = "handgun"
	self.new_raging_bull.challenges.weapon = "bronco"]]
	
	-- self.new_raging_bull.alert_size = 5000
	
	self.new_raging_bull.stats = {
		damage = 23,
		spread = 5,
		recoil = 3,
		spread_moving = 7,
		zoom = 3,
		concealment = 9 * 3,
		suppression = 7,
		-- alert_size = 5,
		extra_ammo = 6,
		value = 1,
	}
	
	-- SAW ---------------------------------------
	self.saw = {}
	self.saw.category = "saw"
	self.saw.upgrade_blocks = { weapon = { "clip_ammo_increase" } }
	
	self.saw.damage_melee = damage_melee_default
	self.saw.damage_melee_effect_mul = damage_melee_effect_multiplier_default
	
	self.saw.sounds = {}
	self.saw.sounds.fire = "Play_saw_handheld_start"
	self.saw.sounds.stop_fire = "Play_saw_handheld_end"
	self.saw.sounds.dryfire = "mp5_dryfire"
	
	self.saw.sounds.enter_steelsight = "secondary_steel_sight_enter"
	self.saw.sounds.leave_steelsight = "secondary_steel_sight_exit"
	
	self.saw.timers = {}
	self.saw.timers.reload_not_empty = 3.2 
	self.saw.timers.reload_empty = 3.2 -- 2.9
	self.saw.timers.unequip = 0.7
	self.saw.timers.equip = 0.5

	self.saw.name_id = "bm_w_saw"
	self.saw.desc_id = "bm_w_saw_desc"
	-- self.saw.hud_icon = "guis/textures/weapon_mp5"
	self.saw.hud_icon = "equipment_saw"
	self.saw.description_id = "des_mp5"
	self.saw.hud_ammo = "guis/textures/ammo_9mm"
	
	self.saw.muzzleflash = "effects/payday2/particles/weapons/9mm_auto_fps"
	self.saw.muzzleflash_silenced = "effects/payday2/particles/weapons/9mm_auto_silence_fps"
	
	self.saw.use_data = {}
	self.saw.use_data.selection_index = 2
	
	self.saw.DAMAGE = 1.05 -- 0.25
	
	self.saw.CLIP_AMMO_MAX = 100 -- Will consume 2 ammo every shot, to be able to upgrade to 1 ammo when killing enemies
	self.saw.NR_CLIPS_MAX = 2
	self.saw.AMMO_MAX = self.saw.CLIP_AMMO_MAX * self.saw.NR_CLIPS_MAX
	self.saw.AMMO_PICKUP = { 0,0 }
	
	self.saw.auto = {}					-- Defines the weapons fire mode
	self.saw.auto.fire_rate = 0.15 --0.12
	
	self.saw.spread = {}
	self.saw.spread.standing = 1 -- 3.5
	self.saw.spread.crouching = 0.71 -- 2.5
	self.saw.spread.steelsight = 0.48 -- 1.7
	self.saw.spread.moving_standing = 1.28 -- 4.5
	self.saw.spread.moving_crouching = 1.52 -- 3.8
	self.saw.spread.moving_steelsight = 0.48
	
	-- kick up, down, left, right
	self.saw.kick = {}
	self.saw.kick.standing = { 1, -1, -1, 1 }
	self.saw.kick.crouching = { 1, -1, -1, 01 }
	self.saw.kick.steelsight = { 0.725, -0.725, -0.725, 0.725 }
	
	self.saw.crosshair = {}
	self.saw.crosshair.standing = {}
	self.saw.crosshair.crouching = {}
	self.saw.crosshair.steelsight = {}
	
	self.saw.crosshair.standing.offset = 0.5
	self.saw.crosshair.standing.moving_offset = 0.6
	self.saw.crosshair.standing.kick_offset = 0.7
	
	self.saw.crosshair.crouching.offset = 0.4
	self.saw.crosshair.crouching.moving_offset = 0.5
	self.saw.crosshair.crouching.kick_offset = 0.6
	
	self.saw.crosshair.steelsight.hidden = true
	self.saw.crosshair.steelsight.offset = 0
	self.saw.crosshair.steelsight.moving_offset = 0
	self.saw.crosshair.steelsight.kick_offset = 0
	
	self.saw.shake = {}
	self.saw.shake.fire_multiplier = 1
	self.saw.shake.fire_steelsight_multiplier = 1
	
	self.saw.autohit = autohit_pistol_default
	self.saw.aim_assist = aim_assist_pistol_default
	
	self.saw.weapon_hold = "saw"
	self.saw.animations = {}
	--[[self.saw.animations.fire = "recoil"
	self.saw.animations.reload = "reload"
	self.saw.animations.reload_not_empty = "reload_not_empty"]]
	self.saw.animations.equip_id = "equip_saw"
	self.saw.animations.recoil_steelsight = false
	
	--[[self.saw.challenges = {}
	-- self.saw.challenges.prefix = "sub_machingun"
	self.saw.challenges.group = "sub_machingun"
	self.saw.challenges.weapon = "saw"]]
	
	-- self.saw.alert_size = 2500
	self.saw.stats = {
		-- alert_size = 4,
		suppression = 9,
		zoom = 1,
		spread = 3,
		recoil = 7,
		spread_moving = 7,
		damage = 10,
		concealment = 6 * 3,
		value = 1,
		extra_ammo = 6,
	}
	self.saw.hit_alert_size_increase = 4		-- with alert size being connected to suppression now, this one reduces suppression


end