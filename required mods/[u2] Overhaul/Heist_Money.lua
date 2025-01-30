-- get 6 times less offshore, 50% more spending because release pd2 economy is wild
-- this is also done for realism purposes, since we have 4 heisters, bain, twitch/bile. Assuming they each get an about equal cut, we split the offshore into 6 pieces
if RequiredScript == "lib/managers/moneymanager" then
	function MoneyManager:_add_to_total( amount, params )
		local no_offshore = params and params.no_offshore
		local offshore = math.round( (no_offshore and 0) or amount * (1 - tweak_data:get_value( "money_manager", "offshore_rate" )) )
		local spending_cash = math.round( (no_offshore and amount) or amount * tweak_data:get_value( "money_manager", "offshore_rate" ) )
		
		local rounding_error = math.round( amount - (offshore + spending_cash) )
		spending_cash = spending_cash + rounding_error
		
		if managers.job:is_current_job_professional() then
			spending_cash = math.round(spending_cash * 1.5)
			offshore = math.round(offshore / 5)
		else
			spending_cash = math.round(spending_cash * 1.4)
			offshore = math.round(offshore / 6)
		end

		self:_set_total( self:total() + spending_cash )
		self:_set_total_collected( self:total_collected() + math.round( amount ) )
		self:_set_offshore( self:offshore() + offshore )
		self:_on_total_changed( amount, spending_cash, offshore ) 
	end
end