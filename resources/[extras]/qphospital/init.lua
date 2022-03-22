-- Clean up and refresh user health in database

CreateThread(function()
	local health      = 0
	local refreshData = {}
	print('Refreshing data')

	refreshData[health] = { query = 'UPDATE users SET `health` = ?', values = { health } }

	if #refreshData > 1 then
		MySQL.transaction(refreshData)
	elseif lib then
		print("Data refreshed")
	end
end)
