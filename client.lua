RegisterNetEvent('bob:tow')
AddEventHandler('bob:tow', function()
	local playerped = GetPlayerPed(-1)
	local coordfirst = GetEntityCoords(playerped, 1)
	local coordsecond = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local veh = getVehFromCoords(coordfirst, coordsecond)
	if IsEntityAVehicle(veh) then
	local pedveh = CreatePedInsideVehicle(veh,26,1644266841,-1,true,true)
	SetVehicleEngineOn(veh,true,true,true)
	TaskVehicleDriveToCoord(pedveh,veh,404.30883789062,-1633.4680175782,29.291931152344,80.0,1.0,0,1074528293,1.0,true)
	Citizen.Wait(10000)
	while DoesEntityExist(veh) do
	Citizen.Wait(1000)
	SetModelAsNoLongerNeeded(veh)
	SetEntityAsNoLongerNeeded(veh)
	SetEntityAsMissionEntity(veh, false, false)
	DeleteEntity(veh)	
	SetModelAsNoLongerNeeded(pedveh)
	SetEntityAsNoLongerNeeded(pedveh)
	SetEntityAsMissionEntity(pedveh, false, false)
	DeleteEntity(pedveh)			
	end
	TriggerEvent("chatMessage", "[Tow BOB]", {255, 255, 0}, "Success!")
	else
	TriggerEvent("chatMessage", "[Tow BOB]", {255, 255, 0}, "No car for evacuation!")
	end
end)
	
function getVehFromCoords(coord1, coord2)
	local handle = CastRayPointToPoint(coord1.x, coord1.y, coord1.z, coord2.x, coord2.y, coord2.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(handle)
	return vehicle
end