LogToConsole("`0[`2Law`3Proxy`0]`9 PROXY STARTED")
package.path = package.path .. ";storage/emulated/0/android/data/launcher.powerkuy.growlauncher/files/ScriptLua?.lua"


-- VARIABLE SECTION=================

Pembatas = "add_smalltext|======================================================================================|left|"

-- FUNCTION SECTION================
function on_sendpacket(type, packet)

inputt = "action|input\n|text|"

function command(str)
    if packet:find(inputt .. str) then
        LogToConsole("`6" .. str)
        return true
    end
end

function log(str)
LogToConsole("`0[`2Law`3Proxy`0] `9"..str)
end

function checkitm(id)
for _, inv in pairs(GetInventory()) do 
if inv.id == id then 
return inv.amount 
end 
end 
return 0 
end

function wear(id)
pkt = {}
pkt.type = 10
pkt.value = id
SendPacketRaw(false, pkt)
end



function editConfigVariable(variableName, newValue)          
local file = io.open("storage/emulated/0/android/data/launcher.powerkuy.growlauncher/files/ScriptLua/LawModules/config.lua", "r")     if not file then         
log("Error: Could not open config.lua for reading!")         
return     
end       
local content = file:read("*all")     
file:close()        
local pattern = variableName .. " =%s*[%d%-]+"     
local newVariableLine = variableName .. " = " .. newValue     
content = content:gsub(pattern, newVariableLine)       
file = io.open("storage/emulated/0/android/data/launcher.powerkuy.growlauncher/files/ScriptLua/LawModules/config.lua", "w")     if not file then         
log("Error: Could not open config.lua for writing!")         
return     
end      
file:write(content)     
file:close()        
log("Config file has been updated: " .. variableName .. " = " .. newValue) 
end

function balance(jenis)
bgl = growtopia.checkInventoryCount(7188)
dl = growtopia.checkInventoryCount(1796)
totalDL = dl + bgl*100
wl = growtopia.checkInventoryCount(242)
totalWL = wl + totalDL*100
if jenis == "wlTotal" then
return totalWL
end
end

if packet:find("action|join_request") or command("/warp") or command("/wp") or command("/b") or command("/back") then
LogToConsole("`9World Lock Balance: `5"..balance("wlTotal"))
end


function reloadConfig()
package.loaded["config"] = nil

return require("config")

end
local config = reloadConfig()




-- COMMAND SECTION =================


-- /HELP
if command("/proxy") then
help_dialog = [[

text_scalling_string|hubmenuscallingextend

add_label_with_icon|big|`2Proxy Commands|left|1790|

add_spacer|small|

add_smalltext|======================================================================================|

add_spacer|small|
text_scaling_string|roleassets1234
add_button_with_icon|discord|Join Discord|staticframe|11186|
add_button_with_icon|spin|Roulette|staticframe|758|
add_button_with_icon||END_LIST|noflags|0|

add_spacer|small|

add_label_with_icon|small|`2Info:|left|660|

add_smalltext|`2/proxy `9(Show All Proxy Commands/This Page)|left|
add_smalltext|`2/news `9(Shows Proxy News & Commands)|
add_smalltext|`2/gazette `9(SOON)|
add_smalltext|`2/discord `9(Join LawProxy Discord For More Info)|left|

add_spacer|small|

add_label_with_icon|small|`2Customize:|left|7206|

add_smalltext|`4Not Available On Beta Version|

add_spacer|small|

add_label_with_icon|small|`2Main Features:|left|12264|

add_smalltext|`2/csn & /roulette `9(Roulette/Dice Settings Page)|
add_smalltext|`2/wrench `9(Wrench Mode Pull/Kick/Ban/Trade)|
add_smalltext|`2/scan `9(Free Extract O Snap With Wrench)|

add_spacer|small|

add_label_with_icon|small|`2Auto Hoster:|left|758|

add_spacer|small|

add_label_with_icon|small|`2Information:|left|11186|

add_spacer|small|

add_label_with_icon|small|`2Shortcuts:|left|2322|

add_spacer|small|

add_label_with_icon|small|`2Other:|left|3432|

add_smalltext|`2/cd [amount] `9(Drop World Locks With lSpesific Amount)|
add_smalltext|`2/dd [amount] `9(Drop Diamond Locks With Spesific Amount)|
add_smalltext|`2/bd [amount] `9(Drop Blue Gem Locks With Spesific Amount)|

add_spacer|small|

add_label_with_icon|small|`2Visual:|left|1784|

add_smalltext|`2/mod `9(Trough The Wall And Invisible, But Its Just Visual)|

add_spacer|small|

add_quick_exit
]]

growtopia.sendDialog(help_dialog)
return true
end


if packet:find("buttonClicked|discord") or command("/discord") then
discordLog = [[
add_label_with_icon|big|`cLvCode `6Community|right|11186|

add_smalltext|`3Join LvCode Community for free script and more info about LawProxy update, Click button on bellow for join LvCode Community Discord|

add_spacer|small|

add_url_button||LawProxy Discord|noflags|https://discord.gg/aPx57h6UJW|Would You Like To Join LvCode Discord Server?|0|0|
add_smalltext|alternate : discord.gg/aPx57h6UJW

add_spacer|small|

end_dialog||Thanks for the info!||
]]

growtopia.sendDialog(discordLog)
end


-- Drop

 local dlockID = 1796
if command("/dd") then
 txt = packet:gsub("action|input\n|text|/dd", "")
if txt == "" then
log("`2Write Amount")
else
dl = math.floor(txt) 
if checkitm(1796) < dl then
wear(7188)
wear(7188)
end
SendPacket(2, "action|drop\n|itemID|"..dlockID)
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..dlockID.."\nitem_count|"..txt)
log("`2Succes Drop`0"..txt.." `2Diamond Lock")
end
return true
end    

local ITEM_ID = 242
if command("/cd") then
txt = packet:gsub("action|input\n|text|/cd", "")
if txt == "" then
log("`2Write Amount")
else
wl = math.floor(txt) 
if checkitm(242) < wl then
wear(1796)
wear(1796)
end
SendPacket(2, "action|drop\n|itemID|"..ITEM_ID)
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..ITEM_ID.."\nitem_count|"..txt)
log("`2Succes Drop`0"..txt.." `2World Lock")
end
return true
end


local ITEM_ID2 = 7188
if command("/bd") then
txt = packet:gsub("action|input\n|text|/bd", "")
if txt == "" then
log("`2Write Amount")
else
SendPacket(2, "action|drop\n|itemID|"..ITEM_ID2)
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..ITEM_ID2.."\nitem_count|"..txt)
log("`2Succes Drop`0"..txt.." `2Blue Gem Lock")
end
return true
end

if command("/balance") or command("/bal") then
function checkamount(id)
for _, inv in pairs(GetInventory()) do
if inv.id == id then
return inv.amount
end
end
return 0
end
log("`0Your World Locks`0 : "..checkamount(242).." `9World Lock`0, "..checkamount(1796).." `cDiamond Lock`0, "..checkamount(7188).." `qBGL")
return true
end



--MOD
if command("/mod") and config.mod == 0 then
editConfigVariable("mod", 1)
editToggle("NoClip and Ghost", true)
log("`5@MODERATOR`9 MODE `2ON")
growtopia.notify("`5@MODERATOR`9 MODE `2ON")
return true
elseif command("/mod") and config.mod == 1 then
editConfigVariable("mod", 0)
editToggle("NoClip and Ghost", false)
log("`5@MODERATOR`9 MODE `4OFF")
growtopia.notify("`5@MODERATOR`9 MODE `4OFF")
return true
end



--SPIN/ROULETTE

if packet:find("buttonClicked|spin") or command("/spin") then
rouletteSet = [[
add_label_with_icon|big|`2Roulette Settings|left|758|

add_spacer|small|

]]..Pembatas..[[

add_spacer|small

add_checkbox|fast_spin|`2Fast Spin `9(Show Roulette Spin Number Before Roulette Stop Spinning)|]]..config.fastspin..[[|

add_checkbox|qq_num|`2QQ Number `9(Show QQ Number *FAST SPIN MUST BE ON)|]]..config.qq..[[|

add_checkbox|reme_num|`2reme Number `9(Show Reme Number *FAST SPIN MUST BE ON)|]]..config.reme..[[|

end_dialog|spin_settings|Cancel|Confirm|
]]

--growtopia.sendDialog(add_checkbox|fast_spin|`2Fast Spin`9 (Show Roulette Spin Number Before Roulette Stop Spinning).  |"..config.fastspin..")
growtopia.sendDialog(rouletteSet)
return true
end


if packet:find("spin_settings\nfast_spin|1") then
editConfigVariable("fastspin", 1)
end

if packet:find("spin_settings\nfast_spin|0") then
editConfigVariable("fastspin", 0)
end




--OTHER
if command("/scan") and config.scan == 1 then
editConfigVariable("scan", 0)
editToggle("Enable Dynamo Extrator", false)
log("Extract O Snap `4Off")
return true
elseif command("/scan") and config.scan == 0 then
editConfigVariable("scan", 1)
editToggle("Enable Dynamo Extrator", true)
log("Extract O Snap `2On`9, Select Wrench And Tap To Dropped Item")
return true
end

if packet:find("/id (.+)") then
id = packet:match("/id (.+)")
result = string.lower(id)
if findItemID(result) == 0 then
log("Item Not Found Or Blank")
end

if findItemID(result) ~= 0 and result ~= "pot o' gems" then
log(string.upper(result).." ID : "..findItemID(result))
end

if result == "pot o' gems" then
log("15460")
end
if result == "pot o' gems seed" then
log("15461")
end
return true
end

if command("/change") then
editConfigVariable("qq", 0)
return true
end

if command("/check") then
log("reme "..config.reme)
log("fast spin "..config.fastspin)
log("qq "..config.qq)
log("mod "..config.mod)
log("scan "..config.scan)
return true
end


end
-- VARIANT SECTION===============
function variantlist(var)    

function reloadConfig()
package.loaded["config"] = nil

return require("config")

end
config = reloadConfig()
        
-- DROP
        if var.v1 == "OnDialogRequest" then
        if var.v2:find("drop") and var.v2:find("242") then
        return true
        end
        end

        if var.v1 == "OnDialogRequest" then
        if var.v2:find("drop") and var.v2:find("1796") then
        return true
        end
        end

        if var.v1 == "OnDialogRequest" then
        if var.v2:find("drop") and var.v2:find("7188") then
        return true
        end
        end


-- SPIN

if config.fastspin == 1 then
if var.v1 == "OnTalkBubble" and var.v3:find("spun the wheel and got") then
    if var.v3:find("spun the wheel and got") and (var.v3:find("`2(%d+)``!") or var.v3:find("`4(%d+)``!") or var.v3:find("`b(%d+)``!")) then
varfs = {}
varfs.v1 = "OnTalkBubble"
varfs.v2 = var.v2
varfs.v3 = "`0[`2REAL`0]`7 "..var.v3
SendVariant(varfs)
return true
        else
varffs = {}
varffs.v1 = "OnTalkBubble"
varffs.v2 = var.v2
varffs.v3 = "`4[`4FAKE] "..var.v3
SendVariant(varffs)
return true
end
end

end


return false
end

AddHook (on_sendpacket, "OnSendPacket")
AddHook (variantlist, "OnVariant")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
