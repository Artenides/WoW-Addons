--[[ 
Description: Guild Roster Spy is a lightweight addon to export data about the members of the guild.
Developed by: Artenides-Arathor
Date: 2020-12-13
--]]

local UIConfig = CreateFrame("Frame", "CrenUI_BuffFrame", UIParent, "BasicFrameTemplateWithInset");

UIConfig:SetSize(350,360); -- width, height
UIConfig:SetPoint("CENTER", UIParent, "CENTER"); -- point, relativeFrame, relativePoint, xOffset, yOffset

UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY");
UIConfig.title:SetFontObject("GameFontHighlight");
UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0);
UIConfig.title:SetText("GuildRosterSpy by Artenides");

UIConfig:SetMovable(true)
UIConfig:EnableMouse(true)
UIConfig:RegisterForDrag("LeftButton")
UIConfig:SetScript("OnDragStart", UIConfig.StartMoving)
UIConfig:SetScript("OnDragStop", UIConfig.StopMovingOrSizing)

UIConfig.nameCheckButton = CreateFrame("CheckButton", "nameCheckButton_GlobalName", UIConfig, "ChatConfigCheckButtonTemplate");
UIConfig.nameCheckButton:SetPoint("TOPLEFT", 20, -65);
UIConfig.nameCheckButton:SetChecked("TRUE");
UIConfig.nameCheckButton:Disable();
getglobal(UIConfig.nameCheckButton:GetName() .. 'Text'):SetText("Character Name");

UIConfig.classCheckButton = CreateFrame("CheckButton", "classCheckButton_GlobalName", UIConfig, "ChatConfigCheckButtonTemplate");
UIConfig.classCheckButton:SetPoint("TOP",UIConfig.nameCheckButton, 0, -20);
UIConfig.classCheckButton:SetChecked("TRUE");
getglobal(UIConfig.classCheckButton:GetName() .. 'Text'):SetText("Class");

UIConfig.levelCheckButton = CreateFrame("CheckButton", "levelCheckButton_GlobalName", UIConfig, "ChatConfigCheckButtonTemplate");
UIConfig.levelCheckButton:SetPoint("TOP",UIConfig.classCheckButton, 0, -20);
UIConfig.levelCheckButton:SetChecked("TRUE");
getglobal(UIConfig.levelCheckButton:GetName() .. 'Text'):SetText("Level");

UIConfig.rankCheckButton = CreateFrame("CheckButton", "rankCheckButton_GlobalName", UIConfig, "ChatConfigCheckButtonTemplate");
UIConfig.rankCheckButton:SetPoint("TOP",UIConfig.levelCheckButton, 0, -20);
UIConfig.rankCheckButton:SetChecked("TRUE");
getglobal(UIConfig.rankCheckButton:GetName() .. 'Text'):SetText("Rank");

UIConfig.lastonlineCheckButton = CreateFrame("CheckButton", "lastonlineCheckButton_GlobalName", UIConfig, "ChatConfigCheckButtonTemplate");
UIConfig.lastonlineCheckButton:SetPoint("TOP",UIConfig.rankCheckButton, 0, -20);
UIConfig.lastonlineCheckButton:SetChecked("TRUE");
getglobal(UIConfig.lastonlineCheckButton:GetName() .. 'Text'):SetText("Last Online");

-- UI Save Button
UIConfig.saveButton = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate");
UIConfig.saveButton:SetPoint("CENTER", UIConfig, "BOTTOM", 0, 40);
UIConfig.saveButton:SetSize(240,40);
UIConfig.saveButton:SetText("Save Guild Members Data"); 		-- Dirctly communicates to the button's main FontString object
UIConfig.saveButton:SetNormalFontObject("GameFontNormalLarge");
UIConfig.saveButton:SetHighlightFontObject("GameFontHighlightLarge");
UIConfig.saveButton:SetScript("OnClick", function(self, arg1)
    DumpData()
end)


function DumpData()

CollectedData = {}


local i, tmax, tname, years, months, days, hours, toff = 1, 0, "placeholder";
while (GetGuildRosterInfo(i) ~= nil) do
    years, months, days, hours = GetGuildRosterLastOnline(i);
    years, months, days, hours = years and years or 0, months and months or 0, days and days or 0, hours and hours or 0;
    toff = (((years*12)+months)*30.5+days)*24+hours;
    name, rankName, rankIndex, level, classDisplayName, zone, publicNote, officerNote, isOnline, status, class, achievementPoints, achievementRank, isMobile, canSoR, repStanding, GUID = GetGuildRosterInfo(i);
    
            
    local gdata = name;
    if(classCheckButton_GlobalName:GetChecked()) then gdata = gdata .. "," .. class end
    if(levelCheckButton_GlobalName:GetChecked()) then gdata = gdata .. "," .. level end
    if(rankCheckButton_GlobalName:GetChecked()) then gdata = gdata .. "," .. rankName end
    if(lastonlineCheckButton_GlobalName:GetChecked()) then gdata = gdata .. "," .. toff end
    --print(gdata)
            
	tinsert(CollectedData, format("%s", gdata))
    i = i + 1;
end

print("Data was collected for ".. i .. " guild members. Logout to save data.")
	
end