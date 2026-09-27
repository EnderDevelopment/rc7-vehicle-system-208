local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Function to spawn the RC7
function SpawnRC7()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local rc7Model = GetHashKey(Config.RC7Model)

    RequestModel(rc7Model)
    while not HasModelLoaded(rc7Model) do
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(rc7Model, Config.RC7Spawn.x, Config.RC7Spawn.y, Config.RC7Spawn.z, Config.RC7SpawnHeading, true, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleNumberPlateText(vehicle, 'RC7' .. math.random(1000, 9999))

    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    TriggerServerEvent('rc7system:registerRC7', GetVehicleNumberPlateText(vehicle))
end

-- Register command to spawn the RC7
RegisterCommand('spawnrc7', function(source, args, rawCommand)
    ESX.TriggerServerCallback('rc7system:checkRC7Ownership', function(hasRC7)
        if hasRC7 then
            ESX.ShowNotification('You already own an RC7!')
        else
            ESX.TriggerServerCallback('rc7system:checkMoney', function(hasMoney)
                if hasMoney then
                    SpawnRC7()
                else
                    ESX.ShowNotification('You do not have enough money to buy an RC7!')
                end
            end)
        end
    end)
end, false)