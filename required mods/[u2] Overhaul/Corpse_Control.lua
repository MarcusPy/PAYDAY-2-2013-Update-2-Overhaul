if RequiredScript == "lib/managers/enemymanager" then
	EnemyManager._MAX_NR_CORPSES = math.round(_G.u2_core.settings.misc.corpse_limit)

	local old_init = EnemyManager.init
	function EnemyManager:init(...)
		old_init(self, ...)
		self._corpse_disposal_upd_interval = 5
	end
end

if RequiredScript == "lib/units/enemies/cop/copdamage" then
	function CopDamage:_spawn_head_gadget(...)
		return
	end
end