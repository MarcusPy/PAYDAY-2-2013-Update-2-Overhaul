if RequiredScript == "lib/tweak_data/moneytweakdata" then
	local old_init = MoneyTweakData.init
	function MoneyTweakData:init(...)
		old_init(self, ...)
		
		self.bag_values = {
			default  = 150, -- ?, prolly used when a specific value isn't assigned
			money 	 = 600, -- was 450, increased to since drilling now takes 10m, rather than 6m
			gold 	 = 800, -- was 600, same as above but should be higher realistically, so assume it needs to be melted down again first
			diamonds = 125, -- low bc jewerly store is too easy, let's assume this is scrap value
			coke 	 = 500,
			meth 	 = 600,
			weapons  = 700
		}

		self.small_loot = {
			money_bundle			   = 18,
			diamondheist_vault_bust	   = 12,
			diamondheist_vault_diamond = 15,
			diamondheist_big_diamond   = 20,
			value_gold 				   = 45,
			gen_atm 				   = 250,
			special_deposit_box		   = 35,
			vault_loot_gold			   = 45,
			vault_loot_cash			   = 14,
			vault_loot_coins		   = 50,
			vault_loot_ring			   = 25,
			vault_loot_jewels		   = 60,
			vault_loot_macka		   = 10 --whatever this is
		}
		
		self.skilltree.respec.point_tier_cost = self._create_value_table( 4000, self.biggest_cashout*0.5, 6, true, 1.1 )
		self.skilltree.respec.respec_refund_multiplier = 1
		
	end
end