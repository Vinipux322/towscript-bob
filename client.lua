local function ModelRequest(mhash)
  local i = 0
  while not HasModelLoaded(mhash) and i < 1000 do
    RequestModel(mhash)
    Citizen.Wait(10)
    i = i + 1
  end
  if HasModelLoaded(mhash) then
    return true
  else
    return false
  end
end

RegisterNetEvent('bob:tow')
AddEventHandler('bob:tow', function()
	local playerped = PlayerPedId()
	local coordfirst = GetEntityCoords(playerped, 1)
	local coordsecond = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local veh = getVehFromCoords(coordfirst, coordsecond)
	if IsEntityAVehicle(veh) then
		-- Bob model hash: 1644266841
		if ModelRequest(1644266841) then
			local pedveh = CreatePedInsideVehicle(veh,26,1644266841,-1,true,true)
			SetVehicleEngineOn(veh,true,true,true)
			TaskVehicleDriveToCoord(pedveh,veh,404.30883789062,-1633.4680175782,29.291931152344,80.0,1.0,0,1074528293,1.0,true)
			Citizen.Wait(10000)
			local i = 0
			
			while DoesEntityExist(veh) and i < 1000 do
				Citizen.Wait(1000)
				SetModelAsNoLongerNeeded(veh)
				SetEntityAsNoLongerNeeded(veh)
				SetEntityAsMissionEntity(veh, false, false)
				DeleteEntity(veh)	
				SetModelAsNoLongerNeeded(pedveh)
				SetEntityAsNoLongerNeeded(pedveh)
				SetEntityAsMissionEntity(pedveh, false, false)
				DeleteEntity(pedveh)
				i = i + 1
			end

			if not DoesEntityExist(veh) then
				TriggerEvent("chatMessage", "[Tow BOB]", {255, 255, 0}, "Success!")
			else
				TriggerEvent("chatMessage", "[Tow BOB]", {255, 0, 0}, "Error, vehicle wasn't deleted")
			end
			
		end
	else
		TriggerEvent("chatMessage", "[Tow BOB]", {255, 255, 0}, "No car for evacuation!")
	end
end)
	
function getVehFromCoords(coord1, coord2)
	local handle = CastRayPointToPoint(coord1.x, coord1.y, coord1.z, coord2.x, coord2.y, coord2.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(handle)
	return vehicle
end