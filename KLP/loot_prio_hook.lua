BINDING_HEADER_DKP = "Keepers_Loot_Priority";

GameTooltip:HookScript("OnTooltipSetItem", function(tooltip, ...)
 local itemname, itemlink = tooltip:GetItem()
 if itemlink then
  priority = search_for_item(itemlink:match("item:(%d+):"))
 end
 if priority then
  prio = string.format("%s", priority)
  if C_Item.GetItemQualityByID(itemlink) == 5 then prio = "Prio: " .. UnitName("player") end
  tooltip:AddLine(prio, 0, 1, 0, true)
 end
end)

ItemRefTooltip:HookScript("OnTooltipSetItem", function(tooltip, ...)
 local itemname, itemlink = tooltip:GetItem()
 if itemlink then
  priority = search_for_item(itemlink:match("item:(%d+):"))
 end
 if priority then
  prio = string.format("%s", priority)
  if C_Item.GetItemQualityByID(itemlink) == 5 then prio = "Prio: " .. UnitName("player") end
  tooltip:AddLine(prio, 0, 1, 0, true)
 end
end)

local AddonPrefix = "KeepersLP";

local function RLP_comms(self, event, prefix, message, channel, sender)
 if event == "CHAT_MSG_ADDON" then
  if (prefix ~= AddonPrefix) then return end
  -- Here we received some shit for us, now deal with it 
  if tonumber(message) > KLP_version then 
   print(sender .. " hat eine neuere KLP version - ich nerve solange bis du updatest!")
  else return end
 elseif event == "PLAYER_LOGIN" then -- register Addonprefix
  local successfulRequest = C_ChatInfo.RegisterAddonMessagePrefix(AddonPrefix)
 elseif event == "PLAYER_ENTERING_WORLD" then -- send 
  C_ChatInfo.SendAddonMessage(AddonPrefix, KLP_version, "GUILD")
 end
end
 
local RLPFrame = CreateFrame("Frame")
RLPFrame:RegisterEvent("CHAT_MSG_ADDON")
RLPFrame:RegisterEvent("PLAYER_LOGIN")
RLPFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
RLPFrame:SetScript("OnEvent", RLP_comms)