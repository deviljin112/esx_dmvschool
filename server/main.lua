ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_dmvschool:addLicense')
AddEventHandler('esx_dmvschool:addLicense', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
		end)
	end)
end)

ESX.RegisterServerCallback('esx_dmvschool:pay', function(source, cb, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local accountMoney = xPlayer.getAccount("money").money

	if accountMoney < price then
		cb(false)
	else
		xPlayer.removeAccountMoney('money', price)
		TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(price)))
		cb(true)
	end
end)
