-- remove junk from PAYDAY loot drop pool, leaving only cash and weapon mods
local old_init = LootDropTweakData.init
function LootDropTweakData:init( tweak_data, ... )
	old_init(self, tweak_data, ...)

	self.WEIGHTED_TYPE_CHANCE = {}
	local min = 10
	local max = 100

	local range = { 
		cash = {25, 25}, 
		weapon_mods = {75, 75}, 
		colors = {0, 0}, 
		textures = {0, 0}, 
		materials = {0, 0}, 
		masks = {0, 0} 
	}

	for i = min, max, 10 do
		local cash = math.lerp(range.cash[1], range.cash[2], i / max)
		local weapon_mods = math.lerp(range.weapon_mods[1], range.weapon_mods[2], i / max)
		local colors = math.lerp(range.colors[1], range.colors[2], i / max)
		local textures = math.lerp(range.textures[1], range.textures[2], i / max)
		local materials = math.lerp(range.materials[1], range.materials[2], i / max)
		local masks = math.lerp(range.masks[1], range.masks[2], i / max)
	
		self.WEIGHTED_TYPE_CHANCE[i] = { 
			cash = cash, 
			weapon_mods = weapon_mods, 
			colors = colors, 
			textures = textures, 
			materials = materials, 
			masks = masks 
		}
	end
end