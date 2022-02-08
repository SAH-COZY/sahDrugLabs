fx_version 'cerulean'
game 'gta5'
author 'SAHCOZY'

client_scripts {
    '@bob74_ipl/dlc_bikers/document_forgery.lua',
    '@bob74_ipl/dlc_bikers/weed.lua',
    '@bob74_ipl/dlc_bikers/cocaine.lua',
    '@bob74_ipl/dlc_bikers/counterfeit_cash.lua',
    '@bob74_ipl/dlc_bikers/meth.lua',
    '@bob74_ipl/lib/common.lua',
    
    'client/**/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/**/*.lua'
}

shared_scripts {
    'shared/**/*.lua'
}