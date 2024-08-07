if RequiredScript == "lib/tweak_data/moneytweakdata" then
	local old_init = MoneyTweakData.init
	function MoneyTweakData:init(...)
		old_init(self, ...)
		
		self.small_loot.gen_atm = 418
		
		self.skilltree.respec.point_tier_cost = self._create_value_table( 4000, self.biggest_cashout*0.66, 6, true, 1.1 )
		self.skilltree.respec.respec_refund_multiplier = 1 -- respec freely, no cost for resetting to compensate for the lack of profiles
		
	end
end