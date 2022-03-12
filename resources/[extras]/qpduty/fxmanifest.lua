fx_version 'cerulean'

game 'gta5'

author "qpr" -- https://github.com/ohqpr

lua54 'yes'

version '1.0.0'

server_scripts {
  '@es_extended/locale.lua',
  'server/main.lua',
  'server/version_check.lua'
}

client_scripts {
  '@es_extended/locale.lua',
  'client.lua'
}