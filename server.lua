-- Update all properties
RegisterServerEvent("updateSkin")
AddEventHandler("updateSkin", function(skin)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.getIdentifier()

		MySQL.Async.execute('UPDATE users SET `skin` = @skin WHERE identifier = @identifier',
			{
				['@skin']       = json.encode(skin),
				['@identifier'] = player
			})

		print("Outfits successfully updated !")
	end)
end)
RegisterServerEvent('hud:loadplayer')
AddEventHandler('hud:loadplayer', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.getIdentifier()
		MySQL.Async.fetchAll("SELECT * FROM `outfits` WHERE `identifier` = @identifier", {['@identifier'] = player},
		function(result)
		TriggerClientEvent('hud:loadskin', source, result)
		end)
	end)
end)
