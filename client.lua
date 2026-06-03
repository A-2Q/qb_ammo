local QBCore = exports['qb-core']:GetCoreObject()
local ped = nil
local isRefilling = false

local function IsOfficerReady()
    return ped and ped ~= 0 and DoesEntityExist(ped)
end

CreateThread(function()
    if not Config or not Config.Ped or not Config.Ped.model then
        print("^1[ERROR] Config not loaded correctly^7")
        return
    end

    local model = joaat(Config.Ped.model)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    ped = CreatePed(4, model, Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z, Config.Ped.coords.w, false, true)

    if not IsOfficerReady() then
        return lib.notify({ title = 'خطأ', description = 'تعذر إنشاء الضابط.', type = 'error' })
    end

    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetModelAsNoLongerNeeded(model)

    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                type = 'client',
                event = 'npc:refill',
                icon = 'fas fa-gun',
                label = 'تعبئة السلاح',
                job = Config.Job,
                grade = Config.MinGrade,
            },
        },
        distance = Config.Distance
    })
end)

RegisterNetEvent('npc:talk', function()
    if not IsOfficerReady() then
        return lib.notify({ title = 'الضابط غير جاهز', description = 'الضابط غير جاهز الآن.', type = 'error' })
    end

    local playerPed = PlayerPedId()
    local dist = #(GetEntityCoords(playerPed) - GetEntityCoords(ped))
    if dist > Config.Distance then
        return lib.notify({ title = 'بعيد جداً', description = 'أنت بعيد جداً عن الضابط.', type = 'error' })
    end

    lib.notify({ title = 'مرحباً!', description = 'أقدر أعبي طلق سلاحك العسكري', type = 'success' })
end)

-- حدث العميل لطلب التعبئة
RegisterNetEvent('npc:refill', function()
    if isRefilling then
        return lib.notify({ title = 'مشغول', description = 'انتظر انتهاء العملية.', type = 'error' })
    end

    if not IsOfficerReady() then
        return lib.notify({ title = 'الضابط غير جاهز', description = 'الضابط غير جاهز الآن.', type = 'error' })
    end

    -- التحقق من الجوب والرتبة على العميل (كطبقة أولى)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name ~= Config.Job or PlayerData.job.grade.level < Config.MinGrade then
        return lib.notify({ title = 'غير مسموح', description = 'هذه الخدمة متاحة فقط للرتبة ' .. Config.MinGrade .. ' فما فوق.', type = 'error' })
    end

    local playerPed = PlayerPedId()
    local dist = #(GetEntityCoords(playerPed) - GetEntityCoords(ped))
    if dist > Config.Distance then
        return lib.notify({ title = 'بعيد جداً', description = 'أنت بعيد جداً عن الضابط.', type = 'error' })
    end

    local weapon = GetSelectedPedWeapon(playerPed)
    if weapon == `WEAPON_UNARMED` then
        return lib.notify({ title = 'لا تملك سلاحاً', description = 'أنت لا تحمل سلاحاً.', type = 'error' })
    end

    if not Config.AllowedWeapons[weapon] then
        return lib.notify({ title = 'سلاح غير مدعوم', description = 'هذا السلاح غير مدعوم.', type = 'error' })
    end

    -- إرسال طلب إلى الخادم لبدء عملية التعبئة
    TriggerServerEvent('npc:refill:request', weapon)
end)

-- حدث لبدء شريط التحميل بعد موافقة الخادم
RegisterNetEvent('npc:refill:start', function(weapon)
    if isRefilling then return end

    local playerPed = PlayerPedId()
    -- إعادة التحقق من المسافة والسلاح (طبقة أمان إضافية)
    local dist = #(GetEntityCoords(playerPed) - GetEntityCoords(ped))
    if dist > Config.Distance then
        return lib.notify({ title = 'بعيد جداً', description = 'أنت بعيد جداً عن الضابط.', type = 'error' })
    end

    if GetSelectedPedWeapon(playerPed) ~= weapon then
        return lib.notify({ title = 'خطأ', description = 'تغير السلاح أثناء العملية.', type = 'error' })
    end

    isRefilling = true
    TaskTurnPedToFaceEntity(ped, playerPed, 1000)

    local success = lib.progressCircle({
        duration = Config.RefillTime,
        position = 'bottom',
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        label = 'جاري التعبئة...'
    })

    if success then
        -- إرسال طلب للخادم لإضافة الذخيرة
        TriggerServerEvent('npc:refill:giveAmmo', weapon)
        lib.notify({ title = 'تم التعبئة', description = 'تم تعبئة السلاح بنجاح.', type = 'success' })
    else
        lib.notify({ title = 'تم الإلغاء', description = 'تم إلغاء عملية التعبئة.', type = 'error' })
    end

    isRefilling = false
end)