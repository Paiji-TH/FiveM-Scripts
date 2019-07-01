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
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kasperr_helpdesk")

local show = false
local cooldown = 0

-- Open menu
function openGui(cases)
  if show == false then
    show = true
    SetNuiFocus(true, true)
    SendNUIMessage(
      {
        show = true,
        cases = cases
      }
    )
  end
end

-- Close menu
function closeGui()
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
end

-- Events
RegisterNetEvent("kasperr_helpdesk:openGui")
AddEventHandler(
  "kasperr_helpdesk:openGui",
  function()
    if cooldown > 0 then
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Please wait " .. cooldown .. " seconds")
      DrawNotification(false, false)
    else
      cooldown = Config.AntiSpamCooldown
      openGui()
    end
  end
)

RegisterNetEvent("kasperr_helpdesk:openCase")
AddEventHandler(
  "kasperr_helpdesk:openCase",
  function(case, replies, options)
    if show == true then
      SendNUIMessage(
        {
          openCase = true,
          case = case,
          replies = replies, 
          options = options
        }
      )
    end
  end
)

RegisterNetEvent("kasperr_helpdesk:showMyCases")
AddEventHandler(
  "kasperr_helpdesk:showMyCases",
  function(cases, options)
    if show == true then
      SendNUIMessage(
        {
          showMyCases = true,
          cases = cases, 
          options = options
        }
      )
    end
  end
)

RegisterNetEvent("kasperr_helpdesk:showSupportCases")
AddEventHandler(
  "kasperr_helpdesk:showSupportCases",
  function(cases, options)
    if show == true then
      SendNUIMessage(
        {
          showSupportCases = true,
          cases = cases, 
          options = options
        }
      )
    end
  end
)

-- NUI callbacks
RegisterNUICallback(
  "close",
  function(data)
    closeGui()
  end
)

RegisterNUICallback(
  "getCases",
  function()
    TriggerServerEvent("kasperr_helpdesk:getCases")
  end
)

RegisterNUICallback(
  "getCase",
  function(data)
    TriggerServerEvent("kasperr_helpdesk:getCase", data.id)
  end
)

RegisterNUICallback(
  "applyReply",
  function(data)
    TriggerServerEvent("kasperr_helpdesk:applyReply", data.message, data.case_id)
  end
)

RegisterNUICallback(
  "closeCase",
  function(data)
    TriggerServerEvent("kasperr_helpdesk:closeCase", data.case_id)
  end
)

RegisterNUICallback(
  "deleteCase",
  function(data)
    TriggerServerEvent("kasperr_helpdesk:deleteCase", data.case_id)
  end
)

RegisterNUICallback(
  "newCase",
  function(data)
    TriggerServerEvent("kasperr_helpdesk:newCase", data.title, data.message)
  end
)

RegisterNUICallback(
  "getSupportCases",
  function()
    TriggerServerEvent("kasperr_helpdesk:getSupportCases")
  end
)

RegisterNUICallback(
  "gotoPlayer",
  function(data)
    TriggerServerEvent("kasperr_helpdesk:gotoPlayer", data.targetID)
  end
)

-- Command handler
RegisterCommand(
  Config.Command,
  function(source, args)
    TriggerEvent("kasperr_helpdesk:openGui")
  end
)

AddEventHandler(
  "onResourceStop",
  function(resource)
    if resource == GetCurrentResourceName() then
      closeGui()
    end
  end
)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if cooldown > 0 then 
      cooldown = cooldown - 1
    end
  end
end)