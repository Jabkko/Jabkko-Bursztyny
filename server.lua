ESX = exports["es_extended"]:getSharedObject()


RegisterServerEvent('bursztyn:zbierz')
AddEventHandler('bursztyn:zbierz',function()
    local chance=math.random(1,100)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('bursztyn', math.random(1,3))
    if chance>=90 then 
        xPlayer.addInventoryItem('phone2', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Znalazłeś Jakiś Telefon...' })
    end
end)

RegisterServerEvent('bursztyn:sell')
AddEventHandler('bursztyn:sell',function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local bursztyn = xPlayer.getInventoryItem('bursztyn').count
    if bursztyn>0 then
        xPlayer.addInventoryItem('money', bursztyn*math.random(20,30))
        xPlayer.removeInventoryItem('bursztyn',bursztyn)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Nie masz Bursztynów' })
    end
end)
