-- FX Information --
fx_version   'cerulean'
lua54        'yes'
game         'gta5'

-- Resource Information --
name         'qphospital'
authors      'qpr'
version      '1.0.6'
repository   'https://github.com/ohqpr/qphospital'
description  'Hospital treatment system'

-- Manifest --
dependencies {
  '/server:5104',
  '/onesync',
  'oxmysql',
  'ox_lib',
  'ox_inventory',
  'qtarget',
  'nh-context'
}

shared_scripts {
  '@es_extended/imports.lua',
  '@ox_lib/init.lua',
  'shared/configuration.lua',
  'shared/locales.lua',
  'locales/*.lua'
}

client_script 'client/main.lua'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'init.lua',
  'server/main.lua'
}

files {
  'web/public/index.css',
  'web/src/*',
  'web/init.js',
  'web/debug.js'
}
