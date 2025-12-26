fx_version 'cerulean'
game 'gta5'

description 'Beautiful notification system with multiple alert types'
author 'BLDR'
version '1.0.0'

ui_page 'web/dist/index.html'
files { 'web/dist/**/*' }

client_scripts { 
    'client/notifications.lua',
    'client/nui.lua',
    'client/main.lua'
}

server_scripts { 
    'server/notifications.lua',
    'server/main.lua'
}
