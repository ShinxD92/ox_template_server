-- Function for locales

Config.Locales = {}

function Locale(str)
    if Config.Locales[Config.Locale][str] then return Config.Locales[Config.Locale][str] else return 'Translation missing' end
end