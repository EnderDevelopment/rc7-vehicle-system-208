local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Register server callback to check if the player owns an RC7
ESX.RegisterServerCallback('rc7system:checkRC7Ownership', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier

    MySQL.Async.fetchScalar('SELECT COUNT(*) FROM rc7_owners WHERE player_id = @player_id', {
        ['@player_id'] = playerId
    }, function(count)
        cb(count > 0)
    end)
end)

-- Register server callback to check if the player has enough money
ESX.RegisterServerCallback('rc7system:checkMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getAccount('bank').money

    if playerMoney >= Config.RC7Price then
        xPlayer.removeAccountMoney('bank', Config.RC7Price)
        cb(true)
    else
        cb(false)
    end
end)

-- Register server event to register the RC7 ownership
RegisterServerEvent('rc7system:registerRC7')
AddEventHandler('rc7system:registerRC7', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier

    MySQL.Async.execute('INSERT INTO rc7_owners (player_id, vehicle_plate) VALUES (@player_id, @vehicle_plate)', {
        ['@player_id'] = playerId,
        ['@vehicle_plate'] = plate
    }, function(rowsChanged)
        if rowsChanged == 0 then
            print('Failed to register RC7 ownership for player ' .. playerId)
        end
    end)
end)