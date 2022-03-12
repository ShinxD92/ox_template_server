Citizen.CreateThread( function()
gitRepo = "https://github.com/ohqpr/qpduty.git"
resourceName = "qpduty ("..GetCurrentResourceName()..")"

function checkVersion(err, responseText, headers)
	curVersion = LoadResourceFile(GetCurrentResourceName(), "version")

	if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
		print("^3You are running the latest version of qpduty (current version: %s)")
	else
		print("^3Update is available for qpduty - please download the latest release (current version: %s)")
	end
end

PerformHttpRequest("https://raw.githubusercontent.com"..gitRepo.."/master/version", checkVersion, "Checking Version")
end)