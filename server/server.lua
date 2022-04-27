ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Armes de poing

RegisterNetEvent("buyPistolet")
AddEventHandler("buyPistolet", function()
	local xPlayer = ESX.GetPlayerFromId(source) -- Avoir le joueur

	if xPlayer.getAccount("black_money").money < Weapons[1].Price then
		TriggerClientEvent('esx:showNotification', source, "Pas assez d'argent sale !")
	elseif xPlayer.hasWeapon("weapon_pistol") then
		TriggerClientEvent('esx:showNotification', source, "Tu as déjà un "..Weapons[1].Label)
	else
		xPlayer.removeAccountMoney("black_money", Weapons[1].Price)
		xPlayer.addWeapon(Weapons[1].Value, 100)
		TriggerClientEvent('esx:showNotification', source, "Tu as reçu ton "..Weapons[1].Label)
	end
end)

RegisterNetEvent("buyPistolet50")
AddEventHandler("buyPistolet50", function()
	local xPlayer = ESX.GetPlayerFromId(source) -- Avoir le joueur

	if xPlayer.getAccount("black_money").money < Weapons[2].Price then
		TriggerClientEvent('esx:showNotification', source, "Pas assez d'argent sale !")
	elseif xPlayer.hasWeapon("weapon_pistol50") then
		TriggerClientEvent('esx:showNotification', source, "Tu as déjà un "..Weapons[2].Label)
	else
		xPlayer.removeAccountMoney("black_money", Weapons[2].Price)
		xPlayer.addWeapon(Weapons[2].Value, 100)
		TriggerClientEvent('esx:showNotification', source, "Tu as reçu ton "..Weapons[2].Label)
	end
end)

-- Armes SMG

RegisterNetEvent("buyMicrouzi")
AddEventHandler("buyMicrouzi", function()
	local xPlayer = ESX.GetPlayerFromId(source) -- Avoir le joueur

	if xPlayer.getAccount("black_money").money < Weapons[3].Price then
		TriggerClientEvent('esx:showNotification', source, "Pas assez d'argent sale !")
	elseif xPlayer.hasWeapon(Weapons[3].Value) then
		TriggerClientEvent('esx:showNotification', source, "Tu as déjà un "..Weapons[3].Label)
	else
		xPlayer.removeAccountMoney("black_money", Weapons[3].Price)
		xPlayer.addWeapon(Weapons[3].Value, 100)
		TriggerClientEvent('esx:showNotification', source, "Tu as reçu ton "..Weapons[3].Label)
	end
end)