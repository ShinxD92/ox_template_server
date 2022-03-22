local plyPos, inBed, bleeding, playerLoaded = GetEntityCoords(cache.ped), false, false, false

-- Functions
local function debug_print(msg)
    if Config.Debug then
        print(msg)
    end
end

local function treatmentInProgress()
    SetEntityCoords(cache.ped, 317.88, -585.21, 44.22 + 0.3)
    lib.requestAnimDict('anim@gangops@morgue@table@')
    TaskPlayAnim(cache.ped, 'anim@gangops@morgue@table@', 'ko_front', 8.0, -8.0, -1, 1, 0, false, false, false)
    SetEntityHeading(cache.ped, 335.05)
    InAction = true
    debug_print('Receiving treatment')
end

local function spawnNurse()
    modelHash = `a_m_m_prolhost_01`
    lib.requestModel(modelHash)

    local NurseNPC = CreatePed(5, modelHash, 316.82, -579.40, 43.30, 178.70, false, false)
    SetEntityAsMissionEntity(NurseNPC)
    SetEntityInvincible(NurseNPC, true)
    Wait(1500)

    SetPedDesiredHeading(NurseNPC, 178.70)
    Wait(100)

    TaskGoStraightToCoord(NurseNPC, 316.67, -585.20, 43.28, 1.0, 5000, 251.89, 2.0)
    Wait(5000)

    TaskStartScenarioInPlace(NurseNPC, 'PROP_HUMAN_BUM_BIN', 0, false)
    Wait(40000)

    TaskGoStraightToCoord(NurseNPC, 342.41, -581.68, 42.41, 1.0, 5000, 70.50, 2.0)
    Wait(4000)
    
    DeleteEntity(NurseNPC)
    debug_print('Nurse NPC has despawned')
end

local function startBleedingEffect()
    if playerLoaded then  
        SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) - 2)

        if not bleeding then
            StartScreenEffect('Rampage', 0, true)
            bleeding = true
        end

        exports.ox_inventory:notify({type = 'info', text = Locale('medicalAttention'), duration = 3500})
        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    end

    Wait(5000)
end

local function stopBleedingEffect()
    bleeding = false
    StopScreenEffect('Rampage')
    SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)
end

local function getTreatment()
    SetEntityCoords(cache.ped, 351.37, -583.14, 44.20 + 0.3)
    TriggerEvent('esx_ambulancejob:revive'); Wait(850)
    SetEntityHealth(cache.ped, 200)
    treatmentInProgress()
    debug_print('Progress bar loaded')

    exports.ox_inventory:Progress({
        duration     = 22500,
        label        = 'Being treated..',
        useWhileDead = true,
        canCancel    = false,
        disable      = {
            move     = true,
            combat   = true
        },
    }, function(cancel)
        if not cancel then
            ClearPedTasksImmediately(cache.ped)
            DoScreenFadeIn(50)
            exports.ox_inventory:notify({type = 'info', text = Locale('playerTreated'), duration = 3500})
            SetEntityCoords(cache.ped, 316.55, -584.42, 43.32)
            SetEntityHeading(cache.ped, 351.02)
            lib.requestAnimSet('move_m@drunk@slightlydrunk')
            SetPedMovementClipset(cache.ped, 'move_m@drunk@slightlydrunk', true)
            StartScreenEffect('drugsmichaelaliensfightout', 0, true)
            Wait(10000)
            StartScreenEffect('drugsmichaelaliensfightout', 0, true)
            Wait(10000)
            StopAllScreenEffects(cache.ped)
            ResetPedMovementClipset(cache.ped, 0)
        end
   end)
end

local function startTreatement()
    debug_print('Requested treatment')

    if Config.costMoney then
        lib.callback('qphospital:signIn', false, function(response)
            if response then
                debug_print('You have been billed $' .. Config.billAmount) 
                exports.ox_inventory:notify({type = 'info', text = string.format(Locale('playerBilled'), Config.billAmount), duration = 3500})
                getTreatment(); spawnNurse()
            elseif not response then
                debug_print('You need $' .. Config.billAmount .. ' in order to get treated.') 
                exports.ox_inventory:notify({type = 'error', text = string.format(Locale('noMoney'), Config.billAmount), duration = 3500})
            end
        end)
    elseif not Config.costMoney then
        debug_print('You have checked in')
        getTreatment(); spawnNurse()
    end
end

local function enterBed(model, data)
    local obj        = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z, 3.0, model, 0, 0, 0)
    local objPos     = GetEntityCoords(obj)

    inBed            = true

    SetEntityCoords(cache.ped, objPos.x, objPos.y, objPos.z + 0.5); SetEntityHeading(cache.ped, GetEntityHeading(obj) - 180)
    FreezeEntityPosition(obj, true); FreezeEntityPosition(cache.ped, true)

    if data.dict then
        lib.requestAnimDict(data.dict)
        TaskPlayAnim(cache.ped, data.dict, data.anim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
    else
        TaskStartScenarioAtPosition(
            cache.ped,
            data.anim,
            objPos.x + data.metadata[1],
            objPos.y + data.metadata[2],
            objPos.z - data.metadata[3],
            GetEntityHeading(obj) + data.metadata[4],
            0,
            true,
            true
        )
    end
end

local function spawnNpc()
    for k, v in pairs(Config.NPC) do
        lib.requestModel(v.model)
        local ped = CreatePed(4, v.model, v.coords, false, false)
        SetEntityHeading(ped, heading)
        SetEntityAsMissionEntity(ped, true, true)
        SetPedFleeAttributes(ped, 0, 0)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end

local function openContext()
    local accept = exports['nh-context']:ContextMenu({
        {
            header  = Locale('name'),
            context = Locale('question')
        },
        {
            header  = Locale('yes'),
            context = string.format(Locale('cost'), Config.billAmount), 
            args    = {"startTreatement"}
        }
    })
    
    if accept ~= nil then
        if accept == 'startTreatement' then
            startTreatement()
        end
    end
end

local function syncHealth()
    lib.callback('qphospital:fetchStats', 1000, function(data)
        SetEntityHealth(cache.ped, data.health); SetPedArmour(cache.ped, data.armour)
    end)
end
-- End of functions

-- Entities
CreateThread(function()
    -- NPC entity
    local doctor = {}

    for k, v in pairs(Config.NPC) do
        doctor   = {v.model}
    end
    
    exports['qtarget']:AddTargetModel(doctor, {
        options        = {
            {
                icon   = 'fas fa-sign-in-alt',
                label  = Locale('checkIn'),
                action = function(entity)
                  openContext()
                end
            }
        },
        distance = 3.0
    })

    debug_print('NPC target loaded')

    -- Bed entity
    exports['qtarget']:AddTargetModel(Config.Beds, {
        options       = {
            {
               icon   = 'fas fa-clipboard',
               label  = Locale('layDown'),
               action = function(entity)
                 enterBed(GetEntityModel(entity), Config.Animation['lay_down'])
               end
           }
        },
        distance = 1.5
    })

    debug_print('Bed target loaded')
end)
-- End of entities

-- Intervals
SetInterval(function()
    plyPos = GetEntityCoords(cache.ped)
end, 2000)

SetInterval(function()
    if inBed then
        local health = GetEntityHealth(cache.ped)

        if health <= 170 then
            SetEntityHealth(cache.ped, health + 1)
        end
    end
end, Config.healTime * 1000)

if Config.lowHealth then
    SetInterval(function()
        local health = GetEntityHealth(cache.ped)

        if health < 140 then
            startBleedingEffect()
        elseif health > 150 then
            stopBleedingEffect()
        end
    end, 5)
end

SetInterval(function()
    local data = {
        health = GetEntityHealth(cache.ped),
        armour = GetPedArmour(cache.ped)
    } 

    TriggerServerEvent('qphospital:syncData', data)
end, 25000)
-- End of intervals

-- Events
RegisterNetEvent('esx:playerLoaded', function()
    spawnNpc(); syncHealth(); Wait(2000); playerLoaded = true
end)
-- End of events

-- Key mapping
RegisterKeyMapping('qphospital:getUp', Locale('getUp'), 'keyboard', 'F')
RegisterCommand('qphospital:getUp', function(raw)
    if inBed then
       inBed = false
        
        ClearPedTasksImmediately(cache.ped)
        FreezeEntityPosition(cache.ped, false)
    end
end)
-- End of key mapping

-- Debug
if Config.Debug then
    RegisterCommand(Locale('debugCommand'), function(source, args, rawCommand) -- This command is to test receiving treatment through nh-context menu
        openContext()
    end)
  
    RegisterCommand(Locale('healthSync'), function(source, args, rawCommand) -- This command syncs health saved to your database
        syncHealth()
    end)
end
-- End of debug
