--[[
    Jan - UI Library
    wally - Script & Multi-Key Support
    Sezei - Contributor
    loafa - UI Toggle & Sustain Timings
--]]

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()

local framework, scrollHandler
while true do
	for _, obj in next, getgc(true) do
		if type(obj) == 'table' and rawget(obj, 'GameUI') then
			framework = obj;
			break
		end	
	end

	for _, module in next, getloadedmodules() do
		if module.Name == 'ScrollHandler' then
			scrollHandler = module;
			break;
		end
	end

	if (type(framework) == 'table') and (typeof(scrollHandler) == 'Instance') then
		break
	end

	wait(1)
end

local runService = game:GetService('RunService')
local userInputService = game:GetService('UserInputService')
local client = game:GetService('Players').LocalPlayer;
local random = Random.new()

local fastWait, fastSpawn, fireSignal, rollChance do
	-- https://eryn.io/gist/3db84579866c099cdd5bb2ff37947cec
	-- bla bla spawn and wait are bad 
	-- can also use bindables for the fastspawn idc

    function fastWait(t)
        local d = 0;
        while d < t do
            d += runService.RenderStepped:wait()
        end
    end

    function fastSpawn(f)
        coroutine.wrap(f)()
    end
	
	-- updated for script-ware or whatever
	-- attempted to update for krnl 
	local set_identity = (type(syn) == 'table' and syn.set_thread_identity) or setidentity or setthreadcontext
	function fireSignal(target, signal, ...)
		-- getconnections with InputBegan / InputEnded does not work without setting Synapse to the game's context level
		set_identity(2) 
		for _, signal in next, getconnections(signal) do
			if type(signal.Function) == 'function' and islclosure(signal.Function) then
				local scr = rawget(getfenv(signal.Function), 'script')
				if scr == target then
					pcall(signal.Function, ...)
				end
			end
		end
		set_identity(7)
	end

	-- uses a weighted random system
	-- its a bit scuffed rn but it works good enough

	function rollChance()
		local chances = {
			{ type = 'Sick', value = library.flags.sickChance },
			{ type = 'Good', value = library.flags.goodChance },
			{ type = 'Ok', value = library.flags.okChance },
			{ type = 'Bad', value = library.flags.badChance },
		}
		
		table.sort(chances, function(a, b) 
			return a.value > b.value 
		end)

		local sum = 0;
		for i = 1, #chances do
			sum += chances[i].value
		end

		if sum == 0 then
			-- forgot to change this before?
			-- fixed 6/5/21
			return chances[random:NextInteger(1, 4)].type 
		end

		local initialWeight = random:NextInteger(0, sum)
		local weight = 0;

		for i = 1, #chances do
			weight = weight + chances[i].value

			if weight > initialWeight then
				return chances[i].type
			end
		end

		return 'Sick' -- just incase it fails?
	end
end

local keyCodeMap = {}
for _, enum in next, Enum.KeyCode:GetEnumItems() do
	keyCodeMap[enum.Value] = enum
end

local chanceValues = {
	Sick = 96,
	Good = 92,
	Ok = 87,
	Bad = 77,
}

if shared._unload then
    pcall(shared._unload)
end

function shared._unload()
    if (shared._id) then
        pcall(runService.UnbindFromRenderStep, runService, shared._id)
    end
    
    if library.open then
        library:Close()
    end
    
    library.base:ClearAllChildren()
    library.base:Destroy()
end

shared._id = game:GetService('HttpService'):GenerateGUID(false)
runService:BindToRenderStep(shared._id, 1, function()
	if (not library.flags.autoPlayer) then return end
    if (typeof(framework.SongPlayer.CurrentlyPlaying) ~= 'Instance') then return end
    if (framework.SongPlayer.CurrentlyPlaying.ClassName ~= 'Sound') then return end

    local arrows = framework.UI:GetNotes()

    local count = framework.SongPlayer:GetKeyCount()
    local mode = count .. 'Key'

    local arrowData = framework.ArrowData[mode].Arrows

    local arrowData = framework.ArrowData[mode].Arrows
    for i, arrow in next, arrows do
        local ignoredNoteTypes = { Death = true, Mechanic = true, Poison = true }
		if (typeof(arrow.NoteDataConfigs) == 'table') then
		    if (ignoredNoteTypes[arrow.NoteDataConfigs.Type]) then
		        continue;
		    end
		end

		if (arrow.Side == framework.UI.CurrentSide) and (not arrow.Marked) and framework.SongPlayer.CurrentlyPlaying.TimePosition > 0 then 
		    local indice = (arrow.Data.Position % count)
			local position = indice 
		    
		    if (position) then
                local hitboxOffset = 0; do
                    local Settings = framework.Settings;
                    local Offset = (typeof(Settings) == "table") and Settings.HitboxOffset;
                    local Value = (typeof(Offset) == "table") and Offset.Value;
                    
                    if (typeof(Value) == "number") then hitboxOffset = Value; end
                    
                    hitboxOffset /= 1000
                end
                
                local songTime = framework.SongPlayer.CurrentTime; do
                    local Configs = framework.SongPlayer.CurrentSongConfigs;
                    local pbs = (typeof(Configs) == "table") and Configs.PlaybackSpeed;
                    
                    if (typeof(pbs) ~= "number") then pbs = 1; end
                    
                    songTime = songTime / pbs;
                end

                local noteTime = math.clamp((1 - math.abs(arrow.Data.Time - (songTime + hitboxOffset))) * 100, 0, 100)

				local hitChance = arrow._hitChance or rollChance();
				arrow._hitChance = hitChance;

				-- if (not chanceValues[hitChance]) then warn('invalid chance', hitChance) end
				if (arrow._hitChance ~= "Miss") and (noteTime >= chanceValues[arrow._hitChance]) then
				    fastSpawn(function()
    					arrow.Marked = true;
    					
                        local keyCode = keyCodeMap[arrowData[tostring(position)].Keybinds.Keyboard[1]] -- ty wally bb
    						
    					fireSignal(scrollHandler, userInputService.InputBegan, { KeyCode = keyCode, UserInputType = Enum.UserInputType.Keyboard }, false)
    
    					-- wait depending on the arrows length so the animation can play
    					if arrow.Data.Length > 0 then
    						fastWait(arrow.Data.Length)
    					else
    						fastWait(library.flags.sustainLength/1000) -- customizeable pog
    					end
    
    					fireSignal(scrollHandler, userInputService.InputEnded, { KeyCode = keyCode, UserInputType = Enum.UserInputType.Keyboard }, false)
    					arrow.Marked = false;
    				end)
				end
			end
		end
	end
end)

local uiToggle = userInputService.InputBegan:Connect(function(Input)
    if (Input.UserInputType == Enum.UserInputType.Keyboard) then
        local KeyCode = Input.KeyCode;
        if (KeyCode == Enum.KeyCode.RightControl) then
            library:Close()
        end
    end
end)

local window = library:CreateWindow('Main') do
	local folder = window:AddFolder('Autoplayer') do
		folder:AddToggle({ text = 'Enabled', flag = 'autoPlayer' })

		folder:AddSlider({ text = 'Sick %', flag = 'sickChance', min = 0, max = 100, value = 100 })
		folder:AddSlider({ text = 'Good %', flag = 'goodChance', min = 0, max = 100, value = 0 })
		folder:AddSlider({ text = 'Ok %', flag = 'okChance', min = 0, max = 100, value = 0 })
		folder:AddSlider({ text = 'Bad %', flag = 'badChance', min = 0, max = 100, value = 0 })
		folder:AddSlider({ text = 'Sustain (ms)', flag = 'sustainLength', min = 0, max = 100, value = 25 })
	end
	local folder = window:AddFolder('Other') do
		local instantStagePromptsCB = nil;
		folder:AddButton({ text = 'Instant Stage Prompts', callback = function()
			if (not instantStagePromptsCB) then
				function CheckInstance(d)
					if (d:IsA("ProximityPrompt") and d.HoldDuration > 0) then
						d.HoldDuration = 0;
					end
				end
				for _, d in pairs(workspace.Map.Stages:GetDescendants()) do
					coroutine.wrap(CheckInstance)(d)
				end
				instantStagePromptsCB = workspace.Map.Stages.DescendantAdded:Connect(CheckInstance)
			end
		end})
	end
end

local window = library:CreateWindow('Options & Credits') do
	window:AddButton({ text = "Close", callback = function()
	    pcall(shared._unload)
	    uiToggle:Disconnect()
	end})
	window:AddLabel({ text = 'Jan - UI Library' })
	window:AddLabel({ text = 'wally - OG Script' })
	window:AddLabel({ text = 'Sezei - Contributor' })
	window:AddLabel({ text = 'loafa - Extra Bits' }) -- ex. Sustain, toggle, etc.
end

library:Init()
