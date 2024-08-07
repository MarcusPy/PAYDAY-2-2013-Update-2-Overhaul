if RequiredScript == "lib/tweak_data/playertweakdata" then
	local old_init = PlayerTweakData.init
	function PlayerTweakData:init()
		old_init(self)
		
		self.put_on_mask_time = 1 --2
		
		self.damage.REVIVE_HEALTH_STEPS = { 0.5 }
		
		self.damage.TASED_TIME = 10
		self.damage.TASED_RECOVER_TIME = 3 --1
		self.damage.BLEED_OUT_HEALTH_INIT = 20 --10
		
		self.damage.DOWNED_TIME = math.huge --30
		self.damage.ARRESTED_TIME = math.random(10, 40)
		self.damage.INCAPACITATED_TIME = math.huge --30
		
		self.damage.MIN_DAMAGE_INTERVAL = 0.35
		
		self.damage.respawn_time_penalty = 15 --30
		self.damage.base_respawn_time_penalty = 10 --5
		
		self.fall_health_damage = 2 --4
		self.fall_damage_alert_size = 0 --250
		
		self.movement_state.standard.movement.speed.STANDARD_MAX = 350		-- Walk speed. ( cm/sec )
		self.movement_state.standard.movement.speed.RUNNING_MAX = 600 --575
		self.movement_state.standard.movement.speed.CROUCHING_MAX = 200 --225
		self.movement_state.standard.movement.speed.STEELSIGHT_MAX = 150 --185
	end
end