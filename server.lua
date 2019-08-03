-- Update all properties
RegisterServerEvent("updateSkin")
AddEventHandler("updateSkin", function(skin)
	TriggerEvent('bfde9955-4b11-4b3e-b4f8-07e6d69badf1', source, function(user)
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
	TriggerEvent('bfde9955-4b11-4b3e-b4f8-07e6d69badf1', source, function(user)
		local player = user.getIdentifier()
		MySQL.Async.fetchAll("SELECT * FROM `outfits` WHERE `identifier` = @identifier", {['@identifier'] = player},
		function(result)
		TriggerClientEvent('hud:loadskin', source, result)
		end)
	end)
end)