ESX = exports["es_extended"]:getSharedObject()
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }


Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-1536.76,-1239.65,2.5)
    SetBlipSprite (blip, 683)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour (blip, 47)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Zbieranie Bursztynów')
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-1684.14,-1070.10,13.13)
    SetBlipSprite (blip, 683)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour (blip, 47)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Sprzedawanie Bursztynów')
    EndTextCommandSetBlipName(blip)
end)

local targetPoint1 = vector3(-1536.76,-1239.65,2.5) 
local targetPoint2 = vector3(-1684.14,-1070.10,13.13) 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - targetPoint1) 

        if distance <= 15.00 then
            ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby zbierać bursztyny')
            if IsControlJustReleased(0, Keys['E'])  then
                TriggerEvent('bursztyn:prog')
            end
        end
    end
end)

RegisterNetEvent('bursztyn:prog')
AddEventHandler('bursztyn:prog', function()
    if lib.progressBar({
        duration = 7500,
        label = 'Szukanie Bursztynów',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            dict = 'amb@world_human_gardener_plant@male@base',
            clip = 'base'
        },
    }) then
        TriggerServerEvent('bursztyn:zbierz')
    end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId()) 
        local distance = #(playerCoords - targetPoint2) 

        if distance <= 5.0 then
            ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby sprzedać bursztyny')
            if IsControlJustReleased(0, Keys['E'])  then
                TriggerServerEvent('bursztyn:sell')
            end
        end
    end
end)

