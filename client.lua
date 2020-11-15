    local white = "#FFFFFF";
local sx,sy = guiGetScreenSize();
local panel = "login";
local bg = 1;
local bgs = {
    [1] = {
        ["start"] = {411.91317749023, -1545.4265136719, 31.213653564453, 408.63696289063, -1542.9384765625, 32.2734375},
        ["end"] = {411.91317749023, -1545.4265136719, 31.213653564453, 408.63696289063, -1542.9384765625, 32.2734375},
    },
    [2] = {
        ["start"] = {411.91317749023, -1545.4265136719, 31.213653564453, 408.63696289063, -1542.9384765625, 32.2734375},
        ["end"] = {411.91317749023, -1545.4265136719, 31.213653564453, 408.63696289063, -1542.9384765625, 32.2734375},
    }
}
local pPos = {
    [1] = {
        --skinid,x,y,z,rot,anim
        {0,1885.0447998047, -1371.0812988281, 13.569966316223,223,"dancing","dan_left_a"},
        {60,1887.4503173828, -1371.6748046875, 13.570111274719,78,"dancing","dan_loop_a"},
        {256,1886.6016845703, -1369.7010498047, 13.569628715515,0,"dancing","bd_clap"},
        {92,1889.9996337891, -1374.1151123047, 13.570707321167,134,"beach","sitnwait_loop_w"},
        {259,1891.1279296875, -1380.0042724609, 13.572145462036,75,"gangs","leanidle"},
    },
    [2] = {
        {0,1699.2810058594, -1937.7847900391, 13.564117431641,84},
        {60,1697.890625, -1937.8073730469, 13.553860664368,268},

        {50,1701.1260986328, -1950.0728759766, 14.1171875,186},
        {80, 1699.4487304688, -1950.0914306641, 14.1171875,186},

        {250, 1702.4349365234, -1940.7305908203, 13.562987327576,88,"gangs","leanidle"},

        {92,1668.1456298828, -1957.8814697266, 13.546875,355,"beach","sitnwait_loop_w"},
    }
}
local peds = {};
local vPos = {
    [1] = {
        {565,1892.4332275391, -1371.7772216797, 13.570136070251, 134},
        {527,1894.7976074219, -1380.4736328125, 13.5703125,80},
        {481,1886.1474609375, -1368.2061767578, 13.569263458252,88}, --BMX
    },
    [2] = {
        {565,1704.9750976563, -1940.7017822266, 13.569981575012,266},
    }
}
local vehs = {};
local oPos = {
    [1] = {
        {2231,1880.8092041016, -1370.0545654297, 13.569715499878-1,50},
        {2231,1874.3682861328, -1369.5866699219, 13.547034263611-1,-30}
    }
}
local objs = {};
local pedPos = {
    [1] = {408.63696289063, -1542.9384765625, 32.2734375, -120},
    [2] = {408.63696289063, -1542.9384765625, 32.2734375, -120},
}
local tick = 0;
local guis = {};
local guiTick = 0;
local clickTick = 0;
local x,y = 0,0;
local time = 200;
local close = false;
local ped = false;
local skins = {
    [1] = {7, 14, 15, 18, 19, 20, 23},
    [2] = {13,}
}
local selected = 1;
local gender = 1;
local camMove = false;
local music = false;

local dataSave = false;

local sX, sY = guiGetScreenSize()

local panelW, panelH = 928, 385
local panelX, panelY = sX/2 - 928/2, sY/2 - 385/2

--local checkedBox = guiCreateCheckBox()

dx = exports.fv_dx;
--[[
function checkBoxChecked()
    if(getElementType(checkedBox) == "gui-checkbox") then
        if(guiCheckBoxGetSelected(checkedBox)) then
            setSoundVolume(music, 0.0)
        else
            setSoundVolume(music, 0.25)
        end
    end
end
addEventHandler("onClientGUIClick", root, checkBoxChecked, false)
]]

addEventHandler("onClientResourceStart",getRootElement(),function(res)
    if getResourceName(res) == "fv_engine" or getThisResource() == res then 
		font = exports.fv_engine:getFont("rage", 14);
		font2 = exports.fv_engine:getFont("rage", 11);
		font3 = exports.fv_engine:getFont("rage", 18);
		font4 = exports.fv_engine:getFont("rage", 15);
		font5 = exports.fv_engine:getFont("rage", 12);
		font6 = exports.fv_engine:getFont("rage", 14);
		font7 = exports.fv_engine:getFont("rage", 12);
        font8 = exports.fv_engine:getFont("rage", 25);
        font9 = exports.fv_engine:getFont("rage", 25);
		sColor = {exports.fv_engine:getServerColor("servercolor",false)};
		sColor2 = exports.fv_engine:getServerColor("servercolor",true);
		red = {exports.fv_engine:getServerColor("red",false)};
		red2 = exports.fv_engine:getServerColor("red",true);
		green = {exports.fv_engine:getServerColor("green",false)};
		orange = {exports.fv_engine:getServerColor("orange",false)};
		blue = {exports.fv_engine:getServerColor("blue",false)};
		icons = exports.fv_engine:getFont("AwesomeFont",15);
    end
    if getThisResource() == res then 
        setElementData(localPlayer,"loggedIn",false);
		setCameraMatrix(0,0,0,0,0,0)
		fadeCamera(true)
        setElementDimension(localPlayer,getElementData(localPlayer,"char >> id") or math.random(0,9999));
        showChat(false);
        showCursor(true);
        removeEventHandler("onClientRender",root,render);
        addEventHandler("onClientRender",root,render);
		manageGUI("destroy")
		manageGUI("login")		
        panel = "login";
        tick = getTickCount();


        setElementData(localPlayer,"loggedIn",false);
		
        music = playSound("login.mp3",true);
        setSoundVolume(music, 0.25)


        loadLoginData();
    end
end);



addEventHandler ( "onClientRender", getRootElement(), onSoundPlayRender )     

function manageGUI(state)
    if state == "destroy" then 
		if dx:dxGetEdit("account.username") then 
			dx:dxDestroyEdit("account.username");
		end
		if dx:dxGetEdit("account.password") then 	
			dx:dxDestroyEdit("account.password");
		end
		
		if dx:dxGetEdit("register.username") then 
			dx:dxDestroyEdit("register.username");
		end
		if dx:dxGetEdit("register.password") then 
			dx:dxDestroyEdit("register.password");
		end
		if dx:dxGetEdit("register.password2") then 
			dx:dxDestroyEdit("register.password2");
		end
		if dx:dxGetEdit("register.email") then
			dx:dxDestroyEdit("register.email");
		end
    elseif state == "login" then	
		dx:dxCreateEdit("account.username","","Felhasználóneved",panelX+25, panelY+120, 214, 30,1,16);
		dx:dxCreateEdit("account.password","","Jelszavad",panelX+25, panelY+160, 214, 30,2,16);
    elseif state == "register" then 
		dx:dxCreateEdit("register.username","","Felhasználóneved",panelX+25, panelY+120, 214, 30,1,16);
		dx:dxCreateEdit("register.email","","Valós e-mailed",panelX+25, panelY+160, 214, 30,1,30);
		dx:dxCreateEdit("register.password","","Jelszavad",panelX+25, panelY+200, 214, 30,2,16);
		dx:dxCreateEdit("register.password2","","Jelszavad mégegyszer",panelX+25, panelY+240, 214, 30,2,16);
    elseif state == "charCreate" then 
        guis[1] = guiCreateEdit(-1000,-1000,0,0,"",false);
        guiEditSetMaxLength(guis[1],40);
        guis[2] = guiCreateEdit(-1000,-1000,0,0,"",false);
        guiEditSetMaxLength(guis[2],3);
        guis[3] = guiCreateEdit(-1000,-1000,0,0,"",false);
        guiEditSetMaxLength(guis[3],3);
        guis[4] = guiCreateEdit(-1000,-1000,0,0,"",false);
        guiEditSetMaxLength(guis[4],3);
    end
end
function isGUI(element) 
    local found = false;
    for k,v in pairs(guis) do 
        if isElement(v) then 
            if element == v then  
                found = k;
                break;
            end
        end
    end
    return found;
end
addEventHandler("onClientGUIChanged",getResourceRootElement(getThisResource()),function(element)
    local a = isGUI(element);
    if a then 
        activeGUI = a;
    end
end);

function saveLoginData()
     if dx:dxGetEdit("account.username") and dx:dxGetEdit("account.password") then 
        local username = dx:dxGetEditText("account.username");
        local pw = dx:dxGetEditText("account.password");
        if username ~= "" or pw ~= "" then 
            if fileExists("login.save") then 
                fileDelete("login.save");
            end
            local file = fileCreate("login.save");
            fileWrite(file,toJSON({username,pw}));
            fileClose(file);
        end
    end
end

function loadLoginData()
    if fileExists("login.save") then 
        local file = fileOpen("login.save",true);
        local temp = fromJSON(fileRead(file,10000));
        if dx:dxGetEdit("account.username") and dx:dxGetEdit("account.password") then 
			dx:dxEditSetText("account.username", temp[1])
			dx:dxEditSetText("account.password", temp[2])
            dataSave = true;
        end
        fileClose(file);
    end
end
addEventHandler("onResourceStop",resourceRoot,function()
    if not dataSave then 
        if fileExists("login.save") then 
            fileDelete("login.save");
        end
    end
end);

function render()
    if panel == "login" then 
		dxDrawImage(0, 0, sX, sY, "bg.png")
		dxDrawRectangle(panelX+11, panelY+27, 238, panelH, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+13, panelY+29, 234, panelH-4, tocolor(61, 61, 61, 255))
			
		dxDrawRectangle(panelX+13, panelY+panelH - 162, 234, 38, tocolor(44, 44, 44, 255))	
		dxDrawRectangle(panelX+13, panelY+panelH - 42, 234, 38, tocolor(44, 44, 44, 255))
			
		dxDrawRectangle(panelX+252, panelY+27, 687, 266, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+254, panelY+29, 683, 262, tocolor(61, 61, 61, 255))
		
		dxDrawRectangle(panelX+252, panelY+296, 227, 66, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+254, panelY+298, 223, 62, tocolor(61, 61, 61, 255))
		
		dxDrawRectangle(panelX+482, panelY+296, 227, 66, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+484, panelY+298, 223, 62, tocolor(61, 61, 61, 255))
		
		dxDrawRectangle(panelX+712, panelY+296, 227, 66, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+714, panelY+298, 223, 62, tocolor(61, 61, 61, 255))			
			
		dxDrawRectangle(panelX+252, panelY+365, 686, 47, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+254, panelY+367, 682, 43, tocolor(61, 61, 61, 255))
						
        if getKeyState("mouse1") and guiTick+300 < getTickCount() then 
			if exports.fv_engine:isInSlot(panelX+25, panelY+200, 20, 20) then 
                dataSave = not dataSave;
                if dataSave then 
                    saveLoginData();
                else 
                    if fileExists("login.save") then 
                        fileDelete("login.save");
                    end
                end
                guiTick = getTickCount();
            end
        end
		
        dxDrawRectangle(panelX+25, panelY+200, 20, 20,tocolor(22,22,22,150));
        if dataSave then 
            dxDrawText("",panelX+25, panelY+200, 20+panelX+25, 20+panelY+200,tocolor(sColor[1],sColor[2],sColor[3]),0.6,icons,"center","center");
        end
        dxDrawText("Jegyezze meg",panelX+60, panelY+200, panelX+60, 20+panelY+200,tocolor(255,255,255),1,font6,"left","center");
		
		dxDrawRectangle(panelX+25, panelY+230, 214, 25, tocolor(22,99,225,255))
        dxDrawRectangle(panelX+25, panelY+350, 214, 25, tocolor(22,99,225,255))
		dxDrawText("Bejelentkezés", panelX+25, panelY+230, 214 + panelX+25, 25+panelY+230, tocolor(0, 0, 0, 255), 1, font6, "center", "center", false, false, false, true)
        dxDrawText("Regisztráció", panelX + 11, panelY+panelH - 66, 238+panelX + 11, 88+panelY+panelH - 66, tocolor(0, 0, 0, 255), 1, font6, "center", "center")
			
		dxDrawText("Night Life Roleplay", panelX+11, panelY+35, 238 + panelX+11, panelH + panelY+40, tocolor(255, 255, 255, 255), 1,font9, "center", "top", false, false, false, true)
		dxDrawText("Bejelentkezés", panelX+11, panelY+80, 238 + panelX+11, panelH + panelY+70, tocolor(255, 255, 255, 255), 1, font4, "center", "top")
			
		--dxDrawText("Hatalmas szeretettel üdvözlünk téged a #1763e1Wave#ffffffGaming-en!", panelX+273, panelY+120, panelX+273, panelY+90, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
		--dxDrawText("#1763e1RP-ben #ffffffés #1763e1élményben #ffffffgazdag játékot kívánunk!", panelX+273, panelY+150, panelX+273, panelY+115, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("Most játszol először #1763e1MTA-val, esetleg még #1763e1kezdő #ffffffvagy? Tekintsd meg a bevezető #1763e1videónkat!", panelX+273, panelY+180, panelX+273, panelY+140, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("[YOUTUBE VIDEÓ LINK]", panelX+273, panelY+210, panelX+273, panelY+140, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
		
			
		dxDrawText("#1763e1", panelX+260, panelY+296, panelX+260, 66+panelY+296, tocolor(255, 255, 255, 255), 1, icons, "left", "center", false, false, false, true)
		dxDrawText("hamarosan", panelX+265, panelY+296, 227 + panelX+265, 66+panelY+296, tocolor(255, 255, 255, 255), 1, font6, "center", "center", false, false, false, true)
		dxDrawText("#1763e1", panelX+490, panelY+296, panelX+490, 66+panelY+296, tocolor(255, 255, 255, 255), 1, icons, "left", "center", false, false, false, true)
		dxDrawText("#ffffffdiscord.gg/QnzGSEt ", panelX+530, panelY+296, 227 + panelX+530, 66+panelY+296, tocolor(255, 255, 255, 255), 1, font7, "left", "center", false, false, false, true)
			
		dxDrawText("#1763e1", panelX+720, panelY+296, panelX+720, 66+panelY+296, tocolor(255, 255, 255, 255), 1, icons, "left", "center", false, false, false, true)
		dxDrawText("fb/nightliferoleplay2020", panelX+735, panelY+296, 227 + panelX+720, 66+panelY+296, tocolor(255, 255, 255, 255), 1, font6, "center", "center", false, false, false, true)
			
		dxDrawText("#1763e1", panelX+260, panelY+365, panelX+260, 47+panelY+365, tocolor(255, 255, 255, 255), 1, icons, "left", "center", false, false, false, true)
		dxDrawText("Hamarosan", panelX+260, panelY+365, 686 + panelX+260, 47+panelY+365, tocolor(255, 255, 255, 255), 1, font6, "center", "center", false, false, false, true)		

    elseif panel == "register" then 
        dxDrawImage(0, 0, sX, sY, "bg2.png")
 		dxDrawRectangle(panelX+11, panelY+27, 238, panelH, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+13, panelY+29, 234, panelH-4, tocolor(61, 61, 61, 255))
		
        
		dxDrawRectangle(panelX+13, panelY+panelH - 66, 234, 88, tocolor(61, 61, 61, 255))
        dxDrawRectangle(panelX+13, panelY+panelH - 42, 234, 38, tocolor(44, 44, 44, 255))
        dxDrawRectangle(panelX+25, panelY+350, 214, 25, tocolor(22,99,225,255))
		dxDrawText("Visszalépés", panelX + 11, panelY+panelH - 66, 238+panelX + 11, 88+panelY+panelH - 66, tocolor(0, 0, 0, 255), 1, font6, "center", "center")
			
		dxDrawRectangle(panelX+252, panelY+27, 687, 266, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+254, panelY+29, 683, 262, tocolor(61, 61, 61, 255))
		
		dxDrawRectangle(panelX+252, panelY+296, 227, 66, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+254, panelY+298, 223, 62, tocolor(61, 61, 61, 255))
		
		dxDrawRectangle(panelX+482, panelY+296, 227, 66, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+484, panelY+298, 223, 62, tocolor(61, 61, 61, 255))
		
		dxDrawRectangle(panelX+712, panelY+296, 227, 66, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+714, panelY+298, 223, 62, tocolor(61, 61, 61, 255))			
			
		dxDrawRectangle(panelX+252, panelY+365, 686, 47, tocolor(44, 44, 44, 255))
		dxDrawRectangle(panelX+254, panelY+367, 682, 43, tocolor(61, 61, 61, 255))
        dxDrawRectangle(panelX+13, panelY+panelH - 112, 234, 38, tocolor(44, 44, 44, 255))	
		dxDrawRectangle(panelX+25, panelY+280, 214, 25, tocolor(22,99,225,255))
		dxDrawText("Regisztráció", panelX+25, panelY+280, 214 + panelX+25, 25+panelY+280, tocolor(0, 0, 0, 200), 1, font6, "center", "center", false, false, false, true)
			
		dxDrawText("Night Life Roleplay", panelX+11, panelY+35, 238 + panelX+11, panelH + panelY+40, tocolor(255, 255, 255, 255), 1, font9, "center", "top", false, false, false, true)
		dxDrawText("Regisztráció", panelX+11, panelY+80, 238 + panelX+11, panelH + panelY+70, tocolor(255, 255, 255, 255), 1, font4, "center", "top")
			
		--dxDrawText("Üdvözlünk a #4c6ef5Regisztrációs felületen!", panelX+273, panelY+50, panelX+273, panelY+90, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("Itt tudsz #4c6ef5regisztrálni #fffffffiók-ot a szerverre! A karakter létrehozás az a következő lépés lesz.", panelX+273, panelY+80, panelX+273, panelY+115, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("Fontos, hogy #4c6ef5megjegyezhető #ffffffnevet, #4c6ef5biztonságos #ffffffjelszót és #4c6ef5valós #ffffffe-mail címet adj meg!", panelX+273, panelY+100, panelX+273, panelY+115, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("", panelX+273, panelY+130, panelX+273, panelY+90, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("Elfelejtetted a #1763e1fiók ID-det?", panelX+273, panelY+150, panelX+273, panelY+115, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("A játékmenet során a #1763e1képernyőd bal lenti oldalán #ffffffilletve a #1763e1dashboard-on #ffffffbelül tekintheted meg.", panelX+273, panelY+170, panelX+273, panelY+140, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("", panelX+273, panelY+200, panelX+273, panelY+90, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("Most játszol először #4c6ef5MTA-val, esetleg még #4c6ef5kezdő #ffffffvagy? Tekintsd meg a bevezető #4c6ef5videónkat!", panelX+273, panelY+220, panelX+273, panelY+140, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
        --dxDrawText("[YOUTUBE VIDEÓ LINK]", panelX+273, panelY+240, panelX+273, panelY+140, tocolor(255, 255, 255, 255), 1, font6, "left", "top", false, false, false, true)
		
			
		dxDrawText("#1763e1", panelX+260, panelY+296, panelX+260, 66+panelY+296, tocolor(255, 255, 255, 255), 1, icons, "left", "center", false, false, false, true)
		dxDrawText("hamarosan", panelX+265, panelY+296, 227 + panelX+265, 66+panelY+296, tocolor(255, 255, 255, 255), 1, font6, "center", "center", false, false, false, true)
		dxDrawText("#1763e1", panelX+490, panelY+296, panelX+490, 66+panelY+296, tocolor(255, 255, 255, 255), 1, icons, "left", "center", false, false, false, true)
		dxDrawText("#ffffffdiscord.gg/QnzGSEt ", panelX+530, panelY+296, 227 + panelX+530, 66+panelY+296, tocolor(255, 255, 255, 255), 1, font7, "left", "center", false, false, false, true)
			
		dxDrawText("#1763e1", panelX+720, panelY+296, panelX+720, 66+panelY+296, tocolor(255, 255, 255, 255), 1, icons, "left", "center", false, false, false, true)
		dxDrawText("fb/nightliferoleplay2020", panelX+735, panelY+296, 227 + panelX+720, 66+panelY+296, tocolor(255, 255, 255, 255), 1, font6, "center", "center", false, false, false, true)
			
		dxDrawText("#1763e1", panelX+260, panelY+365, panelX+260, 47+panelY+365, tocolor(255, 255, 255, 255), 1, icons, "left", "center", false, false, false, true)
		dxDrawText("Hamarosan", panelX+260, panelY+365, 686 + panelX+260, 47+panelY+365, tocolor(255, 255, 255, 255), 1, font6, "center", "center", false, false, false, true)		
		
    elseif panel == "charCreate" then 
      --  if not close then
            x,y = getScreenFromWorldPosition(getElementPosition(ped));
            if x and y then

                dxDrawRectangle(x-140,y-260,280,3,tocolor(sColor[1],sColor[2],sColor[3]));
                shadowedText("Karakter Készítés",x-140,y-285,x-140+280,0,tocolor(255,255,255),1,font,"center","top");

                dxDrawRectangle(x-140,y-250,30,30,tocolor(44,44,44,255));
                if gender == 1 then
                    dxDrawText("",x-140,y-250,x-140+30,y-250+30,tocolor(255,255,255),1,icons,"center","center");
                end
                shadowedText("Férfi",x-105,y-250,30,y-250+30,tocolor(255,255,255),1,font5,"left","center");

                dxDrawRectangle(x+85,y-250,30,30,tocolor(44,44,44,255));
                if gender == 2 then 
                    dxDrawText("",x+85,y-250,x+85+30,y-250+30,tocolor(255,255,255),1,icons,"center","center");
                end
                shadowedText("Nő",x+120,y-250,30,y-250+30,tocolor(255,255,255),1,font5,"left","center");


                local headx,heady = getScreenFromWorldPosition(getPedBonePosition(ped,8));
                if tonumber(headx) and tonumber(heady) then 
                    dxDrawLine(x-140,y-200,headx,heady,tocolor(0,0,0),4,false);
                end
                dxDrawRectangle(x-140,y-200,280,25,tocolor(44,44,44,255));
                if exports.fv_engine:isInSlot(x-140,y-200,20,25) then 
                    tooltip("Karakter Név");
                end
                dxDrawText(guiGetText(guis[1]),x-140,y-200,x-140+280,y-200+25,tocolor(255,255,255),1,font2,"center","center");
                if activeGUI == 1 then 
                    dxDrawText("|",x-140+dxGetTextWidth(guiGetText(guis[1]),1,font2),y-200,x-140+280,y-200+25,tocolor(255,255,255,200 * math.abs(getTickCount() % 1000 - 500)/500),1,font2,"center","center");
                end
                dxDrawText("",x-135,y-200,380,y-200+25,tocolor(255,255,255),1,icons,"left","center");

                shadowedText("Skin választás",x-60,y+180,x+30+30,0,tocolor(255,255,255),1,font5,"center","top");

                local leftColor = tocolor(255,255,255);
                if exports.fv_engine:isInSlot(x-60,y+200,30,30) then
                    leftColor = tocolor(sColor[1],sColor[2],sColor[3]);
                end
                dxDrawRectangle(x-60,y+200,30,30,tocolor(44,44,44,255)); --Balra
                dxDrawText("",x-60,y+200,x-60+30,y+200+30,leftColor,1,icons,"center","center");

                local rightColor = tocolor(255,255,255);
                if exports.fv_engine:isInSlot(x+30,y+200,30,30) then 
                    rightColor = tocolor(sColor[1],sColor[2],sColor[3]);
                end
                dxDrawRectangle(x+30,y+200,30,30,tocolor(44,44,44,255)); --Jobbra
                dxDrawText("",x+30,y+200,x+30+30,y+200+30,rightColor,1,icons,"center","center");

                local pedx,pedy = getScreenFromWorldPosition(getPedBonePosition(ped,2));
                --local pedx1,pedy1 = getScreenFromWorldPosition(getPedBonePosition(ped,3));
                --dxDrawLine(x-103,y-40,pedx1,pedy1,tocolor(0,0,0),4,false);
                dxDrawLine(x-103,y+32.5,pedx,pedy,tocolor(0,0,0),4,false);
                dxDrawRectangle(x-200,y-50,100,25,tocolor(44,44,44,255));
                local magassag = guiGetText(guis[2]);
                if not tonumber(magassag) then guiSetText(guis[2],"") end;
                if tonumber(magassag) and tonumber(magassag) > 200 then guiSetText(guis[2],"") end;
                dxDrawText(guiGetText(guis[2]),x-175,y-50,100,y-50+30,tocolor(255,255,255),1,font2,"left","center");
                dxDrawText("cm",x-200,y-50,x-175+70,y-50+30,tocolor(255,255,255),1,font2,"right","center");
                if exports.fv_engine:isInSlot(x-200,y-50,20,25) then 
                    tooltip("Magasság (Max: 200cm)");
                end
                --dxDrawText("",x-197,y-50,100,y-50+25,tocolor(255,255,255),1,icons,"left","center");
                dxDrawImage(x-197,y-47,19,19,"height.png");

                dxDrawRectangle(x-200,y+20,100,25,tocolor(44,44,44,255));
                local suly = guiGetText(guis[3]); 
                if not tonumber(suly) then guiSetText(guis[3],"") end;
                if tonumber(suly) and tonumber(suly) > 180 then guiSetText(guis[3],"") end;
                dxDrawText(guiGetText(guis[3]),x-175,y+20,100,y+20+30,tocolor(255,255,255),1,font2,"left","center");
                dxDrawText("kg",x-200,y+20,x-175+70,y+20+30,tocolor(255,255,255),1,font2,"right","center");

                if exports.fv_engine:isInSlot(x-200,y+20,20,25) then 
                    tooltip("Testsúly (Max: 180kg)");
                end
                dxDrawText("",x-197,y+20,100,y+20+25,tocolor(255,255,255),1,icons,"left","center");

                dxDrawRectangle(x-200,y+90,100,25,tocolor(44,44,44,255));
                local eletkor = guiGetText(guis[4]);
                if not tonumber(eletkor) then guiSetText(guis[4],"") end;
                if tonumber(eletkor) and tonumber(eletkor) > 60 then guiSetText(guis[4],"") end;
                dxDrawText(guiGetText(guis[4]),x-175,y+90,100,y+90+30,tocolor(255,255,255),1,font2,"left","center");
                dxDrawText("év",x-200,y+90,x-175+70,y+90+30,tocolor(255,255,255),1,font2,"right","center");
                if exports.fv_engine:isInSlot(x-200,y+90,20,25) then 
                    tooltip("Életkor (Max: 60év)");
                end
                dxDrawText("",x-197,y+90,100,y+90+25,tocolor(255,255,255),1,icons,"left","center");

                if getKeyState("mouse1") and guiTick+300 < getTickCount() then
                    if exports.fv_engine:isInSlot(x-140,y-200,280,25) then 
                        guiBringToFront(guis[1]);
                        activeGUI = 1;
                        guiTick = getTickCount();
                    elseif exports.fv_engine:isInSlot(x-200,y-50,100,25) then 
                        guiBringToFront(guis[2]);
                        activeGUI = 2;
                        guiTick = getTickCount();
                    elseif exports.fv_engine:isInSlot(x-200,y+20,100,25) then 
                        guiBringToFront(guis[3]);
                        activeGUI = 3;
                        guiTick = getTickCount();
                    elseif exports.fv_engine:isInSlot(x-200,y+90,100,25) then 
                        guiBringToFront(guis[4]);
                        activeGUI = 4;
                        guiTick = getTickCount();
                    end
                end

                local bColor = tocolor(sColor[1],sColor[2],sColor[3],150);
                if exports.fv_engine:isInSlot(x-100,y+240,200,70) then 
                    bColor = tocolor(sColor[1],sColor[2],sColor[3]);
                end
                dxDrawRectangle(x-100,y+240,200,70,bColor);
                shadowedText("Karakter Elkészítése",x-100,y+240,x-100+200,y+240+70,tocolor(255,255,255),1,font,"center","center");
                dxDrawBorder(x-100,y+240,200,70,2,tocolor(0,0,0));
          --  end
        end        
    end

end

addEventHandler("onClientClick",root,function(button,state)
    if button == "left" and state == "down" then 

        if panel == "login" then 
            if exports.fv_engine:isInSlot(panelX+25, panelY+230, 214, 25) then --Login
                if clickTick+500 > getTickCount() then 
                    exports.fv_infobox:addNotification("warning","Ne ilyen gyors!")
                    return 
                end
                tick = getTickCount();
                clickTick = getTickCount();
                local name,pw = dx:dxGetEditText("account.username"), dx:dxGetEditText("account.password");
                if name == "" or pw == "" then exports.fv_infobox:addNotification("warning","Mezők kitöltése kötelező!") return end;
                if dataSave then 
                    saveLoginData();
                end
				
                triggerServerEvent("acc.login",localPlayer, localPlayer, name, pw);
			

            end
           if exports.fv_engine:isInSlot(panelX+13, panelY+panelH - 66, 234, 88) then --Register		   
                if clickTick+1500 > getTickCount() then return end;
				manageGUI("destroy")
				manageGUI("register")				
				panel = "register"
				tick = getTickCount();
                clickTick = getTickCount();				
            end

        end
        if panel == "register" then  			
            if exports.fv_engine:isInSlot(panelX+13, panelY+panelH - 66, 234, 88) then --Back 		
                if clickTick+1500 > getTickCount() then return end;	
				manageGUI("destroy")
				manageGUI("login")					
				panel = "login"		
                tick = getTickCount();
                clickTick = getTickCount();
            end
            if exports.fv_engine:isInSlot(panelX+25, panelY+280, 214, 25) then --Register
                if clickTick+5000 > getTickCount() then 
                    exports.fv_infobox:addNotification("warning","Ne ilyen gyors!")
                    return 
                end
                clickTick = getTickCount();
                local name,pw,pw2,mail = dx:dxGetEditText("register.username"),dx:dxGetEditText("register.password"),dx:dxGetEditText("register.password2"),dx:dxGetEditText("register.email");
                if name == "" or pw == "" or pw2 == "" or mail == "" then exports.fv_infobox:addNotification("warning","Mezők kitöltése kötelező!") return end;
                if pw ~= pw2 then exports.fv_infobox:addNotification("warning","A két jelszó eltér egymástól!") return end;
                if not string.find(mail,"@") then exports.fv_infobox:addNotification("warning","E-mail cím érvénytelen!") return end;
                triggerServerEvent("acc.register",localPlayer,localPlayer,name,pw,mail);
                print("Register trigger from " .. getPlayerName(localPlayer))
            end
        end
        if panel == "charCreate" then 
            if exports.fv_engine:isInSlot(x-140,y-250,30,30) then --Male
                if gender ~= 1 then 
                    gender = 1;
                    selected = math.random(1,#skins[gender]);
                    setElementModel(ped,skins[gender][selected]);
                end
            elseif exports.fv_engine:isInSlot(x+85,y-250,30,30) then --Females
                if gender ~= 2 then 
                    gender = 2;
                    selected = math.random(1,#skins[gender]);
                    setElementModel(ped,skins[gender][selected]);
                end
            end

            if exports.fv_engine:isInSlot(x-100,y+240,200,70) then --Create Character
                local name = guiGetText(guis[1]):gsub("_"," ");
                local height = guiGetText(guis[2]);
                local weight = guiGetText(guis[3]);
                local age = guiGetText(guis[4]);
                if name == "" or height == "" or weight == "" or age == "" then 
                    exports.fv_infobox:addNotification("warning","Mezők kitöltése kötelező!");
                    return;
                end
                if tonumber(height) < 140 or tonumber(weight) < 40 or tonumber(age) < 17 or string.len(name) < 10 then 
                    exports.fv_infobox:addNotification("warning","Megadott adatok nem megfelelőek, nézd át az adatokat és próbáld újra.");
                    return;
                end
                triggerServerEvent("acc.charCreate",localPlayer,localPlayer,name,height,weight,age,getElementModel(ped),gender);
            end

            --Skin választás--
            if exports.fv_engine:isInSlot(x-60,y+200,30,30) then 
                local s = selected;
                if s-1 <= 0 then 
                    selected = #skins[gender];
                else 
                    selected = selected - 1;
                end
                setElementModel(ped,skins[gender][selected]);
            end
            if exports.fv_engine:isInSlot(x+30,y+200,30,30) then 
                local s = selected;
                if s+1 > #skins[gender] then 
                    selected = 1
                else 
                    selected = selected + 1;
                end
                setElementModel(ped,skins[gender][selected]);
            end
            --Skin választás vége--
        end
    end
end);

local showLoading = false

addEvent("acc.return",true);
addEventHandler("acc.return",root,function(a)
    close = a;
    tick = getTickCount();
    clickTick = getTickCount();
    if a == "charCreate" then 
        startCharCreate();
    end
    if a == "charCheck" then 
        triggerServerEvent("acc.Spawn",localPlayer,localPlayer);

        showChat(false);
        showCursor(false);
        removeEventHandler("onClientRender",root,render);
        panel = "off";
       -- startSpawning();
	   addEventHandler("onClientRender",root,loadRender);
	   showLoading = true
        if isElement(music) then 
            destroyElement(music);
        end
        fadeCamera(true);
		manageGUI("destroy")
    end
	if a == "registerFinish" then
		manageGUI("destroy")
		manageGUI("login")
		panel = "login"
	end
end);

function startCharCreate()
    local pos = bgs[bg]["start"];
    local pos2 = bgs[bg]["end"];
    smoothMoveCamera(pos[1],pos[2],pos[3],pos[4],pos[5],pos[6],pos2[1],pos2[2],pos2[3],pos2[4],pos2[5],pos2[6],3000);
	manageGUI("destroy")
	manageGUI("charCreate")
	panel = "charCreate"
    if isElement(ped) then
        destroyElement(ped);
    end
    selected = math.random(1,#skins[gender]);
    ped = createPed(skins[gender][selected],pedPos[bg][1],pedPos[bg][2],pedPos[bg][3],pedPos[bg][4]);
    setElementDimension(ped,getElementDimension(localPlayer));
    setPedAnimation(ped, "ON_LOOKERS", "wave_loop",-1,true,false,false,false);
end

local logoW, logoH = 485, 485
local waveX, waveY = sx/2 - logoW/2, sy/1 - logoH/1
local bgH = 70
local logoX, logoY = sx/2 - logoW/2, sy/2 - logoH/2

local logoLoading = 0;
local loadingPercent = 0;
function loadRender()
    dxDrawImage(0, 0, sX, sY, "bg.png")
    if getElementData(localPlayer,"togHUD") then 
        setElementData(localPlayer,"togHUD",false);
        showChat(false);
    end
	if (logoLoading < 485) then
		logoLoading = logoLoading + 1
	elseif (logoLoading == 485) then
		startSpawning()
		removeEventHandler("onClientRender", root, loadRender)
	end
	dxDrawImageSection(waveX, waveY, logoLoading, bgH, 0, 0, logoLoading, bgH, "2.png")
	dxDrawImage(logoX, logoY, logoW, logoH, "1.png")
end


function startSpawning()
	if getElementData(localPlayer,"togHUD") then 
        setElementData(localPlayer,"togHUD",false);
        showChat(false);
	end	
		
	local x,y,z = getElementPosition(localPlayer);
	setCameraMatrix(x,y,z+150,x,y,z);	
	playSound("boom.mp3",false);
	logoLoading = 0
	showLoading = false	
	setTimer(function()
		local x,y,z = getElementPosition(localPlayer);
		setCameraMatrix(x,y,z+20,x,y,z);
		playSound("boom.mp3",false);
		setTimer(function()
			local x,y,z = getElementPosition(localPlayer);
			setCameraMatrix(x,y,z+10,x,y,z);
			playSound("boom.mp3",false);
				setTimer(function()
					showChat(true);
					setCameraTarget(localPlayer);
					local pos = fromJSON(getElementData(localPlayer,"char >> position"));
					setElementPosition(localPlayer,pos[1],pos[2],pos[3]);
					setElementInterior(localPlayer,pos[5]);
					setElementDimension(localPlayer,pos[4]);
					setElementFrozen(localPlayer,false);
					setElementData(localPlayer,"togHUD",true);
				end,1000,1)
		end,0,1)
	end,100,1)
end


--UTILS--
addCommandHandler("getcampos",function(command)
	local x, y, z, lx, ly, lz = getCameraMatrix();
	outputChatBox(exports.fv_engine:getServerSyntax("CameraMatrix","servercolor").."  "..x..","..y..","..z..","..lx..","..ly..","..lz,255,255,255,true);
end)
function shadowedText(text,x,y,w,h,color,fontsize,font,aligX,alignY)
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x,y+1,w,h+1,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true) 
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x,y-1,w,h-1,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true)
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x-1,y,w-1,h,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true) 
    dxDrawText(text:gsub("#%x%x%x%x%x%x",""),x+1,y,w+1,h,tocolor(0,0,0,255),fontsize,font,aligX,alignY, false, false, false, true) 
    dxDrawText(text,x,y,w,h,color,fontsize,font,aligX,alignY, false, false, false, true)
end
function toPassword(password)
    if password then
        local length = utfLen(password)
        return string.rep("*", length)
    else 
        return "";
    end
end
function tooltip(text)
	local cx,cy = getCursorPosition();
	cx,cy = cx*sx,cy*sy;
	cx,cy = cx+10,cy+10;
	local width = dxGetTextWidth(text,1,font4)+10;
	dxDrawRectangle(cx-5,cy,width,18,tocolor(255,255,255,200),true);
	dxDrawText(text,cx-5,cy,(cx-5)+width,cy+20,tocolor(0,0,0),1,font4,"center","center",false,false,true,true);
end
function dxDrawBorder(x, y, w, h, radius, color) 
	dxDrawRectangle(x - radius, y, radius, h, color)
	dxDrawRectangle(x + w, y, radius, h, color)
	dxDrawRectangle(x - radius, y - radius, w + (radius * 2), radius, color)
	dxDrawRectangle(x - radius, y + h, w + (radius * 2), radius, color)
end

--Camera Move--
local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
        removeEventHandler("onClientPreRender",root,camRender)
        --setCameraTarget(localPlayer, localPlayer)
        camMove = false
	end
end
function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	end
end
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
    addEventHandler("onClientPreRender",root,camRender, true, "low")
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"Linear")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"Linear")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
    setTimer(destroyElement,time,1,sm.object2)
    camMove = true;
	return true
end

setTimer(
    function()
        if not getElementData(localPlayer, "afk") and getElementData(localPlayer,"loggedIn") then
            local oPlayTime = getElementData(localPlayer, "char >> playedtime")
            setElementData(localPlayer, "char >> playedtime", oPlayTime + 1)
        end
    end, 60 * 1000, 0
)
