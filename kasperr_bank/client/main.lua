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
]]vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "kasperr_bank")

-- Display Map Blips
Citizen.CreateThread(
  function()
    for k, v in ipairs(Config.Banks) do
      local blip = AddBlipForCoord(v.x, v.y, v.z)
      SetBlipSprite(blip, v.id)
      SetBlipScale(blip, 0.8)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(tostring(v.name))
      EndTextCommandSetBlipName(blip)
    end
  end
)

-- NUI Variables
local atBank = false
local atATM = false
local bankOpen = false
local atmOpen = false

-- Open Gui and Focus NUI
function openGui()
  SetNuiFocus(true, true)
  SendNUIMessage({open = true})
end

-- Close Gui and disable NUI
function closeGui()
  if bankOpen or atmOpen then 
    SetNuiFocus(false)
    SendNUIMessage({close = true})
    bankOpen = false
    atmOpen = false
  end
end

if true then
  Citizen.CreateThread(
    function()
      while true do
        Citizen.Wait(0)
        if (IsNearBank() or IsNearATM()) then
          if (atBank == false) then
            TriggerEvent("chatMessage", "", {255, 255, 255}, "Press ^5E^0 to access the bank")
          end
          atBank = true
          if IsControlJustPressed(1, 51) then
            if (IsInVehicle()) then
              TriggerEvent("chatMessage", "", {255, 0, 0}, "^1Please exit the vehicle!")
            else
              if bankOpen then
                closeGui()
                bankOpen = false
              else
                openGui()
                bankOpen = true
              end
            end
          end
        else
          if (atmOpen or bankOpen) then
            closeGui()
          end
          atBank = false
          atmOpen = false
          bankOpen = false
        end
      end
    end
  )
end

Citizen.CreateThread(
  function()
    while true do
      if bankOpen or atmOpen then
        local ply = GetPlayerPed(-1)
        local active = true
        DisableControlAction(0, 1, active)
        DisableControlAction(0, 2, active)
        DisableControlAction(0, 24, active)
        DisablePlayerFiring(ply, true)
        DisableControlAction(0, 142, active)
        DisableControlAction(0, 106, active)
      end
      Citizen.Wait(0)
    end
  end
)

function IsNearATM()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(Config.Atms) do
    local distance =
      GetDistanceBetweenCoords(item.x, item.y, item.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if (distance <= 3) then
      return true
    end
  end
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

function IsNearBank()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(Config.Banks) do
    local distance =
      GetDistanceBetweenCoords(item.x, item.y, item.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if (distance <= 3) then
      return true
    end
  end
end

function IsNearPlayer(player)
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
  local ply2Coords = GetEntityCoords(ply2, 0)
  local distance =
    GetDistanceBetweenCoords(
    ply2Coords["x"],
    ply2Coords["y"],
    ply2Coords["z"],
    plyCoords["x"],
    plyCoords["y"],
    plyCoords["z"],
    true
  )
  if (distance <= 5) then
    return true
  end
end

function notification(title, description, type, returnHome)
  if returnHome == true then
    SendNUIMessage({open = true})
  end
  SendNUIMessage(
    {
      notification = true,
      notification_title = title,
      notification_desc = description,
      notification_type = type
    }
  )
end

RegisterNUICallback("close", function(data)
  closeGui()
end)

RegisterNUICallback("openBalance", function(data)
  TriggerServerEvent("kasperr_bank:openBalance")
end)

RegisterNUICallback("depositMoney", function(data)
  TriggerServerEvent("kasperr_bank:depositMoney", data.amount)
end)

RegisterNUICallback("withdrawMoney", function(data)
  TriggerServerEvent("kasperr_bank:withdrawMoney", data.amount)
end)

RegisterNUICallback("showName", function(data)
  TriggerServerEvent("kasperr_bank:showName")
end)

RegisterNUICallback("transferMoney", function(data)
  TriggerServerEvent("kasperr_bank:transferMoney", tonumber(data.userid), tonumber(data.amount))
end)

RegisterNetEvent("kasperr_bank:notification")
AddEventHandler("kasperr_bank:notification", function(title, description, type, returnHome)
  notification(title, description, type, returnHome)
end)

RegisterNetEvent("kasperr_bank:showName")
AddEventHandler("kasperr_bank:showName", function(firstname, lastname)
  SendNUIMessage({
    showName = true,
    firstname = firstname,
    lastname = lastname
  })
end)

RegisterNetEvent("kasperr_bank:depositResponse")
AddEventHandler("kasperr_bank:depositResponse", function(res)
  Citizen.Wait(1000)
  SendNUIMessage({open = true})
  if res == true then
    notification("Success", "Deposit success", "success")
  else
    notification("Deposit failed", "Not enough money", "error")
  end
end)

RegisterNetEvent("kasperr_bank:withdrawResponse")
AddEventHandler("kasperr_bank:withdrawResponse", function(res)
  Citizen.Wait(1000)
  SendNUIMessage({open = true})
  if res == true then
    notification("Success", "Withdraw success", "success")
  else
    notification("Withdraw failed", "Not enough money", "error")
  end
end)

RegisterNetEvent("kasperr_bank:openBalance")
AddEventHandler("kasperr_bank:openBalance", function(amount)
  SendNUIMessage({
    openBalance = true,
    balance = amount
  })
end)

RegisterNetEvent("kasperr_bank:transferResponse")
AddEventHandler("kasperr_bank:transferResponse", function(res)
  Citizen.Wait(1000)
  SendNUIMessage({open = true})
  if res == true then
    notification("Success", "Transfer success", "success")
  else
    notification("Transfer failed", "Not enough money", "error")
  end
end)

RegisterNetEvent("kasperr_bank:showNotification")
AddEventHandler("kasperr_bank:showNotification", function(text)
  SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end)

AddEventHandler("onResourceStop", function(resource)
  if resource == GetCurrentResourceName() then
    closeGui()
  end
end)
