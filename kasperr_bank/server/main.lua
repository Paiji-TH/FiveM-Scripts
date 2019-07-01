--[[
  __  __           _            _                 _  __                         _____  
 |  \/  |         | |          | |               | |/ /                        |  __ \ 
 | \  / | __ _  __| | ___      | |__  _   _      | ' / __ _ ___ _ __   ___ _ __| |__) |
 | |\/| |/ _` |/ _` |/ _ \     | '_ \| | | |     |  < / _` / __| '_ \ / _ \ '__|  _  / 
 | |  | | (_| | (_| |  __/     | |_) | |_| |     | . \ (_| \__ \ |_) |  __/ |  | | \ \ 
 |_|  |_|\__,_|\__,_|\___|     |_.__/ \__, |     |_|\_\__,_|___/ .__/ \___|_|  |_|  \_\
                                       __/ |                   | |                     
                                      |___/                    |_|                     

  Author: Kasper Rasmussen
  Steam: https://steamcommunity.com/id/kasperrasmussen
]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kasperr_bank")

RegisterServerEvent('kasperr_bank:depositMoney')
AddEventHandler('kasperr_bank:depositMoney', function(amount)
    local user_id = vRP.getUserId({source})
    local _source = source
    if vRP.tryDeposit({user_id,tonumber(amount)}) then
        TriggerClientEvent("kasperr_bank:depositResponse", source, true)
    else
        TriggerClientEvent("kasperr_bank:depositResponse", source, false)
    end
end)

RegisterServerEvent('kasperr_bank:withdrawMoney')
AddEventHandler('kasperr_bank:withdrawMoney', function(amount)
    local user_id = vRP.getUserId({source})
    local _source = source
    if vRP.tryWithdraw({user_id,tonumber(amount)}) then
        TriggerClientEvent("kasperr_bank:withdrawResponse", _source, true)
    else
        TriggerClientEvent("kasperr_bank:withdrawResponse", _source, false)
    end
end)

RegisterServerEvent('kasperr_bank:showName')
AddEventHandler('kasperr_bank:showName', function()
    local _source = source
    local user_id = vRP.getUserId({source})
    vRP.getUserIdentity({user_id, function(identity)
        if identity then
            TriggerClientEvent("kasperr_bank:showName", _source, identity.firstname, identity.name)
        end
    end})
end)

RegisterServerEvent('kasperr_bank:openBalance')
AddEventHandler('kasperr_bank:openBalance', function()
    local _source = source
    local user_id = vRP.getUserId({source})
    local money = vRP.getBankMoney({user_id})
    TriggerClientEvent("kasperr_bank:openBalance", _source, money)
end)

RegisterServerEvent('kasperr_bank:transferMoney')
AddEventHandler('kasperr_bank:transferMoney', function(userid, amount)
    local _source = source
    local user_id = vRP.getUserId({source})
    local targetPlayer = vRP.getUserSource({tonumber(userid)})
    if targetPlayer == nil then
        return TriggerClientEvent("kasperr_bank:notification", _source, "Transfer failed", "User not found", "error", true)
    end
    local myBank = vRP.getBankMoney({user_id})
    if myBank >= amount then
        vRP.setBankMoney({user_id, myBank - amount})
        vRP.giveBankMoney({userid,amount})
        TriggerClientEvent("kasperr_bank:transferResponse", source, true)
        TriggerClientEvent("kasperr_bank:showNotification", targetPlayer, "You have received $" .. amount .." from ID: " .. tostring(user_id))
    else
        TriggerClientEvent("kasperr_bank:transferResponse", source, false)
    end
end)