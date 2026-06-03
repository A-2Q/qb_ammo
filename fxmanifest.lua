
    fx_version 'cerulean'
    game 'gta5'
    name 'ALI.M - Ammo Script for QBCore Framework'
    description 'A Weapon ammo Script for QBCore Framework   ' -- Script تعبئة الذخيرة للسلاح العسكري من قبل ضابط شرطة في QBCore Framework
    author 'ALI.M'
    version '1.0.0'
    lua54 'yes'
    
    shared_scripts {
    '@ox_lib/init.lua',
}
    shared_script 'config.lua'

    client_script 'client.lua'

    server_script 'server.lua'
    