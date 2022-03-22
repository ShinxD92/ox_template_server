local ox_inventory = exports.ox_inventory

if Config.versionCheck then
    lib.versionCheck("ohqpr/qphospital")
end

lib.callback.register("qphospital:signIn", function(source)
    local src        = source
    local returnable = nil

    if ox_inventory:GetItem(src, 'money').count >= Config.billAmount then
       ox_inventory:RemoveItem(src, 'money', Config.billAmount)
        returnable = true
    else
        returnable = false
    end

    while returnable == nil do Wait(50) end; return returnable
end)

lib.callback.register("qphospital:fetchStats", function(source)
    local src        = source
    local xPlayer    = ESX.GetPlayerFromId(src)
    local returnable = nil

    if xPlayer then
      MySQL.Async.fetchAll('SELECT health FROM users WHERE identifier = ?', {xPlayer.identifier}, function(result)
        returnable = json.decode(result[1].health)
      end)
    else
        returnable = {health = 200, armour = 0}
    end

    while returnable == nil do Wait(50) end; return returnable
end)

RegisterServerEvent('qphospital:syncData', function(data)
    local src     = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
      MySQL.Sync.execute('UPDATE users SET health = ? WHERE identifier = ?', {json.encode(data), xPlayer.identifier})
    end
end)