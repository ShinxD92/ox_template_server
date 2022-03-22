-- Configuration

Config = {}

Config.Debug        = true -- If set true this enables client debug_print & debug commands. Visit 'locales' to edit commands.
Config.Locale       = 'en' -- Resource language. Visit `locales` folder to view different languages.
Config.versionCheck = true -- If set true, you'll get a print in server console from 'ox_lib' stating the resource is out of date and needs a update.

Config.costMoney  = true -- If set true receiving treatment will cost money, if false it will be free.
Config.billAmount = 500 -- Total cost to receive treatment (cash).

-- Choose for players to gain health when using qtarget to lay down in bed instead of receiving treatment through NPC.
Config.healTime  = 3 -- If set '0' healing  will be disabled. If set '3' players will receive one health every three seconds.
Config.lowHealth = true -- If set true you will have a bleeding & screen shake effect when your hurt. If false it will be disabled.

-- NPC spawn location & model.
Config.NPC = {
    {
        coords  = vec3(311.57, -594.11, 43.28 - 0.99),
        heading = 0.5000,
        model   = `s_m_m_doctor_01`
    }
}

-- *DO NOT TOUCH UNLESS YOU KNOW WHAT YOUR DOING*
Config.Animation = {
    ['lay_down'] = {
        dict     = 'anim@gangops@morgue@table@',
        anim     = 'ko_front'
    }
}

-- *DO NOT TOUCH UNLESS YOU KNOW WHAT YOUR DOING*
Config.Beds = {
    1631638868, -- hospital treatment room bed
    2117668672 -- catscan bed
}
