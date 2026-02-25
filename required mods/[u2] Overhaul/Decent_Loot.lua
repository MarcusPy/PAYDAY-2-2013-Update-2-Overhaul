if RequiredScript == "lib/tweak_data/moneytweakdata" then
	local old_init = MoneyTweakData.init
	function MoneyTweakData:init(...)
		old_init(self, ...)
		
		self.bag_values = {
			default  = 150,
			money 	 = 500,
			gold 	 = 1000,
			diamonds = 150,
			coke 	 = 300,
			meth 	 = 400,
			weapons  = 500
		}

		self.small_loot = {
			money_bundle			   = 18,
			diamondheist_vault_bust	   = 12,
			diamondheist_vault_diamond = 15,
			diamondheist_big_diamond   = 20,
			value_gold 				   = 45,
			gen_atm 				   = 500,
			special_deposit_box		   = 35,
			vault_loot_gold			   = 45,
			vault_loot_cash			   = 14,
			vault_loot_coins		   = 50,
			vault_loot_ring			   = 25,
			vault_loot_jewels		   = 60,
			vault_loot_macka		   = 10 --whatever this is
		}

		self.skilltree.respec.point_tier_cost = self._create_value_table( 4000, self.biggest_cashout * 0.5, 6, true, 1.1 )
		self.skilltree.respec.respec_refund_multiplier = 0.666
		
	end
end