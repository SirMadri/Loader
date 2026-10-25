-- Script Path: game:GetService("ReplicatedStorage").Controllers.Game.TapController
-- Took 0.17s to decompile.
-- Executor: Volt (1.3.19.4)

local ContextActionService_upv_1 = game:GetService("ContextActionService")
local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local TapResultState_upv_1 = require(ReplicatedStorage_1.Shared.Core.TapResultState)
local tbl_upv_1 = {}
local OnboardingFlow_upv_1 = require(ReplicatedStorage_1.Shared.Progression.OnboardingFlow)
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local AutoClickerPrice_upv_1 = require(ReplicatedStorage_1.Modules.Client.Game.AutoClickerPrice)
local ButtonEffects_upv_1 = require(ReplicatedStorage_1.Modules.Client.Common.ButtonEffects)
local ClickFx_upv_1 = require(ReplicatedStorage_1.Modules.Client.Game.ClickFx)
local DataController_upv_1 = require(ReplicatedStorage_1.Controllers.Core.DataController)
local GameConfig_1 = require(ReplicatedStorage_1.Shared.Core.GameConfig)
local HudController_upv_1 = require(ReplicatedStorage_1.Controllers.UI.HudController)
local FormatNumber_upv_1 = require(ReplicatedStorage_1.Modules.Client.Common.FormatNumber)
local ClientComm_1 = require(ReplicatedStorage_1.Packages.Comm).ClientComm
local MessageController_upv_1 = require(ReplicatedStorage_1.Controllers.UI.MessageController)
local NotificationController_upv_1 = require(ReplicatedStorage_1.Controllers.UI.NotificationController)
local SkillTreeController_upv_1 = require(ReplicatedStorage_1.Controllers.Game.SkillTreeController)
local InputController_upv_1 = require(ReplicatedStorage_1.Controllers.Core.InputController)
local InputHub_upv_1 = require(ReplicatedStorage_1.Modules.Client.Core.InputHub)
local SoundController_upv_1 = require(ReplicatedStorage_1.Controllers.Audio.SoundController)
local TapCursor_upv_1 = require(ReplicatedStorage_1.Modules.Client.Game.TapCursor)
local TapEffects_upv_1 = require(ReplicatedStorage_1.Modules.Client.Game.TapEffects)
local TapIdleFade_upv_1 = require(ReplicatedStorage_1.Modules.Client.Game.TapIdleFade)
local TriggerHold_upv_1 = require(ReplicatedStorage_1.Modules.Client.Core.TriggerHold)
local MicroGamepad_upv_1 = require(ReplicatedStorage_1.Modules.Client.Core.MicroGamepad)
local ControllerHints_upv_1 = require(ReplicatedStorage_1.Modules.Client.Common.ControllerHints)
local ActiveTreatConfig_upv_1 = require(ReplicatedStorage_1.Shared.Items.ActiveTreatConfig)
local ComboStages_upv_1 = require(ReplicatedStorage_1.Shared.Progression.ComboStages)
local TapFormula_upv_1 = require(ReplicatedStorage_1.Shared.Progression.TapFormula)
local SkillTreeFormula_upv_1 = require(ReplicatedStorage_1.Shared.Progression.SkillTreeFormula)
local tbl_2 = {}
local u1 = ClientComm_1.new(ReplicatedStorage_1.RemoteServices, false, "TapService"):BuildObject()
local u2 = ClientComm_1.new(ReplicatedStorage_1.RemoteServices, false, "AutoClickService"):BuildObject()
local Game_upv_1 = nil
local Tap_upv_1 = nil
local Auto_upv_1 = nil
local u3 = nil
local u4 = nil
local u5 = nil
local u6 = nil
local u7 = false
local u8 = Color3.fromRGB(85, 230, 95)
local u9 = Color3.fromRGB(150, 158, 172)
local u10 = nil
local tbl_upv_3 = {ToastAt = -math.huge, Gap = 60}
local u11 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u12 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u13 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local tbl_upv_4 = {}
local u14 = 0
local u15 = -math.huge
local u16 = 0
local u17 = nil
local u18 = 0
local u19 = 0
local tbl_upv_5 = {}
local tbl_upv_6 = {}
local u20 = nil
local ClickFxInterval_upv_1 = GameConfig_1.ClickFxInterval
local TouchTapSlop_upv_1 = InputHub_upv_1.TouchTapSlop
local u21 = false
local tbl_upv_7 = {}
local u22 = nil
local u23 = -math.huge
local u24 = nil
local u25 = false
local u26 = 1
local u27 = nil
local Rebirths_upv_1 = 0
local Multiplier_upv_1 = 1
local u28 = 1
local u29 = 1
local u30 = 1
local u31 = 1
local u32 = 0
local u33 = -math.huge
local u34 = nil
local u35 = nil
local u36 = nil
local tbl_upv_8 = {}
local tbl_upv_9 = {}
local function tapAmountText(a1) --[[ name: tapAmountText, line: 168, upvalues: FormatNumber_upv_1 (copy, index: 1) ]]
    return (("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(a1), 1e+06, true)))
end
local u37 = nil
local function setTapAmount(a1) --[[ name: setTapAmount, line: 175, upvalues: FormatNumber_upv_1 (copy, index: 1), u37 (ref, index: 2), Tap_upv_1 (ref, index: 3) ]]
    local v1 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(a1), 1e+06, true))
    if v1 == u37 then
        return
    end
    u37 = v1
    Tap_upv_1.Main.Amount.Text = v1
    local Amount_1 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
    if Amount_1 == nil then
        return
    end
    if Amount_1:IsA("TextLabel") then
        Amount_1.Text = v1
    end
end
local function runAmountCelebration(a1, a2, a3) --[[ name: runAmountCelebration, line: 184 ]]
    task.spawn(function() end)
end
local function animateAmount(a1) --[[ name: animateAmount, line: 263, upvalues: u24 (ref, index: 1), u26 (ref, index: 2), RunService_upv_1 (copy, index: 3) ]]
    if u24 ~= nil then
        u24:Disconnect()
        u24 = nil
    end
    local _ = u26
    local v3 = os.clock()
    local v2 = RunService_upv_1.Heartbeat:Connect(function() end)
    u24 = v2
end
local function updatePreviewAmount(a1, a2) --[[ name: updatePreviewAmount, line: 280, upvalues: u27 (ref, index: 1), u26 (ref, index: 2), FormatNumber_upv_1 (copy, index: 3), u37 (ref, index: 4), Tap_upv_1 (ref, index: 5), u24 (ref, index: 6), RunService_upv_1 (copy, index: 7) ]]
    local v3 = u27
    u27 = a1
    local v4 = nil
    if v3 ~= nil then
        if a1 == v3 then
            return false
        end
        if u24 ~= nil then
            u24:Disconnect()
            u24 = nil
        end
        local _ = u26
        local v7 = os.clock()
        local v5 = RunService_upv_1.Heartbeat:Connect(function() end)
        u24 = v5
        if u27 < a1 then
            task.spawn(function() end)
        end
        return true
    else
        u26 = a1
        v4 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(a1), 1e+06, true))
        local v6 = nil
        if v4 ~= u37 then
            u37 = v4
            Tap_upv_1.Main.Amount.Text = v4
            v6 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
            if v6 ~= nil and v6:IsA("TextLabel") then
                v6.Text = v4
            end
        end
        return false
    end
end
local function activePetClickMultiplier(a1) --[[ name: activePetClickMultiplier, line: 294, upvalues: ActiveTreatConfig_upv_1 (copy, index: 1) ]]
    local v7 = 1
    for key_1, value_1 in a1.Items.ActiveTreats or {} do
        local v8 = ActiveTreatConfig_upv_1[key_1]
        if type(value_1) ~= "number" or not (value_1 > 0) or v8 == nil then
            continue
        end
        if v8.Type == "PetClicks" then
            v7 = v7 + v8.Multiplier
        end
    end
    return v7
end
local function refreshPreview(a1) --[[ name: refreshPreview, line: 305, upvalues: u29 (ref, index: 1), activePetClickMultiplier (copy, index: 2), Players_upv_1 (copy, index: 3), u28 (ref, index: 4), TapFormula_upv_1 (copy, index: 5), u7 (ref, index: 6), Multiplier_upv_1 (ref, index: 7), u31 (ref, index: 8), HudController_upv_1 (copy, index: 9), u27 (ref, index: 10), Rebirths_upv_1 (ref, index: 11), Tap_upv_1 (ref, index: 12), u26 (ref, index: 13), u30 (ref, index: 14), FormatNumber_upv_1 (copy, index: 15), u37 (ref, index: 16), u24 (ref, index: 17), RunService_upv_1 (copy, index: 18) ]]
    u29 = activePetClickMultiplier(a1)
    local v9 = Players_upv_1.LocalPlayer:GetAttribute("TotemClicksBoost")
    if type(v9) == "number" then
        u28 = v9
    end
    local v10 = ((not u7) and 1) or Multiplier_upv_1
    local v11 = TapFormula_upv_1.GetAmount(a1, 1, v10, u28, u29)
    u31 = v11
    HudController_upv_1:SetClickMultiplier(v11)
    local Rebirths_2 = a1.Statistics.Rebirths
    local _ = (u27 ~= nil) and (Rebirths_2 ~= Rebirths_upv_1)
    Rebirths_upv_1 = Rebirths_2
    if Tap_upv_1 == nil then
        return
    end
    if Tap_upv_1.Parent ~= nil then
        local v12, v13 = nil, nil
        if Tap_upv_1.Main.CriticalIcon.Visible ~= true then
            v12 = u27
            u27 = v11
            local v14 = nil
            if v12 == nil then
                u26 = v11
                v14 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(v11), 1e+06, true))
                if v14 == u37 then
                    return
                end
                u37 = v14
                Tap_upv_1.Main.Amount.Text = v14
                local Amount_2 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
                if Amount_2 ~= nil and Amount_2:IsA("TextLabel") then
                    Amount_2.Text = v14
                    return
                end
            elseif v11 ~= v12 then
                if u24 ~= nil then
                    u24:Disconnect()
                    u24 = nil
                end
                local v16 = u26
                local v17 = os.clock()
                local v15 = RunService_upv_1.Heartbeat:Connect(function() end)
                u24 = v15
                if u27 < v11 then
                    task.spawn(function() end)
                end
            end
        else
            u27 = v11
            u26 = v11
            v13 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil((v11 * 10) * u30), 1e+06, true))
            if v13 == u37 then
                return
            end
            u37 = v13
            Tap_upv_1.Main.Amount.Text = v13
            local Amount_3 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
            if Amount_3 ~= nil and Amount_3:IsA("TextLabel") then
                Amount_3.Text = v13
                return
            end
        end
    end
end
local tbl_upv_10 = {}
local u38 = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local function bumpClickStreak() --[[ name: bumpClickStreak, line: 385, upvalues: u33 (ref, index: 1), u32 (ref, index: 2), TapEffects_upv_1 (copy, index: 3) ]]
    local v16 = os.clock()
    if v16 - u33 > 0.8 then
        u32 = 0
    end
    u32 = u32 + 1
    u33 = v16
    TapEffects_upv_1:SetClickStreak(u32)
end
local u39 = Random.new()
local function playTapSounds() --[[ name: playTapSounds, line: 399, upvalues: SoundController_upv_1 (copy, index: 1), u39 (copy, index: 2) ]]
    SoundController_upv_1:Play("Taps", u39:NextNumber(0.94, 1.06), 1.25)
    SoundController_upv_1:Play("Click", u39:NextNumber(0.9, 1.1), 0.17)
end
local u40 = 0
local u41 = -math.huge
local function nextButtonClickSpeed() --[[ name: nextButtonClickSpeed, line: 427, upvalues: u41 (ref, index: 1), u40 (ref, index: 2) ]]
    local v17 = os.clock()
    local v18 = v17 - u41
    u41 = v17
    local v19 = ((v18 > 0.6) and 0) or (u40 + ((1 / v18) - u40) * 0.5)
    u40 = v19
    return ((math.clamp((u40 - 2) / 5, 0, 1) * 0.6000000000000001) + 1) * 0.9
end
local u42 = nil
local function playWorldClick(a1) --[[ name: playWorldClick, line: 442, upvalues: u41 (ref, index: 1), u40 (ref, index: 2), SoundController_upv_1 (copy, index: 3), u42 (ref, index: 4) ]]
    local v20 = os.clock()
    local v21 = v20 - u41
    u41 = v20
    local v22 = ((v21 > 0.6) and 0) or (u40 + ((1 / v21) - u40) * 0.5)
    u40 = v22
    local u43 = ((math.clamp((u40 - 2) / 5, 0, 1) * 0.6000000000000001) + 1) * 0.9
    SoundController_upv_1:Play("Click", u43, 0.75)
    if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
        task.delay(
            0.05,
            function() --[[ line: 449, upvalues: SoundController_upv_1 (copy, index: 1), u43 (copy, index: 2) ]]
                SoundController_upv_1:Play("Click2", u43, 0.75)
            end
        )
    else
        u42 = u43
    end
end
local function squashTapButton(a1) --[[ name: squashTapButton, line: 458, upvalues: Tap_upv_1 (ref, index: 1), u34 (ref, index: 2), u35 (ref, index: 3), TweenService_upv_1 (copy, index: 4), Players_upv_1 (copy, index: 5), u36 (ref, index: 6) ]]
    local Main_1 = Tap_upv_1.Main
    if u34 == nil or u34.Parent == nil then
        local v23 = Instance.new("UIScale")
        v23.Name = "TS2TapSquash"
        v23.Parent = Main_1
        u34 = v23
        local tbl_11 = {Scale = 1}
        u35 = TweenService_upv_1:Create(v23, TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), tbl_11)
    end
    u35:Cancel()
    u34.Scale = 0.92
    u35:Play()
    local v24
    if a1 == nil then
        v24 = math.clamp((Players_upv_1.LocalPlayer:GetMouse().X - (Main_1.AbsolutePosition.X + (Main_1.AbsoluteSize.X / 2))) / math.max(Main_1.AbsoluteSize.X, 1), -1, 1)
    else
        v24 = a1
    end
    if u36 == nil then
        local tbl_12 = {Rotation = 0}
        u36 = TweenService_upv_1:Create(Main_1, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_12)
    end
    u36:Cancel()
    Main_1.Rotation = v24 * 4
    u36:Play()
end
local function padLean(a1) --[[ name: padLean, line: 496, upvalues: Tap_upv_1 (ref, index: 1) ]]
    local Main_2 = Tap_upv_1.Main
    local CurrentCamera_1 = workspace.CurrentCamera
    return (math.clamp((a1.X - (Main_2.AbsolutePosition.X + (Main_2.AbsoluteSize.X / 2))) / math.max(((CurrentCamera_1 ~= nil) and (CurrentCamera_1.ViewportSize.X / 2)) or (Main_2.AbsoluteSize.X), 1), -1, 1))
end
local function sendTap(a1, a2, a3, a4, a5) --[[ name: sendTap, line: 512, upvalues: TapIdleFade_upv_1 (copy, index: 1), OnboardingFlow_upv_1 (copy, index: 2), DataController_upv_1 (copy, index: 3), Players_upv_1 (copy, index: 4), u14 (ref, index: 5), ClickFxInterval_upv_1 (copy, index: 6), TapEffects_upv_1 (copy, index: 7), ClickFx_upv_1 (copy, index: 8), Tap_upv_1 (ref, index: 9), ButtonEffects_upv_1 (copy, index: 10), u15 (ref, index: 11), u33 (ref, index: 12), u32 (ref, index: 13), HudController_upv_1 (copy, index: 14), SoundController_upv_1 (copy, index: 15), u39 (copy, index: 16), u26 (ref, index: 17), u19 (ref, index: 18), tbl_upv_5 (copy, index: 19), u20 (ref, index: 20), u1 (copy, index: 21), tbl_upv_6 (copy, index: 22) ]]
    TapIdleFade_upv_1.Pressed()
    if OnboardingFlow_upv_1.IsPending(DataController_upv_1:GetReplica().Data) or Players_upv_1.LocalPlayer:GetAttribute("MiningActive") == true or Players_upv_1.LocalPlayer:GetAttribute("AtDigsite") == true or Players_upv_1.LocalPlayer:GetAttribute("DiggingActive") == true or Players_upv_1.LocalPlayer:GetAttribute("ColosseumActive") == true then
        return "Blocked"
    end
    local v25 = os.clock()
    local v26 = v25 - u14 < ClickFxInterval_upv_1
    local v27 = not (a5) or v26 or TapEffects_upv_1:PickPadSpot()
    if a3 then
        local Request_1 = ClickFx_upv_1.Request
        local v28 = "Press"
        local v29
        if v27 == nil then
            v29 = (a5 and 0) or Tap_upv_1
        else
            local _ = Tap_upv_1.Main
            local v32 = workspace.CurrentCamera
            v29 = math.clamp((v27.X - (Tap_upv_1.Main.AbsolutePosition.X + Tap_upv_1.Main.AbsoluteSize.X / 2)) / math.max(workspace.CurrentCamera ~= nil and workspace.CurrentCamera.ViewportSize.X / 2 or Tap_upv_1.Main.AbsoluteSize.X, 1), -1, 1)
        end
        Request_1(v28, v29)
        if a5 then
            ButtonEffects_upv_1:Press(Tap_upv_1.Button)
        end
    end
    if v26 then
        return "Throttled"
    end
    u14 = v25
    u15 = v25
    if a3 then
        ClickFx_upv_1.Request("Ripple", Tap_upv_1)
    end
    local v30 = true
    if a1 == "button_hold" then
        v26 = v30
    else
        v26 = a1 == "screen_hold"
    end
    local v31 = os.clock()
    if v31 - u33 > 0.8 then
        u32 = 0
    end
    u32 = u32 + 1
    u33 = v31
    TapEffects_upv_1:SetClickStreak(u32)
    HudController_upv_1:PulseTap()
    if a2 then
        TapEffects_upv_1:NoteManualInput(a4, v26)
    elseif v27 ~= nil then
        TapEffects_upv_1:NotePadTap(v27)
    end
    v27 = Tap_upv_1.Main.CriticalIcon.Visible == true
    if v27 then
        SoundController_upv_1:Play("Critical")
        TapEffects_upv_1:PredictManualTap(Tap_upv_1.Main.Amount.Text, true)
        Tap_upv_1.Main.CriticalIcon.Visible = false
        Tap_upv_1.Main.Icon.Visible = true
    else
        SoundController_upv_1:Play("Taps", u39:NextNumber(0.94, 1.06), 1.25)
        SoundController_upv_1:Play("Click", u39:NextNumber(0.9, 1.1), 0.17)
        TapEffects_upv_1:PredictManualTap(Tap_upv_1.Main.Amount.Text, false, u26)
    end
    u19 = u19 + 1
    for key_2, value_2 in tbl_upv_5 do
        if v25 - value_2.At >= 2 then
            tbl_upv_5[key_2] = nil
        end
    end
    tbl_upv_5[u19] = {EffectsPlayed = true, Critical = v27, At = v25}
    if v27 then
        u20 = u19
    end
    u1.TapRequested:Fire({Auto = false, ClientSequence = u19, Source = a1})
    for _, value_3 in tbl_upv_6 do
        task.spawn(value_3, v27, a1)
    end
    return "Accepted"
end
local function canClickAnywhere(a1) --[[ name: canClickAnywhere, line: 162, upvalues: tbl_upv_9 (copy, index: 1), OnboardingFlow_upv_1 (copy, index: 2), tbl_upv_8 (copy, index: 3), SkillTreeFormula_upv_1 (copy, index: 4) ]]
    if next(tbl_upv_9) == nil and not (OnboardingFlow_upv_1.IsPending(a1)) then
        if OnboardingFlow_upv_1.IsGuided(a1) then
            return true
        end
        local v32 = true
        if next(tbl_upv_8) == nil then
            v32 = SkillTreeFormula_upv_1.CanClickAnywhere(a1)
        end
        return v32
    end
    return false
end
local function tapButtonShown() --[[ name: tapButtonShown, line: 582, upvalues: Tap_upv_1 (ref, index: 1) ]]
    local Button_1 = Tap_upv_1.Button
    while Button_1 ~= nil and (Button_1:IsA("GuiObject")) do
        if Button_1.Visible then
            Button_1 = Button_1.Parent
            continue
        end
        return false
    end
    local v33 = (Button_1 ~= nil) and (Button_1:IsA("ScreenGui") and (Button_1.Enabled))
    return v33
end
local function holdInPlace(a1) --[[ name: holdInPlace, line: 595, upvalues: TouchTapSlop_upv_1 (copy, index: 1), Tap_upv_1 (ref, index: 2), GuiService_upv_1 (copy, index: 3) ]]
    local Position_1 = a1.Input.Position
    local v34
    if not a1.OnButton then
        return (Position_1 - a1.Origin).Magnitude <= TouchTapSlop_upv_1
    end
    local Button_2 = Tap_upv_1.Button
    local AbsolutePosition_1 = Button_2.AbsolutePosition
    v34 = Button_2:FindFirstAncestorWhichIsA("ScreenGui")
    if v34 ~= nil then
        AbsolutePosition_1 = ((v34.IgnoreGuiInset) and (AbsolutePosition_1 - GuiService_upv_1:GetGuiInset())) or AbsolutePosition_1
    end
    local v35 = AbsolutePosition_1 - Vector2.new(TouchTapSlop_upv_1, TouchTapSlop_upv_1)
    local v36 = AbsolutePosition_1 + Button_2.AbsoluteSize + Vector2.new(TouchTapSlop_upv_1, TouchTapSlop_upv_1)
    return (v35.X <= Position_1.X) and ((Position_1.X <= v36.X) and ((v35.Y <= Position_1.Y) and (Position_1.Y <= v36.Y)))
end
local function holdStillDown(a1, a2) --[[ name: holdStillDown, line: 613, upvalues: holdInPlace (copy, index: 1) ]]
    local UserInputState_1 = a1.Input.UserInputState
    if UserInputState_1 ~= Enum.UserInputState.End and UserInputState_1 ~= Enum.UserInputState.Cancel then
        if a1.Repeating then
            return true
        elseif holdInPlace(a1) then
            if a2 - a1.Started >= 0.25 then
                a1.Repeating = true
            end
            return true
        else
            return false
        end
    end
    return false
end
local function clearTouchHolds() --[[ name: clearTouchHolds, line: 622, upvalues: tbl_upv_7 (copy, index: 1), u22 (ref, index: 2) ]]
    table.clear(tbl_upv_7)
    if u22 == nil then
        return
    end
    u22:Disconnect()
    u22 = nil
end
local function markHoldTap(a1) --[[ name: markHoldTap, line: 630, upvalues: u23 (ref, index: 1) ]]
    local v37 = u23 + 0.16666666666666666
    local v38
    if a1 - v37 <= 0.03333333333333333 then
        v38 = v37
    else
        v38 = a1
    end
    u23 = v38
end
local function stepTouchHolds() --[[ name: stepTouchHolds, line: 635, upvalues: tbl_upv_7 (copy, index: 1), holdInPlace (copy, index: 2), u22 (ref, index: 3), u23 (ref, index: 4), tapButtonShown (copy, index: 5), u21 (ref, index: 6), sendTap (copy, index: 7) ]]
    local v39 = os.clock()
    for n_1 = #tbl_upv_7, 1, -1 do
        local v40 = tbl_upv_7[n_1]
        local UserInputState_2 = v40.Input.UserInputState
        local v41 = nil
        if UserInputState_2 == Enum.UserInputState.End or UserInputState_2 == Enum.UserInputState.Cancel then
            v41 = false
            if not (v41) then
                table.remove(tbl_upv_7, n_1)
            end
        end
        if v40.Repeating then
            v41 = true
        elseif holdInPlace(v40) then
            if v39 - v40.Started >= 0.25 then
                v40.Repeating = true
            end
            v41 = true
        else
            v41 = false
        end
        if not (v41) then
            table.remove(tbl_upv_7, n_1)
        end
    end
    if #tbl_upv_7 == 0 then
        table.clear(tbl_upv_7)
        if u22 ~= nil then
            u22:Disconnect()
            u22 = nil
        end
    elseif not (v39 - u23 < 0.16666666666666666) then
        local _ = nil
        local v42 = nil
        for v47, value_4 in tbl_upv_7 do
            if value_4.Repeating then
                if value_4.OnButton then
                    local v43 = tapButtonShown()
                    if v43 then
                        v42 = u23 + 0.16666666666666666
                        local v44
                        if v39 - v42 <= 0.03333333333333333 then
                            v44 = v42
                        else
                            v44 = v39
                        end
                        u23 = v44
                        u21 = true
                        local v45 = nil
                        sendTap("button_hold", true, true, v45.Input)
                        return
                    end
                else
                    local v46 = nil
                    v46 = v46 or value_4
                end
            end
        end
    end
end
local function startTouchHold(a1, a2) --[[ name: startTouchHold, line: 671, upvalues: tbl_upv_7 (copy, index: 1), u22 (ref, index: 2), RunService_upv_1 (copy, index: 3), stepTouchHolds (copy, index: 4) ]]
    if a1.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    for _, value_5 in tbl_upv_7 do
        if value_5.Input ~= a1 then
            continue
        end
        return
    end
    table.insert(tbl_upv_7, {Repeating = false, Input = a1, Origin = a1.Position, Started = os.clock(), OnButton = a2})
    if u22 == nil then
        u22 = RunService_upv_1.Heartbeat:Connect(stepTouchHolds)
    end
end
function tbl_2.Tap(a1) --[[ name: Tap, line: 685, upvalues: sendTap (copy, index: 1) ]]
    sendTap("intro", true, false)
end
local function worldTapsOpen() --[[ name: worldTapsOpen, line: 574, upvalues: canClickAnywhere (copy, index: 1), DataController_upv_1 (copy, index: 2), InputController_upv_1 (copy, index: 3), Players_upv_1 (copy, index: 4) ]]
    if not canClickAnywhere(DataController_upv_1:GetReplica().Data) or InputController_upv_1:IsWorldInputBlocked() then
        return false
    end
    local SkillTreeGui_1 = Players_upv_1.LocalPlayer.PlayerGui:FindFirstChild("SkillTreeGui")
    local v47 = (SkillTreeGui_1 ~= nil) and (SkillTreeGui_1:IsA("ScreenGui") and (SkillTreeGui_1.Enabled))
    return not v47
end
function tbl_2.BindTapThrough(a1, a2) --[[ name: BindTapThrough, line: 693, upvalues: worldTapsOpen (copy, index: 1), sendTap (copy, index: 2) ]]
    a2.InputBegan:Connect(
        function(a3) --[[ line: 694, upvalues: worldTapsOpen (copy, index: 1), sendTap (copy, index: 2) ]]
            local UserInputType_1 = a3.UserInputType
            if (UserInputType_1 == Enum.UserInputType.MouseButton1 or UserInputType_1 == Enum.UserInputType.Touch) and worldTapsOpen() then
                sendTap("rebirth_row", true, false, a3)
            end
        end
    )
end
function tbl_2.OnManualTap(a1, a2) --[[ name: OnManualTap, line: 704, upvalues: tbl_upv_6 (copy, index: 1) ]]
    table.insert(tbl_upv_6, a2)
end
function tbl_2.WorldTapsOpen(a1) --[[ name: WorldTapsOpen, line: 710, upvalues: worldTapsOpen (copy, index: 1) ]]
    return (worldTapsOpen())
end
function tbl_2.HasHeldToTap(a1) --[[ name: HasHeldToTap, line: 715, upvalues: u21 (ref, index: 1) ]]
    return u21
end
function tbl_2.GetManualTapCount(a1) --[[ name: GetManualTapCount, line: 721, upvalues: u19 (ref, index: 1) ]]
    return u19
end
function tbl_2.GetClickMultiplier(a1) --[[ name: GetClickMultiplier, line: 726, upvalues: u31 (ref, index: 1) ]]
    return u31
end
function tbl_2.SetClickAnywhereOverride(a1, a2, a3) --[[ name: SetClickAnywhereOverride, line: 734, upvalues: tbl_upv_8 (copy, index: 1), TapEffects_upv_1 (copy, index: 2), canClickAnywhere (copy, index: 3), DataController_upv_1 (copy, index: 4) ]]
    if tbl_upv_8[a2] == true == a3 then
        return
    end
    tbl_upv_8[a2] = (a3 and true) or nil
    TapEffects_upv_1:SetPointerEffectsEnabled((canClickAnywhere(DataController_upv_1:GetReplica().Data)))
end
function tbl_2.SetClickAnywhereBlocked(a1, a2, a3) --[[ name: SetClickAnywhereBlocked, line: 742, upvalues: tbl_upv_9 (copy, index: 1), TapEffects_upv_1 (copy, index: 2), canClickAnywhere (copy, index: 3), DataController_upv_1 (copy, index: 4) ]]
    if tbl_upv_9[a2] == true == a3 then
        return
    end
    tbl_upv_9[a2] = (a3 and true) or nil
    TapEffects_upv_1:SetPointerEffectsEnabled((canClickAnywhere(DataController_upv_1:GetReplica().Data)))
end
local u44 = TweenInfo.new(0.04, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local u45 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u46 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u47 = nil
local u48 = nil
local u49 = nil
local tbl_upv_13 = {}
local function setComboText(a1, a2) --[[ name: setComboText, line: 760, upvalues: u48 (ref, index: 1) ]]
    if u48 == a2 then
        return
    end
    u48 = a2
    a1.Amount.Text = a2
end
local function setAutoSpin(a1) --[[ name: setAutoSpin, line: 770, upvalues: u5 (ref, index: 1), u6 (ref, index: 2), TweenService_upv_1 (copy, index: 3) ]]
    if u5 == nil then
        return
    end
    if u6 ~= nil then
        u6:Cancel()
        u6 = nil
    end
    local ReflectionClip_upv_1 = u5:FindFirstChild("ReflectionClip")
    local function showReflection_1(a2) --[[ name: showReflection, line: 775, upvalues: ReflectionClip_upv_1 (copy, index: 1) ]]
        if ReflectionClip_upv_1 == nil or not ReflectionClip_upv_1:IsA("GuiObject") then
            return
        end
        ReflectionClip_upv_1.Visible = a2
    end
    local v48 = u5.Rotation % 360
    u5.Rotation = v48
    if a1 then
        u5:SetAttribute("TS2IconSpinning", true)
        if ReflectionClip_upv_1 ~= nil and ReflectionClip_upv_1:IsA("GuiObject") then
            ReflectionClip_upv_1.Visible = false
        end
        local v49 = TweenService_upv_1:Create(u5, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = v48 - 360})
        u6 = v49
        v49:Play()
    else
        local function settle_1() --[[ name: settle, line: 791, upvalues: u5 (copy, index: 1), ReflectionClip_upv_1 (copy, index: 2) ]]
            u5.Rotation = 0
            u5:SetAttribute("TS2IconSpinning", nil)
            if ReflectionClip_upv_1 == nil or not ReflectionClip_upv_1:IsA("GuiObject") then
                return
            end
            ReflectionClip_upv_1.Visible = true
        end
        if v48 ~= 0 then
            local tbl_14 = {Rotation = 0}
            local v50 = TweenService_upv_1:Create(u5, TweenInfo.new(((1.5707963267948966 * v48) / 360) * 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), tbl_14)
            u6 = v50
            v50.Completed:Once(
                function(a3) --[[ line: 805, upvalues: u5 (copy, index: 1), ReflectionClip_upv_1 (copy, index: 2) ]]
                    if a3 ~= Enum.PlaybackState.Completed then
                        return
                    end
                    u5.Rotation = 0
                    u5:SetAttribute("TS2IconSpinning", nil)
                    if ReflectionClip_upv_1 == nil or not ReflectionClip_upv_1:IsA("GuiObject") then
                        return
                    end
                    ReflectionClip_upv_1.Visible = true
                end
            )
            v50:Play()
        else
            u5.Rotation = 0
            u5:SetAttribute("TS2IconSpinning", nil)
            if ReflectionClip_upv_1 == nil or not ReflectionClip_upv_1:IsA("GuiObject") then
                return
            end
            ReflectionClip_upv_1.Visible = true
        end
    end
end
local function setAutoVisual(a1, a2) --[[ name: setAutoVisual, line: 811, upvalues: u7 (ref, index: 1), SoundController_upv_1 (copy, index: 2), setAutoSpin (copy, index: 3), Auto_upv_1 (ref, index: 4), u4 (ref, index: 5), u8 (copy, index: 6), u9 (copy, index: 7), TweenService_upv_1 (copy, index: 8), Tap_upv_1 (ref, index: 9), u48 (ref, index: 10), u47 (ref, index: 11), u16 (ref, index: 12) ]]
    if a1 ~= u7 then
        if a2 ~= true then
            SoundController_upv_1:PlayCue((a1 and "AutoOn") or "AutoOff")
        end
        setAutoSpin(a1)
    end
    u7 = a1
    local Label_1 = Auto_upv_1.Main.Label
    Label_1.Text = (a1 and "AUTO: ON") or "AUTO: OFF"
    if u4 ~= nil then
        local v51
        if a1 then
            v51 = u8
        else
            v51 = u9
        end
        if a2 ~= true then
            local tbl_15 = {}
            tbl_15.BackgroundColor3 = v51
            TweenService_upv_1:Create(u4, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), tbl_15):Play()
        else
            u4.BackgroundColor3 = v51
        end
    end
    if not (a1) then
        Tap_upv_1.Combo.Visible = false
        local Combo_1 = Tap_upv_1.Combo
        if u48 ~= "x1.0 No Combo" then
            u48 = "x1.0 No Combo"
            Combo_1.Amount.Text = "x1.0 No Combo"
        end
        u47 = 0
        local Bar_1 = Tap_upv_1.Combo.Bar
        local v52 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local tbl_16 = {}
        tbl_16.Size = UDim2.fromScale(0, 1)
        TweenService_upv_1:Create(Bar_1, v52, tbl_16):Play()
        u16 = 0
    end
end
local function clearComboGradients() --[[ name: clearComboGradients, line: 840, upvalues: tbl_upv_4 (copy, index: 1) ]]
    for _, value_6 in tbl_upv_4 do
        value_6:Destroy()
    end
    table.clear(tbl_upv_4)
end
local function flashComboHighlight(a1) --[[ name: flashComboHighlight, line: 847, upvalues: tbl_upv_13 (copy, index: 1), TweenService_upv_1 (copy, index: 2), u46 (copy, index: 3) ]]
    local Highlight_1 = a1.Highlight
    local v53 = table.remove(tbl_upv_13)
    if v53 == nil or v53.Highlight.Parent ~= a1 then
        local u50 = Highlight_1:Clone()
        u50.Parent = a1
        local v54 = TweenService_upv_1:Create(u50, u46, {BackgroundTransparency = 1, Size = UDim2.fromScale(1.35, 2.3)})
        local tbl_upv_17 = {}
        tbl_upv_17.Highlight = u50
        tbl_upv_17.Tween = v54
        v54.Completed:Connect(
            function() --[[ line: 861, upvalues: u50 (copy, index: 1), tbl_upv_13 (copy, index: 2), tbl_upv_17 (copy, index: 3) ]]
                u50.Visible = false
                table.insert(tbl_upv_13, tbl_upv_17)
            end
        )
        v53 = tbl_upv_17
    else
        v53.Highlight.Size = Highlight_1.Size
        v53.Highlight.BackgroundTransparency = Highlight_1.BackgroundTransparency
    end
    v53.Highlight.Visible = true
    v53.Tween:Play()
end
local function updateCombo(a1) --[[ name: updateCombo, line: 872, upvalues: Tap_upv_1 (ref, index: 1), u17 (ref, index: 2), u7 (ref, index: 3), u16 (ref, index: 4), u47 (ref, index: 5), TweenService_upv_1 (copy, index: 6), u44 (copy, index: 7), u48 (ref, index: 8), SoundController_upv_1 (copy, index: 9), tbl_upv_4 (copy, index: 10), ComboStages_upv_1 (copy, index: 11), flashComboHighlight (copy, index: 12), u49 (ref, index: 13), u45 (copy, index: 14) ]]
    local Combo_2 = Tap_upv_1.Combo
    local v55 = u17 or (Combo_2.Size)
    u17 = v55
    if a1 ~= nil and u7 then
        if a1.Progress <= 0 then
            Combo_2.Visible = false
            u16 = 0
        else
            Combo_2.Visible = true
            local v56 = math.clamp(a1.Progress, 0, 1)
            if v56 ~= u47 then
                u47 = v56
                local tbl_18 = {}
                tbl_18.Size = UDim2.fromScale(v56, 1)
                TweenService_upv_1:Create(Combo_2.Bar, u44, tbl_18):Play()
            end
            local v57 = string.format("x%.2f %s", a1.Multiplier, a1.Name)
            if u48 ~= v57 then
                u48 = v57
                Combo_2.Amount.Text = v57
            end
            if u16 == a1.Stage then
                return
            end
            if u16 < a1.Stage and a1.Stage > 0 then
                SoundController_upv_1:PlayCue("ComboStage", (math.min(a1.Stage - 1, 6) * 0.045) + 1)
            end
            for _, value_7 in tbl_upv_4 do
                value_7:Destroy()
            end
            table.clear(tbl_upv_4)
            local v58 = ComboStages_upv_1:GetStageGradient(a1.Stage)
            local v59 = ComboStages_upv_1:GetStageGradient(((a1.Stage ~= 1) and (a1.Stage - 1)) or 0)
            if v59 ~= nil then
                for _, value_8 in {Combo_2, Combo_2.UIStroke} do
                    local v60 = v59:Clone()
                    v60.Parent = value_8
                    table.insert(tbl_upv_4, v60)
                end
            end
            local v61 = nil
            if v58 ~= nil then
                local tbl_19 = {Combo_2.Glow, Combo_2.Amount.UIStroke, Combo_2.Bar}
                v61 = Combo_2.Bar:FindFirstChild("UIStroke")
                if v61 ~= nil then
                    table.insert(tbl_19, v61)
                end
                for _, value_9 in tbl_19 do
                    v61 = v58:Clone()
                    v61.Parent = value_9
                    table.insert(tbl_upv_4, v61)
                end
            end
            flashComboHighlight(Combo_2)
            if u49 == nil then
                local v62 = TweenService_upv_1:Create(Combo_2, u45, {Size = u17})
                u49 = v62
            end
            u49:Cancel()
            Combo_2.Size = UDim2.fromScale(1.7, 0.125)
            u49:Play()
            u16 = a1.Stage
        end
    else
        Combo_2.Visible = false
        u16 = 0
    end
end
local function updateCritical(a1, a2, a3) --[[ name: updateCritical, line: 925, upvalues: u18 (ref, index: 1), SoundController_upv_1 (copy, index: 2), Tap_upv_1 (ref, index: 3), FormatNumber_upv_1 (copy, index: 4), u37 (ref, index: 5) ]]
    u18 = u18 + 1
    local u51 = u18
    if a1.Critical == true and not (a2) then
        SoundController_upv_1:Play("Critical")
    end
    if a1.CriticalQueued ~= true then
        Tap_upv_1.Main.CriticalIcon.Visible = a3
        Tap_upv_1.Main.Icon.Visible = not a3
    else
        SoundController_upv_1:Play("Shine")
        Tap_upv_1.Main.CriticalIcon.Visible = false
        Tap_upv_1.Main.Icon.Visible = true
        task.delay(
            0.05,
            function() --[[ line: 935, upvalues: u18 (ref, index: 1), u51 (copy, index: 2), a3 (copy, index: 3), a1 (copy, index: 4), FormatNumber_upv_1 (copy, index: 5), u37 (ref, index: 6), Tap_upv_1 (ref, index: 7) ]]
                if u18 ~= u51 then
                    return
                end
                if a3 then
                    local v63 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(a1.NextCriticalAmount or (a1.Amount or 0)), 1e+06, true))
                    local v64 = nil
                    if v63 ~= u37 then
                        u37 = v63
                        Tap_upv_1.Main.Amount.Text = v63
                        v64 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
                        if v64 ~= nil and v64:IsA("TextLabel") then
                            v64.Text = v63
                        end
                    end
                end
                Tap_upv_1.Main.CriticalIcon.Visible = a3
                Tap_upv_1.Main.Icon.Visible = not a3
            end
        )
    end
end
local function playPressEffect(a1) --[[ name: playPressEffect, line: 340, upvalues: tbl_upv_10 (copy, index: 1), TweenService_upv_1 (copy, index: 2), u38 (copy, index: 3) ]]
    local v65
    local ClickEffect_1 = a1:FindFirstChild("ClickEffect")
    if ClickEffect_1 == nil then
        return
    end
    if ClickEffect_1:IsA("GuiObject") then
        local u52 = tbl_upv_10[a1]
        if u52 == nil then
            v65 = {}
            tbl_upv_10[a1] = v65
        end
        local u53 = v65
        u52 = table.remove(u53)
        if u52 == nil or u52.Ripple.Parent ~= a1 then
            local v66 = ClickEffect_1:Clone()
            v66.Visible = true
            v66.Parent = a1
            local tbl_20 = {Expanded = 0}
            tbl_20.Ripple = v66
            u52 = tbl_20
        else
            u52.Ripple.Size = ClickEffect_1.Size
            u52.Ripple.BackgroundTransparency = ClickEffect_1.BackgroundTransparency
            u52.Ripple.Visible = true
        end
        local v67 = u52
        local Ripple_upv_1 = v67.Ripple
        local v68 = math.max(a1.AbsoluteSize.X, a1.AbsoluteSize.Y) * 1.4
        if v67.Tween == nil or v67.Expanded ~= v68 then
            if u52.Tween ~= nil then
                u52.Tween:Destroy()
            end
            local v69 = TweenService_upv_1:Create(Ripple_upv_1, u38, {BackgroundTransparency = 1, Size = UDim2.fromOffset(v68, v68)})
            u52.Tween = v69
            u52.Expanded = v68
            v69.Completed:Connect(
                function(a2) --[[ line: 376, upvalues: Ripple_upv_1 (copy, index: 1), a1 (copy, index: 2), u53 (copy, index: 3), u52 (copy, index: 4) ]]
                    if a2 ~= Enum.PlaybackState.Completed or Ripple_upv_1.Parent ~= a1 then
                        return
                    end
                    Ripple_upv_1.Visible = false
                    table.insert(u53, u52)
                end
            )
        end
        u52.Tween:Play()
    end
end
local function offerAutoClicker() --[[ name: offerAutoClicker, line: 950, upvalues: MessageController_upv_1 (copy, index: 1), SkillTreeFormula_upv_1 (copy, index: 2), FormatNumber_upv_1 (copy, index: 3), SkillTreeController_upv_1 (copy, index: 4), NotificationController_upv_1 (copy, index: 5) ]]
    if MessageController_upv_1:IsOpen() then
        return
    end
    local AutoClickerNode_upv_1 = SkillTreeFormula_upv_1.AutoClickerNode
    local v70 = SkillTreeFormula_upv_1.GetNode(AutoClickerNode_upv_1)
    if v70 == nil then
        return
    end
    local function OnConfirm_1() --[[ name: OnConfirm, line: 960, upvalues: SkillTreeController_upv_1 (copy, index: 1), AutoClickerNode_upv_1 (copy, index: 2), NotificationController_upv_1 (copy, index: 3) ]]
        task.spawn(
            function() --[[ line: 961, upvalues: SkillTreeController_upv_1 (copy, index: 1), AutoClickerNode_upv_1 (copy, index: 2), NotificationController_upv_1 (copy, index: 3) ]]
                if not SkillTreeController_upv_1.Unlock(AutoClickerNode_upv_1) then
                    return
                end
                NotificationController_upv_1:Notify("Auto Clicker unlocked!", Color3.fromRGB(0, 255, 0), nil, 3)
            end
        )
    end
    MessageController_upv_1:ShowConfirm({Title = "Auto Clicker", Description = "Unlock the Auto Clicker? It taps for you, even while you explore!", Currency = {Icon = "Gems", Amount = FormatNumber_upv_1:Abbreviate(v70.Data.Cost, true)}, StrokeColor = Color3.fromRGB(0, 255, 0), OnConfirm = OnConfirm_1})
end
local function toggleAuto(a1) --[[ name: toggleAuto, line: 970, upvalues: OnboardingFlow_upv_1 (copy, index: 1), DataController_upv_1 (copy, index: 2), u7 (ref, index: 3), SkillTreeFormula_upv_1 (copy, index: 4), playPressEffect (copy, index: 5), Auto_upv_1 (ref, index: 6), offerAutoClicker (copy, index: 7), u2 (copy, index: 8) ]]
    if OnboardingFlow_upv_1.IsPending(DataController_upv_1:GetReplica().Data) then
        return
    end
    if not (u7) and not (SkillTreeFormula_upv_1.HasAutoClicker(DataController_upv_1:GetReplica().Data)) then
        local v71 = a1 or Auto_upv_1
        playPressEffect(v71)
        offerAutoClicker()
        return
    end
    u2.AutoClickRequested:Fire({Enabled = not u7})
    local v72 = a1 or Auto_upv_1
    playPressEffect(v72)
end
local function getAutoStatusDot(a1) --[[ name: getAutoStatusDot, line: 995, upvalues: u9 (copy, index: 1) ]]
    local Status_1 = a1:FindFirstChild("Status")
    if Status_1 ~= nil and Status_1:IsA("Frame") then
        return Status_1
    end
    local v73 = Instance.new("Frame")
    v73.Name = "Status"
    v73.AnchorPoint = Vector2.new(0.5, 0.5)
    v73.Position = UDim2.fromScale(0.86, 0.14)
    v73.Size = UDim2.fromScale(0.22, 0.22)
    v73.BackgroundColor3 = u9
    v73.BorderSizePixel = 0
    v73.ZIndex = 7
    local v74 = Instance.new("UIAspectRatioConstraint")
    v74.AspectRatio = 1
    v74.Parent = v73
    local v75 = Instance.new("UICorner")
    v75.CornerRadius = UDim.new(0.5, 0)
    v75.Parent = v73
    local v76 = Instance.new("UIStroke")
    v76.Thickness = 2
    v76.Color = Color3.fromRGB(0, 0, 0)
    v76.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    v76.Parent = v73
    v73.Parent = a1
    return v73
end
local function refreshAutoBuy(a1) --[[ name: refreshAutoBuy, line: 1086, upvalues: SkillTreeFormula_upv_1 (copy, index: 1), u4 (ref, index: 2), u7 (ref, index: 3), tbl_upv_3 (copy, index: 4), NotificationController_upv_1 (copy, index: 5), u10 (ref, index: 6) ]]
    local v77 = SkillTreeFormula_upv_1.HasAutoClicker(a1)
    if u4 ~= nil then
        u4.Visible = v77 or u7
    end
    local v79 = SkillTreeFormula_upv_1.GetPrice(a1, SkillTreeFormula_upv_1.AutoClickerNode)
    local v80 = not v77 and (v79 <= (tonumber(a1.Currencies.Gems) or 0))
    local Ready_1 = tbl_upv_3.Ready
    tbl_upv_3.Ready = v80
    if v80 and Ready_1 == false and tbl_upv_3.Gap <= os.clock() - tbl_upv_3.ToastAt then
        tbl_upv_3.ToastAt = os.clock()
        NotificationController_upv_1:Notify("You can now afford the Auto Clicker!", Color3.fromRGB(0, 255, 0), nil, 4)
    end
    if u10 == nil then
        return
    end
    if v77 then
        u10:Set(nil, false)
    else
        u10:Set(v79, v80)
    end
end
local function bindAutoTitle(a1, a2) --[[ name: bindAutoTitle, line: 1025, upvalues: u11 (copy, index: 1), u13 (copy, index: 2), u12 (copy, index: 4), UserInputService_upv_1 (copy, index: 5) ]]
    local Title_upv_1 = a1:FindFirstChild("Title")
    if Title_upv_1 == nil or not Title_upv_1:IsA("TextLabel") then
        return
    end
    local TextTransparency_upv_1 = Title_upv_1.TextTransparency
    local tbl_upv_21 = {}
    for _, value_10 in Title_upv_1:GetChildren() do
        if value_10:IsA("UIStroke") then
            tbl_upv_21[value_10] = value_10.Transparency
            value_10.Transparency = 1
        end
    end
    Title_upv_1.TextTransparency = 1
    local u54 = Instance.new("UIScale")
    u54.Name = "HoverPop"
    u54.Scale = 0.85
    u54.Parent = Title_upv_1
    local tbl_upv_22 = {}
    local u55 = false
    local function setShown_upv_1(a3) --[[ name: setShown, line: 1047, upvalues: u55 (ref, index: 1), tbl_upv_22 (copy, index: 2), u11 (copy, index: 3), u13 (copy, index: 4), Title_upv_1 (copy, index: 6), TextTransparency_upv_1 (copy, index: 7), tbl_upv_21 (copy, index: 8), u54 (copy, index: 9), u12 (copy, index: 10) ]]
        if a3 == u55 then
            return
        end
        u55 = a3
        for _, value_11 in tbl_upv_22 do
            value_11:Cancel()
        end
        table.clear(tbl_upv_22)
        local v81
        if a3 then
            v81 = u11
        else
            v81 = u13
        end
        local tbl_23 = {TextTransparency = 0}
        local v82
        if a3 then
            v82 = TextTransparency_upv_1
        else
            v82 = 1
        end
        tbl_23.TextTransparency = v82
        table.insert(tbl_upv_22, TweenService_upv_1:Create(Title_upv_1, v81, tbl_23))
        local v83 = nil
        for key_3, value_12 in tbl_upv_21 do
            local tbl_24 = {Transparency = 0}
            if a3 then
                v83 = value_12
            else
                v83 = 1
            end
            tbl_24.Transparency = v83
            table.insert(tbl_upv_22, TweenService_upv_1:Create(key_3, v81, tbl_24))
        end
        local v84
        if a3 then
            v84 = u12
        else
            v84 = u13
        end
        local tbl_25 = {Scale = 0}
        tbl_25.Scale = (a3 and 1) or 0.85
        table.insert(tbl_upv_22, TweenService_upv_1:Create(u54, v84, tbl_25))
        for _, value_13 in tbl_upv_22 do
            value_13:Play()
        end
    end
    a2.MouseEnter:Connect(
        function() --[[ line: 1065, upvalues: UserInputService_upv_1 (copy, index: 1), setShown_upv_1 (copy, index: 2) ]]
            if UserInputService_upv_1:GetLastInputType() == Enum.UserInputType.Touch then
                return
            end
            setShown_upv_1(true)
        end
    )
    a2.MouseLeave:Connect(
        function() --[[ line: 1068, upvalues: setShown_upv_1 (copy, index: 1) ]]
            setShown_upv_1(false)
        end
    )
    a2.SelectionGained:Connect(
        function() --[[ line: 1069, upvalues: setShown_upv_1 (copy, index: 1) ]]
            setShown_upv_1(true)
        end
    )
    a2.SelectionLost:Connect(
        function() --[[ line: 1070, upvalues: setShown_upv_1 (copy, index: 1) ]]
            setShown_upv_1(false)
        end
    )
    a2.InputBegan:Connect(
        function(a4) --[[ line: 1071, upvalues: setShown_upv_1 (copy, index: 1) ]]
            if a4.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            setShown_upv_1(true)
            local u56 = nil
            local v85 = a4:GetPropertyChangedSignal("UserInputState"):Connect(
                function() --[[ line: 1075, upvalues: a4 (copy, index: 1), u56 (ref, index: 2), setShown_upv_1 (copy, index: 3) ]]
                    if a4.UserInputState ~= Enum.UserInputState.End and a4.UserInputState ~= Enum.UserInputState.Cancel then
                        return
                    end
                    u56:Disconnect()
                    setShown_upv_1(false)
                end
            )
            u56 = v85
        end
    )
end
local function findBottomAuto(a1) --[[ name: findBottomAuto, line: 983 ]]
    for _, value_14 in a1:GetChildren() do
        if value_14.Name ~= "Auto" or not (value_14:IsA("GuiObject")) or not (value_14.Visible) then
            continue
        end
        return value_14
    end
    return nil
end
function tbl_2.Init(a1) --[[ name: Init, line: 1106, upvalues: Players_upv_1 (copy, index: 1), Game_upv_1 (ref, index: 2), Tap_upv_1 (ref, index: 3), Auto_upv_1 (ref, index: 4), u3 (ref, index: 5), findBottomAuto (copy, index: 6), TapEffects_upv_1 (copy, index: 7), TapIdleFade_upv_1 (copy, index: 8), ButtonEffects_upv_1 (copy, index: 9), ClickFx_upv_1 (copy, index: 10), squashTapButton (copy, index: 11), playPressEffect (copy, index: 12), sendTap (copy, index: 13), u41 (ref, index: 14), u40 (ref, index: 15), SoundController_upv_1 (copy, index: 16), startTouchHold (copy, index: 17), InputController_upv_1 (copy, index: 18), toggleAuto (copy, index: 19), u4 (ref, index: 20), getAutoStatusDot (copy, index: 21), u10 (ref, index: 22), AutoClickerPrice_upv_1 (copy, index: 23), bindAutoTitle (copy, index: 24), u5 (ref, index: 25), MicroGamepad_upv_1 (copy, index: 26), GuiService_upv_1 (copy, index: 27), ControllerHints_upv_1 (copy, index: 28), u1 (copy, index: 29), TapResultState_upv_1 (copy, index: 30), tbl_upv_1 (copy, index: 31), tbl_upv_5 (copy, index: 32), u15 (ref, index: 33), HudController_upv_1 (copy, index: 34), u28 (ref, index: 35), u29 (ref, index: 36), u30 (ref, index: 37), Multiplier_upv_1 (ref, index: 38), u20 (ref, index: 39), u39 (copy, index: 40), u27 (ref, index: 41), u26 (ref, index: 42), FormatNumber_upv_1 (copy, index: 43), u37 (ref, index: 44), u24 (ref, index: 45), RunService_upv_1 (copy, index: 46), u25 (ref, index: 47), TweenService_upv_1 (copy, index: 48), updateCritical (copy, index: 49), updateCombo (copy, index: 50), u2 (copy, index: 51), setAutoVisual (copy, index: 52), refreshPreview (copy, index: 53), DataController_upv_1 (copy, index: 54) ]]
    Game_upv_1 = Players_upv_1.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Game")
    Tap_upv_1 = Game_upv_1.Bottom.Tap
    Tap_upv_1.Main.Glow.Visible = false
    Tap_upv_1.Sunburst.Visible = false
    Tap_upv_1.Shockwave.Visible = false
    Auto_upv_1 = Game_upv_1.LeftButtons.Auto
    u3 = findBottomAuto(Game_upv_1.Bottom)
    TapEffects_upv_1:Init(Game_upv_1, Tap_upv_1)
    TapIdleFade_upv_1.Init(Tap_upv_1)
    ButtonEffects_upv_1:Bind(Tap_upv_1.Button, true)
    ButtonEffects_upv_1:Bind(Auto_upv_1.Button)
    ButtonEffects_upv_1:Bind(Game_upv_1.Bottom.FreeAutoTap.Button)
    ButtonEffects_upv_1:Bind(Game_upv_1.Bottom.AutoTap.Button)
    ClickFx_upv_1.Register(
        "Press",
        function(a2) --[[ line: 1128, upvalues: squashTapButton (copy, index: 1) ]]
            local v86
            if type(a2) ~= "number" then
                v86 = nil
            else
                v86 = a2
            end
            squashTapButton(v86)
        end
    )
    ClickFx_upv_1.Register(
        "Ripple",
        function(a3) --[[ line: 1131, upvalues: playPressEffect (copy, index: 1) ]]
            playPressEffect(a3)
        end
    )
    local u57 = nil
    local u58 = 0.9
    Tap_upv_1.Button.MouseButton1Down:Connect(
        function() --[[ line: 1136, upvalues: sendTap (copy, index: 1), u57 (ref, index: 2), u58 (ref, index: 3), u41 (ref, index: 4), u40 (ref, index: 5), SoundController_upv_1 (copy, index: 6) ]]
            local v87 = sendTap("button", true, true) ~= "Throttled"
            u57 = v87
            if v87 then
                local v88 = os.clock()
                local v89 = v88 - u41
                u41 = v88
                local v90 = ((v89 > 0.6) and 0) or (u40 + ((1 / v89) - u40) * 0.5)
                u40 = v90
                u58 = ((math.clamp((u40 - 2) / 5, 0, 1) * 0.6000000000000001) + 1) * 0.9
                SoundController_upv_1:Play("Click", u58, 0.75)
            end
        end
    )
    Tap_upv_1.Button.InputBegan:Connect(
        function(a4) --[[ line: 1145, upvalues: startTouchHold (copy, index: 1) ]]
            startTouchHold(a4, true)
        end
    )
    Tap_upv_1.Button.Activated:Connect(
        function() --[[ line: 1148, upvalues: u57 (ref, index: 1), InputController_upv_1 (copy, index: 2), sendTap (copy, index: 3), SoundController_upv_1 (copy, index: 4), u41 (ref, index: 5), u40 (ref, index: 6), u58 (ref, index: 7) ]]
            if u57 ~= nil then
                if u57 ~= false then
                    SoundController_upv_1:Play("Click2", u58, 0.75)
                end
                u57 = nil
            else
                local v91 = InputController_upv_1:GetMode() == "Gamepad"
                local v92
                if v91 then
                    v92 = "pad_a"
                else
                    v92 = "button"
                end
                if sendTap(v92, false, true, nil, v91) ~= "Throttled" then
                    local v93 = os.clock()
                    local v94 = v93 - u41
                    u41 = v93
                    local v95 = ((v94 > 0.6) and 0) or (u40 + ((1 / v94) - u40) * 0.5)
                    u40 = v95
                    SoundController_upv_1:Play("Click2", ((math.clamp((u40 - 2) / 5, 0, 1) * 0.6000000000000001) + 1) * 0.9, 0.75)
                end
            end
        end
    )
    Auto_upv_1.Button.Activated:Connect(
        function() --[[ line: 1162, upvalues: toggleAuto (copy, index: 1), Auto_upv_1 (ref, index: 2) ]]
            toggleAuto(Auto_upv_1)
        end
    )
    Game_upv_1.Bottom.FreeAutoTap.Button.Activated:Connect(
        function() --[[ line: 1163, upvalues: toggleAuto (copy, index: 1), Game_upv_1 (ref, index: 2) ]]
            toggleAuto(Game_upv_1.Bottom.FreeAutoTap)
        end
    )
    Game_upv_1.Bottom.AutoTap.Button.Activated:Connect(
        function() --[[ line: 1166, upvalues: toggleAuto (copy, index: 1), Game_upv_1 (ref, index: 2) ]]
            toggleAuto(Game_upv_1.Bottom.AutoTap)
        end
    )
    local v96 = nil
    if u3 == nil then
        warn("[TapController] Game.Bottom has no visible Auto button")
        InputController_upv_1:BindHint(Auto_upv_1, Enum.KeyCode.DPadRight)
    else
        u4 = getAutoStatusDot(u3.Main)
        u10 = AutoClickerPrice_upv_1.Bind(u3.Main, 92)
        bindAutoTitle(u3.Main, u3.Button)
        v96 = u3.Main:FindFirstChild("Icon")
        if v96 ~= nil and v96:IsA("GuiObject") then
            u5 = v96
        end
        ButtonEffects_upv_1:Bind(u3.Button)
        u3.Button.Activated:Connect(
            function() --[[ line: 1175, upvalues: toggleAuto (copy, index: 1), u3 (copy, index: 2) ]]
                toggleAuto(u3)
            end
        )
        InputController_upv_1:BindHint(u3, Enum.KeyCode.DPadRight)
    end
    local v97 = InputController_upv_1:BindHint(Tap_upv_1, Enum.KeyCode.ButtonR2)
    v97.AnchorPoint = Vector2.new(1, 1)
    v97.Position = UDim2.fromScale(0.98, 0.98)
    InputController_upv_1:SetRemoteHudEntry(Tap_upv_1.Button)
    local u59 = v97:Clone()
    u59.Name = "RemoteKeybind"
    u59.Image = ""
    u59.Visible = false
    u59.Parent = v97.Parent
    local function refreshRemoteGlyph() --[[ name: refreshRemoteGlyph, line: 1196, upvalues: InputController_upv_1 (copy, index: 1), MicroGamepad_upv_1 (copy, index: 2), GuiService_upv_1 (copy, index: 3), Tap_upv_1 (ref, index: 4), u59 (copy, index: 5), ControllerHints_upv_1 (copy, index: 6) ]]
        local v98 = (InputController_upv_1:GetMode() == "Gamepad") and (MicroGamepad_upv_1.IsPreferred() and (GuiService_upv_1.SelectedObject == Tap_upv_1.Button))
        u59.Visible = v98 and ControllerHints_upv_1:ApplyGlyph(u59, Enum.KeyCode.ButtonA)
    end
    GuiService_upv_1:GetPropertyChangedSignal("SelectedObject"):Connect(refreshRemoteGlyph)
    MicroGamepad_upv_1.OnChanged(refreshRemoteGlyph)
    u1.TapResult:Connect(
        function(a5) --[[ line: 1204, upvalues: TapResultState_upv_1 (copy, index: 1), tbl_upv_1 (copy, index: 2), Players_upv_1 (copy, index: 3), tbl_upv_5 (copy, index: 4), u15 (ref, index: 5), HudController_upv_1 (copy, index: 6), u28 (ref, index: 7), u29 (ref, index: 8), u30 (ref, index: 9), Multiplier_upv_1 (ref, index: 10), u20 (ref, index: 11), SoundController_upv_1 (copy, index: 12), u39 (copy, index: 13), u27 (ref, index: 14), u26 (ref, index: 15), FormatNumber_upv_1 (copy, index: 16), u37 (ref, index: 17), Tap_upv_1 (ref, index: 18), u24 (ref, index: 19), RunService_upv_1 (copy, index: 20), u25 (ref, index: 21), TweenService_upv_1 (copy, index: 22), updateCritical (copy, index: 23), updateCombo (copy, index: 24), TapEffects_upv_1 (copy, index: 25) ]]
            local v100 = TapResultState_upv_1.Expand(a5, tbl_upv_1)
            local v101, v102, v103 = nil, nil, nil
            if Players_upv_1.LocalPlayer:GetAttribute("ColosseumActive") ~= true then
                u15 = os.clock()
                local Amount_4 = v100.Amount
                local v104 = v100.Critical == true
                HudController_upv_1:NoteTapIncome(Amount_4, v104, v100.IsAuto == true)
                local v105 = v100.TotemMultiplier or u28
                u28 = v105
                local v106 = v100.PetClickTreatMultiplier or u29
                u29 = v106
                local v107 = v100.CriticalPower or u30
                u30 = v107
                if type(v100.Combo) == "table" and type(v100.Combo.Multiplier) == "number" then
                    Multiplier_upv_1 = v100.Combo.Multiplier
                end
                v101 = v100.ClientSequence
                local v108
                if type(v101) ~= "number" then
                    v108 = nil
                else
                    v108 = tbl_upv_5[v101]
                end
                if v108 ~= nil and os.clock() - v108.At >= 2 then
                    v108 = nil
                end
                if type(v101) == "number" then
                    tbl_upv_5[v101] = nil
                end
                local v109 = false
                v104 = false
                if v108 ~= nil and v108.Critical == (v100.Critical == true) then
                    v109 = v108.EffectsPlayed == true
                    v104 = true
                end
                if u20 ~= nil then
                    if v100.Critical ~= true or v101 == u20 then
                        if v101 == u20 or v100.Critical ~= true and v100.CriticalReady ~= true then
                            u20 = nil
                        end
                    else
                        local v110 = true
                        v104 = true
                        v108 = tbl_upv_5[u20]
                        if v108 ~= nil then
                            v108.Critical = false
                        end
                        u20 = nil
                        v109 = v110
                    end
                end
                v101 = false
                if v100.CriticalReady == true then
                    v101 = u20 == nil
                end
                if v100.IsAuto ~= true and v100.Critical ~= true and not (v109) then
                    SoundController_upv_1:Play("Taps", u39:NextNumber(0.94, 1.06), 1.25)
                    SoundController_upv_1:Play("Click", u39:NextNumber(0.9, 1.1), 0.17)
                end
                local v111
                if v101 then
                    v111 = v100.NextCriticalAmount or (v100.Amount)
                else
                    v111 = v100.NormalAmount or (v100.Amount)
                end
                local u60 = v100.NormalAmount or (v100.Amount)
                v102 = u27
                u27 = u60
                local v112, v113 = nil, nil
                if v102 == nil then
                    u26 = u60
                    v113 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(u60), 1e+06, true))
                    local v114 = nil
                    if v113 ~= u37 then
                        u37 = v113
                        Tap_upv_1.Main.Amount.Text = v113
                        v114 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
                        if v114 ~= nil and v114:IsA("TextLabel") then
                            v114.Text = v113
                        end
                    end
                    v112 = false
                elseif u60 ~= v102 then
                    if u24 ~= nil then
                        u24:Disconnect()
                        u24 = nil
                    end
                    local u61 = u26
                    local u62 = os.clock()
                    local v115 = RunService_upv_1.Heartbeat:Connect(
                        function() --[[ line: 267, upvalues: u25 (ref, index: 1), u62 (copy, index: 2), u26 (ref, index: 3), u61 (copy, index: 4), u60 (copy, index: 5), FormatNumber_upv_1 (copy, index: 6), u37 (ref, index: 7), Tap_upv_1 (ref, index: 8), u24 (ref, index: 9) ]]
                            if u25 then
                                return
                            end
                            local v116 = math.min((os.clock() - u62) / 0.4, 1)
                            u26 = math.ceil(u61 + ((u60 - u61) * v116))
                            local v117 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(u26), 1e+06, true))
                            local v118 = nil
                            if v117 ~= u37 then
                                u37 = v117
                                Tap_upv_1.Main.Amount.Text = v117
                                v118 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
                                if v118 ~= nil and v118:IsA("TextLabel") then
                                    v118.Text = v117
                                end
                            end
                            if v116 >= 1 then
                                if u24 ~= nil then
                                    u24:Disconnect()
                                    u24 = nil
                                end
                                u26 = u60
                                local v119 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(u60), 1e+06, true))
                                if v119 == u37 then
                                    return
                                end
                                u37 = v119
                                Tap_upv_1.Main.Amount.Text = v119
                                local Amount_5 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
                                if Amount_5 ~= nil and Amount_5:IsA("TextLabel") then
                                    Amount_5.Text = v119
                                end
                            end
                        end
                    )
                    u24 = v115
                    if u27 < u60 then
                        local u63 = false
                        task.spawn(
                            function() --[[ line: 185, upvalues: Players_upv_1 (copy, index: 1), u25 (ref, index: 2), Tap_upv_1 (ref, index: 3), u63 (copy, index: 4), u27 (copy, index: 5), u60 (copy, index: 6), SoundController_upv_1 (copy, index: 7), TweenService_upv_1 (copy, index: 8), FormatNumber_upv_1 (copy, index: 9), u37 (ref, index: 10), RunService_upv_1 (copy, index: 11), u26 (ref, index: 12) ]]
                                local Inventory_1 = Players_upv_1.LocalPlayer.PlayerGui.Tabs:FindFirstChild("Inventory")
                                if Inventory_1 ~= nil and Inventory_1:IsA("ScreenGui") then
                                    while Inventory_1:GetAttribute("Enabled") == true do
                                        task.wait(0.1)
                                    end
                                end
                                task.wait(2)
                                if (u25) or Tap_upv_1 == nil then
                                    return
                                end
                                if Tap_upv_1.Parent ~= nil then
                                    local Amount_upv_6 = Tap_upv_1.Main:FindFirstChild("Amount")
                                    if Amount_upv_6 ~= nil and Amount_upv_6:IsA("TextLabel") then
                                        u25 = true
                                        if not (u63) and u27 > 0 and u60 / u27 >= 1.5 then
                                            SoundController_upv_1:PlayCue("GainIncrease")
                                        end
                                        Amount_upv_6:SetAttribute("TS2AmountCelebration", (u63 and "Rebirth") or "Regular")
                                        Amount_upv_6:SetAttribute("TS2AmountCelebrationTarget", u60)
                                        local u64 = Amount_upv_6:FindFirstChildOfClass("UIScale")
                                        if u64 == nil then
                                            u64 = Instance.new("UIScale")
                                            u64.Scale = 1
                                            u64.Parent = Amount_upv_6
                                        end
                                        local Scale_upv_1 = u64.Scale
                                        local Rotation_upv_1 = Amount_upv_6.Rotation
                                        local tbl_26 = {Scale = 1.2}
                                        TweenService_upv_1:Create(u64, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_26):Play()
                                        local u65 = Instance.new("NumberValue")
                                        u65.Name = "TS2AmountCelebrationValue"
                                        u65.Value = u27
                                        u65.Parent = Amount_upv_6
                                        local u66 = u65.Changed:Connect(
                                            function() --[[ line: 217, upvalues: u65 (copy, index: 1), FormatNumber_upv_1 (copy, index: 2), u37 (ref, index: 3), Tap_upv_1 (ref, index: 4) ]]
                                                local v120 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(u65.Value), 1e+06, true))
                                                if v120 == u37 then
                                                    return
                                                end
                                                u37 = v120
                                                Tap_upv_1.Main.Amount.Text = v120
                                                local Amount_7 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
                                                if Amount_7 == nil then
                                                    return
                                                end
                                                if Amount_7:IsA("TextLabel") then
                                                    Amount_7.Text = v120
                                                end
                                            end
                                        )
                                        local v121 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(u27), 1e+06, true))
                                        local v122 = nil
                                        if v121 ~= u37 then
                                            u37 = v121
                                            Tap_upv_1.Main.Amount.Text = v121
                                            v122 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
                                            if v122 ~= nil and v122:IsA("TextLabel") then
                                                v122.Text = v121
                                            end
                                        end
                                        local u67 = TweenService_upv_1:Create(u65, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = u60})
                                        u67:Play()
                                        local u68 = (u63 and 1.5) or 3
                                        local u69 = (u63 and 12) or 6
                                        local u70 = os.clock()
                                        local u71 = nil
                                        local v123 = RunService_upv_1.Heartbeat:Connect(
                                            function() --[[ line: 232, upvalues: u70 (copy, index: 1), u68 (copy, index: 2), u71 (ref, index: 3), Amount_upv_6 (copy, index: 4), Rotation_upv_1 (copy, index: 5), u69 (copy, index: 6) ]]
                                                local v124 = os.clock() - u70
                                                if u68 <= v124 then
                                                    if u71 ~= nil then
                                                        u71:Disconnect()
                                                        u71 = nil
                                                    end
                                                    Amount_upv_6.Rotation = Rotation_upv_1
                                                else
                                                    Amount_upv_6.Rotation = math.sin((math.tau * u69) * v124) * 8
                                                end
                                            end
                                        )
                                        u71 = v123
                                        u67.Completed:Once(
                                            function() --[[ line: 242, upvalues: u67 (copy, index: 1), u71 (ref, index: 2), u66 (copy, index: 3), Amount_upv_6 (copy, index: 4), Rotation_upv_1 (copy, index: 5), u26 (ref, index: 6), u60 (copy, index: 7), FormatNumber_upv_1 (copy, index: 8), u37 (ref, index: 9), Tap_upv_1 (ref, index: 10), u65 (copy, index: 11), TweenService_upv_1 (copy, index: 12), u64 (ref, index: 13), Scale_upv_1 (copy, index: 14), u25 (ref, index: 15) ]]
                                                u67:Destroy()
                                                if u71 ~= nil then
                                                    u71:Disconnect()
                                                    u71 = nil
                                                end
                                                u66:Disconnect()
                                                Amount_upv_6.Rotation = Rotation_upv_1
                                                u26 = u60
                                                local v125 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(u60), 1e+06, true))
                                                local v126 = nil
                                                if v125 ~= u37 then
                                                    u37 = v125
                                                    Tap_upv_1.Main.Amount.Text = v125
                                                    v126 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
                                                    if v126 ~= nil and v126:IsA("TextLabel") then
                                                        v126.Text = v125
                                                    end
                                                end
                                                u65:Destroy()
                                                local v127 = TweenService_upv_1:Create(u64, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = Scale_upv_1})
                                                v127.Completed:Once(
                                                    function() --[[ line: 253, upvalues: u25 (ref, index: 1), Amount_upv_6 (copy, index: 2) ]]
                                                        u25 = false
                                                        Amount_upv_6:SetAttribute("TS2AmountCelebration", nil)
                                                        Amount_upv_6:SetAttribute("TS2AmountCelebrationTarget", nil)
                                                    end
                                                )
                                                v127:Play()
                                            end
                                        )
                                        return
                                    end
                                end
                            end
                        )
                    end
                    v112 = true
                else
                    v112 = false
                end
                if v101 or v100.Critical == true or not (v112) then
                    v103 = ("+%*"):format(FormatNumber_upv_1:Adaptive(math.ceil(v111), 1e+06, true))
                    local v128 = nil
                    if v103 ~= u37 then
                        u37 = v103
                        Tap_upv_1.Main.Amount.Text = v103
                        v128 = Tap_upv_1.Main.Amount:FindFirstChild("Amount")
                        if v128 ~= nil then
                            local v129 = v128:IsA("TextLabel")
                            if v129 then
                                v128.Text = v103
                            end
                        end
                    end
                end
                updateCritical(v100, v104, v101)
                updateCombo(v100.Combo)
                if not (v109) then
                    TapEffects_upv_1:Emit(v100)
                end
                if v100.CriticalQueued == true then
                    TapEffects_upv_1:QueueCritical()
                end
            elseif type(v100.ClientSequence) == "number" then
                tbl_upv_5[v100.ClientSequence] = nil
            end
        end
    )
    u1.StateRequested:Fire()
    u2.AutoClickResult:Connect(
        function(a6) --[[ line: 1265, upvalues: setAutoVisual (copy, index: 1), refreshPreview (copy, index: 2), DataController_upv_1 (copy, index: 3) ]]
            setAutoVisual(a6.Enabled == true)
            refreshPreview(DataController_upv_1:GetReplica().Data)
        end
    )
end
function tbl_2.Start(a1) --[[ name: Start, line: 1271, upvalues: DataController_upv_1 (copy, index: 1), TapEffects_upv_1 (copy, index: 2), canClickAnywhere (copy, index: 3), setAutoVisual (copy, index: 4), refreshAutoBuy (copy, index: 5), Rebirths_upv_1 (ref, index: 6), refreshPreview (copy, index: 7), TapCursor_upv_1 (copy, index: 8), Tap_upv_1 (ref, index: 9), ContextActionService_upv_1 (copy, index: 10), Players_upv_1 (copy, index: 11), UserInputService_upv_1 (copy, index: 12), InputController_upv_1 (copy, index: 13), toggleAuto (copy, index: 14), u3 (ref, index: 15), u7 (ref, index: 16), TweenService_upv_1 (copy, index: 17), OnboardingFlow_upv_1 (copy, index: 18), u15 (ref, index: 19), TapIdleFade_upv_1 (copy, index: 20), InputHub_upv_1 (copy, index: 21), worldTapsOpen (copy, index: 22), sendTap (copy, index: 23), playWorldClick (copy, index: 24), u42 (ref, index: 25), SoundController_upv_1 (copy, index: 26), startTouchHold (copy, index: 27), TriggerHold_upv_1 (copy, index: 28), tapButtonShown (copy, index: 29), MicroGamepad_upv_1 (copy, index: 30), GuiService_upv_1 (copy, index: 31), clearTouchHolds (copy, index: 32) ]]
    local u72 = DataController_upv_1:GetReplica()
    TapEffects_upv_1:SetPointerEffectsEnabled((canClickAnywhere(u72.Data)))
    setAutoVisual(u72.Data.Settings.AutoClickerEnabled == true, true)
    refreshAutoBuy(u72.Data)
    DataController_upv_1:ListenToPaths(
        {{"Currencies", "Gems"}, {"SkillTree"}},
        function() --[[ line: 1276, upvalues: refreshAutoBuy (copy, index: 1), u72 (copy, index: 2) ]]
            refreshAutoBuy(u72.Data)
        end
    )
    Rebirths_upv_1 = u72.Data.Statistics.Rebirths
    refreshPreview(u72.Data)
    TapCursor_upv_1.Start(Tap_upv_1, u72)
    ContextActionService_upv_1:BindActionAtPriority(
        "TS2_ToggleAutoClicker",
        function(a2, a3) --[[ line: 1283, upvalues: Players_upv_1 (copy, index: 1), UserInputService_upv_1 (copy, index: 2), InputController_upv_1 (copy, index: 3), toggleAuto (copy, index: 4), u3 (ref, index: 5) ]]
            if Players_upv_1.LocalPlayer:GetAttribute("AtDigsite") ~= true and not (UserInputService_upv_1:GetFocusedTextBox()) and not (InputController_upv_1:IsWorldInputBlocked()) then
                if InputController_upv_1:IsNavigatingUi() or a3 ~= Enum.UserInputState.Begin then
                    return Enum.ContextActionResult.Pass
                end
                toggleAuto(u3)
                return Enum.ContextActionResult.Sink
            end
            return Enum.ContextActionResult.Pass
        end,
        false,
        Enum.ContextActionPriority.High.Value,
        Enum.KeyCode.DPadRight
    )
    local function onDataChanged() --[[ name: onDataChanged, line: 1295, upvalues: u72 (copy, index: 1), TapEffects_upv_1 (copy, index: 2), canClickAnywhere (copy, index: 3), u7 (ref, index: 4), setAutoVisual (copy, index: 5), refreshPreview (copy, index: 6) ]]
        local Data_1 = u72.Data
        TapEffects_upv_1:SetPointerEffectsEnabled((canClickAnywhere(Data_1)))
        if Data_1.Settings.AutoClickerEnabled ~= u7 then
            setAutoVisual(Data_1.Settings.AutoClickerEnabled == true)
        end
        refreshPreview(Data_1)
    end
    DataController_upv_1:ListenToPaths({{"Pets"}, {"Items"}, {"Mastery"}, {"Achievements"}}, onDataChanged, 0.25)
    DataController_upv_1:ListenToPaths({{"Statistics", "Rebirths"}, {"PromptedUIs"}, {"Progression"}, {"Upgrades"}, {"Boosts"}, {"SkillTree"}, {"Settings", "AutoClickerEnabled"}}, onDataChanged)
    Players_upv_1.LocalPlayer:GetAttributeChangedSignal("TotemClicksBoost"):Connect(
        function() --[[ line: 1308, upvalues: refreshPreview (copy, index: 1), u72 (copy, index: 2) ]]
            refreshPreview(u72.Data)
        end
    )
    local Arrow_upv_1 = Tap_upv_1.Arrow
    local tbl_upv_27 = {TweenService_upv_1:Create(Arrow_upv_1, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.fromScale(0.5, -1.2)}), TweenService_upv_1:Create(Arrow_upv_1, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.fromScale(0.862, 0.862)})}
    local function syncArrowTweens() --[[ name: syncArrowTweens, line: 1322, upvalues: tbl_upv_27 (copy, index: 1), Arrow_upv_1 (copy, index: 2) ]]
        for _, value_15 in tbl_upv_27 do
            if Arrow_upv_1.Visible then
                value_15:Play()
            else
                value_15:Pause()
            end
        end
    end
    Arrow_upv_1:GetPropertyChangedSignal("Visible"):Connect(syncArrowTweens)
    syncArrowTweens()
    task.spawn(
        function() --[[ line: 1329, upvalues: OnboardingFlow_upv_1 (copy, index: 1), u72 (copy, index: 2), Tap_upv_1 (ref, index: 3), u15 (ref, index: 4), TapIdleFade_upv_1 (copy, index: 5) ]]
            local v130 = 0
            while task.wait(1) do
                v130 = v130 + 1
                local v131 = OnboardingFlow_upv_1.IsGuided(u72.Data) or (OnboardingFlow_upv_1.IsPending(u72.Data))
                local Arrow_2 = Tap_upv_1.Arrow
                local v132 = not v131 and ((os.clock() - u15 > 30) and (v130 < 300))
                Arrow_2.Visible = v132
                local Update_1 = TapIdleFade_upv_1.Update
                v132 = not v131 and (not Tap_upv_1.Arrow.Visible)
                Update_1(v132)
            end
        end
    )
    InputHub_upv_1.Pointer(
        "TapController.ClickAnywhere",
        function(a4, a5) --[[ line: 1343, upvalues: worldTapsOpen (copy, index: 1), sendTap (copy, index: 2), playWorldClick (copy, index: 3) ]]
            if not worldTapsOpen() then
                return
            end
            if sendTap("screen", true, false, a5) == "Accepted" then
                playWorldClick(a5)
            end
        end,
        {SkipProcessed = true}
    )
    InputHub_upv_1.Ended(
        "TapController.WorldClickRelease",
        {Types = {Enum.UserInputType.MouseButton1}},
        function() --[[ line: 1348, upvalues: u42 (ref, index: 1), SoundController_upv_1 (copy, index: 2) ]]
            local v133 = u42
            if v133 == nil then
                return
            end
            u42 = nil
            SoundController_upv_1:Play("Click2", v133, 0.75)
        end
    )
    InputHub_upv_1.Began(
        "TapController.WorldHold",
        {SkipProcessed = true, Types = {Enum.UserInputType.Touch}},
        function(a6) --[[ line: 1355, upvalues: InputHub_upv_1 (copy, index: 1), worldTapsOpen (copy, index: 2), startTouchHold (copy, index: 3) ]]
            if (InputHub_upv_1.IsMoveStickTouch(a6)) or not worldTapsOpen() then
                return
            end
            startTouchHold(a6, false)
        end
    )
    InputHub_upv_1.Began(
        "TapController.TapKeys",
        {SkipProcessed = true, Keys = {Enum.KeyCode.E}},
        function() --[[ line: 1359, upvalues: sendTap (copy, index: 1) ]]
            sendTap("key_e", false, false)
        end
    )
    local tbl_28 = {}
    function tbl_28.CanFire() --[[ name: CanFire, line: 1366, upvalues: InputController_upv_1 (copy, index: 1) ]]
        return not InputController_upv_1:IsWorldInputBlocked()
    end
    TriggerHold_upv_1.Bind(
        "TapController.Trigger",
        tbl_28,
        function() --[[ line: 1369, upvalues: sendTap (copy, index: 1), tapButtonShown (copy, index: 2) ]]
            sendTap("pad_r2", false, tapButtonShown(), nil, true)
        end
    )
    local function CanFire() --[[ name: CanFire, line: 1376, upvalues: GuiService_upv_1 (copy, index: 1), Tap_upv_1 (ref, index: 2), InputController_upv_1 (copy, index: 3) ]]
        local v134 = (GuiService_upv_1.SelectedObject == Tap_upv_1.Button) and (not InputController_upv_1:IsWorldInputBlocked())
        return v134
    end
    TriggerHold_upv_1.Bind(
        "TapController.ConfirmHold",
        {Keys = MicroGamepad_upv_1.ConfirmKeys, CanFire = CanFire},
        function(a7) --[[ line: 1379, upvalues: sendTap (copy, index: 1) ]]
            if a7 then
                return
            end
            sendTap("pad_a", false, true, nil, true)
        end
    )
    UserInputService_upv_1.WindowFocusReleased:Connect(clearTouchHolds)
    Players_upv_1.LocalPlayer.CharacterRemoving:Connect(clearTouchHolds)
end
return tbl_2
