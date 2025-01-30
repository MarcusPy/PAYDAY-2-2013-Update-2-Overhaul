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
		self.saw.CLIP_AMMO_MAX = 100
		self.saw.AMMO_MAX = 2

	--[[
		Calibre x Damage chart
		.197 = 1
		.236 = 1.5
		.276 = 2
		.315 = 2.5
		.354 = 3
		.394 = 3.5
		.433 = 4
		.472 = 4.5
		.511 = 5
	]]

	--primaries
		--315 , 384
		self.amcar.DAMAGE = 2.5
		self.amcar.CLIP_AMMO_MAX = 24
		self.amcar.AMMO_MAX = 168
		self.amcar.single = {
			fire_rate = 0.12
		}
		self.amcar.auto = nil

		--.354 , 450
		self.ak74.DAMAGE = 3
		self.ak74.CLIP_AMMO_MAX = 30
		self.ak74.AMMO_MAX = 150
		self.ak74.auto.fire_rate = 0.18

		--276 , 448
		self.new_m4.DAMAGE = 2
		self.new_m4.CLIP_AMMO_MAX = 32
		self.new_m4.AMMO_MAX = 224
		self.new_m4.auto.fire_rate =  0.1
		
		--.315, 450
		self.aug.DAMAGE = 2.5
		self.aug.CLIP_AMMO_MAX = 30
		self.aug.AMMO_MAX = 180
		self.aug.auto.fire_rate = 0.14
		
		-- pump, 1440
		self.r870.DAMAGE = 4
		self.r870.CLIP_AMMO_MAX = 6
		self.r870.AMMO_MAX = 30
		self.r870.single.fire_rate = 0.5
		self.r870.rays = 12
		
		--.315 , 450
		self.g36.DAMAGE = 2.5
		self.g36.CLIP_AMMO_MAX = 36
		self.g36.AMMO_MAX = 180
		self.g36.auto.fire_rate = 0.2
		
		--.354 , 420
		self.akm.DAMAGE = 3
		self.akm.CLIP_AMMO_MAX = 28
		self.akm.AMMO_MAX = 140
		self.akm.auto.fire_rate = 0.07
		
		--.511 , 360
		self.new_m14.DAMAGE = 5
		self.new_m14.CLIP_AMMO_MAX = 12
		self.new_m14.AMMO_MAX = 72
		self.new_m14.single.fire_rate = 0.33
		
		-- mag, 1400
		self.saiga.DAMAGE = 4
		self.saiga.CLIP_AMMO_MAX = 7
		self.saiga.AMMO_MAX = 35
		self.saiga.auto.fire_rate = 0.25
		self.saiga.rays = 10

		--.394 , 448
		self.ak5.DAMAGE = 3.5
		self.ak5.CLIP_AMMO_MAX = 32
		self.ak5.AMMO_MAX = 128
		self.ak5.auto.fire_rate = 0.2
		
		--.433 , 384
		self.m16.DAMAGE = 4
		self.m16.CLIP_AMMO_MAX = 16
		self.m16.AMMO_MAX = 96
		self.m16.single = {
			fire_rate = 0.25
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
		.197 = 1
		.236 = 1.5
		.276 = 2
		.315 = 2.5
		.354 = 3
		.394 = 3.5
		.433 = 4
		.472 = 4.5
		.511 = 5
	]]

	--secondaries x13
		-- .236 , 144
		self.glock_17.DAMAGE = 1.5
		self.glock_17.CLIP_AMMO_MAX = 16
		self.glock_17.AMMO_MAX = 96
		self.glock_17.single.fire_rate = 0.2

		-- .315 , 175
		self.colt_1911.DAMAGE = 2.5
		self.colt_1911.CLIP_AMMO_MAX = 10
		self.colt_1911.AMMO_MAX = 70
		self.colt_1911.single.fire_rate = 0.25

		-- .354 , 216
		self.mac10.DAMAGE = 3
		self.mac10.CLIP_AMMO_MAX = 24
		self.mac10.AMMO_MAX = 72
		self.mac10.auto.fire_rate = 0.05

		-- .472 , 162
		self.new_raging_bull.DAMAGE = 4.5
		self.new_raging_bull.CLIP_AMMO_MAX = 6
		self.new_raging_bull.AMMO_MAX = 36
		self.new_raging_bull.single.fire_rate = 0.5

		-- .276 , 168
		self.b92fs.DAMAGE = 2
		self.b92fs.CLIP_AMMO_MAX = 12
		self.b92fs.AMMO_MAX = 84
		self.b92fs.single.fire_rate = 0.2

		-- pump , 960
		self.serbu.DAMAGE = 4
		self.serbu.CLIP_AMMO_MAX = 6
		self.serbu.AMMO_MAX = 24
		self.serbu.single.fire_rate = 0.5
		self.serbu.rays = 10

		-- .276 , 208
		self.new_mp5.DAMAGE = 2
		self.new_mp5.CLIP_AMMO_MAX = 26
		self.new_mp5.AMMO_MAX = 104
		self.new_mp5.auto.fire_rate = 0.15
		
		-- .315 , 200
		self.olympic.DAMAGE = 2.5
		self.olympic.CLIP_AMMO_MAX = 20
		self.olympic.AMMO_MAX = 80
		self.olympic.auto.fire_rate = 0.2

		-- .276 , 200
		self.mp9.DAMAGE = 2
		self.mp9.CLIP_AMMO_MAX = 20
		self.mp9.AMMO_MAX = 100
		self.mp9.auto.fire_rate = 0.1

		-- .315 , 150
		self.akmsu.DAMAGE = 2.5
		self.akmsu.CLIP_AMMO_MAX = 30
		self.akmsu.AMMO_MAX = 60
		self.akmsu.auto.fire_rate = 0.25

		-- .236 , 150
		self.glock_18c.DAMAGE = 1.5
		self.glock_18c.CLIP_AMMO_MAX = 20
		self.glock_18c.AMMO_MAX = 100
		self.glock_18c.auto.fire_rate = 0.08
		
		-- .197 , 150
		self.p90.DAMAGE = 1
		self.p90.CLIP_AMMO_MAX = 50
		self.p90.AMMO_MAX = 150
		self.p90.auto.fire_rate = 0.05

		-- .511 , 140
		self.deagle.DAMAGE = 5
		self.deagle.CLIP_AMMO_MAX = 7
		self.deagle.AMMO_MAX = 28
		self.deagle.single.fire_rate = 0.33
	end
end