local QBCore = exports['qb-core']:GetCoreObject()

-- طلب بدء التعبئة من العميل
RegisterNetEvent('npc:refill:request', function(weapon)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    -- التحقق من الجوب والرتبة على الخادم (أساسي للأمان)
    if Player.PlayerData.job.name ~= Config.Job or Player.PlayerData.job.grade.level < Config.MinGrade then
        TriggerClientEvent('ox_lib:notify', src, { title = 'غير مسموح', description = 'ليس لديك الصلاحية لهذا الإجراء.', type = 'error' })
        return
    end

    -- التحقق من أن السلاح مسموح به
    if not Config.AllowedWeapons[weapon] then
        TriggerClientEvent('ox_lib:notify', src, { title = 'سلاح غير مدعوم', description = 'هذا السلاح غير مدعوم.', type = 'error' })
        return
    end

    -- إخبار العميل ببدء شريط التحميل
    TriggerClientEvent('npc:refill:start', src, weapon)
end)

-- إضافة الذخيرة بعد اكتمال شريط التحميل
RegisterNetEvent('npc:refill:giveAmmo', function(weapon)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    -- التحقق مرة أخرى من الصلاحية
    if Player.PlayerData.job.name ~= Config.Job or Player.PlayerData.job.grade.level < Config.MinGrade then
        print(string.format("^1[SECURITY] Player %s (%s) attempted to exploit ammo refill.^7", Player.PlayerData.name, src))
        return
    end

    if not Config.AllowedWeapons[weapon] then
        print(string.format("^1[SECURITY] Player %s (%s) attempted to refill non-allowed weapon: %s^7", Player.PlayerData.name, src, weapon))
        return
    end

    -- إضافة الذخيرة بأمان باستخدام حدث من الخادم
    local playerPed = GetPlayerPed(src)
    AddAmmoToPed(playerPed, weapon, Config.AmmoAmount)
    
    -- تسجيل نجاح العملية (اختياري)
    
end)