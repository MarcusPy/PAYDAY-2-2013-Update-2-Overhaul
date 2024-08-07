if RequiredScript == "lib/managers/enemymanager" then
	EnemyManager._MAX_NR_CORPSES = 32
	EnemyManager._nr_i_lod = 
	{
		{ 20, 20 }, -- up the lod for each anim setting
		{ 20, 20 },
		{ 20, 20 }
	}

	local old_init = EnemyManager.init
	function EnemyManager:init(...)
		old_init(self, ...)
		self._corpse_disposal_upd_interval = 5 --run the cleanup every x seconds
	end

end

if RequiredScript == "lib/units/enemies/cop/copdamage" then
	function CopDamage:_spawn_head_gadget(...)
		return
	end
end