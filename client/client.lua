ESX = nil

local MainMenu = RageUI.CreateMenu("~r~Illégal", "~c~Vendeur d'arme illegal", 0, 0, "commonmenu", "interaction_bgd", 0,0,0,1);

local ArmesDePoing = RageUI.CreateSubMenu(MainMenu, "~r~Armes de poing", "~c~Vendeur d'arme illegal", 0, 0, "commonmenu", "interaction_bgd", 0,0,0,1);
local ArmesSMG = RageUI.CreateSubMenu(MainMenu, "~r~SMG", "~c~Vendeur d'arme illegal", 0, 0, "commonmenu", "interaction_bgd", 0,0,0,1);

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	RegisterNetEvent('esx:playerLoaded') -- Store the players data
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
        ESX.PlayerLoaded = true
    end)

    -- Creation du ped

    local coords = Ped.Coords
    local pedName = Ped.Model
    local pedHash = GetHashKey(pedName)

    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do Citizen.Wait(0) end

    local ped = CreatePed(9, pedHash, coords, 294.80, false, false)
    Citizen.Wait(1000)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_SMOKE", 0, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)

    -- Creation de la boucle while pour interagir avec le ped

	local interval, ped, pos, distance
	while true do
		interval = 0
		ped = PlayerPedId()
		pos = GetEntityCoords(ped)
		distance = #(pos - coords)
		if distance > 30 then
			interval = 5000
		else
			if distance < 2 then
				AddTextEntry("help", "Appuyer sur ~r~E ~s~pour accéder à cette zone")
				DisplayHelpTextThisFrame("help", false)
				if IsControlJustPressed(1, 51) then
					RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
				end
			else
				RageUI.CloseAll()
			end
		end
		Citizen.Wait(interval)
	end
    

end)

---------------------------------------------------------------------
--                            FUNCTIONS                            --
---------------------------------------------------------------------

function RageUI.PoolMenus:Example()
	MainMenu:IsVisible(function(Items)
        Items:AddButton("Armes de poing", nil, { IsDisabled = false, RightLabel = "~r~>>"},function(onSelected)

		end, ArmesDePoing)
        Items:AddButton("SMG", nil, { IsDisabled = false, RightLabel = "~r~>>"},function(onSelected)

		end, ArmesSMG)

	end, function() end)

    -- SubMenu Arme de poing
    ArmesDePoing:IsVisible(function(Items)
        Items:AddButton(Weapons[1].Label, nil, { IsDisabled = Weapons[1].Active, RightLabel = "Prix : ~g~"..Weapons[1].Price.." ~s~$"}, function(onSelected)
             if onSelected then
                F_Coords("buyPistolet")
            end
        end)
        Items:AddButton(Weapons[2].Label, nil, { IsDisabled = Weapons[2].Active, RightLabel = "Prix : ~g~"..Weapons[2].Price.." ~s~$" }, function(onSelected)
            if onSelected then
                F_Coords("buyPistolet50")
            end
        end)
    end, function() end)
        -- SubMenu Armes SMG
        ArmesSMG:IsVisible(function(Items)
            Items:AddButton(Weapons[3].Label, nil, { IsDisabled = Weapons[3].Active, RightLabel = "Prix : ~g~"..Weapons[3].Price.." ~s~$"}, function(onSelected)
                 if onSelected then
                    F_Coords("buyMicrouzi")
                end
            end)
        end, function() end)
end

function F_Coords(trigger)
    Citizen.CreateThread(function()
        ESX.ShowNotification("Je t'ai envoyer des coords, ce que tu cherche est dans le coffre d'une sultan ! fait attention à toi")
        local coordsrandom = waypoint[math.random(1, #waypoint)]
        SetNewWaypoint(coordsrandom.x, coordsrandom.y)
    
        local vehicleHash = GetHashKey("Sultan")
        
        RequestModel(vehicleHash)
        while not HasModelLoaded(vehicleHash) do Citizen.Wait(10) end
    
        local vehicle = CreateVehicle(vehicleHash, coordsrandom.x, coordsrandom.y, coordsrandom.z, coordsrandom.heanding, false, false)
        local vehicleCoords, pedCoords

        SetVehicleDoorsLocked(vehicle, 2)
    
        while true do
            vehicleCoords = GetEntityCoords(vehicle)
            pedCoords = GetEntityCoords(PlayerPedId())
            distance2 = #(pedCoords - vehicleCoords)
                if distance2 < 3 then
                    AddTextEntry("help", "Appuyer sur ~r~E ~s~pour prendre")
                    DisplayHelpTextThisFrame("help", false)
                    if IsControlJustPressed(1, 51) then
                        TriggerServerEvent(trigger)
                        Citizen.SetTimeout(10000, function()
                            DeleteVehicle(vehicle)
                        end)
                        return
                    end
                else
                    RageUI.CloseAll()
                end
        Citizen.Wait(interval)
        end
    end)
end


RegisterCommand("waypoint", function(source, args, rawCommand)


end, false)

