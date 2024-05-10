ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

function openRockstarMenu()
    local lib = exports['ox_lib']

    options = {}

    table.insert(options, {
        title = "Start recording",
        icon = 'play',
        description = "Click to start recording",
        onSelect = function()
            StartRecording(1)
        end,
    })

    table.insert(options, {
        title = "Stop recording",
        icon = 'stop',
        description = "Click to finish recording",
        onSelect = function()
            if(IsRecording()) then
				StopRecordingAndSaveClip()
			end
        end,
    })

    table.insert(options, {
        title = "Open the Rockstar Editor",
        icon = 'film',
        description = "Click to open the Rockstar Editor menu",
        onSelect = function()
            NetworkSessionLeaveSinglePlayer()
			ActivateRockstarEditor()
        end,
    })

    lib:registerContext({
        id = 'rockstar_menu',
        title = 'Rockstar Editor',
        options = options
    })

    lib:showContext('rockstar_menu')
end


RegisterCommand('record', function()
    openRockstarMenu() 
end, false)