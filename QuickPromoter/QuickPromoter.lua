--[[ 
Description: QuickPromoter let's you search for guild members by name and promote/demote them.
Developed by: Artenides-Arathor
Date: 2020-12-21
--]]


GuildMembers = {}
DisplayedMembers = {}
DisplayedRefs = 0

local function starts_with(str, start)
  str = string.lower(str)
  start = string.lower(start)
  return str:sub(1, #start) == start
end

function HideAllResultElements()


  char_g1:Hide()
  DownButton1:Hide()
  UpButton1:Hide()
  char_g2:Hide()
  DownButton2:Hide()
  UpButton2:Hide()
  char_g3:Hide()
  DownButton3:Hide()
  UpButton3:Hide()
  char_g4:Hide()
  DownButton4:Hide()
  UpButton4:Hide()
  char_g5:Hide()
  DownButton5:Hide()
  UpButton5:Hide()

end

function DisplayMembers()

  HideAllResultElements()

  for i=1,table.getn(DisplayedMembers) do
    
    if(i==1) then 
      char_g1:Show()
      char_g1:SetText(DisplayedMembers[i])
      DownButton1:Show()
      UpButton1:Show()
    end
    if(i==2) then 
      char_g2:Show()
      char_g2:SetText(DisplayedMembers[i])
      DownButton2:Show()
      UpButton2:Show()
    end
    if(i==3) then 
      char_g3:Show()
      char_g3:SetText(DisplayedMembers[i])
      DownButton3:Show()
      UpButton3:Show()
    end    
    if(i==4) then 
      char_g4:Show()
      char_g4:SetText(DisplayedMembers[i])
      DownButton4:Show()
      UpButton4:Show()
    end    
    if(i==5) then 
      char_g5:Show()
      char_g5:SetText(DisplayedMembers[i])
      DownButton5:Show()
      UpButton5:Show()
    end
    
    --local curFrame = _G("char_g"..i)
    --curFrame:Show()
    --curFrame:SetText(DisplayedMembers[i])

    
  end


end

function UpdateMemberList()
  
  local start = QP_Search:GetText()
  if(string.len(start) <= 1) then return end
  DisplayedMembers = {}

  print("Changed ".. start)
  
  table.foreach(GuildMembers, function(k,name) 
    if(starts_with(name, start)) then table.insert(DisplayedMembers, name) end
    --if(table.getn(DisplayedMembers) > 3) then break end
  end)

  print(table.getn(DisplayedMembers))
  DisplayMembers()
end


function InitUI()
  local UIConfig = CreateFrame("Frame", "MainFrame", UIParent, "BasicFrameTemplate");

  UIConfig:SetSize(300,360); -- width, height
  UIConfig:SetPoint("CENTER", UIParent, "CENTER"); -- point, relativeFrame, relativePoint, xOffset, yOffset

  UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY");
  UIConfig.title:SetFontObject("GameFontHighlight");
  UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0);
  UIConfig.title:SetText("QuickPromoter by Artenides");

  UIConfig:SetMovable(true)
  UIConfig:EnableMouse(true)
  UIConfig:RegisterForDrag("LeftButton")
  UIConfig:SetScript("OnDragStart", UIConfig.StartMoving)
  UIConfig:SetScript("OnDragStop", UIConfig.StopMovingOrSizing)

  UIConfig.searchField = CreateFrame("EditBox", "QP_Search", UIConfig, "InputBoxTemplate")
  UIConfig.searchField:SetPoint("TOPLEFT", 20, -25);
  UIConfig.searchField:SetSize(160, 80)
  UIConfig.searchField:SetMultiLine(false)
  UIConfig.searchField:SetAutoFocus(false) -- dont automatically focus
  UIConfig.searchField:SetFontObject("ChatFontNormal")
  UIConfig.searchField:SetScript("OnTextChanged", function(self)
    UpdateMemberList()
  end)

  local char1 = MainFrame:CreateFontString("char_g1", "OVERLAY", "GameFontNormal")
  char1:SetPoint("TOPLEFT", 20, -100 )
  --char1:SetText("C1")  
  _G["char_g1"]=char1
  
  local down1 = CreateFrame("Button", "DownButton1", UIConfig)
  down1:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]])
  down1:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]])
  down1:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  down1:SetSize(25, 25)
  down1:SetPoint("TOPLEFT", 180, -95 )

  local up1 = CreateFrame("Button", "UpButton1", UIConfig)
  up1:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Down]])
  up1:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Up]])
  up1:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  up1:SetSize(25, 25)
  up1:SetPoint("TOPLEFT", 210, -95 )


  local char2 = MainFrame:CreateFontString("char2", "OVERLAY", "GameFontNormal")
  char2:SetPoint("TOPLEFT", 20, -135 )
  --char2:SetText("C2")  
  _G["char_g2"]=char2
  
  local down2 = CreateFrame("Button", "DownButton2", UIConfig)
  down2:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]])
  down2:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]])
  down2:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  down2:SetSize(25, 25)
  down2:SetPoint("TOPLEFT", 180, -130 )

  local up2 = CreateFrame("Button", "UpButton2", UIConfig)
  up2:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Down]])
  up2:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Up]])
  up2:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  up2:SetSize(25, 25)
  up2:SetPoint("TOPLEFT", 210, -130 )

  local char3 = MainFrame:CreateFontString("char3", "OVERLAY", "GameFontNormal")
  char3:SetPoint("TOPLEFT", 20, -170 )
  --char3:SetText("C3")  
  _G["char_g3"]=char3

  local down3 = CreateFrame("Button", "DownButton3", UIConfig)
  down3:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]])
  down3:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]])
  down3:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  down3:SetSize(25, 25)
  down3:SetPoint("TOPLEFT", 180, -165 )

  local up3 = CreateFrame("Button", "UpButton3", UIConfig)
  up3:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Down]])
  up3:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Up]])
  up3:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  up3:SetSize(25, 25)
  up3:SetPoint("TOPLEFT", 210, -165 )


  local char4 = MainFrame:CreateFontString("char4", "OVERLAY", "GameFontNormal")
  char4:SetPoint("TOPLEFT", 20, -205 )
  --char4:SetText("C4")  
  _G["char_g4"]=char4
  
  local down4 = CreateFrame("Button", "DownButton4", UIConfig)
  down4:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]])
  down4:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]])
  down4:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  down4:SetSize(25, 25)
  down4:SetPoint("TOPLEFT", 180, -200 )

  local up4 = CreateFrame("Button", "UpButton4", UIConfig)
  up4:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Down]])
  up4:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Up]])
  up4:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  up4:SetSize(25, 25)
  up4:SetPoint("TOPLEFT", 210, -200 )
  
  local char5 = MainFrame:CreateFontString("char5", "OVERLAY", "GameFontNormal")
  char5:SetPoint("TOPLEFT", 20, -240 )
  --char5:SetText("C5")
  _G["char_g5"]=char5  
  
  local down5 = CreateFrame("Button", "DownButton5", UIConfig)
  down5:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]])
  down5:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]])
  down5:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  down5:SetSize(25, 25)
  down5:SetPoint("TOPLEFT", 180, -235 )

  local up5 = CreateFrame("Button", "UpButton5", UIConfig)
  up5:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Down]])
  up5:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollUp-Up]])
  up5:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]])
  up5:SetSize(25, 25)
  up5:SetPoint("TOPLEFT", 210, -235 )
  
  HideAllResultElements()
end

function InitMemberList()
  local i = 1

  while (GetGuildRosterInfo(i) ~= nil) do
    name, rankName, rankIndex, level, classDisplayName, zone, publicNote, officerNote, isOnline, status, class, achievementPoints, achievementRank, isMobile, canSoR, repStanding, GUID = GetGuildRosterInfo(i);
    table.insert(GuildMembers, name)
    i = i + 1;
  end
  table.sort(GuildMembers)

end





InitMemberList()
InitUI()