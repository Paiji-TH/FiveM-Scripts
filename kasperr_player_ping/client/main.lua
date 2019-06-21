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

local delay = 0
local askingUserID = nil

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			if delay > 0 then
				delay = delay - 1
			end
		end
	end
)

RegisterNetEvent("kasperr_player_ping:askPlayer")
AddEventHandler(
  "kasperr_player_ping:askPlayer",
  function(userID)
	askingUserID = userID
	TriggerEvent('chatMessage', '', {255, 82, 82}, "Ping from ID: " .. userID)
  end
)

RegisterCommand(
  "ping",
  function(source, args)
	if args[1] ~= nil then 
		if tonumber(args[1]) then
			if delay == 0 then
				delay = 5
				TriggerServerEvent("kasperr_player_ping:askPlayer", tonumber(args[1]))
				TriggerEvent('chatMessage', '', {255, 82, 82}, "Pinging " .. args[1])
			else
				TriggerEvent('chatMessage', '', {255, 82, 82}, "To many requests")
			end
		end
		if args[1] == "accept" then
			if askingUserID ~= nil then
				TriggerServerEvent("kasperr_player_ping:setGPS", askingUserID)
				TriggerEvent('chatMessage', '', {255, 82, 82}, "Ping accepted")
				askingUserID = nil
			else
				TriggerEvent('chatMessage', '', {255, 82, 82}, "You have no requests")
			end
		end
	end
  end
)