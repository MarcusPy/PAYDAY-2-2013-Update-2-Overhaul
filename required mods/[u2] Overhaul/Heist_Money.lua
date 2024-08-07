--[[

hud_offshore_account
menu_cash_spending

]]

MoneyManager = MoneyManager or class()

function MoneyManager:_add_to_total( amount, params )
	local no_offshore = params and params.no_offshore
	local offshore = math.round( ((no_offshore and 0) or amount * (1 - tweak_data:get_value( "money_manager", "offshore_rate" ))) / 3 )
	local spending_cash = math.round( ((no_offshore and amount) or amount * tweak_data:get_value( "money_manager", "offshore_rate" )) * 2 )
	
	self:_set_total( self:total() + spending_cash )
	self:_set_total_collected( self:total_collected() + math.round( amount ) )
	self:_set_offshore( self:offshore() + offshore )
	self:_on_total_changed( amount, spending_cash, offshore ) 
end