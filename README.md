# 🔫 ALI.M — Ammo Refill Script for QBCore

<div align="center">

![FiveM](https://img.shields.io/badge/FiveM-QBCore-blue?style=for-the-badge&logo=data:image/png;base64,)
![Version](https://img.shields.io/badge/Version-1.0.0-green?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)
![Lua](https://img.shields.io/badge/Lua-5.4-purple?style=for-the-badge&logo=lua)

**سكربت تعبئة ذخيرة الأسلحة العسكرية عن طريق ضابط شرطة NPC — مبني على QBCore Framework**

</div>

---

## 📋 الوصف

سكربت يتيح لضباط الشرطة (حسب الرتبة) تعبئة أسلحتهم العسكرية عن طريق التفاعل مع ضابط NPC ثابت في العالم. يعتمد السكربت على نظام أمان متعدد الطبقات يتحقق من الصلاحيات على كل من العميل والخادم.

---

## ✨ المميزات

- 🧍 ضابط NPC ثابت قابل للتخصيص (موديل + إحداثيات)
- 🎯 تعبئة الأسلحة المسموح بها فقط
- 🔐 نظام أمان مزدوج (Client + Server side)
- ⏳ شريط تحميل دائري قابل للإلغاء
- 🏷️ تحقق من الجوب والرتبة قبل كل عملية
- 📦 دعم لـ `ox_lib` للإشعارات و Progress Circle
- 🎮 تكامل مع `qb-target` للتفاعل مع البيد

---

## 📦 المتطلبات

| المكتبة | الرابط |
|---|---|
| [QBCore Framework](https://github.com/qbcore-framework/qb-core) | إطار العمل الأساسي |
| [ox_lib](https://github.com/overextended/ox_lib) | للإشعارات وشريط التحميل |
| [qb-target](https://github.com/qbcore-framework/qb-target) | للتفاعل مع البيد |

---

## 🚀 التثبيت

1. حمّل أو انسخ المجلد إلى مجلد `resources` في سيرفرك.
2. أضف السطر التالي في ملف `server.cfg`:
   ```
   ensure ALI.M-ammo-script
   ```
3. افتح ملف `config.lua` واضبط الإعدادات حسب سيرفرك (راجع قسم الإعداد أدناه).
4. أعد تشغيل الخادم أو استخدم أمر `refresh` ثم `start ALI.M-ammo-script`.

---

## ⚙️ الإعداد (`config.lua`)

```lua
Config.Job = 'police'        -- اسم الجوب المسموح له باستخدام السكربت
Config.MinGrade = 2          -- أدنى رتبة مسموح لها (2 = جندي أول وما فوق)
Config.RefillTime = 5000     -- وقت التعبئة بالمللي ثانية (5000 = 5 ثوانٍ)
Config.AmmoAmount = 999      -- كمية الذخيرة المضافة
Config.Distance = 3.0        -- المسافة المسموح بها للتفاعل (بالمتر)

Config.Ped = {
    model = 's_m_y_cop_01',  -- موديل البيد
    coords = vector4(x, y, z, heading)
}
```

### إضافة أو حذف أسلحة

```lua
Config.AllowedWeapons = {
    [`WEAPON_PISTOL`] = true,       -- مسموح
    [`WEAPON_ASSAULTRIFLE`] = true, -- مسموح
    [`WEAPON_RPG`] = false,         -- ممنوع
}
```

- قائمة موديلات البيد: [FiveM Ped Models](https://docs.fivem.net/docs/game-references/ped-models/)
- قائمة أسماء الأسلحة: [FiveM Weapon Models](https://docs.fivem.net/docs/game-references/weapon-models/)

---

## 🔒 نظام الأمان

| الطبقة | الموقع | الوظيفة |
|---|---|---|
| الأولى | Client | فحص الجوب والرتبة والمسافة والسلاح |
| الثانية | Server | إعادة التحقق من الجوب والرتبة والسلاح قبل المنح |
| الثالثة | Server | تسجيل أي محاولة تلاعب في الـ Console |

---

## 📁 هيكل الملفات

```
ALI.M-ammo-script/
├── client.lua        — منطق العميل (البيد، التفاعل، شريط التحميل)
├── server.lua        — منطق الخادم (التحقق، إضافة الذخيرة)
├── config.lua        — جميع الإعدادات القابلة للتخصيص
├── fxmanifest.lua    — ملف التعريف
└── README.md
```

---

## 🐛 المشاكل الشائعة

**البيد لا يظهر:**
تأكد أن الإحداثيات في `config.lua` صحيحة وأن الـ `z` ليست داخل الأرض.

**لا يظهر خيار التفاعل:**
تأكد أن `qb-target` مُشغّل قبل هذا السكربت في `server.cfg`.

**رسالة "غير مسموح":**
تحقق من أن قيمة `Config.Job` تطابق اسم الجوب في قاعدة البيانات تماماً، وأن رتبة اللاعب تساوي أو تتجاوز `Config.MinGrade`.

---

## 📝 الترخيص

هذا المشروع مرخص تحت رخصة [MIT](LICENSE) — راجع ملف `LICENSE` للتفاصيل.

---

## 👤 المطور

**ALI.M**

> إذا أعجبك السكربت، لا تنسَ تضع ⭐ على الريبو!
