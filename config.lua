Config = {}

Config.Job = 'police' --وضع هنا اسم الجوب اللي تبي يشتغل عليه السكربت
Config.MinGrade = 2 --الدرجة الدنيا اللي تقدر تستخدم السكربت (مثلاً 2 يعني من رتبة جندي أول وأعلى يقدر يستخدمه)

Config.RefillTime = 5000 -- الوقت اللي بياخذو البيد عشان يعبئ سلاحك بالذخيرة (بالملي ثانية) يعني 5000 = 5 ثواني
Config.AmmoAmount = 999 -- كمية الذخيرة اللي بياخذها البيد عشان يعبئ سلاحك (999 يعني بيعبئ سلاحك كامل)
Config.Distance = 3.0 -- المسافة اللي لازم تكون فيها عشان تقدر تتفاعل مع البيد (3.0 يعني 3 متر)

Config.Ped = {
    model = 's_m_y_cop_01', -- موديل البيد اللي بيعبئ سلاحك
    coords = vector4(454.1459, -980.2617, 30.6896 -1.0, 90.0) -- الاحداثيات اللي بيكون فيها البيد (x, y, z, heading)
}
-- موقع models البيد موجود في هذا الرابط: https://docs.fivem.net/docs/game-references/ped-models/
Config.AllowedWeapons = { -- هنا تحط الاسلحة اللي تبي  يعبئها، اذا حطيت سلاح هنا بيكون  يقدر يعبئه، اذا ما حطيته ما راح يقدر يعبئه
    [`WEAPON_PISTOL`] = true,
    [`WEAPON_COMBATPISTOL`] = true,
    [`WEAPON_SMG`] = true,
    [`WEAPON_CARBINERIFLE`] = true,
    [`WEAPON_PUMPSHOTGUN`] = true,
    [`WEAPON_ASSAULTSHOTGUN`] = true,
    [`WEAPON_SPECIALCARBINE`] = true,
    [`WEAPON_BULLPUPRIFLE`] = true,
    [`WEAPON_ADVANCEDRIFLE`] = true,
    [`WEAPON_PISTOL_MK2`] = true,
    [`WEAPON_ASSAULTRIFLE`] = true,
    [`WEAPON_MINIGUN`] = true,
}
--[[
    اذا حبيت تضيف سلاح جديد، حط اسمه بين القوسين المربعين، وحط true بعده، يعني مثلا:
    [`WEAPON_RPG`] = true,
    اذا حبيت تمنع سلاح معين من التعبئة، حطه false بعده، يعني مثلا:
    [`WEAPON_PISTOL`] = false,
    موقع الاسلحة موجود في هذا الرابط: https://docs.fivem.net/docs/game-references/weapon-models/
]]--