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

-------------------------------------
------------ vRP tunnels ------------
-------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kasperr_player_ping")

RegisterServerEvent("kasperr_player_ping:askPlayer")
AddEventHandler("kasperr_player_ping:askPlayer", function(targetID)
    local user_id = vRP.getUserId({source})
    local _source = source
    local targetSource = vRP.getUserSource({targetID})
    if targetSource ~= nil then
        TriggerClientEvent("kasperr_player_ping:askPlayer", targetSource, tostring(user_id))
    end
end)

RegisterServerEvent("kasperr_player_ping:setGPS")
AddEventHandler("kasperr_player_ping:setGPS", function(askingUserID)
    local user_id = vRP.getUserId({source})
    local _source = source
    local askingSource = vRP.getUserSource({tonumber(askingUserID)})
    if askingSource ~= nil then
        vRPclient.getPosition(_source,{},function(x,y,z)
            vRPclient.setGPS(askingSource,{x,y})
        end)
    end
end)