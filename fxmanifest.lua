fx_version 'cerulean'
game 'gta5'

description 'tofu-payphone'
version '1.0.0'

ui_page 'html/index.html'

client_script 'client/*.lua'
server_script 'server/*.lua'
shared_scripts {
    'shared/*.lua'
}
files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/tones.js'
}

lua54 'yes'

dependency {
    'npwd',
    'qb-npwd',
    'qb-target',
}

-- 0589236477
