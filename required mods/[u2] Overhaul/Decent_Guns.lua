if RequiredScript == "lib/units/cameras/fpcameraplayerbase" then
	if FPCameraPlayerBase then
		function FPCameraPlayerBase:recoil_kick( up, down, left, right )
			local function rng()
				local rand = (math.random() + math.random()) / 2
				return (rand * 3) - 1.5
			end
			
			up, down, left, right = rng(), rng(), rng(), rng()
			
			local recoil_scale = 0.4
			if math.abs( self._recoil_kick.accumulated ) < 20 then
				local v = math.lerp( up, down, math.random() * recoil_scale )
				self._recoil_kick.accumulated = (self._recoil_kick.accumulated or 0 ) + v
			end
			
			local h = math.lerp( left, right, math.random() * recoil_scale )
			self._recoil_kick.h.accumulated = (self._recoil_kick.h.accumulated or 0 ) + h
		end
	end
end

if RequiredScript == "lib/units/weapons/newnpcraycastweaponbase" then
	function NewRaycastWeaponBase:_get_spread()
		return 0, 0
	end
end

if RequiredScript == "lib/tweak_data/weapontweakdata" then
	local old = WeaponTweakData._init_new_weapons
	function WeaponTweakData:_init_new_weapons( autohit_rifle_default, autohit_pistol_default, autohit_shotgun_default, damage_melee_default, damage_melee_effect_multiplier_default, aim_assist_rifle_default, aim_assist_pistol_default, aim_assist_shotgun_default )
		old(self, autohit_rifle_default, autohit_pistol_default, autohit_shotgun_default, damage_melee_default, damage_melee_effect_multiplier_default, aim_assist_rifle_default, aim_assist_pistol_default, aim_assist_shotgun_default)

	--specials
		self.sentry_gun.DAMAGE = 1
		
		self.trip_mines.damage = 100

		self.saw.DAMAGE = 1
		self.saw.CLIP_AMMO_MAX = 200
		self.saw.AMMO_MAX = 200

	--[[

	]]

	--primaries
		--315 , 588
		self.amcar.DAMAGE = 3.5
		self.amcar.CLIP_AMMO_MAX = 24
		self.amcar.AMMO_MAX = 168
		self.amcar.single = {
			fire_rate = 0.12
		}
		self.amcar.auto = nil

		--.354 , 560
		self.ak74.DAMAGE = 4
		self.ak74.CLIP_AMMO_MAX = 28
		self.ak74.AMMO_MAX = 140
		self.ak74.auto.fire_rate = 0.18

		--276 , 630
		self.new_m4.DAMAGE = 3
		self.new_m4.CLIP_AMMO_MAX = 30
		self.new_m4.AMMO_MAX = 210
		self.new_m4.auto.fire_rate =  0.1
		
		--.315, 588
		self.aug.DAMAGE = 3.5
		self.aug.CLIP_AMMO_MAX = 28
		self.aug.AMMO_MAX = 168
		self.aug.auto.fire_rate = 0.14
		
		-- pump, 1440
		self.r870.DAMAGE = 4
		self.r870.CLIP_AMMO_MAX = 6
		self.r870.AMMO_MAX = 30
		self.r870.single.fire_rate = 0.5
		self.r870.rays = 12
		
		--.315 , 595
		self.g36.DAMAGE = 3.5
		self.g36.CLIP_AMMO_MAX = 34
		self.g36.AMMO_MAX = 170
		self.g36.auto.fire_rate = 0.15
		
		--.354 , 600
		self.akm.DAMAGE = 4
		self.akm.CLIP_AMMO_MAX = 25
		self.akm.AMMO_MAX = 150
		self.akm.auto.fire_rate = 0.1
		
		--.511 , 600
		self.new_m14.DAMAGE = 10
		self.new_m14.CLIP_AMMO_MAX = 12
		self.new_m14.AMMO_MAX = 60
		self.new_m14.single.fire_rate = 0.3
		
		-- mag, 1400
		self.saiga.DAMAGE = 4
		self.saiga.CLIP_AMMO_MAX = 7
		self.saiga.AMMO_MAX = 35
		self.saiga.auto.fire_rate = 0.25
		self.saiga.rays = 10

		--.394 , 576
		self.ak5.DAMAGE = 4.5
		self.ak5.CLIP_AMMO_MAX = 32
		self.ak5.AMMO_MAX = 128
		self.ak5.auto.fire_rate = 0.18
		
		--.433 , 576
		self.m16.DAMAGE = 6
		self.m16.CLIP_AMMO_MAX = 16
		self.m16.AMMO_MAX = 96
		self.m16.single = {
			fire_rate = 0.1
		}
		self.m16.auto = nil
		
		-- double, 1320
		self.huntsman.DAMAGE = 5
		self.huntsman.CLIP_AMMO_MAX = 2
		self.huntsman.AMMO_MAX = 22
		self.huntsman.single.fire_rate = 0.33
		self.huntsman.rays = 12

	--[[
		Calibre x Damage chart
		.197 = 2
		.236 = 2.5
		.276 = 3
		.315 = 3.5
		.354 = 4
		.394 = 4.5
		.433 = 6
		.472 = 8
		.511 = 10
	]]

	--secondaries x13
		-- .236 , 270
		self.glock_17.DAMAGE = 2.5
		self.glock_17.CLIP_AMMO_MAX = 18
		self.glock_17.AMMO_MAX = 108
		self.glock_17.single.fire_rate = 0.1

		-- .315 , 294
		self.colt_1911.DAMAGE = 3.5
		self.colt_1911.CLIP_AMMO_MAX = 12
		self.colt_1911.AMMO_MAX = 84
		self.colt_1911.single.fire_rate = 0.2

		-- .354 , 288
		self.mac10.DAMAGE = 4
		self.mac10.CLIP_AMMO_MAX = 28
		self.mac10.AMMO_MAX = 84
		self.mac10.auto.fire_rate = 0.05

		-- .472 , 288
		self.new_raging_bull.DAMAGE = 8
		self.new_raging_bull.CLIP_AMMO_MAX = 6
		self.new_raging_bull.AMMO_MAX = 36
		self.new_raging_bull.single.fire_rate = 0.4

		-- .276 , 252
		self.b92fs.DAMAGE = 3
		self.b92fs.CLIP_AMMO_MAX = 12
		self.b92fs.AMMO_MAX = 84
		self.b92fs.single.fire_rate = 0.2

		-- pump , 960
		self.serbu.DAMAGE = 4
		self.serbu.CLIP_AMMO_MAX = 6
		self.serbu.AMMO_MAX = 24
		self.serbu.single.fire_rate = 0.5
		self.serbu.rays = 10

		-- .276 , 312
		self.new_mp5.DAMAGE = 3
		self.new_mp5.CLIP_AMMO_MAX = 26
		self.new_mp5.AMMO_MAX = 104
		self.new_mp5.auto.fire_rate = 0.15
		
		-- .315 , 308
		self.olympic.DAMAGE = 3.5
		self.olympic.CLIP_AMMO_MAX = 22
		self.olympic.AMMO_MAX = 88
		self.olympic.auto.fire_rate = 0.2

		-- .276 , 330
		self.mp9.DAMAGE = 3
		self.mp9.CLIP_AMMO_MAX = 22
		self.mp9.AMMO_MAX = 110
		self.mp9.auto.fire_rate = 0.1

		-- .315 , 315
		self.akmsu.DAMAGE = 3.5
		self.akmsu.CLIP_AMMO_MAX = 30
		self.akmsu.AMMO_MAX = 90
		self.akmsu.auto.fire_rate = 0.14

		-- .236 , 325
		self.glock_18c.DAMAGE = 2.5
		self.glock_18c.CLIP_AMMO_MAX = 26
		self.glock_18c.AMMO_MAX = 130
		self.glock_18c.auto.fire_rate = 0.08
		
		-- .197 , 336
		self.p90.DAMAGE = 2
		self.p90.CLIP_AMMO_MAX = 56
		self.p90.AMMO_MAX = 168
		self.p90.auto.fire_rate = 0.05

		-- .511 , 280
		self.deagle.DAMAGE = 10
		self.deagle.CLIP_AMMO_MAX = 7
		self.deagle.AMMO_MAX = 28
		self.deagle.single.fire_rate = 0.33
	end
end

if RequiredScript == "lib/tweak_data/weaponfactorytweakdata" then
	function WeaponFactoryTweakData:_init_silencers()
		self.parts.wpn_fps_upg_ns_ass_smg_large = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel_ext",
			name_id = "bm_wp_upg_ns_ass_smg_large",
			a_obj = "a_ns",
			parent = "barrel",
			unit = "units/payday2/weapons/wpn_fps_upg_ns_ass_smg_large/wpn_fps_upg_ns_ass_smg_large",
			stats = {
				value = 5,
				suppression = 15,
				damage = 0,
				recoil = 2,
				spread_moving = -2,
				concealment = -1
			},
			perks = {"silencer"},
			sound_switch = {
				suppressed = "suppressed_c"
			}
		}
		self.parts.wpn_fps_upg_ns_ass_smg_medium = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel_ext",
			name_id = "bm_wp_upg_ns_ass_smg_medium",
			a_obj = "a_ns",
			parent = "barrel",
			unit = "units/payday2/weapons/wpn_fps_upg_ns_ass_smg_medium/wpn_fps_upg_ns_ass_smg_medium",
			stats = {
				value = 2,
				suppression = 15,
				damage = 0,
				recoil = 2,
				spread_moving = -2,
				concealment = -1
			},
			perks = {"silencer"},
			sound_switch = {
				suppressed = "suppressed_b"
			}
		}
		self.parts.wpn_fps_upg_ns_ass_smg_small = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel_ext",
			name_id = "bm_wp_upg_ns_ass_smg_small",
			a_obj = "a_ns",
			parent = "barrel",
			unit = "units/payday2/weapons/wpn_fps_upg_ns_ass_smg_small/wpn_fps_upg_ns_ass_smg_small",
			stats = {
				value = 3,
				suppression = 15,
				damage = 0,
				recoil = 2,
				spread_moving = -2,
				concealment = -1
			},
			perks = {"silencer"},
			sound_switch = {
				suppressed = "suppressed_a"
			}
		}
		self.parts.wpn_fps_upg_ns_pis_large = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel_ext",
			name_id = "bm_wp_upg_ns_pis_large",
			a_obj = "a_ns",
			parent = "slide",
			unit = "units/payday2/weapons/wpn_fps_upg_ns_pis_large/wpn_fps_upg_ns_pis_large",
			stats = {
				value = 5,
				suppression = 15,
				damage = 0,
				recoil = 2,
				spread_moving = -2,
				concealment = -1
			},
			perks = {"silencer"},
			sound_switch = {
				suppressed = "suppressed_c"
			}
		}
		self.parts.wpn_fps_upg_ns_pis_medium = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel_ext",
			name_id = "bm_wp_upg_ns_pis_medium",
			a_obj = "a_ns",
			parent = "slide",
			unit = "units/payday2/weapons/wpn_fps_upg_ns_pis_medium/wpn_fps_upg_ns_pis_medium",
			stats = {
				value = 1,
				suppression = 15,
				damage = 0,
				recoil = 2,
				spread_moving = -2,
				concealment = -1
			},
			perks = {"silencer"},
			sound_switch = {
				suppressed = "suppressed_b"
			}
		}
		self.parts.wpn_fps_upg_ns_pis_small = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel_ext",
			name_id = "bm_wp_upg_ns_pis_small",
			a_obj = "a_ns",
			parent = "slide",
			unit = "units/payday2/weapons/wpn_fps_upg_ns_pis_small/wpn_fps_upg_ns_pis_small",
			stats = {
				value = 3,
				suppression = 15,
				damage = 0,
				recoil = 2,
				spread_moving = -2,
				concealment = -1
			},
			perks = {"silencer"},
			sound_switch = {
				suppressed = "suppressed_a"
			}
		}
		self.parts.wpn_fps_upg_ns_shot_thick = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel_ext",
			name_id = "bm_wp_upg_ns_shot_thick",
			a_obj = "a_ns",
			parent = "barrel",
			unit = "units/payday2/weapons/wpn_fps_upg_ns_shot_thick/wpn_fps_upg_ns_shot_thick",
			stats = {
				value = 7,
				suppression = 15,
				damage = 0,
				recoil = 2,
				spread_moving = -2,
				concealment = -1
			},
			perks = {"silencer"},
			sound_switch = {
				suppressed = "suppressed_a"
			}
		}
		self.parts.wpn_fps_upg_ns_ass_smg_large.third_unit = "units/payday2/weapons/wpn_third_upg_ns_ass_smg_large/wpn_third_upg_ns_ass_smg_large"
		self.parts.wpn_fps_upg_ns_ass_smg_medium.third_unit = "units/payday2/weapons/wpn_third_upg_ns_ass_smg_medium/wpn_third_upg_ns_ass_smg_medium"
		self.parts.wpn_fps_upg_ns_ass_smg_small.third_unit = "units/payday2/weapons/wpn_third_upg_ns_ass_smg_small/wpn_third_upg_ns_ass_smg_small"
		self.parts.wpn_fps_upg_ns_pis_large.third_unit = "units/payday2/weapons/wpn_third_upg_ns_pis_large/wpn_third_upg_ns_pis_large"
		self.parts.wpn_fps_upg_ns_pis_medium.third_unit = "units/payday2/weapons/wpn_third_upg_ns_pis_medium/wpn_third_upg_ns_pis_medium"
		self.parts.wpn_fps_upg_ns_pis_small.third_unit = "units/payday2/weapons/wpn_third_upg_ns_pis_small/wpn_third_upg_ns_pis_small"
		self.parts.wpn_fps_upg_ns_shot_thick.third_unit = "units/payday2/weapons/wpn_third_upg_ns_shot_thick/wpn_third_upg_ns_shot_thick"
	end

	function WeaponFactoryTweakData:_init_gadgets()
		self.parts.wpn_fps_addon_ris = {
			type = "extra",
			name_id = "bm_wp_upg_fl_pis_tlr1",
			a_obj = "a_fl",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_addon_ris",
			stats = {value = 1}
		}
		self.parts.wpn_fps_addon_ris.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_addon_ris"
		self.parts.wpn_fps_upg_fl_ass_smg_sho_surefire = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "gadget",
			name_id = "bm_wp_upg_fl_ass_smg_sho_surefire",
			a_obj = "a_fl",
			unit = "units/payday2/weapons/wpn_fps_upg_fl_ass_smg_sho_surefire/wpn_fps_upg_fl_ass_smg_sho_surefire",
			stats = {
				value = 3
			},
			adds = {
				"wpn_fps_addon_ris"
			}
		}
		self.parts.wpn_fps_upg_fl_ass_smg_sho_peqbox = {
			pcs = {
				20,
				30,
				40
			},
			type = "gadget",
			name_id = "bm_wp_upg_fl_ass_smg_sho_peqbox",
			a_obj = "a_fl",
			unit = "units/payday2/weapons/wpn_fps_upg_fl_ass_smg_sho_peqbox/wpn_fps_upg_fl_ass_smg_sho_peqbox",
			stats = {
				value = 5
			},
			adds = {
				"wpn_fps_addon_ris"
			}
		}
		self.parts.wpn_fps_upg_fl_pis_laser = {
			pcs = {
				20,
				30,
				40
			},
			type = "gadget",
			name_id = "bm_wp_upg_fl_pis_laser",
			a_obj = "a_fl",
			unit = "units/payday2/weapons/wpn_fps_upg_fl_pis_laser/wpn_fps_upg_fl_pis_laser",
			stats = {
				value = 5
			}
		}
		self.parts.wpn_fps_upg_fl_pis_tlr1 = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "gadget",
			name_id = "bm_wp_upg_fl_pis_tlr1",
			a_obj = "a_fl",
			unit = "units/payday2/weapons/wpn_fps_upg_fl_pis_tlr1/wpn_fps_upg_fl_pis_tlr1",
			stats = {
				value = 2
			}
		}
		self.parts.wpn_fps_upg_fl_ass_smg_sho_surefire.third_unit = "units/payday2/weapons/wpn_third_upg_fl_ass_smg_sho_surefire/wpn_third_upg_fl_ass_smg_sho_surefire"
		self.parts.wpn_fps_upg_fl_ass_smg_sho_peqbox.third_unit = "units/payday2/weapons/wpn_third_upg_fl_ass_smg_sho_peqbox/wpn_third_upg_fl_ass_smg_sho_peqbox"
		self.parts.wpn_fps_upg_fl_pis_laser.third_unit = "units/payday2/weapons/wpn_third_upg_fl_pis_laser/wpn_third_upg_fl_pis_laser"
		self.parts.wpn_fps_upg_fl_pis_tlr1.third_unit = "units/payday2/weapons/wpn_third_upg_fl_pis_tlr1/wpn_third_upg_fl_pis_tlr1"
	end

	function WeaponFactoryTweakData:_init_sights()
		self.parts.wpn_fps_upg_o_specter = {
			pcs = {30, 40},
			type = "sight",
			name_id = "bm_wp_upg_o_specter",
			a_obj = "a_o",
			unit = "units/payday2/weapons/wpn_fps_upg_o_specter/wpn_fps_upg_o_specter",
			stats = {
				value = 8,
				zoom = 4,
				recoil = 2,
				spread_moving = -1
			},
			perks = {"scope"},
			stance_mod = {
				wpn_fps_ass_m4 = {
					translation = Vector3(0, 0, -0.45)
				},
				wpn_fps_ass_m16 = {
					translation = Vector3(0, 0, -0.01)
				},
				wpn_fps_smg_olympic = {
					translation = Vector3(0, 0, -0.01)
				},
				wpn_fps_ass_74 = {
					translation = Vector3(0, 0, -3)
				},
				wpn_fps_ass_akm = {
					translation = Vector3(0, 0, -3)
				},
				wpn_fps_shot_saiga = {
					translation = Vector3(0, 0, -3)
				},
				wpn_fps_shot_r870 = {
					translation = Vector3(0, 0, -3)
				},
				wpn_fps_shot_serbu = {
					translation = Vector3(0, 0, -3)
				},
				wpn_fps_smg_akmsu = {
					translation = Vector3(0, 0, -2.7)
				},
				wpn_fps_ass_ak5 = {
					translation = Vector3(0, 0, -3.5)
				},
				wpn_fps_ass_aug = {
					translation = Vector3(0, 0, -2.8)
				},
				wpn_fps_ass_g36 = {
					translation = Vector3(0, 0, -3)
				},
				wpn_fps_smg_p90 = {
					translation = Vector3(0, 0, -2.97)
				},
				wpn_fps_ass_m14 = {
					translation = Vector3(0, 0, -3.8)
				},
				wpn_fps_smg_mp9 = {
					translation = Vector3(0, 0, -3.4)
				},
				wpn_fps_smg_mp5 = {
					translation = Vector3(0, 0, -3)
				},
				wpn_fps_smg_mac10 = {
					translation = Vector3(0, 0, -4.5)
				}
			},
			--[[forbids = {
				"wpn_fps_amcar_uupg_body_upperreciever",
				"wpn_fps_ass_m16_os_frontsight"
			}]]
		}
		self.parts.wpn_fps_upg_o_aimpoint = {
			pcs = {30, 40},
			type = "sight",
			name_id = "bm_wp_upg_o_aimpoint",
			a_obj = "a_o",
			unit = "units/payday2/weapons/wpn_fps_upg_o_aimpoint/wpn_fps_upg_o_aimpoint",
			stats = {
				value = 8,
				zoom = 4,
				recoil = 2,
				spread_moving = -1
			},
			perks = {"scope"},
			stance_mod = deep_clone(self.parts.wpn_fps_upg_o_specter.stance_mod),
			--[[forbids = {
				"wpn_fps_amcar_uupg_body_upperreciever",
				"wpn_fps_ass_m16_os_frontsight"
			}]]
		}
		self.parts.wpn_fps_upg_o_aimpoint_2 = {
			pcs = {
				10,
				20,
				30,
				40
			},
			dlc = "preorder",
			type = "sight",
			name_id = "bm_wp_upg_o_aimpoint",
			a_obj = "a_o",
			unit = "units/payday2/weapons/wpn_fps_upg_o_aimpoint/wpn_fps_upg_o_aimpoint_preorder",
			stats = {
				value = 1,
				zoom = 4,
				recoil = 2,
				spread_moving = -1
			},
			perks = {"scope"},
			stance_mod = deep_clone(self.parts.wpn_fps_upg_o_specter.stance_mod),
			--[[forbids = {
				"wpn_fps_amcar_uupg_body_upperreciever",
				"wpn_fps_ass_m16_os_frontsight"
			}]]
		}
		self.parts.wpn_fps_upg_o_docter = {
			pcs = {
				20,
				30,
				40
			},
			type = "sight",
			name_id = "bm_wp_upg_o_docter",
			a_obj = "a_o",
			unit = "units/payday2/weapons/wpn_fps_upg_o_docter/wpn_fps_upg_o_docter",
			stats = {
				value = 5,
				zoom = 2,
				recoil = 2,
				spread_moving = -1
			},
			perks = {"scope"},
			stance_mod = deep_clone(self.parts.wpn_fps_upg_o_specter.stance_mod),
			--[[forbids = {
				"wpn_fps_amcar_uupg_body_upperreciever",
				"wpn_fps_ass_m16_os_frontsight"
			}]]
		}
		self.parts.wpn_fps_upg_o_eotech = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "sight",
			name_id = "bm_wp_upg_o_eotech",
			a_obj = "a_o",
			unit = "units/payday2/weapons/wpn_fps_upg_o_eotech/wpn_fps_upg_o_eotech",
			stats = {
				value = 3,
				zoom = 3,
				recoil = 2,
				spread_moving = -1
			},
			perks = {"scope"},
			stance_mod = deep_clone(self.parts.wpn_fps_upg_o_specter.stance_mod),
			--[[forbids = {
				"wpn_fps_amcar_uupg_body_upperreciever",
				"wpn_fps_ass_m16_os_frontsight"
			}]]
		}
		self.parts.wpn_fps_upg_o_t1micro = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "sight",
			name_id = "bm_wp_upg_o_t1micro",
			a_obj = "a_o",
			unit = "units/payday2/weapons/wpn_fps_upg_o_t1micro/wpn_fps_upg_o_t1micro",
			stats = {
				value = 3,
				zoom = 3,
				recoil = 2,
				spread_moving = -1
			},
			perks = {"scope"},
			stance_mod = deep_clone(self.parts.wpn_fps_upg_o_specter.stance_mod),
			--[[forbids = {
				"wpn_fps_amcar_uupg_body_upperreciever",
				"wpn_fps_ass_m16_os_frontsight"
			}]]
		}
		self.parts.wpn_upg_o_marksmansight_rear = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "sight",
			name_id = "bm_wp_upg_o_marksmansight_rear",
			a_obj = "a_o",
			unit = "units/payday2/weapons/wpn_fps_upg_o_marksmansight/wpn_upg_o_marksmansight_rear",
			stats = {
				value = 3,
				zoom = 1,
				recoil = 2,
				spread_moving = -1
			},
			perks = {"scope"},
			adds = {
				"wpn_upg_o_marksmansight_front"
			},
			stance_mod = {
				wpn_fps_smg_mac10 = {
					translation = Vector3(0, 0, -1)
				}
			}
		}
		self.parts.wpn_upg_o_marksmansight_front = {
			type = "extra",
			name_id = "bm_wp_upg_o_marksmansight_front",
			a_obj = "a_o",
			unit = "units/payday2/weapons/wpn_fps_upg_o_marksmansight/wpn_upg_o_marksmansight_front"
		}
		self.parts.wpn_fps_upg_o_specter.third_unit = "units/payday2/weapons/wpn_third_upg_o_specter/wpn_third_upg_o_specter"
		self.parts.wpn_fps_upg_o_docter.third_unit = "units/payday2/weapons/wpn_third_upg_o_docter/wpn_third_upg_o_docter"
		self.parts.wpn_fps_upg_o_aimpoint.third_unit = "units/payday2/weapons/wpn_third_upg_o_aimpoint/wpn_third_upg_o_aimpoint"
		self.parts.wpn_fps_upg_o_aimpoint_2.third_unit = "units/payday2/weapons/wpn_third_upg_o_aimpoint/wpn_third_upg_o_aimpoint_preorder"
		self.parts.wpn_fps_upg_o_eotech.third_unit = "units/payday2/weapons/wpn_third_upg_o_eotech/wpn_third_upg_o_eotech"
		self.parts.wpn_fps_upg_o_t1micro.third_unit = "units/payday2/weapons/wpn_third_upg_o_t1micro/wpn_third_upg_o_t1micro"
		self.parts.wpn_upg_o_marksmansight_rear.third_unit = "units/payday2/weapons/wpn_third_upg_o_marksmansight/wpn_third_upg_o_marksmansight_rear"
		self.parts.wpn_upg_o_marksmansight_front.third_unit = "units/payday2/weapons/wpn_third_upg_o_marksmansight/wpn_third_upg_o_marksmansight_front"
		self.parts.wpn_upg_o_marksmansight_rear_vanilla = deep_clone(self.parts.wpn_upg_o_marksmansight_rear)
		self.parts.wpn_upg_o_marksmansight_rear_vanilla.stats = nil
		self.parts.wpn_upg_o_marksmansight_rear_vanilla.pcs = nil
		self.parts.wpn_upg_o_marksmansight_rear_vanilla.perks = nil
		self.parts.wpn_upg_o_marksmansight_front_vanilla = deep_clone(self.parts.wpn_upg_o_marksmansight_front)
		self.parts.wpn_upg_o_marksmansight_front_vanilla.stats = nil
		self.parts.wpn_upg_o_marksmansight_front_vanilla.pc = nil
		self.parts.wpn_upg_o_marksmansight_front_vanilla.perks = nil
	end

	function WeaponFactoryTweakData:_init_m4()
		self.parts.wpn_fps_m4_lower_reciever = {
			type = "lower_reciever",
			name_id = "bm_wp_m4_lower_reciever",
			a_obj = "a_body",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_lower_reciever",
			stats = {value = 1}
		}
		self.parts.wpn_fps_m4_upper_reciever_edge = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "upper_reciever",
			name_id = "bm_wp_m4_upper_reciever_edge",
			a_obj = "a_body",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_upper_reciever_edge",
			stats = {value = 3, recoil = 1},
			animations = {reload = "reload"}
		}
		self.parts.wpn_fps_m4_upper_reciever_round = {
			type = "upper_reciever",
			name_id = "bm_wp_m4_upper_reciever_round",
			a_obj = "a_body",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_upper_reciever_round",
			stats = {value = 1},
			animations = {reload = "reload"}
		}
		self.parts.wpn_fps_m4_uupg_b_long = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel",
			name_id = "bm_wp_m4_uupg_b_long",
			a_obj = "a_b",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_b_long",
			stats = {
				value = 4,
				damage = 1,
				spread = 1,
				spread_moving = -2,
				concealment = -2
			}
		}
		self.parts.wpn_fps_m4_uupg_b_short = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel",
			name_id = "bm_wp_m4_uupg_b_short",
			a_obj = "a_b",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_b_short",
			stats = {
				value = 5,
				spread = -1,
				spread_moving = 2,
				concealment = 2
			}
		}
		self.parts.wpn_fps_m4_uupg_b_medium = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel",
			name_id = "bm_wp_m4_uupg_b_medium",
			a_obj = "a_b",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_b_medium",
			stats = {
				value = 1,
				spread = 1,
				concealment = -1
			}
		}
		self.parts.wpn_fps_m4_uupg_b_sd = {
			pcs = {
				20,
				30,
				40
			},
			type = "barrel",
			name_id = "bm_wp_m4_uupg_b_sd",
			a_obj = "a_b",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_b_sd",
			stats = {
				value = 6,
				suppression = 15,
				spread = -1,
				damage = -2,
				recoil = 1,
				spread_moving = 1,
				concealment = -1
			},
			perks = {"silencer"},
			sound_switch = {
				suppressed = "suppressed_c"
			},
			forbids = {
				"wpn_fps_m4_uupg_fg_rail_ext",
				"wpn_fps_upg_ns_ass_smg_large",
				"wpn_fps_upg_ns_ass_smg_medium",
				"wpn_fps_upg_ns_ass_smg_small",
				"wpn_fps_upg_ns_ass_smg_firepig",
				"wpn_fps_upg_ns_ass_smg_stubby",
				"wpn_fps_upg_ns_ass_smg_tank"
			}
		}
		self.parts.wpn_fps_m4_uupg_fg_lr300 = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "foregrip",
			name_id = "bm_wp_m4_uupg_fg_lr300",
			a_obj = "a_fg",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_fg_lr300",
			stats = {
				value = 5,
				spread_moving = 1,
				concealment = 1,
				recoil = 1
			}
		}
		self.parts.wpn_fps_m4_uupg_fg_rail = {
			type = "foregrip",
			name_id = "bm_wp_m4_uupg_fg_rail",
			a_obj = "a_fg",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_fg_rail",
			stats = {value = 1, concealment = -1},
			adds = {
				"wpn_fps_m4_uupg_fg_rail_ext"
			},
			forbids = {
				"wpn_fps_addon_ris"
			}
		}
		self.parts.wpn_fps_m4_uupg_m_std = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "magazine",
			name_id = "bm_wp_m4_uupg_m_std",
			a_obj = "a_m",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_m_std",
			stats = {value = 1, extra_ammo = 4}
		}
		self.parts.wpn_fps_m4_uupg_s_fold = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "stock",
			name_id = "bm_wp_m4_uupg_s_fold",
			a_obj = "a_s",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_s_fold",
			stats = {
				value = 5,
				recoil = -1,
				concealment = 2,
				spread_moving = 2
			}
		}
		self.parts.wpn_fps_m4_uupg_o_flipup = {
			type = "sight",
			name_id = "bm_wp_m4_uupg_o_flipup",
			a_obj = "a_o",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_o_flipup",
			stats = {value = 1}
		}
		self.parts.wpn_fps_m4_uupg_draghandle = {
			type = "drag_handle",
			name_id = "bm_wp_m4_uupg_draghandle",
			a_obj = "a_dh",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_draghandle",
			stats = {value = 1}
		}
		self.parts.wpn_fps_m4_uupg_fg_rail_ext = {
			type = "foregrip_ext",
			name_id = "bm_wp_m4_uupg_fg_rail_ext",
			a_obj = "a_fg",
			unit = "units/payday2/weapons/wpn_fps_ass_m4_pts/wpn_fps_m4_uupg_fg_rail_ext",
			stats = {value = 1}
		}
		self.parts.wpn_fps_upg_m4_g_standard = {
			type = "grip",
			name_id = "bm_wp_m4_g_standard",
			a_obj = "a_g",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_upg_m4_g_standard",
			stats = {value = 1}
		}
		self.parts.wpn_fps_upg_m4_g_ergo = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "grip",
			name_id = "bm_wp_m4_g_ergo",
			a_obj = "a_g",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_upg_m4_g_ergo",
			stats = {
				value = 2,
				spread_moving = 2,
				recoil = 1
			}
		}
		self.parts.wpn_fps_upg_m4_g_sniper = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "grip",
			name_id = "bm_wp_m4_g_sniper",
			a_obj = "a_g",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_upg_m4_g_sniper",
			stats = {
				value = 2,
				spread = 1,
				recoil = -2,
				spread_moving = -2
			}
		}
		self.parts.wpn_fps_upg_m4_m_drum = {
			type = "magazine",
			name_id = "bm_wp_m4_m_drum",
			a_obj = "a_m",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_upg_m4_m_drum",
			stats = {value = 9, extra_ammo = 20}
		}
		self.parts.wpn_fps_upg_m4_m_pmag = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "magazine",
			name_id = "bm_wp_m4_m_pmag",
			a_obj = "a_m",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_upg_m4_m_pmag",
			stats = {
				value = 3,
				spread_moving = 1,
				concealment = 0,
				extra_ammo = 2
			}
		}
		self.parts.wpn_fps_upg_m4_m_straight = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "magazine",
			name_id = "bm_wp_m4_m_straight",
			a_obj = "a_m",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_upg_m4_m_straight",
			stats = {
				value = 2,
				spread_moving = 2,
				concealment = 2,
				extra_ammo = -4
			}
		}
		self.parts.wpn_fps_upg_m4_s_standard = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "stock",
			name_id = "bm_wp_m4_s_standard",
			a_obj = "a_s",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_upg_m4_s_standard",
			stats = {
				value = 1,
				recoil = 1,
				spread_moving = -1
			},
			adds_type = {
				"stock_adapter"
			},
			forbids = {
				"wpn_fps_shot_r870_ris_special"
			}
		}
		self.parts.wpn_fps_upg_m4_s_pts = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "stock",
			name_id = "bm_wp_m4_s_pts",
			a_obj = "a_s",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_upg_m4_s_pts",
			stats = {
				value = 3,
				spread = 0,
				spread_moving = -1,
				recoil = 2,
				concealment = -1
			},
			adds_type = {
				"stock_adapter"
			},
			forbids = {
				"wpn_fps_shot_r870_ris_special"
			}
		}
		self.parts.wpn_fps_upg_m4_s_adapter = {
			type = "stock_adapter",
			name_id = "bm_wp_m4_s_adapter",
			a_obj = "a_s",
			unit = "units/payday2/weapons/wpn_fps_upg_m4_reusable/wpn_fps_upg_m4_s_adapter",
			stats = {value = 1}
		}
		self.parts.wpn_fps_m4_lower_reciever.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_lower_reciever"
		self.parts.wpn_fps_m4_upper_reciever_edge.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_upper_reciever_edge"
		self.parts.wpn_fps_m4_upper_reciever_round.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_upper_reciever_round"
		self.parts.wpn_fps_m4_uupg_b_long.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_b_long"
		self.parts.wpn_fps_m4_uupg_b_short.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_b_short"
		self.parts.wpn_fps_m4_uupg_b_medium.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_b_medium"
		self.parts.wpn_fps_m4_uupg_b_sd.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_b_sd"
		self.parts.wpn_fps_m4_uupg_draghandle.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_draghandle"
		self.parts.wpn_fps_m4_uupg_fg_lr300.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_fg_lr300"
		self.parts.wpn_fps_m4_uupg_fg_rail.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_fg_rail"
		self.parts.wpn_fps_m4_uupg_fg_rail_ext.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_fg_rail_ext"
		self.parts.wpn_fps_m4_uupg_m_std.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_m_std"
		self.parts.wpn_fps_m4_uupg_o_flipup.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_o_flipup"
		self.parts.wpn_fps_m4_uupg_s_fold.third_unit = "units/payday2/weapons/wpn_third_ass_m4_pts/wpn_third_m4_uupg_s_fold"
		self.parts.wpn_fps_upg_m4_g_ergo.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_upg_m4_g_ergo"
		self.parts.wpn_fps_upg_m4_g_sniper.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_upg_m4_g_sniper"
		self.parts.wpn_fps_upg_m4_g_standard.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_upg_m4_g_standard"
		self.parts.wpn_fps_upg_m4_m_drum.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_upg_m4_m_drum"
		self.parts.wpn_fps_upg_m4_m_pmag.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_upg_m4_m_pmag"
		self.parts.wpn_fps_upg_m4_m_straight.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_upg_m4_m_straight"
		self.parts.wpn_fps_upg_m4_s_adapter.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_upg_m4_s_adapter"
		self.parts.wpn_fps_upg_m4_s_pts.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_upg_m4_s_pts"
		self.parts.wpn_fps_upg_m4_s_standard.third_unit = "units/payday2/weapons/wpn_third_upg_m4_reusable/wpn_third_upg_m4_s_standard"
		self.parts.wpn_fps_m4_upper_reciever_round_vanilla = deep_clone(self.parts.wpn_fps_m4_upper_reciever_round)
		self.parts.wpn_fps_m4_upper_reciever_round_vanilla.stats = nil
		self.parts.wpn_fps_m4_upper_reciever_round_vanilla.pcs = nil
		self.parts.wpn_fps_m4_uupg_draghandle_vanilla = deep_clone(self.parts.wpn_fps_m4_uupg_draghandle)
		self.parts.wpn_fps_m4_uupg_draghandle_vanilla.stats = nil
		self.parts.wpn_fps_m4_uupg_draghandle_vanilla.pcs = nil
		self.parts.wpn_fps_m4_uupg_m_std_vanilla = deep_clone(self.parts.wpn_fps_m4_uupg_m_std)
		self.parts.wpn_fps_m4_uupg_m_std_vanilla.stats = nil
		self.parts.wpn_fps_m4_uupg_m_std_vanilla.pcs = nil
		self.parts.wpn_fps_upg_m4_m_straight_vanilla = deep_clone(self.parts.wpn_fps_upg_m4_m_straight)
		self.parts.wpn_fps_upg_m4_m_straight_vanilla.stats = nil
		self.parts.wpn_fps_upg_m4_m_straight_vanilla.pcs = nil
		self.parts.wpn_fps_upg_m4_s_standard_vanilla = deep_clone(self.parts.wpn_fps_upg_m4_s_standard)
		self.parts.wpn_fps_upg_m4_s_standard_vanilla.stats = nil
		self.parts.wpn_fps_upg_m4_s_standard_vanilla.pcs = nil
		self.parts.wpn_fps_upg_m4_g_standard_vanilla = deep_clone(self.parts.wpn_fps_upg_m4_g_standard)
		self.parts.wpn_fps_upg_m4_g_standard_vanilla.stats = nil
		self.parts.wpn_fps_upg_m4_g_standard_vanilla.pc = nil
		self.parts.wpn_fps_m4_uupg_b_medium_vanilla = deep_clone(self.parts.wpn_fps_m4_uupg_b_medium)
		self.parts.wpn_fps_m4_uupg_b_medium_vanilla.stats = nil
		self.parts.wpn_fps_m4_uupg_b_medium_vanilla.pcs = nil
		self.parts.wpn_fps_m4_uupg_b_short_vanilla = deep_clone(self.parts.wpn_fps_m4_uupg_b_short)
		self.parts.wpn_fps_m4_uupg_b_short_vanilla.stats = nil
		self.parts.wpn_fps_m4_uupg_b_short_vanilla.pcs = nil
		self.wpn_fps_ass_m4 = {}
		self.wpn_fps_ass_m4.optional_types = {
			"barrel_ext",
			"gadget",
			"vertical_grip"
		}
		self.wpn_fps_ass_m4.unit = "units/payday2/weapons/wpn_fps_ass_m4/wpn_fps_ass_m4"
		self.wpn_fps_ass_m4.stock_adapter = "wpn_fps_upg_m4_s_adapter"
		self.wpn_fps_ass_m4.default_blueprint = {
			"wpn_fps_upg_m4_g_standard_vanilla",
			"wpn_fps_m4_lower_reciever",
			"wpn_fps_m4_upper_reciever_round",
			"wpn_fps_m4_uupg_b_medium_vanilla",
			"wpn_fps_m4_uupg_fg_rail",
			"wpn_fps_m4_uupg_m_std_vanilla",
			"wpn_fps_upg_m4_s_standard_vanilla",
			"wpn_fps_m4_uupg_draghandle",
			"wpn_fps_m4_uupg_o_flipup"
		}
		self.wpn_fps_ass_m4.uses_parts = {
			"wpn_fps_m4_lower_reciever",
			"wpn_fps_m4_upper_reciever_edge",
			"wpn_fps_m4_upper_reciever_round",
			"wpn_fps_m4_uupg_b_long",
			"wpn_fps_m4_uupg_b_medium_vanilla",
			"wpn_fps_m4_uupg_b_short",
			"wpn_fps_m4_uupg_b_sd",
			"wpn_fps_upg_ns_ass_smg_large",
			"wpn_fps_upg_ns_ass_smg_medium",
			"wpn_fps_upg_ns_ass_smg_small",
			"wpn_fps_m4_uupg_fg_rail",
			"wpn_fps_m4_uupg_fg_lr300",
			"wpn_fps_m4_uupg_m_std_vanilla",
			"wpn_fps_upg_m4_m_drum",
			"wpn_fps_upg_m4_m_pmag",
			"wpn_fps_upg_m4_m_straight",
			"wpn_fps_m4_uupg_s_fold",
			"wpn_fps_upg_m4_s_standard_vanilla",
			"wpn_fps_upg_m4_s_pts",
			"wpn_fps_m4_uupg_draghandle",
			"wpn_fps_m4_uupg_o_flipup",
			"wpn_fps_upg_o_specter",
			"wpn_fps_upg_o_aimpoint",
			"wpn_fps_upg_o_docter",
			"wpn_fps_upg_o_eotech",
			"wpn_fps_upg_o_t1micro",
			"wpn_fps_upg_o_aimpoint_2",
			"wpn_fps_upg_vg_ass_smg_verticalgrip",
			"wpn_fps_upg_vg_ass_smg_stubby",
			"wpn_fps_upg_vg_ass_smg_afg",
			"wpn_fps_upg_fl_ass_smg_sho_peqbox",
			"wpn_fps_upg_fl_ass_smg_sho_surefire",
			"wpn_fps_upg_m4_g_standard_vanilla",
			"wpn_fps_upg_m4_g_ergo",
			"wpn_fps_upg_m4_g_sniper",
			"wpn_fps_upg_ns_ass_smg_firepig",
			"wpn_fps_upg_ns_ass_smg_stubby",
			"wpn_fps_upg_ns_ass_smg_tank"
		}
		self.wpn_fps_ass_m4_npc = deep_clone(self.wpn_fps_ass_m4)
		self.wpn_fps_ass_m4_npc.unit = "units/payday2/weapons/wpn_fps_ass_m4/wpn_fps_ass_m4_npc"
	end

	function WeaponFactoryTweakData:_init_aug()
		self.parts.wpn_fps_aug_b_long = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel",
			name_id = "bm_wp_aug_b_long",
			a_obj = "a_b",
			unit = "units/payday2/weapons/wpn_fps_ass_aug_pts/wpn_fps_aug_b_long",
			stats = {
				value = 7,
				spread_moving = -2,
				spread = 1,
				recoil = 1,
				concealment = -3,
				damage = 1
			}
		}
		self.parts.wpn_fps_aug_b_medium = {
			type = "barrel",
			name_id = "bm_wp_aug_b_medium",
			a_obj = "a_b",
			unit = "units/payday2/weapons/wpn_fps_ass_aug_pts/wpn_fps_aug_b_medium",
			stats = {value = 1}
		}
		self.parts.wpn_fps_aug_b_short = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "barrel",
			name_id = "bm_wp_aug_b_short",
			a_obj = "a_b",
			unit = "units/payday2/weapons/wpn_fps_ass_aug_pts/wpn_fps_aug_b_short",
			stats = {
				value = 5,
				spread_moving = 3,
				spread = -1,
				recoil = 2,
				concealment = 4
			}
		}
		self.parts.wpn_fps_aug_m_pmag = {
			type = "magazine",
			name_id = "bm_wp_aug_m_pmag",
			a_obj = "a_m",
			unit = "units/payday2/weapons/wpn_fps_ass_aug_pts/wpn_fps_aug_m_pmag",
			stats = {value = 1},
			animations = {
				reload = "reload",
				reload_not_empty = "reload_not_empty"
			}
		}
		self.parts.wpn_fps_aug_body_aug = {
			type = "lower_reciever",
			name_id = "bm_wp_aug_body_aug",
			a_obj = "a_body",
			unit = "units/payday2/weapons/wpn_fps_ass_aug_pts/wpn_fps_aug_body_aug",
			stats = {value = 1},
			animations = {reload = "reload"}
		}
		self.parts.wpn_fps_aug_fg_a3 = {
			pcs = {
				10,
				20,
				30,
				40
			},
			type = "extra",
			name_id = "bm_wp_aug_fg_a3",
			a_obj = "a_fg",
			unit = "units/payday2/weapons/wpn_fps_ass_aug_pts/wpn_fps_aug_fg_a3",
			stats = {
				value = 7,
				recoil = 2,
				spread_moving = -2,
				concealment = -2
			}
		}
		self.parts.wpn_fps_aug_ris_special = {
			type = "extra",
			name_id = "bm_wp_aug_body_ris",
			a_obj = "a_body",
			unit = "units/payday2/weapons/wpn_fps_ass_aug_pts/wpn_fps_aug_ris_special",
			stats = {value = 1}
		}
		self.parts.wpn_fps_aug_b_long.third_unit = "units/payday2/weapons/wpn_third_ass_aug_pts/wpn_third_ass_aug_b_long"
		self.parts.wpn_fps_aug_b_medium.third_unit = "units/payday2/weapons/wpn_third_ass_aug_pts/wpn_third_ass_aug_b_medium"
		self.parts.wpn_fps_aug_b_short.third_unit = "units/payday2/weapons/wpn_third_ass_aug_pts/wpn_third_ass_aug_b_short"
		self.parts.wpn_fps_aug_body_aug.third_unit = "units/payday2/weapons/wpn_third_ass_aug_pts/wpn_third_ass_aug_body_aug"
		self.parts.wpn_fps_aug_fg_a3.third_unit = "units/payday2/weapons/wpn_third_ass_aug_pts/wpn_third_ass_aug_fg_a3"
		self.parts.wpn_fps_aug_m_pmag.third_unit = "units/payday2/weapons/wpn_third_ass_aug_pts/wpn_third_aug_m_pmag"
		self.parts.wpn_fps_aug_ris_special.third_unit = "units/payday2/weapons/wpn_third_ass_aug_pts/wpn_third_aug_ris_special"
		self.wpn_fps_ass_aug = {}
		self.wpn_fps_ass_aug.unit = "units/payday2/weapons/wpn_fps_ass_aug/wpn_fps_ass_aug"
		self.wpn_fps_ass_aug.optional_types = {"barrel_ext", "gadget"}
		self.wpn_fps_ass_aug.adds = {
			wpn_fps_upg_fl_ass_smg_sho_peqbox = {
				"wpn_fps_aug_ris_special"
			},
			wpn_fps_upg_fl_ass_smg_sho_surefire = {
				"wpn_fps_aug_ris_special"
			}
		}
		self.wpn_fps_ass_aug.override = {
			wpn_upg_o_marksmansight_rear_vanilla = {a_obj = "a_or"},
			wpn_upg_o_marksmansight_front_vanilla = {a_obj = "a_of"},
			wpn_upg_o_marksmansight_front = {a_obj = "a_of"}
		}
		self.wpn_fps_ass_aug.default_blueprint = {
			"wpn_fps_aug_body_aug",
			"wpn_fps_aug_b_medium",
			"wpn_fps_upg_vg_ass_smg_verticalgrip",
			"wpn_fps_aug_m_pmag",
			"wpn_upg_o_marksmansight_rear_vanilla"
		}
		self.wpn_fps_ass_aug.uses_parts = {
			"wpn_fps_aug_body_aug",
			"wpn_fps_aug_fg_a3",
			"wpn_fps_aug_ris_special",
			"wpn_fps_aug_b_long",
			"wpn_fps_aug_b_medium",
			"wpn_fps_aug_b_short",
			"wpn_fps_aug_m_pmag",
			"wpn_fps_upg_o_specter",
			"wpn_fps_upg_o_aimpoint",
			"wpn_fps_upg_o_docter",
			"wpn_fps_upg_o_eotech",
			"wpn_fps_upg_o_t1micro",
			"wpn_fps_upg_o_aimpoint_2",
			"wpn_upg_o_marksmansight_rear_vanilla",
			"wpn_upg_o_marksmansight_front_vanilla",
			"wpn_fps_upg_vg_ass_smg_verticalgrip",
			"wpn_fps_upg_vg_ass_smg_stubby",
			"wpn_fps_upg_vg_ass_smg_afg",
			"wpn_fps_upg_ns_ass_smg_large",
			"wpn_fps_upg_ns_ass_smg_medium",
			"wpn_fps_upg_ns_ass_smg_small",
			"wpn_fps_upg_ns_ass_smg_firepig",
			"wpn_fps_upg_ns_ass_smg_stubby",
			"wpn_fps_upg_ns_ass_smg_tank",
			"wpn_fps_upg_fl_ass_smg_sho_peqbox",
			"wpn_fps_upg_fl_ass_smg_sho_surefire"
		}
		self.wpn_fps_ass_aug_npc = deep_clone(self.wpn_fps_ass_aug)
		self.wpn_fps_ass_aug_npc.unit = "units/payday2/weapons/wpn_fps_ass_aug/wpn_fps_ass_aug_npc"
	end

end