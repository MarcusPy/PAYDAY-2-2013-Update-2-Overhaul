if RequiredScript == "lib/tweak_data/playertweakdata" then
	local old_init = PlayerTweakData.init
	function PlayerTweakData:init()
		old_init(self)
		
		self.damage.HEALTH_INIT = 30--20
		self.put_on_mask_time = 1
		self.damage.MIN_DAMAGE_INTERVAL = 0.4 --0.35
		self.damage.respawn_time_penalty = 15 
		self.damage.DOWNED_TIME = math.huge -- custody can only occur when spooc'd or cuffed
		self.damage.ARRESTED_TIME = 20 -- 30
		self.damage.INCAPACITATED_TIME = 20 -- 30

		self.fall_health_damage = 2
		self.fall_damage_alert_size = 100
		
		self.movement_state.standard.movement.speed.STANDARD_MAX = 350
		self.movement_state.standard.movement.speed.RUNNING_MAX = 600
		self.movement_state.standard.movement.speed.CROUCHING_MAX = 200
		self.movement_state.standard.movement.speed.STEELSIGHT_MAX = 150
	end
end