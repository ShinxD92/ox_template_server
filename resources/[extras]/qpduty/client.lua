Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
 	PlayerData = ESX.GetPlayerData()
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('qpduty:PoliceDuty')
AddEventHandler('qpduty:PoliceDuty', function()
  RequestAnimDict("anim@heists@keycard@")
  TaskPlayAnim( GetPlayerPed(-1), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
  TriggerServerEvent('PoliceDuty:police')
  exports["mythic_notify"]:SendAlert("inform", "Hope you have a good day!")
end)

RegisterNetEvent('qpduty:AmbulanceDutyaduty')
AddEventHandler('qpduty:AmbulanceDuty', function()
  RequestAnimDict("anim@heists@keycard@")
  TaskPlayAnim( GetPlayerPed(-1), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
  TriggerServerEvent('AmbulanceDuty:ambulance')
  exports["mythic_notify"]:SendAlert("inform", "Hope you have a good day!")
end)

exports['qtarget']:AddBoxZone("PoliceClipboard", vector3(441.7989, -982.0529, 30.67834), 0.45, 0.35, {
	name = "PoliceClipboard",
	heading = 50,
	debugPoly = true,
	minZ = 30.77834,
	maxZ = 30.87834,
	}, {
		options = {
		    {
				event = "qpduty:PoliceDuty",
				icon = "fas fa-sign-in-alt",
				label = "Go On-Duty",
				job = "offpolice",
            },
		    {
				event = "qpduty:PoliceDuty",
				icon = "fas fa-sign-out-alt",
				label = "Go Off-Duty",
				job = "police",
		    },
	    },
        distance = 1.0
 })

exports['qtarget']:AddBoxZone("AmbulanceClipboard", vector3(307.50, -595.35, 43.10), 0.30, 0.50, {
	name = "AmbulanceClipboard",
	heading = 50,
	debugPoly = true,
	minZ = 43.10,
	maxZ = 43.20,
	}, {
		options = {
			{
				event = "qpduty:AmbulanceDuty",
				icon = "fas fa-sign-in-alt",
				label = "Clock-In",
				job = "offambulance",
			},
			{
				event = "qpduty:AmbulanceDuty",
				icon = "fas fa-sign-out-alt",
				label = "Clock-Out",
				job = "ambulance",
			},
		},
		distance = 1.0
})
