﻿function ()
function ExecEvent(state)
    ResetRequest()
    hkbFireEvent(state)
    
end

function ExecEventNoReset(state)
    hkbFireEvent(state)
    
end

function ExecEvents(...)
    local buff = {...}
    for , 1, #buff do
        ExecEvent(buff[f5265_local0])
    end
    
end

function ResetRequest()
    act(9101)
    act("自動捕捉対象クリア")
    
end

function GetVariable(variable)
    return hkbGetVariable(variable)
    
end

function ExecEventHalfBlend(event_table, blend_type)
    if blend_type == ALLBODY then
        SetVariable("MoveSpeedLevelReal", 0)
        local lower_event = event_table[1]
        local upper_event = lower_event .. "_Upper"
        for ExecEvents(lower_event, upper_event), 2, #event_table do
            SetVariable("LowerDefaultState0" .. f5268_local0 - 2, event_table[f5268_local0])
            SetVariable("UpperDefaultState0" .. f5268_local0 - 2, event_table[f5268_local0])
        end
    elseif blend_type == LOWER then
        ExecEvent(event_table[1])
        for , 2, #event_table do
            SetVariable("LowerDefaultState0" .. f5268_local3 - 2, event_table[f5268_local3])
        end
    elseif blend_type == UPPER then
        ExecEvent(event_table[1] .. "_Upper")
        for , 2, #event_table do
            SetVariable("UpperDefaultState0" .. f5268_local3 - 2, event_table[f5268_local3])
        end
    end
    
end

function ExecEventHalfBlendNoReset(event_table, blend_type)
    if blend_type == ALLBODY then
        local lower_event = event_table[1]
        local upper_event = lower_event .. "_Upper"
        ExecEventNoReset(lower_event)
        for ExecEventNoReset(upper_event), 2, #event_table do
            SetVariable("LowerDefaultState0" .. f5269_local0 - 2, event_table[f5269_local0])
            SetVariable("UpperDefaultState0" .. f5269_local0 - 2, event_table[f5269_local0])
        end
    elseif blend_type == LOWER then
        ExecEventNoReset(event_table[1])
        for , 2, #event_table do
            SetVariable("LowerDefaultState0" .. f5269_local3 - 2, event_table[f5269_local3])
        end
    elseif blend_type == UPPER then
        ExecEventNoReset(event_table[1] .. "_Upper")
        for , 2, #event_table do
            SetVariable("UpperDefaultState0" .. f5269_local3 - 2, event_table[f5269_local3])
        end
    end
    
end

function ExecEventAllBody(event)
    SetVariable("MoveSpeedLevelReal", 0)
    ExecEvent(event)
    
end

function IsNodeActive(...)
    local buff = {...}
    for , 1, #buff do
        if hkbIsNodeActive(buff[f5271_local0]) then
            return TRUE
        end
    end
    local f5271_local0 = FALSE
    return f5271_local0
    
end

function ResetEventState()
    SetVariable("MoveSpeedLevelReal", 0)
    ResetRequest()
    
end

function Replanning()
    act("キャンセルタイミングでAIへのリプランニング要求")
    
end

function AddStamina(num)
    act(110)
    act(1001, num)
    
end

function SetMoveWeightIndex()
    SetVariable("MoveWeightIndex", GetWeightIndex(TRUE))
    
end

function SetBaseCategory()
    SetVariable("IndexBaseCategory", GetBaseCategory())
    
end

function SetStyleSpecialEffect()
    if c_Style == HAND_LEFT_BOTH then
        if env(ESD_ENV_DS3GetSpecialEffectID, 139995) == FALSE then
            act(2002, 139995)
        end
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 139990) == FALSE then
        act(2002, 139990)
    end
    
end

function SetMoveType()
    if env(ESD_ENV_DS3GetSpecialEffectID, 100130) == TRUE then
        SetVariable("MoveType", 1)
        SetVariable("DrawStanceLoopUpperBlend", 1)
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100140) == TRUE then
        SetVariable("MoveType", 2)
        SetVariable("DrawStanceLoopUpperBlend", 1)
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100150) == TRUE then
        SetVariable("MoveType", 0)
        SetVariable("DrawStanceLoopUpperBlend", 1)
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100160) == TRUE then
        SetVariable("MoveType", 0)
        SetVariable("DrawStanceLoopUpperBlend", 1)
    else
        SetVariable("MoveType", 3)
        SetVariable("DrawStanceLoopUpperBlend", 1)
    end
    return 
    
end

function SetThrowDefBlendWeight()
    if env(ESD_ENV_DS3DoesAnimExist, GetVariable("ThrowID") + 4) == FALSE then
        return 
    end
    local regist_num = env(ESD_ENV_DS3GetThrowDefenseCount)
    local dT = GetDeltaTime()
    local blend_weight = GetVariable("ThrowHoldBlendWeight")
    local is_holding = GetVariable("ThrowHolding")
    local no_regist_time = GetVariable("ThrowNoRegistTime")
    if regist_num > 0 then
        is_holding = true
    end
    if is_holding == true then
        if regist_num <= 0 then
            no_regist_time = no_regist_time + dT
        end
        if no_regist_time > 0.699999988079071 then
            is_holding = false
        else
            blend_weight = blend_weight + 2 * dT
            if blend_weight > 0.9900000095367432 then
                blend_weight = 0.9900000095367432
            end
            SetVariable("IsEnableTAEThrowHold", true)
        end
    else
        no_regist_time = 0
        blend_weight = blend_weight - 4 * dT
        if blend_weight < 0.009999999776482582 then
            blend_weight = 0.009999999776482582
            SetVariable("IsEnableTAEThrowHold", false)
        else
            SetVariable("IsEnableTAEThrowHold", true)
        end
    end
    SetVariable("ThrowHoldBlendWeight", blend_weight)
    SetVariable("ThrowHolding", is_holding)
    SetVariable("ThrowNoRegistTime", no_regist_time)
    
end

function SetTurnSpeed(turn_speed)
    act(2004, turn_speed)
    
end

function SetRollingTurnCondition(is_selftrans)
    local rolling_angle = "RollingAngleReal"
    if is_selftrans == TRUE then
        rolling_angle = "RollingAngleRealSelftrans"
    end
    if GetVariable("IsLockon") == true then
        local angle = GetVariable("TurnAngleReal")
        if angle > 180 then
            SetTurnSpeed(0)
        elseif angle > 90 then
            SetTurnSpeed(360)
        end
    elseif TRUE == env(ESD_ENV_IsPrecisionShoot) then
        SetTurnSpeed(0)
        SetVariable("TurnAngleReal", 300)
    elseif math.abs(GetVariable(rolling_angle)) > 0.0010000000474974513 then
        SetTurnSpeed(0)
    elseif GetVariable("TurnAngleReal") > 200 then
        SetTurnSpeed(0)
    end
    
end

function SetAIActionState()
    act(9103, 1)
    
end

function SetAttackHand(hand)
    act("武器パラメータ参照先", hand)
    
end

function SetInterruptType(num)
    act("AI通知攻撃タイプ", num)
    
end

function SetArtsGeneratorTransitionIndex(gen_hand, is_from)
    if gen_hand == FALSE then
        SetVariable("ArtsTransition", 0)
        return 
    end
    if IsNonGeneratorTransition() == TRUE then
        SetVariable("ArtsTransition", 0)
        return 
    end
    local hand = HAND_LEFT
    local f5285_local0 = GEN_TRANS_RIGHT
    if gen_hand == f5285_local0 then
        hand = HAND_RIGHT
    end
    local offset = 0
    if is_from == TRUE and env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_FIST then
        offset = 4
        hand = HAND_RIGHT
    end
    local changetype = GetHandChangeType(hand)
    if offset == 4 and env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT) == 161 then
        offset = 0
        changetype = WEAPON_CHANGE_REQUEST_LEFT_BACK
    end
    if changetype == WEAPON_CHANGE_REQUEST_LEFT_WAIST or changetype == WEAPON_CHANGE_REQUEST_RIGHT_WAIST then
        SetVariable("ArtsTransition", 1 + offset)
    elseif changetype == WEAPON_CHANGE_REQUEST_LEFT_BACK or changetype == WEAPON_CHANGE_REQUEST_RIGHT_BACK then
        SetVariable("ArtsTransition", 2 + offset)
    elseif changetype == WEAPON_CHANGE_REQUEST_LEFT_SHOULDER or changetype == WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER then
        SetVariable("ArtsTransition", 3 + offset)
    elseif changetype == WEAPON_CHANGE_REQUEST_LEFT_SPEAR or changetype == WEAPON_CHANGE_REQUEST_RIGHT_SPEAR then
        SetVariable("ArtsTransition", 4 + offset)
    else
        SetVariable("ArtsTransition", 0)
    end
    return 
    
end

function GetDeltaTime()
    return env(ESD_ENV_ObtainedDT) / 1000
    
end

function GetConstVariable()
    c_HasActionRequest = IsActionRequest()
    local f5287_local0, f5287_local1 = GetSwordArtsInfo()
    c_SwordArtsHand = f5287_local1
    c_SwordArtsID = f5287_local0
    f5287_local0 = IsEnableSwordArts
    f5287_local0 = f5287_local0()
    c_IsEnableSwordArts = f5287_local0
    f5287_local0 = env
    f5287_local1 = 207
    f5287_local0 = f5287_local0(f5287_local1)
    c_Style = f5287_local0
    
end

function GetMoveSpeed(stick_level)
    local speed = GetVariable("MoveSpeedLevelReal")
    local inc_val = ACCELERATION_WALK_SPEED_UP
    local dec_val = ACCELERATION_SPEED_DOWN
    if stick_level == 2 then
        inc_val = ACCELERATION_DASH_SPEED_UP
        dec_val = ACCELERATION_DASH_SPEED_DOWN
    end
    local ret = ConvergeValue(stick_level, speed, inc_val, dec_val)
    return ret
    
end

function GetWeightIndex(is_move)
    local move_id = env(ESD_ENV_GetMoveAnimParamID)
    local move_weight = MOVE_WEIGHT_NORMAL
    local evasion_weight = EVASION_WEIGHT_INDEX_MEDIUM
    if move_id == WEIGHT_LIGHT or move_id == WEIGHT_LIGHT + 20 or move_id == WEIGHT_LIGHT + 40 or move_id == WEIGHT_LIGHT + 60 then
        move_weight = MOVE_WEIGHT_LIGHT
        evasion_weight = EVASION_WEIGHT_INDEX_LIGHT
    elseif move_id == WEIGHT_HEAVY or move_id == WEIGHT_HEAVY + 20 or move_id == WEIGHT_HEAVY + 40 or move_id == WEIGHT_HEAVY + 60 then
        move_weight = MOVE_WEIGHT_HEAVY
        evasion_weight = EVASION_WEIGHT_INDEX_HEAVY
    elseif move_id == WEIGHT_OVERWEIGHT or move_id == WEIGHT_OVERWEIGHT + 20 or move_id == WEIGHT_OVERWEIGHT + 40 or move_id == WEIGHT_OVERWEIGHT + 60 then
        move_weight = MOVE_WEIGHT_HEAVY
        evasion_weight = EVASION_WEIGHT_INDEX_OVERWEIGHT
    elseif move_id == WEIGHT_SUPERLIGHT or move_id == WEIGHT_SUPERLIGHT + 20 or move_id == WEIGHT_SUPERLIGHT + 40 or move_id == WEIGHT_SUPERLIGHT + 60 then
        move_weight = MOVE_WEIGHT_LIGHT
        evasion_weight = EVASION_WEIGHT_INDEX_SUPERLIGHT
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 130110) == TRUE then
        if move_weight < MOVE_WEIGHT_HEAVY then
            move_weight = MOVE_WEIGHT_HEAVY
        end
        if evasion_weight < EVASION_WEIGHT_INDEX_HEAVY then
            evasion_weight = EVASION_WEIGHT_INDEX_HEAVY
        end
    elseif env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_GRAVITY_MEDIUM) == TRUE then
        if move_weight < MOVE_WEIGHT_HEAVY then
            move_weight = MOVE_WEIGHT_HEAVY
        end
        if evasion_weight < EVASION_WEIGHT_INDEX_HEAVY then
            evasion_weight = EVASION_WEIGHT_INDEX_HEAVY
        end
    elseif env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_GRAVITY_WEAK) == TRUE and move_weight < MOVE_WEIGHT_HEAVY then
        move_weight = MOVE_WEIGHT_HEAVY
    end
    local weight = evasion_weight
    if is_move == TRUE then
        weight = move_weight
    end
    return weight
    
end

function GetHalfBlendInfo()
    local blend_type = ALLBODY
    local lower_state = LOWER_IDLE
    if GetLocomotionState() == PLAYER_STATE_MOVE then
        blend_type = UPPER
        lower_state = LOWER_MOVE
    elseif IsLowerQuickTurn() == TRUE then
        if TRUE == IsExitLowerQuickTurn() then
            lower_state = LOWER_END_TURN
        else
            blend_type = UPPER
            lower_state = LOWER_TURN
        end
    end
    return blend_type, lower_state
    
end

function GetLocomotionState()
    local state = GetVariable("LowerDefaultState00")
    if state == MOVE_DEF0 or state == MOVECEREMONY_DEF0 then
        if env(ESD_ENV_DS3GetSpecialEffectID, 100000) == TRUE then
            return PLAYER_STATE_MOVE
        elseif env(ESD_ENV_DS3GetSpecialEffectID, 100001) == TRUE then
            return PLAYER_STATE_MOVE
        elseif env(ESD_ENV_DS3GetSpecialEffectID, 100002) == TRUE then
            return PLAYER_STATE_MOVE
        end
    end
    return PLAYER_STATE_IDLE
    
end

function GetBaseCategory()
    local basecategoryid = 0
    if kind_special == 50 then
        basecategoryid = 0
    else
        basecategoryid = env(ESD_ENV_DS3GetStayAnimCategory)
    end
    local index = 0
    if basecategoryid == 0 then
        index = 0
    elseif basecategoryid == 2 or basecategoryid == 12 then
        index = 1
    elseif basecategoryid == 3 or basecategoryid == 13 then
        index = 2
    end
    return index
    
end

function GetEquipType(hand, ...)
    local buff = {...}
    local kind = {}
    local num = 1
    if hand == HAND_BOTH then
        kind[1] = env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT)
        kind[2] = env(ESD_ENV_GetEquipWeaponCategory, HAND_RIGHT)
        num = 2
    else
        kind[1] = env(ESD_ENV_GetEquipWeaponCategory, hand)
    end
    for , 1, num do
        for , 1, #buff do
            if kind[f5293_local0] == buff[f5293_local3] then
                return TRUE
            end
        end
    end
    local f5293_local0 = FALSE
    return f5293_local0
    
end

function GetWeaponChangeType(hand)
    local left_offset = 0
    local pos = env(ESD_ENV_DS3GetWeaponStorageSpotType, hand)
    if hand == HAND_LEFT then
        left_offset = 4
    end
    if pos == 0 then
        return WEAPON_CHANGE_REQUEST_RIGHT_WAIST + left_offset
    elseif pos == 1 then
        return WEAPON_CHANGE_REQUEST_RIGHT_BACK + left_offset
    elseif pos == 2 then
        return WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER + left_offset
    elseif pos == 3 then
        return WEAPON_CHANGE_REQUEST_RIGHT_SPEAR + left_offset
    end
    return WEAPON_CHANGE_REQUEST_INVALID
    
end

function GetHandChangeType(hand)
    local left_offset = 0
    local pos = env(ESD_ENV_DS3GetWeaponStorageSpotType, hand)
    if hand == HAND_LEFT then
        left_offset = 4
    end
    if pos == 0 then
        return WEAPON_CHANGE_REQUEST_RIGHT_WAIST + left_offset
    elseif pos == 1 then
        return WEAPON_CHANGE_REQUEST_RIGHT_BACK + left_offset
    elseif pos == 2 then
        return WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER + left_offset
    elseif pos == 3 then
        return WEAPON_CHANGE_REQUEST_RIGHT_SPEAR + left_offset
    end
    return WEAPON_CHANGE_REQUEST_INVALID
    
end

function GetSwordArtsInfo()
    local style = c_Style
    local is_both = FALSE
    local f5296_local0 = HAND_LEFT_BOTH
    if f5296_local0 <= style then
        is_both = TRUE
    end
    local arts_id = 0
    local arts_hand = 0
    if is_both == TRUE then
        if style == HAND_RIGHT_BOTH then
            arts_hand = HAND_RIGHT
        elseif style == HAND_LEFT_BOTH then
            arts_hand = HAND_LEFT
        end
        arts_id = env(ESD_ENV_GetWeaponID, arts_hand)
    else
        local weaponswordartid = env(ESD_ENV_GetWeaponID, HAND_LEFT)
        if weaponswordartid == SWORDARTS_RIGHTARTS then
            arts_hand = HAND_RIGHT
            arts_id = env(ESD_ENV_GetWeaponID, HAND_RIGHT)
        else
            arts_hand = HAND_LEFT
            arts_id = weaponswordartid
        end
        if env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_FIST then
            if arts_hand == HAND_LEFT then
                if arts_id ~= SWORDARTS_ONESHOTFULL then
                    arts_id = SWORDARTS_PARRY
                end
            elseif arts_id == SWORDARTS_RIGHTARTS then
                arts_id = SWORDARTS_PARRY
                arts_hand = HAND_LEFT
            end
        end
    end
    return arts_id, arts_hand
    
end

function GetSwordArtsRequest()
    local style = c_Style
    local is_both = FALSE
    local arts_id = c_SwordArtsID
    if style >= HAND_LEFT_BOTH then
        is_both = TRUE
    end
    if is_both == TRUE then
        local request = arts_id + 200
        return request
    elseif c_SwordArtsHand == HAND_RIGHT then
        local request = arts_id + 200
        return request
    else
        local request = arts_id + 100
        return request
    end
    
end

function GetAttackRequest(is_guard)
    local style = c_Style
    local is_both = FALSE
    local is_both_right = FALSE
    if style >= HAND_LEFT_BOTH then
        is_both = TRUE
    end
    local f5298_local0 = HAND_RIGHT_BOTH
    if style == f5298_local0 then
        is_both_right = TRUE
    end
    local hand = HAND_RIGHT
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local is_arrow = GetEquipType(hand, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW)
    local is_crossbow = GetEquipType(hand, WEAPON_CATEGORY_CROSSBOW)
    local is_staff = GetEquipType(hand, WEAPON_CATEGORY_STAFF)
    if TRUE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_R1) then
        if is_both == TRUE then
            if is_arrow == TRUE then
                act("弓矢スロット選択", 0)
                return ATTACK_REQUEST_ARROW_FIRE_RIGHT
            elseif is_crossbow == TRUE then
                act("弓矢スロット選択", 0)
                if style == HAND_LEFT_BOTH then
                    return ATTACK_REQUEST_BOTHLEFT_CROSSBOW
                else
                    return ATTACK_REQUEST_BOTHRIGHT_CROSSBOW
                end
            elseif is_staff == TRUE then
                return ATTACK_REQUEST_INVALID
            end
            if TRUE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_LIGHT_KICK) then
                return ATTACK_REQUEST_LIGHT_KICK
            else
                return ATTACK_REQUEST_BOTH_LIGHT
            end
        else
            if is_guard == TRUE then
                local is_spear = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SPEAR)
                local is_rapier = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_RAPIER)
                if is_spear == TRUE or is_rapier == TRUE then
                    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L1) > 0 then
                        return ATTACK_REQUEST_ATTACK_WHILE_GUARD
                    end
                else
                    if is_staff == TRUE then
                        return ATTACK_REQUEST_INVALID
                    end
                    if is_arrow == TRUE then
                        return ATTACK_REQUEST_ARROW_BOTH_RIGHT
                    end
                    if is_crossbow == TRUE then
                        act("弓矢スロット選択", 0)
                        return ATTACK_REQUEST_RIGHT_CROSSBOW
                    end
                end
            else
                if is_staff == TRUE then
                    return ATTACK_REQUEST_INVALID
                end
                if is_arrow == TRUE then
                    return ATTACK_REQUEST_ARROW_BOTH_RIGHT
                end
                if is_crossbow == TRUE then
                    act("弓矢スロット選択", 0)
                    return ATTACK_REQUEST_RIGHT_CROSSBOW
                end
            end
            if TRUE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_LIGHT_KICK) then
                return ATTACK_REQUEST_LIGHT_KICK
            else
                return ATTACK_REQUEST_RIGHT_LIGHT
            end
        end
    end
    if TRUE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_R2) then
        if is_arrow == TRUE then
            if is_both == TRUE then
                act("弓矢スロット選択", 1)
                return ATTACK_REQUEST_ARROW_FIRE_RIGHT2
            else
                return ATTACK_REQUEST_ARROW_BOTH_RIGHT
            end
        elseif is_crossbow == TRUE then
            if is_both == TRUE then
                if style == HAND_LEFT_BOTH then
                    act("弓矢スロット選択", 1)
                    return ATTACK_REQUEST_BOTHLEFT_CROSSBOW2
                else
                    act("弓矢スロット選択", 1)
                    return ATTACK_REQUEST_BOTHRIGHT_CROSSBOW2
                end
            else
                act("弓矢スロット選択", 1)
                return ATTACK_REQUEST_RIGHT_CROSSBOW2
            end
        else
            if TRUE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_HEAVY_KICK) then
                local check_weapon = GetEquipType(hand, WEAPON_CATEGORY_STAFF)
                if check_weapon == FALSE and FALSE == env(ESD_ENV_DS3GetSpecialEffectID, 100260) then
                    return ATTACK_REQUEST_HEAVY_KICK
                end
            end
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
            if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 then
                return ATTACK_REQUEST_INVALID
            end
            if sp_kind == 257 and FALSE == env(ESD_ENV_DS3GetSpecialEffectID, 100580) then
                return ATTACK_REQUEST_INVALID
            end
            if is_both == TRUE then
                return ATTACK_REQUEST_BOTH_HEAVY
            else
                return ATTACK_REQUEST_RIGHT_HEAVY
            end
        end
    end
    if TRUE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_L1) then
        if TRUE == env(ESD_ENV_IsPrecisionShoot) then
            return ATTACK_REQUEST_INVALID
        end
        if is_both == TRUE then
            if is_arrow == TRUE or is_crossbow == TRUE then
                return ATTACK_REQUEST_INVALID
            end
        else
            is_arrow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW)
            if is_arrow == TRUE then
                return ATTACK_REQUEST_ARROW_BOTH_LEFT
            end
            is_crossbow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW)
            if is_crossbow == TRUE then
                act("弓矢スロット選択", 0)
                return ATTACK_REQUEST_LEFT_CROSSBOW
            end
        end
        if is_both == TRUE then
            if c_SwordArtsID ~= 32 then
                if TRUE == IsDualBlade() then
                    return ATTACK_REQUEST_BOTH_LEFT
                end
            else
                return ATTACK_REQUEST_INVALID
            end
        end
        if is_both == FALSE then
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
            if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
                return ATTACK_REQUEST_LEFT_HEAVY
            end
            if sp_kind == 99 or sp_kind == 101 or sp_kind == 137 or sp_kind == 151 or sp_kind == 164 or sp_kind == 218 then
                return ATTACK_REQUEST_LEFT_HEAVY_SP
            end
        end
        local is_shield_left = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_SHIELD, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_TORCH)
        local is_shield_right = GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_SHIELD, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_TORCH)
        if is_shield_left == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        if is_shield_right == TRUE and is_both_right == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        if TRUE == IsEnableGuard() then
            return ATTACK_REQUEST_INVALID
        end
        is_shield_left = GetEquipType
        is_shield_right = HAND_LEFT
        is_staff = is_shield_left(is_shield_right, WEAPON_CATEGORY_STAFF)
        if is_staff == TRUE then
            return ATTACK_REQUEST_INVALID
        end
        if is_both == FALSE then
            is_shield_left = env
            is_shield_right = 225
            if is_shield_left(is_shield_right, HAND_LEFT) == 42 then
                return ATTACK_REQUEST_LEFT_HEAVY
            end
        end
        return ATTACK_REQUEST_LEFT_LIGHT
    end
    if TRUE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_L2) then
        if is_both == FALSE then
            is_crossbow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_CROSSBOW)
            is_arrow = GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW)
            if is_crossbow == TRUE then
                act("弓矢スロット選択", 1)
                return ATTACK_REQUEST_LEFT_CROSSBOW2
            end
            if is_arrow == TRUE then
                return ATTACK_REQUEST_ARROW_BOTH_LEFT
            end
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
            if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
                return ATTACK_REQUEST_INVALID
            end
        end
        if TRUE == c_IsEnableSwordArts then
            local swordartrequest = GetSwordArtsRequest()
            if swordartrequest == SWORDARTS_REQUEST_LEFT_CHARGESHOT or swordartrequest == SWORDARTS_REQUEST_RIGHT_CHAINSHOT or swordartrequest == SWORDARTS_REQUEST_LEFT_CHAINSHOT or swordartrequest == SWORDARTS_REQUEST_RIGHT_CHARGESHOT or swordartrequest == SWORDARTS_REQUEST_LEFT_STRONGSHOT or swordartrequest == SWORDARTS_REQUEST_RIGHT_STRONGSHOT or swordartrequest == SWORDARTS_REQUEST_LEFT_WIDESHOT or swordartrequest == SWORDARTS_REQUEST_RIGHT_WIDESHOT then
                local f5298_local1 = FALSE
                if is_both == f5298_local1 then
                    local arts_hand = c_SwordArtsHand
                    if arts_hand == HAND_RIGHT then
                        return ATTACK_REQUEST_ARROW_BOTH_RIGHT
                    else
                        return ATTACK_REQUEST_ARROW_BOTH_LEFT
                    end
                end
            end
            return swordartrequest
        elseif style >= HAND_LEFT_BOTH then
            return ATTACK_REQUEST_BOTH_HEAVY
        else
            return ATTACK_REQUEST_LEFT_HEAVY
        end
    end
    return ATTACK_REQUEST_INVALID
    
end

function GetEvasionRequest()
    if env(ESD_ENV_GetStamina) < STAMINA_MINIMUM then
        return ATTACK_REQUEST_INVALID
    end
    if env(ESD_ENV_DS3ActionRequest, ACTION_ARM_JUMP) == TRUE then
        local speed = GetVariable("MoveSpeedLevelReal")
        if speed > SPEED_ENABLE_JUMP then
            return ATTACK_REQUEST_JUMP
        end
    end
    if env(ESD_ENV_DS3ActionRequest, ACTION_ARM_ROLLING) == TRUE then
        return ATTACK_REQUEST_ROLLING
    elseif env(ESD_ENV_DS3ActionRequest, ACTION_ARM_BACKSTEP) == TRUE then
        return ATTACK_REQUEST_BACKSTEP
    end
    return ATTACK_REQUEST_INVALID
    
end

function GetLadderEventCommand(is_start)
    if env(ESD_ENV_IsCOMPlayer) == FALSE then
        return env(ESD_ENV_GetCommandIDFromEvent, 0)
    else
        local req_up = env(ESD_ENV_DS3ActionRequest, ACTION_ARM_LADDERUP)
        local req_down = env(ESD_ENV_DS3ActionRequest, ACTION_ARM_LADDERDOWN)
        if is_start == TRUE then
            if req_up == TRUE then
                return LADDER_ACTION_START_BOTTOM
            elseif req_down == TRUE then
                return LADDER_ACTION_START_TOP
            end
        elseif req_up == TRUE then
            if env(ESD_ENV_IsReachTopOfLadder) == TRUE then
                return LADDER_EVENT_COMMAND_END_TOP
            else
                return LADDER_EVENT_COMMAND_UP
            end
        elseif req_down == TRUE then
            if env(ESD_ENV_IsReachBottomOfLadder) == TRUE then
                return LADDER_EVENT_COMMAND_END_BOTTOM
            else
                return LADDER_EVENT_COMMAND_DOWN
            end
        end
        return INVALID
    end
    
end

function SetVariable(name, value)
    act(148, name, value)
    
end

function SetHandChangeStyle(s, e)
    SetVariable("HandChangeStartIndex", s)
    SetVariable("HandChangeEndIndex", e)
    
end

function SetEvasionStaminaCost()
    local weight = env(ESD_ENV_GetMoveAnimParamID)
    if weight == WEIGHT_LIGHT then
        c_StaminaCostRolling = -16
        c_StaminaCostBackStep = -11
        c_StaminaCostJump = -16
    elseif weight == WEIGHT_NORMAL then
        c_StaminaCostRolling = -16
        c_StaminaCostBackStep = -11
        c_StaminaCostJump = -16
    elseif weight == WEIGHT_HEAVY then
        c_StaminaCostRolling = -16
        c_StaminaCostBackStep = -11
        c_StaminaCostJump = -16
    elseif weight == WEIGHT_OVERWEIGHT then
        c_StaminaCostRolling = -26
        c_StaminaCostBackStep = -18
        c_StaminaCostJump = -26
    else
        c_StaminaCostRolling = -16
        c_StaminaCostBackStep = -11
        c_StaminaCostJump = -16
    end
    
end

function SetSwordArtsCancelType()
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    if IsEnableSwordArts() == TRUE then
        act(2011, env(ESD_ENV_GetWeaponCancelType, c_SwordArtsHand))
    else
        act(2011, 0)
    end
    
end

function SetGender()
    if env(ESD_ENV_DS3GetSpecialEffectID, 112074000) == TRUE then
        if env(ESD_ENV_DS3IsFemale) == TRUE then
            c_IsFemale = FALSE
        else
            c_IsFemale = TRUE
        end
    elseif env(ESD_ENV_DS3IsFemale) == TRUE then
        c_IsFemale = TRUE
    else
        c_IsFemale = FALSE
    end
    
end

function SetSwordArtsPointInfo(button, is_point_consume)
    local hand = c_SwordArtsHand
    if is_point_consume == TRUE then
        act("アーツポイント使用予約", button, hand)
    end
    local sel = 0
    if env(ESD_ENV_DS3HasEnoughArtsPoints, button, hand) == FALSE then
        sel = 1
    elseif env(ESD_ENV_GetWeaponDurability, hand) == 0 then
        sel = 1
    elseif env(ESD_ENV_IsAbilityInsufficient, hand) == TRUE then
        sel = 1
    elseif c_SwordArtsID == SWORDARTS_MAGICBUFFPRAY and env(ESD_ENV_DS3GetSpecialEffectID, 135000) == FALSE then
        sel = 1
    end
    local val = "IsEnoughArtPointsL2"
    if button == ACTION_ARM_R1 then
        if TRUE == IsNodeActive("DrawStanceRightAttackLight_Selector") then
            val = "IsEnoughArtPointsR1_2"
        elseif TRUE == IsNodeActive("DrawStanceRightAttackLight2_Selector") then
            val = "IsEnoughArtPointsR1_3"
        else
            val = "IsEnoughArtPointsR1"
        end
    elseif button == ACTION_ARM_R2 then
        if TRUE == IsNodeActive("DrawStanceRightAttackHeavy_Selector") or TRUE == IsNodeActive("Charge_Upper_Selector") then
            val = "IsEnoughArtPointsR2_2"
        elseif TRUE == IsNodeActive("ChargeContinue_Selector") then
            val = "IsEnoughArtPointsR2_3"
        else
            val = "IsEnoughArtPointsR2"
        end
    elseif button == ACTION_ARM_L2 then
        if TRUE == IsNodeActive("MagicBuffRight_Upper_Selector") or TRUE == IsNodeActive("MagicBuffLeft_Upper_Selector") then
            local sp_kind_L = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
            local sp_kind_R = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)
            local style = c_Style
            if sp_kind_L == 265 and sp_kind_R == 265 then
                DebugPrint(1, style)
                if style == HAND_BOTH or style == HAND_LEFT_BOTH or style == HAND_RIGHT_BOTH then
                    val = "IsEnoughArtPointsL2_2"
                else
                    val = "IsEnoughArtPointsL2_3"
                end
            else
                val = "IsEnoughArtPointsL2_2"
            end
        elseif TRUE == IsNodeActive("MagicBuffRight2_Selector") or TRUE == IsNodeActive("MagicBuffLeft2_Selector") then
            val = "IsEnoughArtPointsL2_3"
        elseif TRUE == IsNodeActive("MagicBuffRight3_Selector") or TRUE == IsNodeActive("MagicBuffLeft3_Selector") then
            val = "IsEnoughArtPoints_L2_2"
        end
    end
    SetVariable(val, sel)
    
end

function SetAttackQueue(r1, r2, l1, l2, b1, b2)
    g_r1 = r1
    g_r2 = r2
    g_l1 = l1
    g_l2 = l2
    g_b1 = b1
    g_b2 = b2
    
end

function ClearAttackQueue()
    g_r1 = "W_AttackRightLight1"
    g_r2 = "W_AttackRightHeavy1Start"
    g_l1 = "W_AttackLeftLight1"
    g_l2 = "W_AttackLeftHeavy1"
    g_b1 = "W_AttackBothLight1"
    g_b2 = "W_AttackBothHeavy1Start"
    
end

function UpdateOldMonkState()
    if env(ESD_ENV_DS3GetSpecialEffectID, 9130) == FALSE then
        if env(ESD_ENV_DS3GetSpecialEffectID, 9139) == FALSE then
            act(2002, 9139)
        end
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 9139) == TRUE then
        act(2002, 9133)
    end
    
end

function UpdateAtkAutoAim()
    local aim_time = GetVariable("AtkAutoAimTime")
    local upper_limit = 0.16599999368190765
    if GetVariable("AtkAutoAimFlag") == true and GetVariable("AtkAutoAimTime") < upper_limit and GetVariable("IsLockon") == false then
        act("自動捕捉対象設定")
    end
    if aim_time < upper_limit then
        SetVariable("AtkAutoAimTime", aim_time + GetDeltaTime())
    else
        SetVariable("AtkAutoAimFlag", false)
    end
    if math.abs(GetVariable("MoveAngle")) > 30 then
        act("自動捕捉対象クリア")
    end
    
end

function IsEnableSwordArts()
    local style = c_Style
    local arts_id = c_SwordArtsID
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    if style ~= HAND_LEFT_BOTH and c_SwordArtsHand == 0 then
        if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
            return FALSE
        end
        if arts_id == SWORDARTS_PARRY or arts_id == SWORDARTS_SPIN or arts_id == SWORDARTS_STRONGBASH or arts_id == SWORDARTS_CHAINSHOT or arts_id == SWORDARTS_MAGICBUFF or arts_id == SWORDARTS_SAMAGIC or arts_id == SWORDARTS_CHARGESHOT or arts_id == SWORDARTS_ONESHOTFULL or arts_id == SWORDARTS_STRONGSHOT or arts_id == SWORDARTS_SAMAGICMEDIUM or arts_id == SWORDARTS_SAMAGICSTRONG or arts_id == SWORDARTS_WIDESHOT or arts_id == SWORDARTS_MAGICBUFFPRAY or arts_id == SWORDARTS_MAGICBUFFATTACK then
            return TRUE
        end
    elseif arts_id ~= SWORDARTS_RIGHTARTS and arts_id ~= SWORDARTS_INVALID then
        return TRUE
    end
    return FALSE
    
end

function IsAttackMagic(index)
    for , 1, #AttackMagicIndex do
        if AttackMagicIndex[f5312_local0] == index then
            return TRUE
        end
    end
    local f5312_local0 = FALSE
    return f5312_local0
    
end

function IsExistArrow()
    local style = c_Style
    local hand = HAND_RIGHT
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    return env(ESD_ENV_IsOutOfAmmo, hand)
    
end

function IsExistBolt(hand)
    return env(ESD_ENV_IsOutOfAmmo, hand)
    
end

function IsEnoughWeaponReleaseStatus(hand)
    return env(ESD_ENV_DS3HasReachedStatsNeededForWeapon, hand)
    
end

function IsActionRequest()
    return env(ESD_ENV_DS3HasActionRequest)
    
end

function IsLowerQuickTurn()
    if GetVariable("LowerDefaultState00") == QUICKTURN_DEF0 and env(ESD_ENV_DS3GetSpecialEffectID, 100010) == TRUE then
        return TRUE
    end
    return FALSE
    
end

function IsExitLowerQuickTurn()
    if env(ESD_ENV_IsAnimEnd, 2) == TRUE or env(ESD_ENV_GetEventEzStateFlag, 1) == TRUE then
        return TRUE
    end
    if GetVariable("IsLockon") == false then
        return TRUE
    end
    return FALSE
    
end

function IsNonGeneratorTransition()
    local style = c_Style
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand)
    if env(ESD_ENV_DS3GetSpecialEffectID, 100500) == TRUE then
        return TRUE
    elseif sp_kind == 232 then
        if GetVariable("MoveSpeedLevel") > 0 and env(ESD_ENV_DS3GetSpecialEffectID, 100490) == TRUE then
            return FALSE
        else
            return TRUE
        end
    elseif sp_kind == 256 then
        return TRUE
    end
    if style ~= HAND_RIGHT then
        SetVariable("ArtsTransition", 0)
        return TRUE
    end
    local kind_right = env(ESD_ENV_GetEquipWeaponCategory, HAND_RIGHT)
    if c_SwordArtsID == SWORDARTS_DRAWSTANCE and kind_right == WEAPON_CATEGORY_RAPIER then
        return TRUE
    end
    if FALSE == IsDualBlade() then
        local kind_left = env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT)
        if kind_left == WEAPON_CATEGORY_FIST then
            return TRUE
        end
    end
    return FALSE
    
end

function IsHoldMagic()
    local magic_type = env(ESD_ENV_GetMagicAnimType)
    if magic_type == MAGIC_REQUEST_FLAMETHROWER then
        SetVariable("IndexHoldMagicType", 0)
        return TRUE
    elseif magic_type == MAGIC_REQUEST_PRAYHOLD then
        SetVariable("IndexHoldMagicType", 1)
        return TRUE
    elseif magic_type == MAGIC_REQUEST_AOEPRAYHOLD then
        SetVariable("IndexHoldMagicType", 2)
        return TRUE
    elseif magic_type == MAGIC_REQUEST_SLASHHOLD then
        SetVariable("IndexHoldMagicType", 3)
        return TRUE
    elseif magic_type == MAGIC_REQUEST_BOW then
        SetVariable("IndexHoldMagicType", 4)
        return TRUE
    else
        return FALSE
    end
    
end

function IsQuickMagic()
    local magic_type = env(ESD_ENV_GetMagicAnimType)
    if magic_type == MAGIC_REQUEST_QUICKENBULLET then
        SetVariable("IndexQuickMagicType", 0)
        return TRUE
    elseif magic_type == MAGIC_REQUEST_QUICKSLASH then
        SetVariable("IndexQuickMagicType", 1)
        return TRUE
    else
        return FALSE
    end
    
end

function IsComboMagic()
    local magic_type = env(ESD_ENV_GetMagicAnimType)
    if magic_type == MAGIC_REQUEST_FAN then
        return TRUE
    else
        return FALSE
    end
    
end

function IsLoopMagic()
    local magic_type = env(ESD_ENV_GetMagicAnimType)
    if magic_type == MAGIC_REQUEST_FLAMETHROWER then
        SetVariable("IndexLoopMagicType", 0)
        return TRUE
    else
        return FALSE
    end
    
end

function IsWeaponCanGuard()
    local style = c_Style
    local kind = 0
    local pos = 0
    if style == HAND_RIGHT or style == HAND_LEFT_BOTH then
        kind = env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT)
        pos = 2
    else
        kind = env(ESD_ENV_GetEquipWeaponCategory, HAND_RIGHT)
        pos = 3
    end
    for , 1, #WeaponCategoryID do
        if WeaponCategoryID[f5324_local0][1] == kind then
            local canguard = WeaponCategoryID[f5324_local0][pos]
            return canguard
        end
    end
    
end

function IsEnableGuard()
    local style = c_Style
    local hand = HAND_LEFT
    if style == HAND_RIGHT_BOTH then
        hand = HAND_RIGHT
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    if style == HAND_RIGHT then
        if GetEquipType(hand, WEAPON_CATEGORY_STAFF) == TRUE then
            return FALSE
        end
        if sp_kind == 123 then
            return TRUE
        end
        if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
            return FALSE
        end
        if sp_kind == 99 or sp_kind == 101 or sp_kind == 137 or sp_kind == 151 or sp_kind == 164 or sp_kind == 218 then
            return FALSE
        end
    end
    if sp_kind == 229 or sp_kind == 231 or sp_kind == 234 then
        return TRUE
    end
    if FALSE == IsWeaponCanGuard() then
        return FALSE
    end
    if c_SwordArtsID ~= 32 and style >= HAND_LEFT_BOTH and TRUE == IsDualBlade() then
        return FALSE
    end
    return TRUE
    
end

function IsDualBlade()
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        return env(ESD_ENV_IsTwinSwords, 0)
    else
        return env(ESD_ENV_IsTwinSwords, 1)
    end
    
end

function IsDualBladeSpecific(hand)
    local style = c_Style
    if hand == HAND_LEFT then
        return env(ESD_ENV_IsTwinSwords, 0)
    else
        return env(ESD_ENV_IsTwinSwords, 1)
    end
    
end

function IsWarcrySpAtk()
    local style = c_Style
    local offset = 0
    local f5328_local0 = HAND_LEFT_BOTH
    if style == f5328_local0 then
        offset = 50
    end
    f5328_local0 = {}
    local f5328_local1 = 1062301
    local f5328_local2 = 1062311
    local f5328_local3 = 1070101
    local f5328_local4 = 1070111
    local f5328_local5 = 1070401
    local f5328_local6 = 1070411
    local f5328_local7 = 1070501
    local f5328_local8 = 1070511
    local f5328_local9 = 1080001
    local f5328_local10 = 1080011
    local f5328_local11 = 1080601
    local f5328_local12 = 1080611
    local f5328_local13 = 1083201
    local f5328_local14 = 1092401
    local f5328_local15 = 1092411
    f5328_local0[1] = f5328_local1
    f5328_local0[2] = f5328_local2
    f5328_local0[3] = f5328_local3
    f5328_local0[4] = f5328_local4
    f5328_local0[5] = f5328_local5
    f5328_local0[6] = f5328_local6
    f5328_local0[7] = f5328_local7
    f5328_local0[8] = f5328_local8
    f5328_local0[9] = f5328_local9
    f5328_local0[10] = f5328_local10
    f5328_local0[11] = f5328_local11
    f5328_local0[12] = f5328_local12
    f5328_local0[13] = f5328_local13
    f5328_local0[14] = f5328_local14
    for f5328_local0[15] = f5328_local15, 1, #f5328_local0 do
        if env(ESD_ENV_DS3GetSpecialEffectID, f5328_local0[f5328_local1] + offset) == TRUE then
            return TRUE
        end
    end
    f5328_local1 = FALSE
    return f5328_local1
    
end

function IsArtsSpAtk()
    local style = c_Style
    local offset = 0
    local f5329_local0 = HAND_LEFT_BOTH
    if style == f5329_local0 then
        offset = 50
    end
    f5329_local0 = {}
    local f5329_local1 = 1083201
    local f5329_local2 = 1092401
    local f5329_local3 = 1092411
    f5329_local0[1] = f5329_local1
    f5329_local0[2] = f5329_local2
    for f5329_local0[3] = f5329_local3, 1, #f5329_local0 do
        if env(ESD_ENV_DS3GetSpecialEffectID, f5329_local0[f5329_local1] + offset) == TRUE then
            return TRUE
        end
    end
    f5329_local1 = FALSE
    return f5329_local1
    
end

function IsWepBrokenHeavyAtk()
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if env(ESD_ENV_GetWeaponDurability, hand) == 0 or env(ESD_ENV_IsAbilityInsufficient, hand) == TRUE then
        local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
        if sp_kind == 158 then
            return TRUE
        elseif sp_kind == 162 then
            return TRUE
        end
    end
    return FALSE
    
end

function IsWepBrokenParry(hand)
    if env(ESD_ENV_GetWeaponDurability, hand) == 0 or env(ESD_ENV_IsAbilityInsufficient, hand) == TRUE then
        return TRUE
    end
    return FALSE
    
end

function IsEnableJumpAtk()
    local style = c_Style
    local hand = HAND_RIGHT
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if env(ESD_ENV_GetEquipWeaponCategory, hand) == WEAPON_CATEGORY_STAFF then
        return FALSE
    end
    return TRUE
    
end

function IsGuardbreakBlowDamage(damage_level)
    return FALSE
    
end

function IsLadderDamage(hand)
    local damage_flag = Flag_LadderDamage
    if damage_flag == LADDER_DAMAGE_SMALL then
        AddStamina(-30)
        if ExecLadderFall() == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDamageSmallLeft")
        else
            ExecEvent("W_LadderDamageSmallRight")
        end
    elseif damage_flag == LADDER_DAMAGE_LARGE then
        AddStamina(-40)
        if ExecLadderFall() == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDamageLargeLeft")
        else
            ExecEvent("W_LadderDamageLargeRight")
        end
    else
        Flag_LadderDamage = LADDER_DAMAGE_NONE
        return FALSE
    end
    Flag_LadderDamage = LADDER_DAMAGE_NONE
    return TRUE
    
end

function CalcDamageCount()
    if env(ESD_ENV_GetBehaviorID, 8) == TRUE then
        SetVariable("UseChainRecover", 1)
        return 
    else
        local damagecount = GetVariable("DamageCount")
        SetVariable("DamageCount", damagecount + 1)
        SetVariable("UseChainRecover", 1)
    end
    
end

function ResetDamageCount()
    SetVariable("DamageCount", 0)
    SetVariable("UseChainRecover", 0)
    
end

function ExecGuard(event, blend_type)
    if env(ESD_ENV_DS3ActionRequest, ACTION_ARM_L1) == TRUE or env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L1) > 0 then
        if env(ESD_ENV_GetStamina) <= 0 then
            return FALSE
        end
        local f5337_local0 = IsEnableGuard()
        local f5337_local1 = TRUE
        if f5337_local0 == f5337_local1 then
            local style = c_Style
            local hand = HAND_LEFT
            if style == HAND_RIGHT_BOTH then
                hand = HAND_RIGHT
            end
            local kind = env(ESD_ENV_GetEquipWeaponCategory, hand)
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
            local guardindex = env(ESD_ENV_GetGuardMotionCategory, hand)
            if kind == WEAPON_CATEGORY_TORCH and style == HAND_RIGHT then
                guardindex = GUARD_STYLE_TORCH
            elseif sp_kind == 240 and style == HAND_RIGHT then
                guardindex = GUARD_STYLE_TORCH
            elseif (style == HAND_RIGHT_BOTH or style == HAND_LEFT_BOTH) and env(ESD_ENV_DS3GetStayAnimCategory) ~= 15 then
                guardindex = GUARD_STYLE_DEFAULT
            end
            SetVariable("IndexGuardStyle", guardindex)
            if blend_type == ALLBODY and TRUE == MoveStart(LOWER, Event_MoveLong, FALSE) then
                blend_type = UPPER
            end
            ExecEventHalfBlend(event, blend_type)
            return TRUE
        end
    end
    return FALSE
    
end

function ExecStop()
    if GetVariable("MoveSpeedLevel") > 0 and env(ESD_ENV_DS3GetSpecialEffectID, 100200) == FALSE then
        return FALSE
    end
    local stop_speed = GetVariable("MoveSpeedLevelReal")
    local movedirection = GetVariable("MoveDirection")
    SetVariable("ArtsTransition", 0)
    if stop_speed >= 0 and stop_speed <= 1 then
        if stop_speed <= 0.3499999940395355 then
            ExecEventAllBody("W_Idle")
        elseif movedirection == 0 then
            ExecEventHalfBlend(Event_RunStopFront, ALLBODY)
        elseif movedirection == 1 then
            ExecEventHalfBlend(Event_RunStopBack, ALLBODY)
        elseif movedirection == 2 then
            ExecEventHalfBlend(Event_RunStopLeft, ALLBODY)
        elseif movedirection == 3 then
            ExecEventHalfBlend(Event_RunStopRight, ALLBODY)
        end
    elseif stop_speed > 1 then
        ExecEventHalfBlend(Event_DashStop, ALLBODY)
    else
        ExecEventAllBody("W_Idle")
    end
    return TRUE
    
end

function ExecStopHalfBlend(event, to_idle)
    if GetVariable("MoveSpeedLevel") > 0 and env(ESD_ENV_DS3GetSpecialEffectID, 100200) == FALSE then
        return FALSE
    end
    SetVariable("LocomotionState", 0)
    if to_idle == TRUE then
        ExecEventNoReset("W_Idle")
        return TRUE
    end
    ExecEventHalfBlendNoReset(event, LOWER)
    return TRUE
    
end

function MoveStart(blend_type, event, gen_hand)
    if GetVariable("MoveSpeedLevel") <= 0 then
        return FALSE
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100200) == TRUE then
        return FALSE
    end
    if blend_type ~= LOWER then
        if gen_hand == FALSE then
            SetVariable("ArtsTransition", 0)
        else
            SetArtsGeneratorTransitionIndex(gen_hand, TRUE)
        end
    end
    if GetLocomotionState() ~= PLAYER_STATE_MOVE then
        SetVariable("MoveSpeedLevelReal", 0)
        SpeedUpdate()
    end
    if blend_type == ALLBODY then
        local f5340_local0 = event[2]
        if f5340_local0 == MOVE_DEF0 then
            local guard_event = Event_GuardStart
            if TRUE == IsNodeActive("Rolling_CMSG", "RollingSelftrans_CMSG", "EStepDown_CMSG") then
                guard_event = Event_GuardStartLong
            end
            if ExecGuard(guard_event, UPPER) == TRUE then
                blend_type = LOWER
            end
        end
    end
    ExecEventHalfBlend(event, blend_type)
    return TRUE
    
end

function MoveStartonCancelTiming(event, gen_hand)
    if env(ESD_ENV_DS3IsMoveCancelPossible) == TRUE then
        if GetLocomotionState() == PLAYER_STATE_MOVE then
            if MoveStart(UPPER, event, gen_hand) == TRUE then
                return TRUE
            end
        elseif MoveStart(ALLBODY, event, gen_hand) == TRUE then
            return TRUE
        end
    end
    return FALSE
    
end

function ExecAttack(r1, r2, l1, l2, b1, b2, is_guard, blend_type, artsr1, artsr2)
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if env(ESD_ENV_GetStamina) <= 0 then
        return FALSE
    end
    local request = GetAttackRequest(is_guard)
    if request == ATTACK_REQUEST_INVALID then
        return FALSE
    end
    local style = c_Style
    local atk_hand = HAND_RIGHT
    local is_find_atk = TRUE
    local is_atk_auto_aim = TRUE
    act(2006, 0)
    if env(ESD_ENV_IsSpecialTransitionPossible) == TRUE then
        r1 = "W_AttackRightLight1"
        r2 = "W_AttackRightHeavy1Start"
        l1 = "W_AttackLeftLight1"
        l2 = "W_AttackLeftHeavy1"
        b1 = "W_AttackBothLight1"
        b2 = "W_AttackBothHeavy1Start"
    end
    if request == ATTACK_REQUEST_RIGHT_LIGHT then
        if artsr1 == TRUE then
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
        end
        if TRUE == IsArtsSpAtk() and r1 == "W_AttackRightLightStep" then
            r1 = "W_AttackRightLightStepSpecial"
        end
        ExecEventAllBody(r1)
    elseif request == ATTACK_REQUEST_LIGHT_KICK then
        if style >= HAND_LEFT_BOTH then
            ExecEventAllBody("W_AttackBothLightKick")
        else
            ExecEventAllBody("W_AttackRightLightKick")
        end
    elseif request == ATTACK_REQUEST_RIGHT_HEAVY then
        if artsr2 == TRUE then
            SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        end
        if TRUE == IsWarcrySpAtk() then
            if r2 == "W_AttackRightHeavy1Start" then
                r2 = "W_AttackRightHeavySpecial1Start"
            elseif r2 == "W_AttackRightHeavy1SubStart" then
                r2 = "W_AttackRightHeavySpecial1SubStart"
            elseif r2 == "W_AttackRightHeavy2Start" then
                r2 = "W_AttackRightHeavySpecial2Start"
            end
        elseif TRUE == IsWepBrokenHeavyAtk() then
            if r2 == "W_AttackRightHeavy1Start" then
                r2 = "W_AttackRightHeavyWepBroken1Start"
            elseif r2 == "W_AttackRightHeavy1SubStart" then
                r2 = "W_AttackRightHeavyWepBroken1SubStart"
            elseif r2 == "W_AttackRightHeavy2Start" then
                r2 = "W_AttackRightHeavyWepBroken2Start"
            end
        end
        ExecEventAllBody(r2)
    elseif request == ATTACK_REQUEST_HEAVY_KICK then
        if style >= HAND_LEFT_BOTH then
            if TRUE == IsArtsSpAtk() then
                ExecEventAllBody("W_AttackBothHeavyKickSpecial")
            else
                ExecEventAllBody("W_AttackBothHeavyKick")
            end
        elseif TRUE == IsArtsSpAtk() then
            ExecEventAllBody("W_AttackRightHeavyKickSpecial")
        else
            ExecEventAllBody("W_AttackRightHeavyKick")
        end
    elseif request == ATTACK_REQUEST_LEFT_LIGHT then
        atk_hand = HAND_LEFT
        ExecEventAllBody(l1)
    elseif request == ATTACK_REQUEST_LEFT_HEAVY then
        atk_hand = HAND_LEFT
        ExecEventAllBody(l2)
    elseif request == ATTACK_REQUEST_LEFT_HEAVY_SP then
        atk_hand = HAND_LEFT
        if l2 == "W_AttackLeftHeavy2" then
            l2 = "W_AttackLeftHeavySp2"
        elseif l2 == "W_AttackLeftHeavy3" then
            l2 = "W_AttackLeftHeavySp3"
        else
            l2 = "W_AttackLeftHeavySp1"
        end
        ExecEventAllBody(l2)
    elseif request == ATTACK_REQUEST_BOTH_LIGHT then
        if artsr1 == TRUE then
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
        end
        if TRUE == IsArtsSpAtk() and b1 == "W_AttackBothLightStep" then
            b1 = "W_AttackBothLightStepSpecial"
        end
        ExecEventAllBody(b1)
    elseif request == ATTACK_REQUEST_BOTH_LEFT then
        if r1 == "W_AttackRightLightDash" then
            l1 = "W_AttackBothLeftDash"
        elseif r1 == "W_AttackRightLightStep" then
            l1 = "W_AttackBothLeftStep"
        elseif l1 == "W_AttackLeftLight1" then
            l1 = "W_AttackBothLeft1"
        elseif l1 == "W_AttackLeftLight2" then
            l1 = "W_AttackBothLeft2"
        end
        ExecEventAllBody(l1)
    elseif request == ATTACK_REQUEST_BOTH_HEAVY then
        if artsr2 == TRUE then
            SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        end
        if TRUE == IsWarcrySpAtk() then
            if b2 == "W_AttackBothHeavy1Start" then
                b2 = "W_AttackBothHeavySpecial1Start"
            elseif b2 == "W_AttackBothHeavy1SubStart" then
                b2 = "W_AttackBothHeavySpecial1SubStart"
            elseif b2 == "W_AttackBothHeavy2Start" then
                b2 = "W_AttackBothHeavySpecial2Start"
            end
        elseif TRUE == IsWepBrokenHeavyAtk() then
            if b2 == "W_AttackBothHeavy1Start" then
                b2 = "W_AttackBothHeavyWepBroken1Start"
            elseif b2 == "W_AttackBothHeavy1SubStart" then
                b2 = "W_AttackBothHeavyWepBroken1SubStart"
            elseif b2 == "W_AttackBothHeavy2Start" then
                b2 = "W_AttackBothHeavyWepBroken2Start"
            end
        end
        ExecEventAllBody(b2)
    elseif request == ATTACK_REQUEST_ARROW_BOTH_RIGHT then
        if ExecHandChange(HAND_RIGHT, TRUE, blend_type) == TRUE then
            return TRUE
        else
            return FALSE
        end
    elseif request == ATTACK_REQUEST_ARROW_BOTH_LEFT then
        if ExecHandChange(HAND_LEFT, TRUE, blend_type) == TRUE then
            return TRUE
        else
            return FALSE
        end
    elseif request == ATTACK_REQUEST_LEFT_REVERSAL then
        ExecEventAllBody("W_AttackLeftReversal")
    elseif request == SWORDARTS_REQUEST_LEFT_PARRY then
        is_find_atk = FALSE
        atk_hand = HAND_LEFT
        SetBaseCategory()
        if TRUE == IsWepBrokenParry(HAND_LEFT) then
            ExecEventAllBody("W_ParryLeftStart_WepBreak")
        else
            ExecEventAllBody("W_ParryLeftStart")
        end
    elseif request == SWORDARTS_REQUEST_LEFT_MAGICBUFF then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        atk_hand = HAND_LEFT
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        ExecEventHalfBlend(Event_MagicBuffLeft, blend_type)
    elseif request == SWORDARTS_REQUEST_LEFT_CROSSBOWSTEPIN then
        return FALSE
    elseif request == SWORDARTS_REQUEST_LEFT_ONESHOTFULL then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        atk_hand = HAND_LEFT
        SetBaseCategory()
        ExecEventAllBody("W_OneShotFullLeftStart")
    elseif request == SWORDARTS_REQUEST_LEFT_MAGICBUFFPRAY then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        ExecEventHalfBlend(Event_MagicBuffLeft, ALLBODY)
    elseif request == SWORDARTS_REQUEST_LEFT_MAGICBUFFATTACK then
        atk_hand = HAND_LEFT
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        local sp_kind_left = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
        local sp_kind_right = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)
        local dual = FALSE
        local style = c_Style
        if sp_kind_left == 265 and sp_kind_right == 265 then
            dual = TRUE
        end
        if dual == TRUE and style == HAND_RIGHT then
            if TRUE == IsNodeActive("MagicBuffLeft_Upper_Selector") then
                ExecEventAllBody("W_MagicBuffRight3")
            elseif TRUE == IsNodeActive("MagicBuffLeft2_Selector") then
                ExecEventAllBody("W_MagicBuffRight2")
            elseif TRUE == IsNodeActive("MagicBuffLeft3_Selector") then
                ExecEventAllBody("W_MagicBuffRight3")
            elseif TRUE == IsNodeActive("MagicBuffRight_Upper_Selector") then
                ExecEventAllBody("W_MagicBuffLeft3")
            elseif TRUE == IsNodeActive("MagicBuffRight2_Selector") then
                ExecEventAllBody("W_MagicBuffLeft2")
            elseif TRUE == IsNodeActive("MagicBuffRight3_Selector") then
                ExecEventAllBody("W_MagicBuffLeft3")
            else
                ExecEventHalfBlend(Event_MagicBuffRight, ALLBODY)
            end
        elseif TRUE == IsNodeActive("MagicBuffLeft_Upper_Selector") then
            ExecEventAllBody("W_MagicBuffLeft2")
        elseif TRUE == IsNodeActive("MagicBuffLeft2_Selector") then
            ExecEventAllBody("W_MagicBuffLeft3")
        elseif TRUE == IsNodeActive("MagicBuffLeft3_Selector") then
            ExecEventAllBody("W_MagicBuffLeft2")
        else
            ExecEventHalfBlend(Event_MagicBuffLeft, ALLBODY)
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_STEPIN or request == SWORDARTS_REQUEST_LEFT_STEPIN then
        is_find_atk = FALSE
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        if TRUE == IsNodeActive("StepInRightStart_CMSG", "StepInRightUppercut", "StepInRightSlash") then

        else
            SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        end
        AddStamina(-25)
        ExecEventHalfBlend(Event_StepInRightStart, ALLBODY)
    elseif request == SWORDARTS_REQUEST_RIGHT_PARRY then
        is_find_atk = FALSE
        local hand = HAND_RIGHT
        local style = c_Style
        if style == HAND_LEFT_BOTH then
            hand = HAND_LEFT
        end
        if IsWepBrokenParry(hand) == TRUE then
            ExecEventAllBody("W_ParryRightStart_WepBreak")
        else
            ExecEventAllBody("W_ParryRightStart")
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_SPIN or request == SWORDARTS_REQUEST_LEFT_SPIN then
        is_find_atk = FALSE
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        AddStamina(-35)
        SetVariable("SpinAngle", GetVariable("MoveAngle"))
        ExecEventAllBody("W_SpinRightStart")
    elseif request == SWORDARTS_REQUEST_RIGHT_STRONGBASH or request == SWORDARTS_REQUEST_LEFT_STRONGBASH then
        is_find_atk = FALSE
        ExecEventAllBody("W_StrongBashRightStart")
    elseif request == SWORDARTS_REQUEST_RIGHT_DOUBLEATTACK or request == SWORDARTS_REQUEST_LEFT_DOUBLEATTACK then
        ExecEventAllBody("W_DoubleAttackRightStart")
    elseif request == SWORDARTS_REQUEST_RIGHT_STAMPEDE or request == SWORDARTS_REQUEST_LEFT_STAMPEDE then
        ExecEventAllBody("W_StampedeRightStart")
    elseif request == SWORDARTS_REQUEST_RIGHT_SPECIALATTACK or request == SWORDARTS_REQUEST_LEFT_SPECIALATTACK then
        ExecEventAllBody("W_SpecialAttackRightStart")
    elseif request == SWORDARTS_REQUEST_RIGHT_ATTACKSPIN or request == SWORDARTS_REQUEST_LEFT_ATTACKSPIN then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        if TRUE == IsNodeActive("AttackSpinStart_CMSG", "AttackSpinLight_CMSG", "AttackSpinHeavy_CMSG") then

        else
            SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        end
        ExecEventHalfBlend(Event_AttackSpinStart, ALLBODY)
    elseif request == SWORDARTS_REQUEST_RIGHT_WARCRY or request == SWORDARTS_REQUEST_LEFT_WARCRY then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        ExecEventAllBody("W_Warcry")
    elseif request == SWORDARTS_REQUEST_RIGHT_CHARGE or request == SWORDARTS_REQUEST_LEFT_CHARGE then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        ExecEventHalfBlend(Event_Charge, ALLBODY)
    elseif request == SWORDARTS_REQUEST_RIGHT_ENDURE or request == SWORDARTS_REQUEST_LEFT_ENDURE then
        is_find_atk = FALSE
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        ExecEventHalfBlend(Event_Endure, ALLBODY)
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
    elseif request == SWORDARTS_REQUEST_RIGHT_MAGICBUFF then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        ExecEventHalfBlend(Event_MagicBuffRight, blend_type)
    elseif request == SWORDARTS_REQUEST_RIGHT_MAGICBUFFATTACK then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        local sp_kind_left = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
        local sp_kind_right = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)
        local dual = FALSE
        local style = c_Style
        if sp_kind_left == 265 and sp_kind_right == 265 then
            dual = TRUE
        end
        if dual == TRUE and style == HAND_RIGHT then
            if TRUE == IsNodeActive("MagicBuffRight_Upper_Selector") then
                ExecEventAllBody("W_MagicBuffLeft3")
            elseif TRUE == IsNodeActive("MagicBuffRight2_Selector") then
                ExecEventAllBody("W_MagicBuffLeft2")
            elseif TRUE == IsNodeActive("MagicBuffRight3_Selector") then
                ExecEventAllBody("W_MagicBuffLeft3")
            elseif TRUE == IsNodeActive("MagicBuffLeft_Upper_Selector") then
                ExecEventAllBody("W_MagicBuffRight3")
            elseif TRUE == IsNodeActive("MagicBuffLeft2_Selector") then
                ExecEventAllBody("W_MagicBuffRight2")
            elseif TRUE == IsNodeActive("MagicBuffLeft3_Selector") then
                ExecEventAllBody("W_MagicBuffRight3")
            else
                ExecEventHalfBlend(Event_MagicBuffRight, ALLBODY)
            end
        elseif TRUE == IsNodeActive("MagicBuffRight_Upper_Selector") then
            ExecEventAllBody("W_MagicBuffRight2")
        elseif TRUE == IsNodeActive("MagicBuffRight2_Selector") then
            ExecEventAllBody("W_MagicBuffRight3")
        elseif TRUE == IsNodeActive("MagicBuffRight3_Selector") then
            ExecEventAllBody("W_MagicBuffRight2")
        else
            ExecEventHalfBlend(Event_MagicBuffRight, ALLBODY)
        end
    elseif request == SWORDARTS_REQUEST_LEFT_DAGGERSTANCE or request == SWORDARTS_REQUEST_RIGHT_DAGGERSTANCE then
        if TRUE == IsNodeActive("AttackRight_Script") or TRUE == IsNodeActive("AttackBoth_Script") then
            if GetLocomotionState() == PLAYER_STATE_IDLE then
                SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
                local rightarmlocation = RightArmLocation()
                if rightarmlocation == 0 then
                    ExecEventAllBody("W_DrawStanceRightComboStartRight")
                else
                    ExecEventAllBody("W_DrawStanceRightComboStartLeft")
                end
            else
                return FALSE
            end
        elseif GetVariable("MoveSpeedLevel") > 1.5 then
            SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
            local rightarmlocation = RightArmLocation()
            ExecEventAllBody("W_DrawStanceStartDash")
        elseif TRUE == IsNodeActive("Rolling_CMSG") and env(ESD_ENV_GetEventEzStateFlag, 0) == TRUE then
            SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
            local rightarmlocation = RightArmLocation()
            ExecEventAllBody("W_DrawStanceStartRolling")
        else
            return FALSE
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_SAMAGIC or request == SWORDARTS_REQUEST_LEFT_SAMAGIC then
        return FALSE
    elseif request == SWORDARTS_REQUEST_LEFT_DRAWSTANCE or request == SWORDARTS_REQUEST_RIGHT_DRAWSTANCE then
        return FALSE
    elseif request == SWORDARTS_REQUEST_LEFT_CHAINSHOT or request == SWORDARTS_REQUEST_RIGHT_CHAINSHOT then
        return FALSE
    elseif request == SWORDARTS_REQUEST_LEFT_WIDESHOT or request == SWORDARTS_REQUEST_RIGHT_WIDESHOT then
        return FALSE
    elseif request == SWORDARTS_REQUEST_LEFT_STRONGSHOT or request == SWORDARTS_REQUEST_RIGHT_STRONGSHOT then
        return FALSE
    elseif request == SWORDARTS_REQUEST_RIGHT_SAMAGICMEDIUM or request == SWORDARTS_REQUEST_LEFT_SAMAGICMEDIUM then
        return FALSE
    elseif request == SWORDARTS_REQUEST_RIGHT_SAMAGICSTRONG or request == SWORDARTS_REQUEST_LEFT_SAMAGICSTRONG then
        return FALSE
    elseif request == SWORDARTS_REQUEST_RIGHT_CIRCLESTEP or request == SWORDARTS_REQUEST_LEFT_CIRCLESTEP then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        local angle = GetVariable("MoveAngle")
        local f5342_local0 = GetWeightIndex(FALSE)
        if f5342_local0 == EVASION_WEIGHT_INDEX_OVERWEIGHT then
            local event = "W_RollingOverweightFront"
            if math.abs(angle) > 135 then
                event = "W_RollingOverweightBack"
            elseif angle > 45 then
                event = "W_RollingOverweightRight"
            elseif angle < -45 then
                event = "W_RollingOverweightLeft"
            end
            ExecEventAllBody(event)
        else
            local front, back, left, right = false
            if math.abs(angle) > 135 then
                back = true
            elseif angle > 45 then
                right = true
            elseif angle < -45 then
                left = true
            else
                front = true
            end
            SetVariable("EnableTAE_CircleStepFront", front)
            SetVariable("EnableTAE_CircleStepBack", back)
            SetVariable("EnableTAE_CircleStepLeft", left)
            SetVariable("EnableTAE_CircleStepRight", right)
            SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
            if TRUE == IsNodeActive("CircleStepStart_Blend") then
                if angle >= 0 then
                    SetVariable("CircleStepDirectionSelftrans", 1)
                else
                    SetVariable("CircleStepDirectionSelftrans", 0)
                end
                SetVariable("CircleStepAngleSelftrans", angle)
                ExecEventAllBody("W_CircleStepStartSelftrans")
            else
                if angle >= 0 then
                    SetVariable("CircleStepDirection", 1)
                else
                    SetVariable("CircleStepDirection", 0)
                end
                SetVariable("CircleStepAngle", angle)
                ExecEventAllBody("W_CircleStepStart")
            end
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_CHARGESHOT or request == SWORDARTS_REQUEST_LEFT_CHARGESHOT then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        ExecEventHalfBlend(Event_ChargeShotRightStart, ALLBODY)
    elseif request == SWORDARTS_REQUEST_RIGHT_CROSSBOWSTEPIN then
        is_find_atk = FALSE
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        ExecEventHalfBlend(Event_CrossbowStepInRightStart, ALLBODY)
    elseif request == SWORDARTS_REQUEST_RIGHT_HEADHUNT or request == SWORDARTS_REQUEST_LEFT_HEADHUNT then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        ExecEventHalfBlend(Event_HeadHunt, ALLBODY)
    elseif request == SWORDARTS_REQUEST_RIGHT_ONESHOT or request == SWORDARTS_REQUEST_LEFT_ONESHOT then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        ExecEventHalfBlend(Event_OneShot, ALLBODY)
    elseif request == SWORDARTS_REQUEST_RIGHT_ONESHOTFULL then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        if style == HAND_RIGHT then
            ExecEventAllBody("W_OneShotFullRightStart")
        else
            ExecEventAllBody("W_OneShotFullBothStart")
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_ONESHOT_NOGENTRANS or request == SWORDARTS_REQUEST_LEFT_ONESHOT_NOGENTRANS then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        ExecEventAllBody("W_OneShotNoGenTransStart")
    elseif request == SWORDARTS_REQUEST_RIGHT_STORMSTANCE or request == SWORDARTS_REQUEST_LEFT_STORMSTANCE then
        return FALSE
    elseif request == SWORDARTS_REQUEST_RIGHT_MAGICBUFFPRAY then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        ExecEventHalfBlend(Event_MagicBuffRight, ALLBODY)
    elseif request == SWORDARTS_REQUEST_RIGHT_FOURWAYATTACK or request == SWORDARTS_REQUEST_LEFT_FOURWAYATTACK then
        local angle = GetVariable("MoveAngle")
        local f5342_local0 = GetWeightIndex(FALSE)
        if f5342_local0 == EVASION_WEIGHT_INDEX_OVERWEIGHT then
            local event = "W_RollingOverweightFront"
            if math.abs(angle) > 135 then
                event = "W_RollingOverweightBack"
            elseif angle > 45 then
                event = "W_RollingOverweightRight"
            elseif angle < -45 then
                event = "W_RollingOverweightLeft"
            end
            ExecEventAllBody(event)
        else
            local front, back, left, right = false
            if math.abs(angle) > 135 then
                back = true
            elseif angle > 45 then
                right = true
            elseif angle < -45 then
                left = true
            else
                front = true
            end
            SetVariable("EnableTAE_FourWayAttackStartFront", front)
            SetVariable("EnableTAE_FourWayAttackStartBack", back)
            SetVariable("EnableTAE_FourWayAttackStartLeft", left)
            SetVariable("EnableTAE_FourWayAttackStartRight", right)
            SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
            if FALSE == IsNodeActive("FourWayAttackStart_CMSG") then
                if angle >= 0 then
                    SetVariable("FourWayAttackStartDirection", 1)
                else
                    SetVariable("FourWayAttackStartDirection", 0)
                end
                SetVariable("FourWayAttackStartAngle", angle)
                ExecEventAllBody("W_FourWayAttackStart")
            else
                if angle >= 0 then
                    SetVariable("FourWayAttackStartDirection_SelfTrans", 1)
                else
                    SetVariable("FourWayAttackStartDirection_SelfTrans", 0)
                end
                SetVariable("FourWayAttackStartAngle_SelfTrans", angle)
                ExecEventAllBody("W_FourWayAttackStart_SelfTrans")
            end
        end
    elseif request == SWORDARTS_REQUEST_RIGHT_FOURWAYDRAWSTANCE or request == SWORDARTS_REQUEST_LEFT_FOURWAYDRAWSTANCE then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        if GetVariable("MoveSpeedLevel") < 0.5099999904632568 then
            if TRUE == IsNodeActive("DrawStanceRightEnd_Upper_CMSG", "DrawStanceRightAttackLight_CMSG", "DrawStanceRightAttackLight2_CMSG", "DrawStanceRightAttackLight3_CMSG", "DrawStanceRightAttackHeavy_CMSG") then

            else
                SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
            end
            if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
                blend_type = UPPER
            end
            if env(ESD_ENV_DS3GetSpecialEffectID, 100490) == TRUE then
                ExecEventHalfBlend(Event_DrawStanceRightLoop, blend_type)
            else
                ExecEventHalfBlend(Event_DrawStanceRightStart, blend_type)
            end
        else
            local angle = GetVariable("MoveAngle")
            local front, back, left, right = false
            if math.abs(angle) > 135 then
                back = true
            elseif angle > 45 then
                right = true
            elseif angle < -45 then
                left = true
            else
                front = true
            end
            SetVariable("EnableTAE_FourWayDrawStanceStartFront", front)
            SetVariable("EnableTAE_FourWayDrawStanceStartBack", back)
            SetVariable("EnableTAE_FourWayDrawStanceStartLeft", left)
            SetVariable("EnableTAE_FourWayDrawStanceStartRight", right)
            SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
            if angle >= 0 then
                SetVariable("FourWayDrawStanceStartDirection", 1)
            else
                SetVariable("FourWayDrawStanceStartDirection", 0)
            end
            SetVariable("FourWayDrawStanceStartAngle", angle)
            ExecEventAllBody("W_FourWayDrawStanceRightStart")
            act(1001, -10)
        end
    elseif request == SWORDARTS_REQUEST_LEFT_GATLINGSTANCE or request == SWORDARTS_REQUEST_RIGHT_GATLINGSTANCE then
        return FALSE
    elseif request == SWORDARTS_REQUEST_LEFT_RANDOMONESHOT or request == SWORDARTS_REQUEST_RIGHT_RANDOMONESHOT then
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        ExecEventAllBody("W_RandomOneShot1")
    elseif request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        local arrow_hand = HAND_RIGHT
        if style == HAND_LEFT_BOTH then
            arrow_hand = HAND_LEFT
        end
        local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, arrow_hand)
        if TRUE == IsExistArrow() then
            ExecEventAllBody("W_NoArrow")
        elseif sp_kind == 81 or sp_kind == 249 then
            if IsEnoughWeaponReleaseStatus(arrow_hand) == TRUE then
                if r1 == "W_AttackRightLightStep" then
                    is_find_atk = TRUE
                    ExecEventAllBody("W_AttackArrowRightFireStep")
                elseif r1 == "W_AttackRightLightDash" then
                    is_find_atk = TRUE
                    ExecEventAllBody("W_AttackArrowRightFireStep")
                else
                    if env(ESD_ENV_GetEquipWeaponCategory, arrow_hand) == WEAPON_CATEGORY_LARGE_ARROW then
                        blend_type = ALLBODY
                    elseif blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
                        blend_type = UPPER
                    end
                    ExecEventHalfBlend(Event_AttackArrowRightStart, blend_type)
                end
            else
                if env(ESD_ENV_GetEquipWeaponCategory, arrow_hand) == WEAPON_CATEGORY_LARGE_ARROW then
                    blend_type = ALLBODY
                elseif blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
                    blend_type = UPPER
                end
                ExecEventHalfBlend(Event_AttackArrowRightStart, blend_type)
            end
        else
            if env(ESD_ENV_GetEquipWeaponCategory, arrow_hand) == WEAPON_CATEGORY_LARGE_ARROW then
                blend_type = ALLBODY
            elseif blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
                blend_type = UPPER
            end
            ExecEventHalfBlend(Event_AttackArrowRightStart, blend_type)
        end
    elseif request == ATTACK_REQUEST_RIGHT_CROSSBOW or request == ATTACK_REQUEST_RIGHT_CROSSBOW2 then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if IsExistBolt(HAND_RIGHT) == TRUE then
            ExecEventHalfBlend(Event_AttackCrossbowRightEmpty, blend_type)
        elseif env(ESD_ENV_GetBoltLoadingState, 1) == TRUE then
            ExecEventHalfBlend(Event_AttackCrossbowRightStart, blend_type)
        else
            ExecEventHalfBlend(Event_AttackCrossbowRightReload, blend_type)
        end
    elseif request == ATTACK_REQUEST_LEFT_CROSSBOW or request == ATTACK_REQUEST_LEFT_CROSSBOW2 then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        atk_hand = HAND_LEFT
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if TRUE == IsExistBolt(HAND_LEFT) then
            ExecEventHalfBlend(Event_AttackCrossbowLeftEmpty, blend_type)
        elseif env(ESD_ENV_GetBoltLoadingState, 0) == TRUE then
            ExecEventHalfBlend(Event_AttackCrossbowLeftStart, blend_type)
        else
            ExecEventHalfBlend(Event_AttackCrossbowLeftReload, blend_type)
        end
    elseif request == ATTACK_REQUEST_BOTHRIGHT_CROSSBOW or request == ATTACK_REQUEST_BOTHRIGHT_CROSSBOW2 then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if IsExistBolt(HAND_RIGHT) == TRUE then
            ExecEventHalfBlend(Event_AttackCrossbowBothRightEmpty, blend_type)
        elseif env(ESD_ENV_GetBoltLoadingState, 1) == TRUE then
            ExecEventHalfBlend(Event_AttackCrossbowBothRightStart, blend_type)
        else
            ExecEventHalfBlend(Event_AttackCrossbowBothRightReload, blend_type)
        end
    elseif request == ATTACK_REQUEST_BOTHLEFT_CROSSBOW or request == ATTACK_REQUEST_BOTHLEFT_CROSSBOW2 then
        is_find_atk = FALSE
        is_atk_auto_aim = FALSE
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if TRUE == IsExistBolt(HAND_LEFT) then
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftEmpty, blend_type)
        elseif env(ESD_ENV_GetBoltLoadingState, 0) == TRUE then
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftStart, blend_type)
        else
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftReload, blend_type)
        end
    elseif request == ATTACK_REQUEST_ATTACK_WHILE_GUARD then
        local index = env(ESD_ENV_GetGuardMotionCategory, HAND_LEFT)
        if GetVariable("IndexGuardStyle") == GUARD_STYLE_TORCH then
            index = 3
        end
        SetVariable("IndexAttackWhileGuard", index)
        ExecEventAllBody("W_AttackRightWhileGuard")
    else
        return FALSE
    end
    if is_find_atk == TRUE then
        SetInterruptType(INTERRUPT_FINDATTACK)
    end
    if is_atk_auto_aim == TRUE then
        SetVariable("AtkAutoAimFlag", true)
        if GetVariable("IsLockon") == false then
            act("自動捕捉対象設定")
        end
    end
    SetVariable("AtkAutoAimTime", 0)
    if style == HAND_RIGHT_BOTH then
        atk_hand = HAND_RIGHT
    elseif style == HAND_LEFT_BOTH then
        atk_hand = HAND_LEFT
    end
    SetAttackHand(atk_hand)
    SetAIActionState()
    return TRUE
    
end

function ExecSwordArtsStance(blend_type)
    if c_IsEnableSwordArts == FALSE then
        return FALSE
    end
    local style = c_Style
    local arts_id = c_SwordArtsID
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 then
        return FALSE
    end
    if arts_id == SWORDARTS_DAGGERSTANCE then
        if IsNodeActive("AttackRight_Script") == TRUE or IsNodeActive("AttackBoth_Script") == TRUE then
            if GetLocomotionState() == PLAYER_STATE_IDLE then
                return FALSE
            end
        elseif GetVariable("MoveSpeedLevel") > 1.5 then
            return FALSE
        elseif IsNodeActive("Rolling_CMSG") == TRUE then
            return FALSE
        end
    end
    if env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand) == 248 and env(ESD_ENV_GetStamina) <= 0 then
        return FALSE
    end
    if arts_id == SWORDARTS_DRAWSTANCE or arts_id == SWORDARTS_DAGGERSTANCE then
        if IsNodeActive("DrawStanceRightEnd_Upper_CMSG", "DrawStanceRightAttackLight_CMSG", "DrawStanceRightAttackHeavy_CMSG") == TRUE then

        else
            SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        end
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if env(ESD_ENV_DS3GetSpecialEffectID, 100490) == TRUE then
            ExecEventHalfBlend(Event_DrawStanceRightLoop, blend_type)
        else
            ExecEventHalfBlend(Event_DrawStanceRightStart, blend_type)
        end
    elseif arts_id == SWORDARTS_STORMSTANCE then
        if IsNodeActive("StormStanceEnd_Upper_CMSG", "StormStanceFullEnd_Upper_CMSG", "StormStanceLight_CMSG", "StormStanceFullLight_CMSG", "StormStanceHeavy_CMSG", "StormStanceFullHeavy_CMSG") == TRUE then

        elseif FALSE == IsNodeActive("StormStanceChange_Upper_CMSG") then
            SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        end
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        local stormstancefull = FALSE
        if c_SwordArtsHand == HAND_LEFT then
            if env(ESD_ENV_DS3GetSpecialEffectID, 100911) == TRUE then
                stormstancefull = TRUE
            end
        elseif env(ESD_ENV_DS3GetSpecialEffectID, 100910) == TRUE then
            stormstancefull = TRUE
        end
        if stormstancefull == FALSE then
            ExecEventHalfBlend(Event_StormStanceStart, blend_type)
        else
            ExecEventHalfBlend(Event_StormStanceFullStart, blend_type)
        end
    elseif arts_id == SWORDARTS_CHAINSHOT or arts_id == SWORDARTS_WIDESHOT or arts_id == SWORDARTS_STRONGSHOT then
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if style >= HAND_LEFT_BOTH then
            SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
            ExecEventHalfBlend(Event_ChainShotRightStart, blend_type)
        else
            return FALSE
        end
    elseif arts_id == SWORDARTS_FOURWAYDRAWSTANCE then
        if arts_id == SWORDARTS_FOURWAYDRAWSTANCE then
            if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 then
                return FALSE
            end
            if IsNodeActive("DrawStanceRightEnd_Upper_CMSG", "DrawStanceRightAttackLight_CMSG", "DrawStanceRightAttackLight2_CMSG", "DrawStanceRightAttackLight3_CMSG", "DrawStanceRightAttackHeavy_CMSG") == TRUE then

            else
                SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
            end
            if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
                blend_type = UPPER
            end
            if env(ESD_ENV_DS3GetSpecialEffectID, 100490) == TRUE then
                ExecEventHalfBlend(Event_DrawStanceRightLoop, blend_type)
            else
                ExecEventHalfBlend(Event_DrawStanceRightStart, blend_type)
            end
        else
            local angle = GetVariable("MoveAngle")
            local front, back, left, right = false
            if math.abs(angle) > 135 then
                back = true
            elseif angle > 45 then
                right = true
            elseif angle < -45 then
                left = true
            else
                front = true
            end
            SetVariable("EnableTAE_FourWayDrawStanceStartFront", front)
            SetVariable("EnableTAE_FourWayDrawStanceStartBack", back)
            SetVariable("EnableTAE_FourWayDrawStanceStartLeft", left)
            SetVariable("EnableTAE_FourWayDrawStanceStartRight", right)
            SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
            if angle >= 0 then
                SetVariable("FourWayDrawStanceStartDirection", 1)
            else
                SetVariable("FourWayDrawStanceStartDirection", 0)
            end
            SetVariable("FourWayDrawStanceStartAngle", angle)
            ExecEventAllBody("W_FourWayDrawStanceRightStart")
            act(1001, -10)
        end
    elseif arts_id == SWORDARTS_GATLINGSTANCE then
        if IsNodeActive("GatlingStanceRightEnd_Upper_CMSG") == TRUE then

        else
            SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, FALSE)
        end
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if env(ESD_ENV_DS3GetSpecialEffectID, 100490) == TRUE then
            ExecEventHalfBlend(Event_GatlingStanceRightLoop, blend_type)
        else
            ExecEventHalfBlend(Event_GatlingStanceRightStart, blend_type)
        end
    else
        return FALSE
    end
    if style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
    end
    SetAIActionState()
    return TRUE
    
end

function ExecSwordArtsStanceOnCancelTiming(blend_type)
    if env(ESD_ENV_IsWeaponCancelPossible) == TRUE and ExecSwordArtsStance(blend_type) == TRUE then
        return TRUE
    end
    return FALSE
    
end

function ExecMagic(quick_type, blend_type)
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if env(ESD_ENV_GetStamina) <= 0 then
        return FALSE
    end
    local style = c_Style
    local magic_hand = HAND_RIGHT
    local is_samagic = FALSE
    if env(ESD_ENV_DS3ActionRequest, ACTION_ARM_MAGIC_R) == TRUE then
        if style == HAND_LEFT_BOTH then
            if FALSE == GetEquipType(HAND_LEFT, WEAPON_CATEGORY_STAFF) then
                return FALSE
            end
            SetAttackHand(HAND_LEFT)
        else
            if FALSE == GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_STAFF) then
                return FALSE
            end
            SetAttackHand(HAND_RIGHT)
        end
    elseif env(ESD_ENV_DS3ActionRequest, ACTION_ARM_MAGIC_L) == TRUE then
        if style == HAND_RIGHT_BOTH or style == HAND_LEFT_BOTH then
            return FALSE
        end
        if FALSE == GetEquipType(HAND_LEFT, WEAPON_CATEGORY_STAFF) then
            return FALSE
        end
        SetAttackHand(HAND_LEFT)
        magic_hand = HAND_LEFT
    elseif env(ESD_ENV_DS3ActionRequest, ACTION_ARM_R2) == TRUE then
        if env(ESD_ENV_DS3ActionRequest, ACTION_ARM_HEAVY_KICK) == TRUE then
            return FALSE
        end
        if style == HAND_LEFT_BOTH then
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
            if sp_kind ~= 178 and sp_kind ~= 207 and sp_kind ~= 217 and sp_kind ~= 220 and sp_kind ~= 234 and sp_kind ~= 257 then
                return FALSE
            end
            if sp_kind == 257 and env(ESD_ENV_DS3GetSpecialEffectID, 100580) == TRUE then
                return FALSE
            end
            SetAttackHand(HAND_LEFT)
        else
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)
            if sp_kind ~= 178 and sp_kind ~= 207 and sp_kind ~= 217 and sp_kind ~= 220 and sp_kind ~= 234 and sp_kind ~= 257 then
                return FALSE
            end
            if sp_kind == 257 and env(ESD_ENV_DS3GetSpecialEffectID, 100580) == TRUE then
                return FALSE
            end
            SetAttackHand(HAND_RIGHT)
        end
    elseif env(ESD_ENV_DS3ActionRequest, ACTION_ARM_L2) == TRUE then
        if c_SwordArtsID == SWORDARTS_SAMAGIC or c_SwordArtsID == SWORDARTS_SAMAGICMEDIUM or c_SwordArtsID == SWORDARTS_SAMAGICSTRONG then
            is_samagic = TRUE
            if style == HAND_RIGHT_BOTH then
                SetAttackHand(HAND_RIGHT)
            elseif style == HAND_LEFT_BOTH then
                SetAttackHand(HAND_LEFT)
            elseif HAND_RIGHT == c_SwordArtsHand then
                SetAttackHand(HAND_RIGHT)
            else
                SetAttackHand(HAND_LEFT)
                magic_hand = HAND_LEFT
            end
        elseif style == HAND_RIGHT then
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
            if sp_kind ~= 178 and sp_kind ~= 207 and sp_kind ~= 217 and sp_kind ~= 220 and sp_kind ~= 234 and sp_kind ~= 257 then
                return FALSE
            end
            SetAttackHand(HAND_LEFT)
            magic_hand = HAND_LEFT
        else
            return FALSE
        end
    else
        return FALSE
    end
    if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
        blend_type = UPPER
    end
    local magic_type = env(ESD_ENV_GetMagicAnimType)
    local magic_index = MAGIC_REQUEST_NOTHING
    local is_atk_auto_aim = FALSE
    if FALSE == env(ESD_ENV_IsMagicUseable) then
        if magic_hand == HAND_LEFT then
            ExecEventHalfBlend(Event_MagicInvalidLeft, blend_type)
        else
            ExecEventHalfBlend(Event_MagicInvalidRight, blend_type)
        end
        act(118, TRUE)
        SetAIActionState()
        return TRUE
    elseif magic_type == 0 then
        magic_index = MAGIC_REQUEST_ENBULLET
    elseif magic_type == 1 then
        if c_Style == HAND_LEFT_BOTH then
            ExecEventHalfBlend(Event_MagicInvalidRight, blend_type)
            act(118, TRUE)
            SetAIActionState()
            return TRUE
        else
            magic_index = MAGIC_REQUEST_WEAPON_ENCHANT
        end
    elseif magic_type == 2 then
        magic_index = MAGIC_REQUEST_SELF_ENCHANT
    elseif magic_type == 3 then
        magic_index = MAGIC_REQUEST_PRAY
    elseif magic_type == 4 then
        magic_index = MAGIC_REQUEST_PRAY_BRO
    elseif magic_type == 5 then
        magic_index = MAGIC_REQUEST_FLAME_RADIATION
    elseif magic_type == 6 then
        magic_index = MAGIC_REQUEST_SELF_FLAME_ENCHANT
    elseif magic_type == 7 then
        magic_index = MAGIC_REQUEST_DRAIN
    elseif magic_type == 8 then
        magic_index = MAGIC_REQUEST_FLAME_NEAR
    elseif magic_type == 9 then
        magic_index = MAGIC_REQUEST_CLOUD
    elseif magic_type == 10 then
        magic_index = MAGIC_REQUEST_SPARK
    elseif magic_type == 11 then
        magic_index = MAGIC_REQUEST_CHARM
    elseif magic_type == 12 then
        magic_index = MAGIC_REQUEST_IMPACT
    elseif magic_type == 13 then
        magic_index = MAGIC_REQUEST_CHAMELEON
    elseif magic_type == 14 then
        magic_index = MAGIC_REQUEST_TRANSFORM
    elseif magic_type == 15 then
        if c_Style == HAND_LEFT_BOTH then
            ExecEventHalfBlend(Event_MagicInvalidRight, blend_type)
            act(118, TRUE)
            SetAIActionState()
            return TRUE
        else
            magic_index = MAGIC_REQUEST_WEAPON_ENCHANT2
        end
    elseif magic_type == 16 then
        magic_index = MMAGIC_REQUEST_SUMMON
    elseif magic_type == 17 then
        magic_index = MAGIC_REQUEST_SHIELD_ENCHANT
    elseif magic_type == 18 then
        magic_index = MAGIC_REQUEST_FORCE
    elseif magic_type == 19 then
        magic_index = MAGIC_REQUEST_THUNDER
    elseif magic_type == 20 then
        magic_index = MAGIC_REQUEST_ENVIRONMENT
    elseif magic_type == 21 then
        magic_index = MAGIC_REQUEST_BREATH
    elseif magic_type == 22 then
        magic_index = MAGIC_REQUEST_ENBULLET2
    elseif magic_type == 23 then
        magic_index = MAGIC_REQUEST_FLAMETHROWER
    elseif magic_type == 24 then
        magic_index = MAGIC_REQUEST_WHIP
        is_atk_auto_aim = TRUE
    elseif magic_type == 25 then
        magic_index = MAGIC_REQUEST_SLASH
        is_atk_auto_aim = TRUE
    elseif magic_type == 26 then
        magic_index = MAGIC_REQUEST_PRAYHOLD
    elseif magic_type == 27 then
        magic_index = MAGIC_REQUEST_STANDINGPRAYHOLD
    elseif magic_type == 28 then
        magic_index = MAGIC_REQUEST_AOEPRAYHOLD
    elseif magic_type == 29 then
        magic_index = MAGIC_REQUEST_QUICKENBULLET
    elseif magic_type == 30 then
        magic_index = MAGIC_REQUEST_QUICKSLASH
        is_atk_auto_aim = TRUE
    elseif magic_type == 31 then
        magic_index = MAGIC_REQUEST_BEAM_CANNON
    elseif magic_type == 32 then
        magic_index = MAGIC_REQUEST_FLAME_BACKHAND
    elseif magic_type == 33 then
        magic_index = MAGIC_REQUEST_FLAME_GRAB
        is_atk_auto_aim = TRUE
    elseif magic_type == 34 then
        magic_index = MAGIC_REQUEST_CRUSH
        is_atk_auto_aim = TRUE
    elseif magic_type == 35 then
        magic_index = MAGIC_REQUEST_MIRACLE_RADIATION
    elseif magic_type == 36 then
        magic_index = MAGIC_REQUEST_LIGHTNING_ROD
    elseif magic_type == 37 then
        magic_index = MAGIC_REQUEST_CHOP
        is_atk_auto_aim = TRUE
    elseif magic_type == 38 then
        magic_index = MAGIC_REQUEST_TRAP
    elseif magic_type == 39 then
        magic_index = MAGIC_REQUEST_WRATH
    elseif magic_type == 40 then
        magic_index = MAGIC_REQUEST_MACHINEGUN
    elseif magic_type == 41 then
        magic_index = MAGIC_REQUEST_STRONGENBULLET
    elseif magic_type == 42 then
        magic_index = MAGIC_REQUEST_FAST_SPARK
    elseif magic_type == 43 then
        magic_index = MAGIC_REQUEST_FAST_FLAME_RADIATION
    elseif magic_type == 44 then
        magic_index = MAGIC_REQUEST_SCYTHE
        is_atk_auto_aim = TRUE
    elseif magic_type == 45 then
        magic_index = MAGIC_REQUEST_HOLY_SPARK
    elseif magic_type == 46 then
        magic_index = MAGIC_REQUEST_SLASHHOLD
    elseif magic_type == 47 then
        magic_index = MAGIC_REQUEST_BIT
    elseif magic_type == 48 then
        magic_index = MAGIC_REQUEST_CHAKRAM
    elseif magic_type == 49 then
        magic_index = MAGIC_REQUEST_BOW
    elseif magic_type == 50 then
        magic_index = MAGIC_REQUEST_FAN
    else
        if magic_hand == HAND_LEFT then
            ExecEventHalfBlend(Event_MagicInvalidLeft, blend_type)
        else
            ExecEventHalfBlend(Event_MagicInvalidRight, blend_type)
        end
        act(118, TRUE)
        SetAIActionState()
        return TRUE
    end
    if env(ESD_ENV_IsMagicUseMenuOpened) == TRUE then
        return FALSE
    end
    if env(ESD_ENV_IsMagicUseMenuOpening) == TRUE then
        ResetRequest()
        act(124)
        return TRUE
    end
    SetVariable("IndexMagicType", magic_index)
    if TRUE == IsQuickMagic() then
        if magic_hand == HAND_RIGHT then
            if quick_type == QUICKTYPE_NORMAL then
                ExecEventHalfBlend(Event_MagicLaunchRight, blend_type)
            elseif quick_type == QUICKTYPE_DASH then
                ExecEventHalfBlend(Event_QuickMagicFireRightDash, blend_type)
            elseif quick_type == QUICKTYPE_ROLLING then
                ExecEventHalfBlend(Event_QuickMagicFireRightStep, blend_type)
            elseif quick_type == QUICKTYPE_ATTACK then
                if 1 == ForwardLeg() then
                    ExecEventHalfBlend(Event_QuickMagicFireRightAttackRight, blend_type)
                else
                    ExecEventHalfBlend(Event_QuickMagicFireRightAttackLeft, blend_type)
                end
            elseif quick_type == QUICKTYPE_COMBO then
                if 1 == ForwardLeg() then
                    ExecEventHalfBlend(Event_QuickMagicFireRightAttackRight2, blend_type)
                else
                    ExecEventHalfBlend(Event_QuickMagicFireRightAttackLeft2, blend_type)
                end
            end
        elseif quick_type == QUICKTYPE_NORMAL then
            ExecEventHalfBlend(Event_MagicLaunchLeft, blend_type)
        elseif quick_type == QUICKTYPE_DASH then
            ExecEventHalfBlend(Event_QuickMagicFireLeftDash, blend_type)
        elseif quick_type == QUICKTYPE_ROLLING then
            ExecEventHalfBlend(Event_QuickMagicFireLeftStep, blend_type)
        elseif quick_type == QUICKTYPE_ATTACK then
            if 1 == ForwardLeg() then
                ExecEventHalfBlend(Event_QuickMagicFireLeftAttackRight, blend_type)
            else
                ExecEventHalfBlend(Event_QuickMagicFireLeftAttackLeft, blend_type)
            end
        elseif quick_type == QUICKTYPE_COMBO then
            if 1 == ForwardLeg() then
                ExecEventHalfBlend(Event_QuickMagicFireLeftAttackRight2, blend_type)
            else
                ExecEventHalfBlend(Event_QuickMagicFireLeftAttackLeft2, blend_type)
            end
        end
    elseif TRUE == IsComboMagic() then
        if magic_hand == HAND_RIGHT then
            if env(ESD_ENV_DS3GetSpecialEffectID, 100620) == TRUE then
                ExecEventHalfBlend(Event_MagicFireRight2, blend_type)
            elseif env(ESD_ENV_DS3GetSpecialEffectID, 100650) == TRUE then
                ExecEventHalfBlend(Event_MagicLaunchRight, blend_type)
            elseif env(ESD_ENV_DS3GetSpecialEffectID, 100630) == TRUE then
                ExecEventHalfBlend(Event_MagicFireRight3, blend_type)
            elseif env(ESD_ENV_DS3GetSpecialEffectID, 100660) == TRUE then
                ExecEventHalfBlend(Event_MagicLaunchRight, blend_type)
            elseif env(ESD_ENV_DS3GetSpecialEffectID, 100640) == TRUE then
                ExecEventHalfBlend(Event_MagicFireRight2, blend_type)
            elseif env(ESD_ENV_DS3GetSpecialEffectID, 100670) == TRUE then
                ExecEventHalfBlend(Event_MagicLaunchRight, blend_type)
            else
                ExecEventHalfBlend(Event_MagicLaunchRight, blend_type)
            end
        elseif env(ESD_ENV_DS3GetSpecialEffectID, 100620) == TRUE then
            ExecEventHalfBlend(Event_MagicLaunchLeft, blend_type)
        elseif env(ESD_ENV_DS3GetSpecialEffectID, 100650) == TRUE then
            ExecEventHalfBlend(Event_MagicFireLeft2, blend_type)
        elseif env(ESD_ENV_DS3GetSpecialEffectID, 100630) == TRUE then
            ExecEventHalfBlend(Event_MagicLaunchLeft, blend_type)
        elseif env(ESD_ENV_DS3GetSpecialEffectID, 100660) == TRUE then
            ExecEventHalfBlend(Event_MagicFireLeft3, blend_type)
        elseif env(ESD_ENV_DS3GetSpecialEffectID, 100640) == TRUE then
            ExecEventHalfBlend(Event_MagicLaunchLeft, blend_type)
        elseif env(ESD_ENV_DS3GetSpecialEffectID, 100670) == TRUE then
            ExecEventHalfBlend(Event_MagicFireLeft2, blend_type)
        else
            ExecEventHalfBlend(Event_MagicLaunchLeft, blend_type)
        end
    elseif is_samagic == TRUE then
        ExecEventNoReset("W_SAMagicStart")
        SetVariable("SAMagicBlendRate", 1)
        SetSwordArtsPointInfo(ACTION_ARM_L2, TRUE)
        if c_SwordArtsID == SWORDARTS_SAMAGIC then
            if env(ESD_ENV_DS3HasEnoughArtsPoints, ACTION_ARM_L2, c_SwordArtsHand) == TRUE then
                act(2002, 120800)
                act(2002, 120801)
            else
                act(2002, 120810)
                act(2002, 120811)
            end
        elseif c_SwordArtsID == SWORDARTS_SAMAGICMEDIUM then
            if env(ESD_ENV_DS3HasEnoughArtsPoints, ACTION_ARM_L2, c_SwordArtsHand) == TRUE then
                act(2002, 120820)
                act(2002, 120821)
            else
                act(2002, 120830)
                act(2002, 120831)
            end
        elseif env(ESD_ENV_DS3HasEnoughArtsPoints, ACTION_ARM_L2, c_SwordArtsHand) == TRUE then
            act(2002, 120840)
            act(2002, 120841)
        else
            act(2002, 120850)
            act(2002, 120851)
        end
        if magic_hand == HAND_RIGHT then
            ExecEventHalfBlend(Event_MagicLaunchRightSA, blend_type)
        else
            ExecEventHalfBlend(Event_MagicLaunchLeftSA, blend_type)
        end
    elseif magic_hand == HAND_RIGHT then
        ExecEventHalfBlend(Event_MagicLaunchRight, blend_type)
    else
        ExecEventHalfBlend(Event_MagicLaunchLeft, blend_type)
    end
    if IsAttackMagic(magic_index) == TRUE then
        SetInterruptType(INTERRUPT_FINDATTACK)
    end
    if is_atk_auto_aim == TRUE then
        SetVariable("AtkAutoAimFlag", true)
        if GetVariable("IsLockon") == false then
            act("自動捕捉対象設定")
        end
    end
    SetVariable("AtkAutoAimTime", 0)
    act(118, TRUE)
    SetAIActionState()
    return TRUE
    
end

function ExecGesture()
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if FALSE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_GESTURE) then
        return FALSE
    end
    local request = env(ESD_ENV_DS3GetGestureRequestNumber)
    if request == INVALID then
        return FALSE
    end
    local isloop = FALSE
    if request == 7 then
        SetVariable("IndexGestureLoop", 0)
        isloop = TRUE
    elseif request == 9 then
        SetVariable("IndexGestureLoop", 1)
        isloop = TRUE
    elseif request == 17 then
        SetVariable("IndexGestureLoop", 2)
        isloop = TRUE
    elseif request == 22 then
        SetVariable("IndexGestureLoop", 3)
        isloop = TRUE
    elseif request == 23 then
        SetVariable("IndexGestureLoop", 4)
        isloop = TRUE
    elseif request == 25 then
        SetVariable("IndexGestureLoop", 5)
        isloop = TRUE
    elseif request == 27 then
        SetVariable("IndexGestureLoop", 6)
        isloop = TRUE
    elseif request == 29 then
        SetVariable("IndexGestureLoop", 7)
        isloop = TRUE
    elseif request == 31 then
        SetVariable("IndexGestureLoop", 8)
        isloop = TRUE
    elseif request == 32 then
        SetVariable("IndexGestureLoop", 9)
        isloop = TRUE
    elseif request == 33 then
        SetVariable("IndexGestureLoop", 10)
        isloop = TRUE
    elseif request == 34 then
        SetVariable("IndexGestureLoop", 11)
        isloop = TRUE
    end
    if isloop == TRUE then
        SetAIActionState()
        if GetVariable("LocomotionState") == PLAYER_STATE_MOVE then
            ExecEventHalfBlend(Event_GestureLoopStart, UPPER)
            return TRUE
        else
            ExecEventHalfBlend(Event_GestureLoopStart, ALLBODY)
            return TRUE
        end
    else
        SetVariable("IndexGesture", request)
        SetAIActionState()
        if GetVariable("LocomotionState") == PLAYER_STATE_MOVE then
            ExecEventHalfBlend(Event_GestureStart, UPPER)
            return TRUE
        else
            ExecEventHalfBlend(Event_GestureStart, ALLBODY)
            return TRUE
        end
    end
    
end

function ExecItem(quick_type, blend_type)
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if FALSE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_USE_ITEM) then
        return FALSE
    end
    if env(ESD_ENV_IsItemUseMenuOpened) == TRUE then
        return FALSE
    end
    if env(ESD_ENV_IsItemUseMenuOpening) == TRUE and env(ESD_ENV_IsItemUseable) == TRUE then
        ResetRequest()
        act(123)
        return TRUE
    end
    local item_type = env(ESD_ENV_GetItemAnimType)
    if TRUE == IsNodeActive("ItemDrinking_Upper_CMSG") then
        if item_type ~= ITEM_DRINK then
            return FALSE
        end
    elseif TRUE == IsNodeActive("ItemDrinkingMP_Upper_CMSG") then
        if item_type ~= ITEM_DRINK_MP then
            return FALSE
        end
    elseif TRUE == IsNodeActive("ItemDrinkingSake_Upper_CMSG") and item_type ~= ITEM_DRINK_SAKE then
        return FALSE
    end
    if item_type == ITEM_RECOVER then
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        ExecEventHalfBlend(Event_ItemRecover, blend_type)
    elseif item_type == ITEM_WEAPON_ENCHANT then
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        ExecEventHalfBlend(Event_ItemWeaponEnchant, blend_type)
    elseif item_type == ITEM_THROW_KNIFE then
        if env(ESD_ENV_GetStamina) <= 0 then
            ResetRequest()
            return FALSE
        end
        AddStamina(-7)
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        ExecEventHalfBlend(Event_ItemThrowKnife, blend_type)
    elseif item_type == ITEM_THROW_BOTTLE then
        if env(ESD_ENV_GetStamina) <= 0 then
            ResetRequest()
            return FALSE
        end
        AddStamina(-7)
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        ExecEventHalfBlend(Event_ItemThrowBottle, blend_type)
    elseif item_type == ITEM_MEGANE then
        if env(ESD_ENV_GetStateChangeType, 15) == TRUE then
            ExecEventHalfBlend(Event_ItemMeganeEnd, ALLBODY)
        else
            ExecEventHalfBlend(Event_ItemMeganeStart, ALLBODY)
        end
    elseif item_type == ITEM_REPAIR then
        ExecEventHalfBlend(Event_ItemWeaponRepair, blend_type)
    elseif item_type == ITEM_PRAY then
        ExecEventHalfBlend(Event_ItemPray, blend_type)
    elseif item_type == ITEM_TRAP then
        ExecEventHalfBlend(Event_ItemTrap, blend_type)
    elseif item_type == ITEM_MESSAGE then
        ExecEventHalfBlend(Event_ItemMessage, ALLBODY)
    elseif item_type == ITEM_SOUL then
        ExecEventHalfBlend(Event_ItemSoul, blend_type)
    elseif item_type == ITEM_DRINK then
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            ExecEventHalfBlend(Event_ItemDrinkNothing, blend_type)
        elseif TRUE == IsNodeActive("ItemDrinking_Upper_CMSG") then
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_ItemDrinking, blend_type)
        else
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_ItemDrinkStart, blend_type)
        end
    elseif item_type == ITEM_DRAGONHEAD then
        if env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_DRAGONHEAD) == TRUE or env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_DRAGONFULL) == TRUE then
            if env(ESD_ENV_GetStamina) <= 0 then
                ResetRequest()
                return FALSE
            end
            ExecEventHalfBlend(Event_DragonHeadStartAfter, blend_type)
        else
            ExecEventHalfBlend(Event_DragonHeadStartBefore, blend_type)
        end
    elseif item_type == ITEM_DRAGONFULL then
        if env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_DRAGONFULL) == TRUE then
            if env(ESD_ENV_GetStamina) < 0 then
                ResetRequest()
                return FALSE
            end
            AddStamina(-80)
            ExecEventHalfBlend(Event_DragonFullStartAfter, blend_type)
        else
            ExecEventHalfBlend(Event_DragonFullStartBefore, blend_type)
        end
    elseif item_type == ITEM_SHOCK_WAVE then
        ExecEventHalfBlend(Event_ItemShockWeaveStart, blend_type)
    elseif item_type == ITEM_QUICK_WEAPON_ENCHANT then
        if quick_type == QUICKTYPE_NORMAL then
            ExecEventHalfBlend(Event_QuickItemEnchantNormal, blend_type)
        elseif quick_type == QUICKTYPE_DASH then
            ExecEventHalfBlend(Event_QuickItemEnchantDash, blend_type)
        elseif quick_type == QUICKTYPE_ROLLING then
            ExecEventHalfBlend(Event_QuickItemEnchantStep, ALLBODY)
        elseif quick_type == QUICKTYPE_ATTACK then
            if ForwardLeg() == 1 then
                ExecEventHalfBlend(Event_QuickItemEnchantAttackRight, ALLBODY)
            else
                ExecEventHalfBlend(Event_QuickItemEnchantAttackLeft, ALLBODY)
            end
        else
            return FALSE
        end
    elseif item_type == ITEM_QUICK_THROW_KNIFE then
        if env(ESD_ENV_GetStamina) <= 0 then
            ResetRequest()
            return FALSE
        end
        AddStamina(-7)
        if quick_type == QUICKTYPE_NORMAL then
            ExecEventHalfBlend(Event_QuickItemThrowKnifeNormal, ALLBODY)
        elseif quick_type == QUICKTYPE_DASH then
            ExecEventHalfBlend(Event_QuickItemThrowKnifeDash, ALLBODY)
        elseif quick_type == QUICKTYPE_ROLLING then
            ExecEventHalfBlend(Event_QuickItemThrowKnifeStep, ALLBODY)
        elseif quick_type == QUICKTYPE_ATTACK then
            if ForwardLeg() == 1 then
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackRight, ALLBODY)
            else
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackLeft, ALLBODY)
            end
        elseif quick_type == QUICKTYPE_COMBO then
            if ForwardLeg() == 1 then
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackRight2, ALLBODY)
            else
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackLeft2, ALLBODY)
            end
        else
            return FALSE
        end
    elseif item_type == ITEM_QUICK_THROW_BOTTLE then
        return FALSE
    elseif item_type == ITEM_DRINK_MP then
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            ExecEventHalfBlend(Event_ItemDrinkNothingMP, blend_type)
        elseif TRUE == IsNodeActive("ItemDrinkingMP_Upper_CMSG") then
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_ItemDrinkingMP, blend_type)
        else
            SetInterruptType(INTERRUPT_USEITEM)
            ExecEventHalfBlend(Event_ItemDrinkStartMP, blend_type)
        end
    elseif item_type == ITEM_BACK_BOTTLE then
        ExecEventHalfBlend(Event_ItemBackBottle, blend_type)
    elseif item_type == ITEM_DRINK_SAKE then
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        if TRUE == IsNodeActive("ItemDrinkingSake_Upper_CMSG") then
            ExecEventHalfBlend(Event_ItemDrinkingSake, blend_type)
        else
            ExecEventHalfBlend(Event_ItemDrinkStartSake, blend_type)
        end
    elseif item_type == ITEM_CHAMELEON then
        ExecEventHalfBlend(Event_ItemChameleon, blend_type)
    elseif item_type == ITEM_DRAGONHEADLVL2 then
        if env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_DRAGONHEAD) == TRUE or env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_DRAGONFULL) == TRUE then
            if env(ESD_ENV_GetStamina) <= 0 then
                ResetRequest()
                return FALSE
            end
            ExecEventHalfBlend(Event_DragonHeadStartAfterLVL2, blend_type)
        else
            ExecEventHalfBlend(Event_DragonHeadStartBefore, blend_type)
        end
    elseif item_type == ITEM_DRAGONFULLLVL2 then
        if env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_DRAGONFULL) == TRUE then
            if env(ESD_ENV_GetStamina) < 0 then
                ResetRequest()
                return FALSE
            end
            AddStamina(-100)
            ExecEventHalfBlend(Event_DragonFullStartAfterLVL2, blend_type)
        else
            ExecEventHalfBlend(Event_DragonFullStartBefore, blend_type)
        end
    elseif item_type == ITEM_OLDMONK then
        ExecEventHalfBlend(Event_ItemOldMonk, blend_type)
    elseif item_type == ITEM_QUICK_THROW_HOMINGKNIFE then
        if env(ESD_ENV_GetStamina) <= 0 then
            ResetRequest()
            return FALSE
        end
        AddStamina(-10)
        if quick_type == QUICKTYPE_NORMAL then
            ExecEventHalfBlend(Event_QuickItemThrowKnifeNormal, ALLBODY)
        elseif quick_type == QUICKTYPE_DASH then
            ExecEventHalfBlend(Event_QuickItemThrowKnifeDash, ALLBODY)
        elseif quick_type == QUICKTYPE_ROLLING then
            ExecEventHalfBlend(Event_QuickItemThrowKnifeStep, ALLBODY)
        elseif quick_type == QUICKTYPE_ATTACK then
            if ForwardLeg() == 1 then
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackRight, ALLBODY)
            else
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackLeft, ALLBODY)
            end
        elseif quick_type == QUICKTYPE_COMBO then
            if ForwardLeg() == 1 then
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackRight2, ALLBODY)
            else
                ExecEventHalfBlend(Event_QuickItemThrowKnifeAttackLeft2, ALLBODY)
            end
        else
            return FALSE
        end
    elseif item_type == ITEM_NO_DRINK then
        if env(ESD_ENV_IsCOMPlayer) == TRUE and FALSE == env(ESD_ENV_DS3GetSpecialEffectID, 5110) then
            act(2002, 5110)
        end
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        ExecEventHalfBlend(Event_ItemDrinkEmpty, blend_type)
    elseif item_type == ITEM_INVALID then
        if env(ESD_ENV_IsCOMPlayer) == TRUE and FALSE == env(ESD_ENV_DS3GetSpecialEffectID, 5111) then
            act(2002, 5111)
        end
        if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
            blend_type = UPPER
        end
        ExecEventHalfBlend(Event_ItemInvalid, blend_type)
    else
        return FALSE
    end
    act("アイテムアニメ中か設定")
    g_ItemFirstFrame = 1
    SetAIActionState()
    return TRUE
    
end

function ExecLadderItem(hand)
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    if FALSE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_USE_ITEM) then
        return FALSE
    end
    if env(ESD_ENV_IsItemUseMenuOpened) == TRUE then
        return FALSE
    end
    if env(ESD_ENV_IsItemUseMenuOpening) == TRUE and env(ESD_ENV_IsItemUseable) == TRUE then
        ResetRequest()
        act(123)
        return TRUE
    end
    local item_type = env(ESD_ENV_GetItemAnimType)
    local event = "W_ItemLadderInvalid"
    local event_hand = "Left"
    if hand == HAND_STATE_RIGHT then
        event_hand = "Right"
    end
    if TRUE == IsNodeActive("ItemLadderDrinkingRight_CMSG", "ItemLadderDrinkingLeft_CMSG") then
        if item_type ~= ITEM_DRINK then
            return FALSE
        end
    elseif TRUE == IsNodeActive("ItemLadderDrinkingMPRight_CMSG", "ItemLadderDrinkingMPLeft_CMSG") then
        if item_type ~= ITEM_DRINK_MP then
            return FALSE
        end
    elseif TRUE == IsNodeActive("ItemLadderDrinkingSakeRight_CMSG", "ItemLadderDrinkingSakeLeft_CMSG") and item_type ~= ITEM_DRINK_SAKE then
        return FALSE
    end
    if item_type == ITEM_RECOVER then
        event = "W_ItemLadderRecover"
    elseif item_type == ITEM_SOUL then
        event = "W_ItemLadderSoul"
    elseif item_type == ITEM_DRINK then
        if env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            event = "W_ItemLadderDrinkNothing"
        elseif TRUE == IsNodeActive("ItemLadderDrinkingRight_CMSG") then
            event = "W_ItemLadderDrinking"
            event_hand = "Right"
        elseif TRUE == IsNodeActive("ItemLadderDrinkingLeft_CMSG") then
            event = "W_ItemLadderDrinking"
            event_hand = "Left"
        else
            event = "W_ItemLadderDrinkStart"
        end
    elseif item_type == ITEM_DRINK_MP then
        if env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_NO_EST) == TRUE then
            event = "W_ItemLadderDrinkNothingMP"
        elseif TRUE == IsNodeActive("ItemLadderDrinkingMPRight_CMSG") then
            event = "W_ItemLadderDrinkingMP"
            event_hand = "Right"
        elseif TRUE == IsNodeActive("ItemLadderDrinkingMPLeft_CMSG") then
            event = "W_ItemLadderDrinkingMP"
            event_hand = "Left"
        else
            event = "W_ItemLadderDrinkStartMP"
        end
    elseif item_type == ITEM_DRINK_SAKE then
        if TRUE == IsNodeActive("ItemLadderDrinkingSakeRight_CMSG") then
            event = "W_ItemLadderDrinkingSake"
            event_hand = "Right"
        elseif TRUE == IsNodeActive("ItemLadderDrinkingSakeLeft_CMSG") then
            event = "W_ItemLadderDrinkingSake"
            event_hand = "Left"
        else
            event = "W_ItemLadderDrinkStartSake"
        end
    elseif item_type == ITEM_NO_DRINK then
        event = "W_ItemLadderDrinkEmpty"
    end
    act("アイテムアニメ中か設定")
    ExecEvent(event .. event_hand)
    return TRUE
    
end

function ExecWeaponChange(blend_type)
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    local kind = WEAPON_CHANGE_REQUEST_INVALID
    if env(ESD_ENV_DS3ActionRequest, ACTION_ARM_CHANGE_WEAPON_R) == TRUE then
        kind = GetWeaponChangeType(HAND_RIGHT)
    elseif env(ESD_ENV_DS3ActionRequest, ACTION_ARM_CHANGE_WEAPON_L) == TRUE then
        kind = GetWeaponChangeType(HAND_LEFT)
    else
        return FALSE
    end
    if kind == WEAPON_CHANGE_REQUEST_INVALID then
        return FALSE
    end
    SetVariable("WeaponChangeType", kind)
    if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
        blend_type = UPPER
    end
    ExecEventHalfBlend(Event_WeaponChangeStart, blend_type)
    SetAIActionState()
    return TRUE
    
end

function ExecHandChange(hand, is_force, blend_type)
    if is_force == FALSE then
        if FALSE == c_HasActionRequest then
            return FALSE
        end
        if env(ESD_ENV_DS3ActionRequest, ACTION_ARM_CHANGE_STYLE) == TRUE then

        elseif env(ESD_ENV_DS3ActionRequest, ACTION_ARM_CHANGE_STYLE_LEFT) == TRUE then
            hand = HAND_LEFT
        else
            return FALSE
        end
    end
    local style = c_Style
    local pos = nil
    if style == HAND_RIGHT then
        if hand == HAND_RIGHT then
            if FALSE == env(ESD_ENV_IsTwoHandPossible, HAND_RIGHT) then
                return FALSE
            end
            pos = GetHandChangeType(HAND_LEFT)
            if pos == WEAPON_CHANGE_REQUEST_LEFT_WAIST then
                if TRUE == IsDualBladeSpecific(HAND_RIGHT) then
                    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)
                    local kind = env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT)
                    if sp_kind == 144 and kind == WEAPON_CATEGORY_FIST then
                        SetHandChangeStyle(LEFT_TO_BACK, LEFT_FROM_BACK)
                    else
                        SetHandChangeStyle(LEFT_TO_WAIST, LEFT_FROM_WAIST)
                    end
                else
                    SetHandChangeStyle(LEFT_TO_WAIST, BOTH_FROM_ALL)
                end
            elseif pos == WEAPON_CHANGE_REQUEST_LEFT_BACK then
                local kind = env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT)
                if TRUE == IsDualBladeSpecific(HAND_RIGHT) then
                    SetHandChangeStyle(LEFT_TO_BACK, LEFT_FROM_BACK)
                elseif kind == WEAPON_CATEGORY_KATANA then
                    SetHandChangeStyle(LEFT_TO_WAIST, BOTH_FROM_ALL)
                else
                    SetHandChangeStyle(LEFT_TO_BACK, BOTH_FROM_ALL)
                end
            elseif pos == WEAPON_CHANGE_REQUEST_LEFT_SHOULDER then
                if TRUE == IsDualBladeSpecific(HAND_RIGHT) then
                    SetHandChangeStyle(LEFT_TO_SHOULDER, LEFT_FROM_SHOULDER)
                else
                    SetHandChangeStyle(LEFT_TO_SHOULDER, BOTH_FROM_ALL)
                end
            elseif pos == WEAPON_CHANGE_REQUEST_LEFT_SPEAR then
                if TRUE == IsDualBladeSpecific(HAND_RIGHT) then
                    SetHandChangeStyle(LEFT_TO_SPEAR, LEFT_FROM_SPEAR)
                else
                    SetHandChangeStyle(LEFT_TO_SPEAR, BOTH_FROM_ALL)
                end
            elseif TRUE == IsDualBladeSpecific(HAND_RIGHT) then
                SetHandChangeStyle(LEFT_TO_SPEAR, LEFT_FROM_SPEAR)
            else
                SetHandChangeStyle(LEFT_TO_SPEAR, BOTH_FROM_ALL)
            end
            act(104, 1)
        else
            if FALSE == env(ESD_ENV_IsTwoHandPossible, HAND_LEFT) then
                return FALSE
            end
            pos = GetHandChangeType(HAND_RIGHT)
            if pos == WEAPON_CHANGE_REQUEST_RIGHT_WAIST then
                if TRUE == IsDualBladeSpecific(HAND_LEFT) then
                    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
                    local kind = env(ESD_ENV_GetEquipWeaponCategory, HAND_RIGHT)
                    if sp_kind == 144 and kind == WEAPON_CATEGORY_FIST then
                        SetHandChangeStyle(RIGHT_TO_BACK, RIGHT_FROM_BACK)
                    else
                        SetHandChangeStyle(RIGHT_TO_WAIST, RIGHT_FROM_WAIST)
                    end
                else
                    SetHandChangeStyle(RIGHT_TO_WAIST, BOTHLEFT_FROM_ALL)
                end
            elseif pos == WEAPON_CHANGE_REQUEST_RIGHT_BACK then
                local kind = env(ESD_ENV_GetEquipWeaponCategory, HAND_RIGHT)
                if TRUE == IsDualBladeSpecific(HAND_LEFT) then
                    if kind == WEAPON_CATEGORY_KATANA then
                        SetHandChangeStyle(RIGHT_TO_WAIST, BOTHLEFT_FROM_ALL)
                    else
                        SetHandChangeStyle(RIGHT_TO_BACK, RIGHT_FROM_BACK)
                    end
                elseif kind == WEAPON_CATEGORY_KATANA then
                    SetHandChangeStyle(RIGHT_TO_WAIST, BOTHLEFT_FROM_ALL)
                else
                    SetHandChangeStyle(RIGHT_TO_BACK, BOTHLEFT_FROM_ALL)
                end
            elseif pos == WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER then
                if TRUE == IsDualBladeSpecific(HAND_LEFT) then
                    SetHandChangeStyle(RIGHT_TO_SHOULDER, RIGHT_FROM_SHOULDER)
                else
                    SetHandChangeStyle(RIGHT_TO_SHOULDER, BOTHLEFT_FROM_ALL)
                end
            elseif pos == WEAPON_CHANGE_REQUEST_RIGHT_SPEAR then
                if TRUE == IsDualBladeSpecific(HAND_LEFT) then
                    SetHandChangeStyle(RIGHT_TO_SPEAR, RIGHT_FROM_SPEAR)
                else
                    SetHandChangeStyle(RIGHT_TO_SPEAR, BOTHLEFT_FROM_ALL)
                end
            elseif TRUE == IsDualBladeSpecific(HAND_LEFT) then
                SetHandChangeStyle(RIGHT_TO_BACK, RIGHT_FROM_BACK)
            else
                SetHandChangeStyle(RIGHT_TO_BACK, BOTHLEFT_FROM_ALL)
            end
            act(104, 2)
        end
    elseif style == HAND_RIGHT_BOTH then
        pos = GetHandChangeType(HAND_LEFT)
        if pos == WEAPON_CHANGE_REQUEST_LEFT_WAIST then
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_RIGHT)
            local kind = env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT)
            if sp_kind == 144 and kind == WEAPON_CATEGORY_FIST then
                SetHandChangeStyle(BOTH_TO_BACK, LEFT_FROM_BACK)
            else
                SetHandChangeStyle(BOTH_TO_WAIST, LEFT_FROM_WAIST)
            end
        elseif pos == WEAPON_CHANGE_REQUEST_LEFT_BACK then
            SetHandChangeStyle(BOTH_TO_BACK, LEFT_FROM_BACK)
        elseif pos == WEAPON_CHANGE_REQUEST_LEFT_SHOULDER then
            SetHandChangeStyle(BOTH_TO_SHOULDER, LEFT_FROM_SHOULDER)
        else
            SetHandChangeStyle(BOTH_TO_BACK, LEFT_FROM_SPEAR)
        end
        act(104, 3)
    elseif style == HAND_LEFT_BOTH then
        pos = GetHandChangeType(HAND_RIGHT)
        if pos == WEAPON_CHANGE_REQUEST_RIGHT_WAIST then
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
            local kind = env(ESD_ENV_GetEquipWeaponCategory, HAND_RIGHT)
            if sp_kind == 144 and kind == WEAPON_CATEGORY_FIST then
                SetHandChangeStyle(BOTHRIGHT_TO_BACK, RIGHT_FROM_BACK)
            else
                SetHandChangeStyle(BOTHRIGHT_TO_WAIST, RIGHT_FROM_WAIST)
            end
        elseif pos == WEAPON_CHANGE_REQUEST_RIGHT_BACK then
            SetHandChangeStyle(BOTHRIGHT_TO_BACK, RIGHT_FROM_BACK)
        elseif pos == WEAPON_CHANGE_REQUEST_RIGHT_SHOULDER then
            SetHandChangeStyle(BOTHRIGHT_TO_SHOULDER, RIGHT_FROM_SHOULDER)
        else
            SetHandChangeStyle(BOTHRIGHT_TO_BACK, RIGHT_FROM_SPEAR)
        end
        act(104, 1)
    end
    if blend_type == ALLBODY and MoveStart(LOWER, Event_MoveLong, FALSE) == TRUE then
        blend_type = UPPER
    end
    ExecEventHalfBlend(Event_HandChangeStart, blend_type)
    SetAIActionState()
    return TRUE
    
end

function ExecEvasion(backstep_limit, estep, is_usechainrecover)
    if c_HasActionRequest == FALSE then
        return FALSE
    end
    local request = GetEvasionRequest()
    if request == ATTACK_REQUEST_INVALID then
        return FALSE
    end
    if backstep_limit == TRUE and request == ATTACK_REQUEST_BACKSTEP and TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        return FALSE
    end
    SetEvasionStaminaCost()
    if request == ATTACK_REQUEST_ROLLING then
        if is_usechainrecover == TRUE then
            local damagecount = GetVariable("DamageCount")
            if damagecount >= 4 then
                if FALSE == env(ESD_ENV_GetEventEzStateFlag, 5) then
                    return FALSE
                end
            elseif damagecount == 3 then
                if FALSE == env(ESD_ENV_GetEventEzStateFlag, 4) then
                    return FALSE
                end
            elseif damagecount == 2 then
                if FALSE == env(ESD_ENV_GetEventEzStateFlag, 3) then
                    return FALSE
                end
            elseif damagecount <= 1 and FALSE == env(ESD_ENV_GetEventEzStateFlag, 2) then
                return FALSE
            end
        end
        if env(ESD_ENV_GetStamina) <= 0 then
            return FALSE
        end
        local rollingangle = GetVariable("RollingAngle")
        if rollingangle >= 0 then
            SetVariable("RollingDirection", 1)
        else
            SetVariable("RollingDirection", 0)
        end
        local event = "W_Rolling"
        local weight = GetWeightIndex(FALSE)
        local is_selftrans = FALSE
        if TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100370) then
            if weight == EVASION_WEIGHT_INDEX_OVERWEIGHT then
                return FALSE
            end
            event = "W_EStepDown"
        elseif weight == EVASION_WEIGHT_INDEX_OVERWEIGHT then
            if math.abs(rollingangle) > 135 then
                event = "W_RollingOverweightBack"
            elseif rollingangle > 45 then
                event = "W_RollingOverweightRight"
            elseif rollingangle < -45 then
                event = "W_RollingOverweightLeft"
            else
                event = "W_RollingOverweightFront"
            end
        else
            if weight == EVASION_WEIGHT_INDEX_MEDIUM then
                event = event .. "Medium"
            elseif weight == EVASION_WEIGHT_INDEX_HEAVY then
                event = event .. "Heavy"
            else
                event = event .. "Light"
            end
            if TRUE == IsNodeActive("Rolling_CMSG") then
                is_selftrans = TRUE
            end
        end
        local turn_angle_real = 200
        if GetVariable("IsLockon") == true then
            act("ロックオン対象へ即座に旋回")
            turn_angle_real = math.abs(GetVariable("TurnAngle") - rollingangle)
            if turn_angle_real > 180 then
                turn_angle_real = 360 - turn_angle_real
            end
        elseif math.abs(rollingangle) > 0.0010000000474974513 then
            SetTurnSpeed(0)
        else
            local move_angle = GetVariable("MoveAngle")
            if move_angle ~= 0 then
                rollingangle = move_angle
            end
        end
        SetVariable("TurnAngleReal", turn_angle_real)
        if is_selftrans == TRUE then
            event = event .. "Selftrans"
            SetVariable("RollingAngleRealSelftrans", rollingangle)
        else
            SetVariable("RollingAngleReal", rollingangle)
        end
        local front, back, left, right = false
        if math.abs(rollingangle) > 135 then
            back = true
        elseif rollingangle > 45 then
            right = true
        elseif rollingangle < -45 then
            left = true
        else
            front = true
        end
        SetVariable("EnableTAE_RollingFront", front)
        SetVariable("EnableTAE_RollingBack", back)
        SetVariable("EnableTAE_RollingLeft", left)
        SetVariable("EnableTAE_RollingRight", right)
        AddStamina(c_StaminaCostRolling)
        ExecEventAllBody(event)
    elseif request == ATTACK_REQUEST_JUMP then
        AddStamina(c_StaminaCostJump)
        ExecEventAllBody("W_Jump")
    elseif request == ATTACK_REQUEST_BACKSTEP then
        ResetDamageCount()
        local index = GetWeightIndex(FALSE)
        local event = "W_BackStepLight"
        if index == EVASION_WEIGHT_INDEX_SUPERLIGHT then
            event = "W_BackStepSuperlight"
        elseif index == EVASION_WEIGHT_INDEX_MEDIUM then
            event = "W_BackStepNomal"
        elseif index == EVASION_WEIGHT_INDEX_HEAVY then
            event = "W_BackStepHeavy"
        elseif index == EVASION_WEIGHT_INDEX_OVERWEIGHT then
            event = "W_BackStepOverweight"
        end
        if GetVariable("IsLockon") == true and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100360) then
            act("ロックオン対象へ即座に旋回")
        end
        AddStamina(c_StaminaCostBackStep)
        ExecEventAllBody(event)
    else
        return FALSE
    end
    SetAIActionState()
    return TRUE
    
end

function ExecQuickTurn(blend_type)
    if blend_type == LOWER and IsLowerQuickTurn() == TRUE then
        return FALSE
    end
    if GetVariable("IsLockon") == false then
        return FALSE
    end
    local turn_angle = GetVariable("TurnAngle")
    if math.abs(turn_angle) < 45 then
        return FALSE
    end
    if turn_angle >= 45 then
        ExecEventHalfBlend(Event_QuickTurnRight180, blend_type)
    else
        ExecEventHalfBlend(Event_QuickTurnLeft180, blend_type)
    end
    return TRUE
    
end

function ExecDashTurn()
    if GetVariable("MoveSpeedLevel") <= 0 then
        return FALSE
    end
    local angle = math.abs(GetVariable("TurnAngle"))
    if angle > 90 then
        ExecEventHalfBlend(Event_Dash180, ALLBODY)
        return TRUE
    end
    return FALSE
    
end

function ExecQuickTurnOnCancelTiming()
    if env(ESD_ENV_DS3IsMoveCancelPossible) == FALSE then
        return FALSE
    end
    if ExecQuickTurn(ALLBODY) == TRUE then
        return TRUE
    end
    return FALSE
    
end

function ExecFallStart(fall_type)
    if env(ESD_ENV_IsFalling) == FALSE then
        return FALSE
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 4500) == TRUE or env(ESD_ENV_DS3GetSpecialEffectID, 4502) == TRUE then
        ExecEventAllBody("W_FallStartFaceDown")
        return TRUE
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 4501) == TRUE then
        ExecEventAllBody("W_FallStartFaceUp")
        return TRUE
    end
    if fall_type == FALL_TYPE_DEFAULT then
        if env(ESD_ENV_IsSpecialTransition2Possible) == TRUE then
            local style = c_Style
            local hand = HAND_RIGHT
            if style == HAND_LEFT_BOTH then
                hand = HAND_LEFT
            end
            local check_weapon = GetEquipType(hand, WEAPON_CATEGORY_STAFF, WEAPON_CATEGORY_FIST_CUT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_SMALL_SHIELD, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_TORCH)
            if check_weapon == FALSE then
                ExecEventAllBody("W_FallAttackLoop")
            else
                ExecEventAllBody("W_FallStart")
            end
        else
            ExecEventAllBody("W_FallStart")
        end
    elseif fall_type == FALL_TYPE_JUMP then
        if env(ESD_ENV_DS3GetSpecialEffectID, 100310) == TRUE then
            ExecEventAllBody("W_FallJumpStart")
        else
            return FALSE
        end
    elseif fall_type == FALL_TYPE_FACEDOWN_LOOP then
        ExecEventAllBody("W_FallLoopFaceDown")
    elseif fall_type == FALL_TYPE_FACEDOWN then
        ExecEventAllBody("W_FallStartFaceDown")
    elseif fall_type == FALL_TYPE_FACEUP_LOOP then
        ExecEventAllBody("W_FallLoopFaceUp")
    elseif fall_type == FALL_TYPE_FACEUP then
        ExecEventAllBody("W_FallStartFaceUp")
    else
        local damage_angle = env(ESD_ENV_GetReceivedDamageDirection)
        if damage_angle == DAMAGE_DIR_BACK then
            if fall_type == FALL_TYPE_FORCE_LOOP then
                ExecEventAllBody("W_FallLoopFaceDown")
            else
                ExecEventAllBody("W_FallStartFaceDown")
            end
        elseif fall_type == FALL_TYPE_FORCE_LOOP then
            ExecEventAllBody("W_FallLoopFaceUp")
        else
            ExecEventAllBody("W_FallStartFaceUp")
        end
    end
    return TRUE
    
end

function ExecAddDamage(damage_dir, attack_dir, damage_level, is_guard, is_damaged)
    if is_damaged == FALSE then
        return 
    end
    if env(ESD_ENV_GetBehaviorID, 9) == TRUE then
        return 
    end
    if is_guard == TRUE then
        SetVariable("AddDamageGuardBlend", 1)
    elseif damage_level == DAMAGE_LEVEL_NONE or damage_level == DAMAGE_LEVEL_MINIMUM then
        SetVariable("AddDamageBlend", 1)
    else
        SetVariable("DamageDirBlendRate", 1)
    end
    if damage_dir == DAMAGE_DIR_LEFT then
        if attack_dir == ATTACK_DIR_FRONT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallLeft_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumLeft_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartLeft")
                return 
            else
                ExecEventNoReset("W_AddDamageStartLeft")
                return 
            end
        elseif attack_dir == ATTACK_DIR_UP then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallLeft_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumLeft_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartLeft")
                return 
            else
                ExecEventNoReset("W_AddDamageStartLeft")
                return 
            end
        elseif attack_dir == ATTACK_DIR_DOWN then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallLeft_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumLeft_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartLeft")
                return 
            else
                ExecEventNoReset("W_AddDamageStartLeft")
                return 
            end
        elseif attack_dir == ATTACK_DIR_LEFT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallFront_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumFront_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return 
            else
                ExecEventNoReset("W_AddDamageStartFront")
                return 
            end
        elseif attack_dir == ATTACK_DIR_RIGHT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallBack_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumBack_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartBack")
                return 
            else
                ExecEventNoReset("W_AddDamageStartBack")
                return 
            end
        end
    elseif damage_dir == DAMAGE_DIR_RIGHT then
        if attack_dir == ATTACK_DIR_FRONT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallRight_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumRight_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartRight")
                return 
            else
                ExecEventNoReset("W_AddDamageStartRight")
                return 
            end
        elseif attack_dir == ATTACK_DIR_UP then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallRight_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumRight_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartRight")
                return 
            else
                ExecEventNoReset("W_AddDamageStartRight")
                return 
            end
        elseif attack_dir == ATTACK_DIR_DOWN then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallRight_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumRight_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartRight")
                return 
            else
                ExecEventNoReset("W_AddDamageStartRight")
                return 
            end
        elseif attack_dir == ATTACK_DIR_LEFT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallBack_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumBack_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartBack")
                return 
            else
                ExecEventNoReset("W_AddDamageStartBack")
                return 
            end
        elseif attack_dir == ATTACK_DIR_RIGHT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallFront_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumFront_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return 
            else
                ExecEventNoReset("W_AddDamageStartFront")
                return 
            end
        end
    elseif damage_dir == DAMAGE_DIR_FRONT then
        if attack_dir == ATTACK_DIR_FRONT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallFront_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumFront_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return 
            else
                ExecEventNoReset("W_AddDamageStartFront")
                return 
            end
        elseif attack_dir == ATTACK_DIR_UP then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallUp_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumUp_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return 
            else
                ExecEventNoReset("W_AddDamageStartFront")
                return 
            end
        elseif attack_dir == ATTACK_DIR_DOWN then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallDown_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumDown_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartFront")
                return 
            else
                ExecEventNoReset("W_AddDamageStartFront")
                return 
            end
        elseif attack_dir == ATTACK_DIR_LEFT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallRight_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumRight_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartRight")
                return 
            else
                ExecEventNoReset("W_AddDamageStartRight")
                return 
            end
        elseif attack_dir == ATTACK_DIR_RIGHT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallLeft_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumLeft_Add")
                return 
            elseif is_guard == TRUE then
                ExecEventNoReset("W_AddDamageGuardStartLeft")
                return 
            else
                ExecEventNoReset("W_AddDamageStartLeft")
                return 
            end
        end
    elseif damage_dir == DAMAGE_DIR_BACK then
        if attack_dir == ATTACK_DIR_FRONT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallBack_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumBack_Add")
                return 
            else
                ExecEventNoReset("W_AddDamageStartBack")
                return 
            end
        elseif attack_dir == ATTACK_DIR_UP then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallBack_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumBack_Add")
                return 
            else
                ExecEventNoReset("W_AddDamageStartBack")
                return 
            end
        elseif attack_dir == ATTACK_DIR_DOWN then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallBack_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumBack_Add")
                return 
            else
                ExecEventNoReset("W_AddDamageStartBack")
                return 
            end
        elseif attack_dir == ATTACK_DIR_LEFT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallLeft_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumLeft_Add")
                return 
            else
                ExecEventNoReset("W_AddDamageStartLeft")
                return 
            end
        elseif attack_dir == ATTACK_DIR_RIGHT then
            if damage_level == DAMAGE_LEVEL_SMALL then
                ExecEventNoReset("W_DirDamageSmallRight_Add")
                return 
            elseif damage_level == DAMAGE_LEVEL_MIDDLE or damage_level == DAMAGE_LEVEL_LARGE then
                ExecEventNoReset("W_DirDamageMediumRight_Add")
                return 
            else
                ExecEventNoReset("W_AddDamageStartRight")
                return 
            end
        end
    end
    
end

function ExecPassiveAction(is_parry, fall_type, is_attackwhileguard)
    if env(ESD_ENV_DS3HasThrowRequest) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if TRUE == ExecDeath() then
        return TRUE
    end
    if env(ESD_ENV_DS3CheckForEventAnimPlaybackRequest) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if ExecDamage(is_parry, is_attackwhileguard) == TRUE then
        return TRUE
    end
    if TRUE == ExecSlide() then
        return TRUE
    end
    if ExecFallStart(fall_type) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    return FALSE
    
end

function IsDead()
    if env(ESD_ENV_GetReceivedDamageType) == DAMAGE_TYPE_DEATH or env(ESD_ENV_GetHP) <= 0 then
        return TRUE
    end
    return FALSE
    
end

function IsLandDead(height)
    if env(ESD_ENV_GetHP) <= 0 then
        return TRUE
    elseif height > 20 and env(ESD_ENV_IsInvincibleDebugMode) == FALSE and env(ESD_ENV_DS3GetSpecialEffectID, 4050) == FALSE and env(ESD_ENV_DS3GetSpecialEffectID, 4060) == FALSE and env(ESD_ENV_DS3GetSpecialEffectID, 4070) == FALSE and env(ESD_ENV_DS3GetSpecialEffectID, 4080) == FALSE then
        return TRUE
    end
    return FALSE
    
end

function ExecDeath()
    if IsDead() == TRUE then
        if env(ESD_ENV_GetReceivedDamageType) ~= DAMAGE_TYPE_DEATH_FALLING and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 103520000) then
            return FALSE
        end
        local damage_angle = env(ESD_ENV_GetReceivedDamageDirection)
        SetVariable("DamageDirection", damage_angle)
        if env(ESD_ENV_DS3GetKnockbackDistance) < 0 then
            if damage_angle == DAMAGE_DIR_LEFT then
                damage_angle = DAMAGE_DIR_RIGHT
            elseif damage_angle == DAMAGE_DIR_RIGHT then
                damage_angle = DAMAGE_DIR_LEFT
            elseif damage_angle == DAMAGE_DIR_FRONT then
                damage_angle = DAMAGE_DIR_BACK
            elseif damage_angle == DAMAGE_DIR_BACK then
                damage_angle = DAMAGE_DIR_FRONT
            end
        end
        local damage_level = env(ESD_ENV_GetDamageLevel)
        if TRUE == env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_STONE) then
            SetVariable("IndexDeath", DEATH_TYPE_STONE)
        elseif TRUE == env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_CRYSTAL) then
            SetVariable("IndexDeath", DEATH_TYPE_STONE)
        elseif TRUE == env(ESD_ENV_IsOnLadder) then
            SetVariable("IndexDeath", DEATH_TYPE_LADDER)
        elseif TRUE == env(ESD_ENV_GetIsWeakPoint) then
            SetVariable("IndexDeath", DEATH_TYPE_WEAK)
        elseif damage_level == DAMAGE_LEVEL_EXLARGE or damage_level == DAMAGE_LEVEL_SMALL_BLOW then
            SetVariable("IndexDeath", DEATH_TYPE_BLAST)
        elseif damage_level == DAMAGE_LEVEL_UPPER then
            SetVariable("IndexDeath", DEATH_TYPE_UPPER)
        elseif damage_level == DAMAGE_LEVEL_FLING then
            SetVariable("IndexDeath", DEATH_TYPE_FLING)
        else
            SetVariable("DamageState", env(ESD_ENV_GetRandomInt, 0, 3))
            if damage_angle == DAMAGE_DIR_BACK then
                SetVariable("IndexDeath", DEATH_TYPE_COMMON_BACK)
            else
                SetVariable("IndexDeath", DEATH_TYPE_COMMON)
            end
        end
        ExecEventAllBody("W_DeathStart")
        return TRUE
    elseif env(ESD_ENV_IsInvincibleDebugMode) == FALSE then
        if TRUE == env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_STONE) or TRUE == env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_CRYSTAL) then
            SetVariable("IndexDeath", DEATH_TYPE_STONE)
            ExecEventAllBody("W_DeathStart")
            return TRUE
        elseif TRUE == env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_TAINTDEATH) then
            SetVariable("IndexDeath", DEATH_TYPE_TAINT)
            ExecEventAllBody("W_DeathStart")
            return TRUE
        end
    end
    
end

function ExecDamage(is_parry, is_attackwhileguard)
    local damage_level = env(ESD_ENV_GetDamageLevel)
    local damage_type = env(ESD_ENV_GetReceivedDamageType)
    local is_damaged = env(ESD_ENV_HasReceivedAnyDamage)
    if damage_level <= DAMAGE_LEVEL_NONE and is_damaged == FALSE and (damage_type == DAMAGE_TYPE_INVALID or damage_type == DAMAGE_TYPE_WEAK_POINT or damage_type == DAMAGE_LEVEL_MINIMUM) then
        return FALSE
    end
    local attack_dir = env(ESD_ENV_DS3GetAtkDirection)
    local damage_angle = env(ESD_ENV_GetReceivedDamageDirection)
    local style = c_Style
    if damage_type == DAMAGE_TYPE_PARRY then
        ExecEventAllBody("W_DamageParry")
        return TRUE
    end
    if damage_type == DAMAGE_TYPE_GUARD and env(ESD_ENV_GetBehaviorID, 4) == TRUE then
        damage_type = DAMAGE_TYPE_GUARDBREAK
    end
    if damage_type >= DAMAGE_TYPE_GUARDED and damage_type <= DAMAGE_TYPE_WALL_LEFT then
        Replanning()
        if (damage_type == DAMAGE_TYPE_GUARDBREAK_BLAST or damage_type == DAMAGE_TYPE_GUARDBREAK_FLING) and IsGuardbreakBlowDamage(damage_level) == FALSE then
            damage_type = DAMAGE_TYPE_GUARDBREAK
        end
        if damage_type == DAMAGE_TYPE_GUARDED then
            if style == HAND_RIGHT then
                SetVariable("GuardDamageIndex", 1)
            else
                SetVariable("GuardDamageIndex", 2)
            end
            act(141, DAMAGE_FLAG_GUARD_BREAK)
            ExecEventAllBody("W_GuardDamageBreak")
            return TRUE
        elseif damage_type == DAMAGE_TYPE_GUARDED_LEFT then
            SetVariable("GuardDamageIndex", 0)
            act(141, DAMAGE_FLAG_GUARD_BREAK)
            ExecEventAllBody("W_GuardDamageBreak")
            return TRUE
        elseif damage_type == DAMAGE_TYPE_GUARDBREAK then
            if is_parry == TRUE then
                return FALSE
            end
            if env(ESD_ENV_DS3GetSpecialEffectID, 100350) == TRUE then
                return FALSE
            end
            local guardindex = GUARD_STYLE_DEFAULT
            if style == HAND_RIGHT then
                guardindex = env(ESD_ENV_GetGuardMotionCategory, HAND_LEFT)
                if env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_TORCH or env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT) == 240 then
                    SetVariable("IsTorchGuard", TRUE)
                else
                    SetVariable("IsTorchGuard", FALSE)
                end
            elseif style == HAND_LEFT_BOTH then
                SetVariable("IsTorchGuard", FALSE)
                if env(ESD_ENV_DS3GetStayAnimCategory) == 15 then
                    guardindex = env(ESD_ENV_GetGuardMotionCategory, HAND_LEFT)
                end
            elseif style == HAND_RIGHT_BOTH then
                SetVariable("IsTorchGuard", FALSE)
                if env(ESD_ENV_DS3GetStayAnimCategory) == 15 then
                    guardindex = env(ESD_ENV_GetGuardMotionCategory, HAND_RIGHT)
                end
            end
            SetVariable("IndexGuard", guardindex)
            act(141, DAMAGE_FLAG_GUARD_BREAK)
            local isguardgentrans = FALSE
            if env(ESD_ENV_DS3GetSpecialEffectID, 100520) == TRUE then
                isguardgentrans = TRUE
            end
            if isguardgentrans == TRUE then
                ExecEventAllBody("W_GuardBreak_GenTrans")
                return TRUE
            else
                ExecEventAllBody("W_GuardBreak")
                return TRUE
            end
        elseif damage_type == DAMAGE_TYPE_WALL_RIGHT then
            if style == HAND_RIGHT then
                SetVariable("GuardDamageIndex", 1)
            else
                SetVariable("GuardDamageIndex", 2)
            end
            act(141, DAMAGE_FLAG_GUARD_BREAK)
            ExecEventAllBody("W_GuardBreakWall")
            return TRUE
        elseif damage_type == DAMAGE_TYPE_WALL_LEFT then
            SetVariable("GuardDamageIndex", 0)
            act(141, DAMAGE_FLAG_GUARD_BREAK)
            ExecEventAllBody("W_GuardBreakWall")
            return TRUE
        elseif damage_type == DAMAGE_TYPE_GUARDBREAK_BLAST then
            SetVariable("DamageDirection", damage_angle)
            act(141, DAMAGE_FLAG_SMALL_BLOW)
            ExecEventAllBody("W_DamageSmallBlow")
            return TRUE
        elseif damage_type == DAMAGE_TYPE_GUARDBREAK_FLING then
            act(141, DAMAGE_FLAG_FLING)
            ExecEventAllBody("W_DamageFling")
            return TRUE
        end
    elseif damage_type == DAMAGE_TYPE_GUARD then
        if is_parry == TRUE then
            return FALSE
        end
        if env(ESD_ENV_DS3GetSpecialEffectID, 100690) == TRUE and env(ESD_ENV_GetBehaviorID, 11) == TRUE then
            ExecEventAllBody("W_DrawStanceRightHeavyLoopGuard")
            return TRUE
        end
        if env(ESD_ENV_DS3GetSpecialEffectID, 100350) == TRUE then
            return FALSE
        end
        if env(ESD_ENV_DS3GetSpecialEffectID, 100700) == TRUE then
            return FALSE
        end
        if env(ESD_ENV_DS3GetSpecialEffectID, 100510) == TRUE then
            return FALSE
        end
        local guardindex = GUARD_STYLE_DEFAULT
        if style == HAND_RIGHT then
            guardindex = env(ESD_ENV_GetGuardMotionCategory, HAND_LEFT)
            if env(ESD_ENV_GetEquipWeaponCategory, HAND_LEFT) == WEAPON_CATEGORY_TORCH or env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT) == 240 then
                SetVariable("IsTorchGuard", TRUE)
            else
                SetVariable("IsTorchGuard", FALSE)
            end
        elseif style == HAND_LEFT_BOTH then
            SetVariable("IsTorchGuard", FALSE)
            if env(ESD_ENV_DS3GetStayAnimCategory) == 15 then
                guardindex = env(ESD_ENV_GetGuardMotionCategory, HAND_LEFT)
            end
        elseif style == HAND_RIGHT_BOTH then
            SetVariable("IsTorchGuard", FALSE)
            if env(ESD_ENV_DS3GetStayAnimCategory) == 15 then
                guardindex = env(ESD_ENV_GetGuardMotionCategory, HAND_RIGHT)
            end
        end
        SetVariable("IndexGuard", guardindex)
        local guard_damage_level = env(ESD_ENV_GetGuardLevelAction)
        if guard_damage_level > 0 then
            if env(ESD_ENV_DS3GetSpecialEffectID, 100420) == TRUE then
                ExecAddDamage(damage_angle, attack_dir, nil, TRUE, TRUE)
                return FALSE
            end
            local isguardgentrans = FALSE
            local f5361_local0 = env(ESD_ENV_DS3GetSpecialEffectID, 100520)
            local f5361_local1 = TRUE
            if f5361_local0 == f5361_local1 then
                isguardgentrans = TRUE
            end
            local guarddamagesmall = "W_GuardDamageSmall"
            local guarddamagemiddle = "W_GuardDamageMiddle"
            local guarddamagelarge = "W_GuardDamageLarge"
            if isguardgentrans == TRUE then
                guarddamagesmall = "W_GuardDamageSmall_GenTrans"
                guarddamagemiddle = "W_GuardDamageMiddle_GenTrans"
                guarddamagelarge = "W_GuardDamageLarge_GenTrans"
            end
            if guard_damage_level == 1 then
                act(141, DAMAGE_FLAG_GUARD_SMALL)
                ExecEventAllBody(guarddamagesmall)
            elseif guard_damage_level == 3 then
                act(141, DAMAGE_FLAG_GUARD_LARGE)
                ExecEventAllBody(guarddamagemiddle)
            elseif guard_damage_level == 4 then
                act(141, DAMAGE_FLAG_GUARD_EXLARGE)
                ExecEventAllBody(guarddamagelarge)
            else
                act(141, DAMAGE_FLAG_GUARD_LARGE)
                ExecEventAllBody(guarddamagemiddle)
            end
            return TRUE
        else
            ExecAddDamage(damage_angle, attack_dir, damage_level, TRUE, is_damaged)
            return FALSE
        end
    end
    if env(ESD_ENV_GetBehaviorID, 5) == TRUE then
        Replanning()
        local blend_type, lower_state = GetHalfBlendInfo()
        act(141, DAMAGE_FLAG_SMALL)
        ExecEventHalfBlend(Event_Event61000, blend_type)
        return TRUE
    elseif env(ESD_ENV_GetBehaviorID, 10) == TRUE then
        Replanning()
        ResetDamageCount()
        act(141, DAMAGE_FLAG_SMALL)
        ExecEvent("W_SpecialDamageUpper")
        return TRUE
    end
    if env(ESD_ENV_DS3GetKnockbackDistance) < 0 then
        if damage_angle == DAMAGE_DIR_LEFT then
            damage_angle = DAMAGE_DIR_RIGHT
        elseif damage_angle == DAMAGE_DIR_RIGHT then
            damage_angle = DAMAGE_DIR_LEFT
        elseif damage_angle == DAMAGE_DIR_FRONT then
            damage_angle = DAMAGE_DIR_BACK
        elseif damage_angle == DAMAGE_DIR_BACK then
            damage_angle = DAMAGE_DIR_FRONT
        end
    end
    if env(ESD_ENV_GetIsWeakPoint) == TRUE then
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(141, DAMAGE_FLAG_WEAK)
        ExecEventAllBody("W_DamageWeak")
        Replanning()
        return TRUE
    elseif damage_level == DAMAGE_LEVEL_NONE then
        ExecAddDamage(damage_angle, attack_dir, damage_level, FALSE, is_damaged)
        return FALSE
    elseif damage_level == DAMAGE_LEVEL_SMALL then
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        ExecAddDamage(damage_angle, attack_dir, damage_level, FALSE, is_damaged)
        act(141, DAMAGE_FLAG_SMALL)
        ExecEventAllBody("W_DamageSmall")
        Replanning()
        SetVariable("DamageDefaultState", 0)
        return TRUE
    elseif damage_level == DAMAGE_LEVEL_MIDDLE then
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        ExecAddDamage(damage_angle, attack_dir, damage_level, FALSE, is_damaged)
        act(141, DAMAGE_FLAG_MEDIUM)
        ExecEventAllBody("W_DamageMiddle")
        Replanning()
        SetVariable("DamageDefaultState", 1)
        return TRUE
    elseif damage_level == DAMAGE_LEVEL_LARGE then
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        ExecAddDamage(damage_angle, attack_dir, damage_level, FALSE, is_damaged)
        act(141, DAMAGE_FLAG_LARGE)
        Replanning()
        if env(ESD_ENV_GetBehaviorID, 2) == TRUE then
            SetVariable("DamageDefaultState", 3)
            ExecEventAllBody("W_DamageLarge2")
            return TRUE
        else
            SetVariable("DamageDefaultState", 2)
            ExecEventAllBody("W_DamageLarge")
            return TRUE
        end
    elseif damage_level == DAMAGE_LEVEL_EXLARGE then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(141, DAMAGE_FLAG_LARGE_BLOW)
        ExecEventAllBody("W_DamageExLarge")
        Replanning()
        return TRUE
    elseif damage_level == DAMAGE_LEVEL_EX_BLAST then
        SetVariable("DamageDirection", damage_angle)
        act(141, DAMAGE_FLAG_LARGE_BLOW)
        ExecEventAllBody("W_DamageExBlast")
        Replanning()
        return TRUE
    elseif damage_level == DAMAGE_LEVEL_PUSH then
        CalcDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(141, DAMAGE_FLAG_PUSH)
        ExecEventAllBody("W_DamagePush")
        Replanning()
        return TRUE
    elseif damage_level == DAMAGE_LEVEL_SMALL_BLOW then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(141, DAMAGE_FLAG_SMALL_BLOW)
        ExecEventAllBody("W_DamageSmallBlow")
        Replanning()
        return TRUE
    elseif damage_level == DAMAGE_LEVEL_UPPER then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(141, DAMAGE_FLAG_LARGE_BLOW)
        ExecEventAllBody("W_DamageUpper")
        Replanning()
        return TRUE
    elseif damage_level == DAMAGE_LEVEL_MINIMUM then
        ExecAddDamage(damage_angle, attack_dir, damage_level, FALSE, is_damaged)
        return FALSE
    elseif damage_level == DAMAGE_LEVEL_FLING then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(141, DAMAGE_FLAG_FLING)
        ExecEventAllBody("W_DamageFling")
        Replanning()
        return TRUE
    elseif damage_level == DAMAGE_LEVEL_BREATH then
        ResetDamageCount()
        SetVariable("DamageDirection", damage_angle)
        act(141, DAMAGE_FLAG_BREATH)
        ExecEventAllBody("W_DamageBreath")
        Replanning()
        return TRUE
    end
    return FALSE
    
end

function ExecGuardOnCancelTiming(guardcondition, blend_type)
    if env(ESD_ENV_IsGuardFromAtkCancel) == FALSE then
        return FALSE
    end
    if guardcondition == TO_GUARDON then
        if ExecGuard(Event_GuardOn, blend_type) == TRUE then
            return TRUE
        end
    elseif ExecGuard(Event_GuardStart, blend_type) == TRUE then
        return TRUE
    end
    return FALSE
    
end

function LadderIdleCommonFunction(hand)
    act(147)
    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if ExecLadderDamageIdle(hand) == TRUE then
        return TRUE
    end
    if ExecLadderAttack(hand) == TRUE then
        return TRUE
    end
    if ExecLadderItem(hand) == TRUE then
        return TRUE
    end
    if ExecLadderMove(hand) == TRUE then
        return TRUE
    end
    return FALSE
    
end

function LadderMoveCommonFunction(hand, is_no_damage)
    act(147)
    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if is_no_damage == FALSE and TRUE == ExecLadderDamageMove() then

    else

    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if IsLadderDamage(hand) == TRUE then
            return TRUE
        end
        if ExecLadderAttack(hand) == TRUE then
            return TRUE
        end
        if ExecLadderItem(hand) == TRUE then
            return TRUE
        end
        if ExecLadderMove(hand) == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderIdleLeft")
        else
            ExecEvent("W_LadderIdleRight")
        end
        return TRUE
    end
    return FALSE
    
end

function LadderAttackCommonFunction(hand)
    act(147)
    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if ExecLadderDamageIdle(hand) == TRUE then
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if ExecLadderAttack(hand) == TRUE then
            return TRUE
        end
        if ExecLadderItem(hand) == TRUE then
            return TRUE
        end
        if ExecLadderMove(hand) == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderIdleLeft")
        else
            ExecEvent("W_LadderIdleRight")
        end
        return TRUE
    end
    return FALSE
    
end

function LadderDamageCommonFunction(hand)
    act(147)
    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if ExecLadderDamageIdle(hand) == TRUE then
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if ExecLadderAttack(hand) == TRUE then
            return TRUE
        end
        if ExecLadderItem(hand) == TRUE then
            return TRUE
        end
        if ExecLadderMove(hand) == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_RIGHT then
            ExecEvent("W_LadderIdleRight")
        else
            ExecEvent("W_LadderIdleLeft")
        end
        return TRUE
    end
    return FALSE
    
end

function LadderEndCommonFunction()
    act(147)
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        LadderSetActionState(LADDER_ACTION_INVALID)
        return TRUE
    end
    return FALSE
    
end

function LadderItemCommonFunction(hand, tonext)
    act("アイテムアニメ中か設定")
    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if ExecLadderDamageIdle(hand) == TRUE then
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if ExecLadderItem(hand) == TRUE then
            return TRUE
        end
        if tonext == FALSE then
            if ExecLadderAttack(hand) == TRUE then
                return TRUE
            end
            if ExecLadderMove(hand) == TRUE then
                return TRUE
            end
            if hand == HAND_STATE_RIGHT then
                ExecEvent("W_LadderIdleRight")
            else
                ExecEvent("W_LadderIdleLeft")
            end
            return TRUE
        end
        return FALSE
    end
    return FALSE
    
end

function ExecLadderDeath()
    local hp = env(ESD_ENV_GetHP)
    if hp <= 0 then
        ExecEvent("W_LadderDeathStart")
        return TRUE
    end
    return FALSE
    
end

function ExecLadderDamageIdle(hand)
    if env(ESD_ENV_HasReceivedAnyDamage) == FALSE then
        return FALSE
    end
    if env(ESD_ENV_GetStamina) <= 80 then
        AddStamina(-40)
        if ExecLadderFall() == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDamageLargeLeft")
        else
            ExecEvent("W_LadderDamageLargeRight")
        end
    else
        AddStamina(-30)
        if ExecLadderFall() == TRUE then
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDamageSmallLeft")
        else
            ExecEvent("W_LadderDamageSmallRight")
        end
    end
    return TRUE
    
end

function ExecLadderDamageMove()
    if env(ESD_ENV_HasReceivedAnyDamage) == FALSE then
        return FALSE
    end
    if env(ESD_ENV_GetStamina) <= 80 then
        Flag_LadderDamage = LADDER_DAMAGE_LARGE
    else
        Flag_LadderDamage = LADDER_DAMAGE_SMALL
    end
    return TRUE
    
end

function ExecLadderFall()
    if env(ESD_ENV_GetStamina) > 0 then
        return FALSE
    end
    ExecEvent("W_LadderFallStart")
    return TRUE
    
end

function ExecLadderMove(hand)
    local sp_action = env(ESD_ENV_DS3ActionDuration, ACTION_ARM_SP_MOVE)
    if sp_action == 0 then
        if Flag_LadderJump == LADDER_JUMP_WHEN_RELEASE and env(ESD_ENV_DS3ActionRequest, ACTION_ARM_BACKSTEP) == TRUE and env(ESD_ENV_IsOnLastRungOfLadder) == FALSE then
            LadderSendCommand(LADDER_EVENT_COMMAND_EXIT)
            LadderSetActionState(LADDER_ACTION_INVALID)
            ExecEvent("W_LadderDrop")
            return TRUE
        end
        Flag_LadderJump = LADDER_JUMP_SP_RELEASED
    elseif sp_action < 150 then
        if Flag_LadderJump == LADDER_JUMP_SP_RELEASED then
            Flag_LadderJump = LADDER_JUMP_WHEN_RELEASE
        end
    else
        Flag_LadderJump = LADDER_JUMP_INVALID
    end
    local event_command = GetLadderEventCommand(FALSE)
    if event_command <= 0 then
        return FALSE
    end
    if event_command == LADDER_EVENT_COMMAND_UP then
        if env(ESD_ENV_IsCOMPlayer) == TRUE and env(ESD_ENV_DoesLadderHaveCharacters, LADDER_UP_CHECK_DIST, 1, 1) == TRUE then
            if hand == HAND_STATE_RIGHT then
                ExecEvent("W_LadderAttackUpRight")
            else
                ExecEvent("W_LadderAttackUpLeft")
            end
            return TRUE
        end
        if env(ESD_ENV_IsSomeoneOnLadder, LADDER_UP_CHECK_DIST, 0) == TRUE then
            return FALSE
        end
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_SP_MOVE) > 0 then
            SetVariable("IsFastUp", TRUE)
        else
            SetVariable("IsFastUp", FALSE)
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderUpLeft")
        else
            ExecEvent("W_LadderUpRight")
        end
        return TRUE
    elseif event_command == LADDER_EVENT_COMMAND_DOWN then
        if env(ESD_ENV_IsCOMPlayer) == TRUE and env(ESD_ENV_DoesLadderHaveCharacters, LADDER_DOWN_CHECK_DIST, 0, 1) == TRUE then
            if hand == HAND_STATE_RIGHT then
                ExecEvent("W_LadderAttackDownRight")
            else
                ExecEvent("W_LadderAttackDownLeft")
            end
            return TRUE
        end
        if env(ESD_ENV_IsSomeoneUnderLadder, LADDER_DOWN_CHECK_DIST, 0) == TRUE then
            return FALSE
        end
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_SP_MOVE) > 0 and env(ESD_ENV_IsCOMPlayer) == FALSE then
            ExecEvent("W_LadderCoastStart")
            return TRUE
        end
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderDownLeft")
        else
            ExecEvent("W_LadderDownRight")
        end
        return TRUE
    elseif event_command == LADDER_EVENT_COMMAND_END_TOP then
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderEndTopLeft")
        else
            ExecEvent("W_LadderEndTopRight")
        end
        return TRUE
    elseif event_command == LADDER_EVENT_COMMAND_END_BOTTOM then
        if hand == HAND_STATE_LEFT then
            ExecEvent("W_LadderEndBottomLeft")
        else
            ExecEvent("W_LadderEndBottomRight")
        end
        return TRUE
    end
    return FALSE
    
end

function LadderStart()
    local event_command = GetLadderEventCommand(TRUE)
    if event_command == LADDER_ACTION_START_BOTTOM then
        ExecEvent("W_LadderAttachBottom")
        return TRUE
    elseif event_command == LADDER_ACTION_START_TOP then
        ExecEvent("W_LadderAttachTop")
        return TRUE
    end
    return FALSE
    
end

function LadderSetActionState(state)
    act(133, state)
    
end

function LadderSendCommand(event_call)
    act(108, event_call)
    
end

function ExecLadderAttack(hand)
    if env(ESD_ENV_GetStamina) <= 0 then
        return FALSE
    end
    if env(ESD_ENV_DS3ActionRequest, ACTION_ARM_R1) == TRUE then
        if hand == HAND_STATE_RIGHT then
            ExecEvent("W_LadderAttackUpRight")
        else
            ExecEvent("W_LadderAttackUpLeft")
        end
        return TRUE
    elseif env(ESD_ENV_DS3ActionRequest, ACTION_ARM_R2) == TRUE then
        if hand == HAND_STATE_RIGHT then
            ExecEvent("W_LadderAttackDownRight")
        else
            ExecEvent("W_LadderAttackDownLeft")
        end
        return TRUE
    end
    return FALSE
    
end

function LadderCoastCommonFunction(hand, is_start)
    act(147)
    if ExecLadderDeath() == TRUE then
        return TRUE
    end
    if TRUE == ExecLadderDamageMove() then

    else

    end
    if is_start == FALSE then
        if TRUE == env(ESD_ENV_IsOnLastRungOfLadder) then
            ExecEvent("W_LadderCoastLanding")
            return TRUE
        end
        local event_command = GetLadderEventCommand(FALSE)
        if not (env(ESD_ENV_DS3ActionDuration, ACTION_ARM_SP_MOVE) > 0 and env(ESD_ENV_DS3MovementRequestDuration) > 0 and (event_command <= 0 or event_command == LADDER_EVENT_COMMAND_DOWN)) or TRUE == env(ESD_ENV_IsSomeoneUnderLadder, LADDER_DOWN_CHECK_DIST, 0) then
            act("はしご滑り降り解除")
            if env(ESD_ENV_DS3GetNumberOfRungsBelowOnLadder) % 2 == 0 then
                ExecEvent("W_LadderCoastStopRight")
            else
                ExecEvent("W_LadderCoastStopLeft")
            end
            return TRUE
        end
    elseif TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if IsLadderDamage(hand) == TRUE then
            return TRUE
        end
        ExecEvent("W_LadderCoastLeft")
        return TRUE
    end
    return FALSE
    
end

function ExecSlide()
    if env(ESD_ENV_DS3GetSpecialEffectID, 100400) == TRUE then
        return 
    elseif env(ESD_ENV_DescendingToFloor) == TRUE then
        ExecEvent("W_SlideStart")
        return 
    end
    
end

function IdleCommonFunction()
    act("ロックオン時システム旋回不可角度", 90, 90)
    act(9100)
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
            act("精密射撃可能か")
        end
    elseif style == HAND_RIGHT_BOTH and GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
        act("精密射撃可能か")
    end
    if TRUE == ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) then
        return TRUE
    end
    if TRUE == LadderStart() then
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        return TRUE
    end
    if TRUE == ExecGuard(Event_GuardStart, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStance(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == MoveStart(ALLBODY, Event_Move, FALSE) then
        return TRUE
    end
    if TRUE == ExecQuickTurn(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsCOMPlayer) then
        local event_command = env(ESD_ENV_GetCommandIDFromEvent, 1)
        if event_command == 1903 then
            ExecEvent("W_Event90801")
            return TRUE
        elseif event_command == 2100 then
            ExecEvent("W_Event90851")
            return TRUE
        elseif event_command == 7300 then
            ExecEvent("W_Event91190")
            return TRUE
        end
    end
    return FALSE
    
end

function AttackCommonFunction(r1, r2, l1, l2, b1, b2, guardcondition, use_atk_queue)
    if env(ESD_ENV_DS3GetSpecialEffectID, 100380) == FALSE then
        SetThrowAtkInvalid()
    end
    SetAIActionState()
    UpdateAtkAutoAim()
    local bool = FALSE
    if guardcondition == TO_GUARDON then
        bool = TRUE
    end
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, bool) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(guardcondition, ALLBODY) == TRUE then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_ATTACK, ALLBODY) then
        if use_atk_queue == TRUE then
            SetAttackQueue(r1, r2, l1, l2, b1, b2)
        end
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_ATTACK, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if ExecAttack(r1, r2, l1, l2, b1, b2, guardcondition, ALLBODY, FALSE, FALSE) == TRUE then
        if use_atk_queue == TRUE then
            SetAttackQueue(r1, r2, l1, l2, b1, b2)
        end
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return 
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecQuickTurnOnCancelTiming() then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function BackStabCommonFunction()
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_ATTACK, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_ATTACK, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return 
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecQuickTurnOnCancelTiming() then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function FallCommonFunction(is_enable_falling_death, is_jump, fall_style)
    local height = env(ESD_ENV_GetFallHeight) / 100
    local damage_type = env(ESD_ENV_GetReceivedDamageType)
    if damage_type == DAMAGE_TYPE_DEATH_FALLING then
        if fall_style == FALL_FACEUP then
            ExecEventAllBody("W_FallDeathFaceUp")
        elseif fall_style == FALL_FACEDOWN then
            ExecEventAllBody("W_FallDeathFaceDown")
        else
            ExecEventAllBody("W_FallDeath")
        end
        return TRUE
    end
    if height >= 60 and is_enable_falling_death == TRUE then
        if env(ESD_ENV_GetStateChangeType, 266) == TRUE then

        else
            if fall_style == FALL_FACEUP then
                ExecEventAllBody("W_FallDeathFaceUp")
            elseif fall_style == FALL_FACEDOWN then
                ExecEventAllBody("W_FallDeathFaceDown")
            else
                ExecEventAllBody("W_FallDeath")
            end
            return TRUE
        end
    end
    act(147)
    if env(ESD_ENV_DS3HasThrowRequest) == TRUE then
        return TRUE
    end
    if env(ESD_ENV_IsLanding) == TRUE then
        if env(ESD_ENV_GetStateChangeType, 266) == TRUE and fall_style ~= FALL_ATTACK then
            if height > 1.2999999523162842 then
                if height > 8 then
                    SetVariable("LandIndex", LAND_HEAVY)
                elseif height > 4 then
                    SetVariable("LandIndex", LAND_MIDDLE)
                elseif is_jump == TRUE and height > 0 then
                    SetVariable("LandIndex", LAND_JUMP)
                else
                    SetVariable("LandIndex", LAND_DEFAULT)
                end
                Replanning()
                ExecEventAllBody("W_Land")
                return TRUE
            else
                if height > 0.30000001192092896 then
                    ExecEventAllBody("W_LandLow")
                else
                    ExecEventAllBody("W_Idle")
                end
                return TRUE
            end
        end
        if fall_style == FALL_DEFAULT then
            if IsLandDead(height) == TRUE then
                if height > 8 then
                    SetVariable("IndexDeath", DEATH_TYPE_LAND)
                else
                    SetVariable("IndexDeath", DEATH_TYPE_LAND_LOW)
                end
                ExecEventAllBody("W_DeathStart")
                return TRUE
            else
                if height > 1.2999999523162842 then
                    if height > 8 then
                        SetVariable("LandIndex", LAND_HEAVY)
                    elseif height > 4 then
                        SetVariable("LandIndex", LAND_MIDDLE)
                    elseif is_jump == TRUE and height > 0 then
                        SetVariable("LandIndex", LAND_JUMP)
                    else
                        SetVariable("LandIndex", LAND_DEFAULT)
                    end
                    Replanning()
                    ExecEventAllBody("W_Land")
                else
                    act("AIへのリプランニング要求")
                    if height > 0.30000001192092896 then
                        ExecEventAllBody("W_LandLow")
                    else
                        ExecEventAllBody("W_Idle")
                    end
                end
                return TRUE
            end
        elseif fall_style == FALL_FACEUP then
            if IsLandDead(height) == TRUE then
                SetVariable("IndexDeath", DEATH_TYPE_LAND_FACEUP)
                ExecEventAllBody("W_DeathStart")
            else
                Replanning()
                ExecEventAllBody("W_LandFaceUp")
            end
            return TRUE
        elseif fall_style == FALL_FACEDOWN then
            if IsLandDead(height) == TRUE then
                SetVariable("IndexDeath", DEATH_TYPE_LAND_FACEDOWN)
                ExecEventAllBody("W_DeathStart")
            else
                Replanning()
                ExecEventAllBody("W_LandFaceDown")
            end
            return TRUE
        elseif fall_style == FALL_LADDER then
            if IsLandDead(height) == TRUE then
                ExecEventAllBody("W_LadderDeathLand")
            else
                Replanning()
                ExecEventAllBody("W_LadderFallLanding")
            end
            return TRUE
        else
            if IsLandDead(height) == TRUE then
                SetVariable("IndexDeath", DEATH_TYPE_LAND)
                ExecEventAllBody("W_DeathStart")
            else
                ExecEventAllBody("W_LandFallAttack")
            end
            return TRUE
        end
    end
    if fall_style == FALL_DEFAULT and height >= 2 and (env(ESD_ENV_DS3ActionRequest, ACTION_ARM_R1) == TRUE or env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) > 0) then
        local style = c_Style
        local hand = HAND_RIGHT
        if style == HAND_LEFT_BOTH then
            hand = HAND_LEFT
        end
        local check_weapon = GetEquipType(hand, WEAPON_CATEGORY_STAFF, WEAPON_CATEGORY_FIST_CUT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW, WEAPON_CATEGORY_SMALL_SHIELD, WEAPON_CATEGORY_LARGE_SHIELD, WEAPON_CATEGORY_TORCH)
        if check_weapon == TRUE and env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand) ~= 234 then
            return FALSE
        end
        SetAttackHand(hand)
        ExecEventAllBody("W_FallAttackStart")
        return TRUE
    end
    return FALSE
    
end

function SlideCommonFunction(can_endslide)
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if can_endslide == TRUE and FALSE == env(ESD_ENV_DescendingToFloor) then
        ExecEvent("W_SlideEnd")
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_ROLLING, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_ROLLING, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_MoveLong, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function ThrowCommonFunction(estep)
    act(2005, CEREMONY_STATE_RELEASE)
    if env(ESD_ENV_IsThrowing) == TRUE then
        if env(ESD_ENV_GetReceivedDamageType) == DAMAGE_TYPE_DEATH_FALLING then
            if env(ESD_ENV_DS3GetSpecialEffectID, 4502) == TRUE then
                ExecEventAllBody("W_FallDeathFaceDown")
            elseif env(ESD_ENV_DS3GetSpecialEffectID, 4501) == TRUE then
                ExecEventAllBody("W_FallDeathFaceUp")
            else
                ExecEventAllBody("W_FallDeath")
            end
            return TRUE
        end
    else
        if TRUE == ExecDeath() then
            return TRUE
        end
        if env(ESD_ENV_DS3CheckForEventAnimPlaybackRequest) == TRUE then
            return TRUE
        end
        if TRUE == ExecDamage(FALSE, FALSE) then
            return TRUE
        end
    end
    if TRUE == ExecFallStart(FALL_TYPE_DEFAULT) then
        act(136, 0)
        return TRUE
    end
    if ExecEvasion(FALSE, estep, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecGuardOnCancelTiming(FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == MoveStartonCancelTiming(Event_MoveShort, FALSE) then
        return TRUE
    end
    if TRUE == ExecQuickTurnOnCancelTiming() then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function GestureCommonFunction(blend_type)
    act(147)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function GestureLoopCommonFunction(blend_type, lower_state, is_start)
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    local canmove = FALSE
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        if TRUE == env(ESD_ENV_DS3HasActionRequest) then
            SetVariable("IndexGestureLoopEnd", GetVariable("IndexGestureLoop"))
            ExecEventHalfBlend(Event_GestureEnd, lower_state)
            return TRUE
        end
        if canmove == FALSE and 0 < GetVariable("MoveSpeedLevel") then
            SetVariable("IndexGestureLoopEnd", GetVariable("IndexGestureLoop"))
            ExecEventHalfBlend(Event_GestureEnd, lower_state)
            return TRUE
        end
    end
    return FALSE
    
end

function MagicCommonFunction(blend_type, quick_type)
    local magic_type = env(ESD_ENV_GetMagicAnimType)
    if magic_type ~= MAGIC_REQUEST_FLAME_GRAB then
        SetThrowAtkInvalid()
    end
    SetAIActionState()
    UpdateAtkAutoAim()
    act(118, TRUE)
    if TRUE == ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) then
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(quick_type, blend_type) == TRUE then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function ArrowCommonFunction(blend_type, is_allbody_turn, is_enable_stance)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if is_enable_stance == TRUE and ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if is_allbody_turn == TRUE then
        if TRUE == ExecQuickTurnOnCancelTiming() then
            return TRUE
        end
    elseif blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return FALSE
    end
    return FALSE
    
end

function CrossbowCommonFunction(blend_type)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    return FALSE
    
end

function EvasionCommonFunction(fall_type, r1, r2, l1, l2, b1, b2)
    SetAIActionState()
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
            act("精密射撃可能か")
        end
    elseif style == HAND_RIGHT_BOTH and GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
        act("精密射撃可能か")
    end
    if ExecPassiveAction(FALSE, fall_type, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        return TRUE
    end
    if TRUE == ExecGuardOnCancelTiming(FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_ROLLING, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_ROLLING, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if ExecAttack(r1, r2, l1, l2, b1, b2, FALSE, ALLBODY, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == MoveStartonCancelTiming(Event_MoveLong, FALSE) then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function DamageCommonFunction(guardcondition, estep, fall_type)
    act(147)
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
            act("精密射撃可能か")
        end
    elseif style == HAND_RIGHT_BOTH and GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
        act("精密射撃可能か")
    end
    if ExecPassiveAction(FALSE, fall_type, FALSE) == TRUE then
        return TRUE
    end
    local is_usechainrecover = GetVariable("UseChainRecover")
    if ExecEvasion(TRUE, estep, is_usechainrecover) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(guardcondition, ALLBODY) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        ResetDamageCount()
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        ResetDamageCount()
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", guardcondition, ALLBODY, FALSE, FALSE) == TRUE then
        ResetDamageCount()
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        ResetDamageCount()
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        ResetDamageCount()
        return TRUE
    end
    if TRUE == ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) then
        ResetDamageCount()
        return TRUE
    end
    if TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
        ResetDamageCount()
        return TRUE
    end
    if TRUE == ExecQuickTurnOnCancelTiming() then
        return TRUE
    end
    if TRUE == ExecGesture() then
        ResetDamageCount()
        return TRUE
    end
    if TRUE == env(ESD_ENV_DS3IsMoveCancelPossible) then
        ResetDamageCount()
    end
    return FALSE
    
end

function QuickTurnCommonFunction()
    local blend_type = UPPER
    if env(ESD_ENV_DS3IsMoveCancelPossible) == TRUE then
        blend_type = ALLBODY
    end
    if TRUE == ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) then
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, UPPER) == TRUE then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if ExecSwordArtsStanceOnCancelTiming(UPPER) == TRUE then
        return TRUE
    end
    if TRUE == ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) then
        return TRUE
    end
    if ExecWeaponChange(UPPER) == TRUE then
        return TRUE
    end
    if TRUE == ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
        return TRUE
    end
    return FALSE
    
end

function LandCommonFunction()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsSlope) then
        return FALSE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecQuickTurnOnCancelTiming() then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function ItemCommonFunction(blend_type)
    if g_ItemFirstFrame == 1 then
        g_ItemFirstFrame = 0
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100560) == TRUE then
        act("道具ID切り替え無効")
    end
    if env(ESD_ENV_GetStateChangeType, 15) == FALSE then
        act("アイテムアニメ中か設定")
    end
    SetAIActionState()
    if TRUE == ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) then
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_ATTACK, ALLBODY) then
        return TRUE
    end
    if ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, blend_type, quick_type)
    if g_ItemFirstFrame == 1 then
        g_ItemFirstFrame = 0
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100560) == TRUE then
        act("道具ID切り替え無効")
    end
    act("アイテムアニメ中か設定")
    SetAIActionState()
    if TRUE == ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) then
        ClearAttackQueue()
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        ClearAttackQueue()
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecItem(quick_type, blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_ATTACK, ALLBODY) then
        ClearAttackQueue()
        return TRUE
    end
    if ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecAttack(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, FALSE, blend_type, FALSE, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
        ClearAttackQueue()
        return TRUE
    end
    return FALSE
    
end

function StopCommonFunction(is_dash_stop)
    act(9100)
    if is_dash_stop == TRUE then
        act("ロックオン時システム旋回不可角度", 180, 180)
    else
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        if TRUE == GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) then
            act("精密射撃可能か")
        end
    elseif style == HAND_RIGHT_BOTH and TRUE == GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) then
        act("精密射撃可能か")
    end
    if TRUE == ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) then
        return TRUE
    end
    if TRUE == LadderStart() then
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        return TRUE
    end
    if TRUE == ExecGuard(Event_GuardStart, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStance(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100170) then
        act("ロックオン中角度固定解除")
        if TRUE == ExecDashTurn() then
            return TRUE
        end
    end
    if TRUE == MoveStart(ALLBODY, Event_Move, FALSE) then
        return TRUE
    end
    if is_dash_stop == FALSE and TRUE == ExecQuickTurn(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function MoveCommonFunction(blend_type)
    act(9100)
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
            act("精密射撃可能か")
        end
    elseif style == HAND_RIGHT_BOTH and GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
        act("精密射撃可能か")
    end
    if TRUE == ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) then
        return TRUE
    end
    if TRUE == LadderStart() then
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        return TRUE
    end
    if ExecGuard(Event_GuardStart, blend_type) == TRUE then
        return TRUE
    end
    local speed = GetVariable("MoveSpeedLevelReal")
    local quick_type = QUICKTYPE_NORMAL
    if speed > 1.600000023841858 then
        quick_type = QUICKTYPE_DASH
    end
    if ExecItem(quick_type, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(quick_type, blend_type) == TRUE then
        return TRUE
    end
    if ExecSwordArtsStance(blend_type) == TRUE then
        return TRUE
    end
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    if speed > 1.600000023841858 then
        r1 = "W_AttackRightLightDash"
        b1 = "W_AttackBothDash"
        if TRUE == IsArtsSpAtk() then
            r1 = "W_AttackRightLightDashSpecial"
            b1 = "W_AttackBothDashSpecial"
            if TRUE == IsEnableJumpAtk() then
                r2 = "W_AttackRightHeavyKickSpecial"
                b2 = "W_AttackBothHeavyKickSpecial"
            end
        elseif TRUE == IsEnableJumpAtk() then
            r2 = "W_AttackRightHeavyKick"
            b2 = "W_AttackBothHeavyKick"
        end
    end
    if ExecAttack(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, blend_type, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if TRUE == ExecStop() then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function GuardCommonFunction(is_guard_end, blend_type)
    act(9100)
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == LadderStart() then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if is_guard_end == TRUE and ExecGuard(Event_GuardStart, blend_type) == TRUE then
        return TRUE
    end
    if GetVariable("MoveSpeedIndex") == 2 then
        if ExecItem(QUICKTYPE_DASH, blend_type) == TRUE then
            return TRUE
        end
    elseif ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if GetVariable("MoveSpeedIndex") == 2 then
        if ExecMagic(QUICKTYPE_DASH, blend_type) == TRUE then
            return TRUE
        end
    elseif ExecMagic(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if is_guard_end == TRUE then
        if ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
            return TRUE
        end
    elseif TRUE == env(ESD_ENV_DS3ActionRequest, ACTION_ARM_L2) and ExecSwordArtsStance(blend_type) == TRUE then
        return TRUE
    end
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local guard_attack = FALSE
    if GetVariable("MoveSpeedLevelReal") > 1.100000023841858 then
        r1 = "W_AttackRightLightDash"
        b1 = "W_AttackBothDash"
        if TRUE == IsEnableJumpAtk() then
            if TRUE == IsArtsSpAtk() then
                r2 = "W_AttackRightHeavyKickSpecial"
                b2 = "W_AttackBothHeavyKickSpecial"
            else
                r2 = "W_AttackRightHeavyKick"
                b2 = "W_AttackBothHeavyKick"
            end
        end
    elseif is_guard_end == FALSE then
        guard_attack = TRUE
    end
    if ExecAttack(r1, r2, nil, "W_AttackLeftHeavy1", b1, b2, guard_attack, blend_type, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if is_guard_end == FALSE and (TRUE == env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L1) or env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L1) <= 0 or env(ESD_ENV_GetStamina) <= 0) then
        ExecEventHalfBlendNoReset(Event_GuardEnd, blend_type)
        return TRUE
    end
    return FALSE
    
end

function SwordArtsCommonFunction(r1, r2, l1, l2, b1, b2, guardcondition, artsr1, artsr2, gen_trans)
    if env(ESD_ENV_DS3GetSpecialEffectID, 37) == FALSE and env(ESD_ENV_DS3GetSpecialEffectID, 100380) == FALSE then
        SetThrowAtkInvalid()
    end
    UpdateAtkAutoAim()
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_ATTACK, ALLBODY) then
        ClearAttackQueue()
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_ATTACK, ALLBODY) then
        ClearAttackQueue()
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        ClearAttackQueue()
        return TRUE
    end
    if ExecAttack(r1, r2, l1, l2, b1, b2, guardcondition, ALLBODY, artsr1, artsr2) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        ClearAttackQueue()
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        ClearAttackQueue()
        return 
    end
    if MoveStartonCancelTiming(Event_Move, gen_trans) == TRUE then
        ClearAttackQueue()
        return TRUE
    end
    if TRUE == ExecQuickTurnOnCancelTiming() then
        ClearAttackQueue()
        return TRUE
    end
    if TRUE == ExecGesture() then
        ClearAttackQueue()
        return TRUE
    end
    return FALSE
    
end

function SwordArtsParryCommonFunction()
    SetAIActionState()
    if ExecPassiveAction(TRUE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        return TRUE
    end
    if TRUE == ExecGuardOnCancelTiming(FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_ATTACK, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_ATTACK, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) then
        return 
    end
    if TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
        return TRUE
    end
    if TRUE == ExecQuickTurnOnCancelTiming() then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function SwordArtsStanceCommonFunction(r1, r2, l1, l2, b1, b2, blend_type, artsr1, artsr2, is_stance_end)
    if is_stance_end == FALSE then
        SetThrowAtkInvalid()
    end
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L1) < 440 and ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if is_stance_end == TRUE and ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack(r1, r2, l1, l2, b1, b2, FALSE, blend_type, artsr1, artsr2) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        if is_stance_end == TRUE then
            SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        end
        ClearAttackQueue()
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    return FALSE
    
end

function GatlingStanceCommonFunction(blend_type, can_fire)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if TRUE == is_enable_stance and ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    local request = GetAttackRequest(FALSE)
    if can_fire == TRUE then
        if request > 17 and request < 26 then
            if TRUE == IsExistArrow() then
                ExecEventAllBody("W_NoArrow")
                return 
            elseif env(ESD_ENV_GetStamina) > 0 then
                SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
                if c_Style == HAND_LEFT_BOTH then
                    ExecEventHalfBlend(Event_GatlingStanceRightFireStartLeft, blend_type)
                else
                    ExecEventHalfBlend(Event_GatlingStanceRightFireStart, blend_type)
                end
            end
        end
    elseif ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return FALSE
    end
    return FALSE
    
end

function SwordArtsChargeShotCommonFunction(blend_type)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    return FALSE
    
end

function SwordArtsCrossbowStepInFunction()
    SetThrowAtkInvalid()
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, blend_type) then
        return TRUE
    end
    if TRUE == ExecWeaponChange(blend_type) then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if MoveStartonCancelTiming(Event_Move, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecQuickTurnOnCancelTiming() then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function WeaponChangeCommonFunction(blend_type)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, blend_type) == TRUE then
        CultForceQuit()
        return TRUE
    end
    if ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function HandChangeCommonFunction(blend_type)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, blend_type) == TRUE then
        CultForceQuit()
        return TRUE
    end
    if ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function DamageHalfBlendCommonFunction(blend_type)
    SetAIActionState()
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, blend_type) == TRUE then
        return TRUE
    end
    if ExecItem(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecMagic(QUICKTYPE_NORMAL, blend_type) == TRUE then
        return TRUE
    end
    if ExecSwordArtsStanceOnCancelTiming(blend_type) == TRUE then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, blend_type, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if ExecWeaponChange(blend_type) == TRUE then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, blend_type) == TRUE then
        return TRUE
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function EventCommonFunction()
    act(9102)
    act(147)
    act(2005, CEREMONY_STATE_RELEASE)
    if env(ESD_ENV_DS3HasThrowRequest) == TRUE then
        return TRUE
    end
    if TRUE == ExecDeath() then
        return TRUE
    end
    if TRUE == ExecDamage(FALSE, FALSE) then
        return TRUE
    end
    if TRUE == ExecFallStart(FALL_TYPE_DEFAULT) then
        return TRUE
    end
    if TRUE == ExecEvasion(FALSE, ESTEP_NONE, FALSE) then
        return TRUE
    end
    if TRUE == ExecGuardOnCancelTiming(FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if TRUE == ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) then
        return TRUE
    end
    if TRUE == MoveStartonCancelTiming(Event_MoveShort, FALSE) then
        return TRUE
    end
    if TRUE == ExecQuickTurnOnCancelTiming() then
        return TRUE
    end
    if TRUE == ExecGesture() then
        return TRUE
    end
    return FALSE
    
end

function CultMoveStart(blend_type, event)
    act(138, FALSE)
    if GetVariable("MoveSpeedLevel") <= 0 then
        return FALSE
    end
    SetVariable("MoveSpeedLevelReal", 0)
    if blend_type == ALLBODY then
        ExecEventHalfBlend(event, ALLBODY)
        return TRUE
    elseif blend_type == UPPER then
        ExecEventHalfBlend(event, UPPER)
        return TRUE
    elseif blend_type == LOWER then
        ExecEventHalfBlend(event, LOWER)
        return TRUE
    end
    return FALSE
    
end

function CultHoldCommonFunction()
    act(138, FALSE)
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        CultForceQuit()
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        CultForceQuit()
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        CultForceQuit()
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) == TRUE then
        CultForceQuit()
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        CultForceQuit()
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        CultForceQuit()
        return TRUE
    end
    return FALSE
    
end

function CultCommonFunction(id, is_end)
    act(138, FALSE)
    act(9102)
    act(2005, CEREMONY_STATE_RELEASE)
    if ExecPassiveAction(FALSE, FALL_TYPE_DEFAULT, FALSE) == TRUE then
        return TRUE
    end
    if ExecEvasion(FALSE, ESTEP_NONE, FALSE) == TRUE then
        return TRUE
    end
    if ExecGuardOnCancelTiming(FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if TRUE == ExecItem(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecMagic(QUICKTYPE_NORMAL, ALLBODY) then
        return TRUE
    end
    if TRUE == ExecSwordArtsStanceOnCancelTiming(ALLBODY) then
        return TRUE
    end
    if ExecAttack("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, ALLBODY, FALSE, FALSE) == TRUE then
        return TRUE
    end
    if TRUE == ExecWeaponChange(ALLBODY) then
        return TRUE
    end
    if ExecHandChange(HAND_RIGHT, FALSE, ALLBODY) == TRUE then
        return TRUE
    end
    if is_end == FALSE then
        local str_int = "W_CultInterrupt"
        local str_end = "W_CultEnd"
        if TRUE == env(ESD_ENV_DS3IsCeremonyInterrupt) then
            ExecEventAllBody(str_int .. id)
            return TRUE
        end
        if TRUE == env(ESD_ENV_DS3IsCeremonyComplete) then
            ExecEventAllBody(str_end .. id)
            return TRUE
        end
    end
    return FALSE
    
end

function HalfBlendLowerCommonFunction(event, lower_state, to_idle_on_cancel, is_fire_upper_on_move)
    if lower_state == LOWER_MOVE then
        if ExecStopHalfBlend(event, to_idle_on_cancel) == TRUE then
            return TRUE
        end
    else
        local blend_type = LOWER
        if TRUE == env(ESD_ENV_DS3IsMoveCancelPossible) then
            blend_type = ALLBODY
        end
        if MoveStart(blend_type, Event_Move, FALSE) == TRUE then
            if is_fire_upper_on_move == TRUE and blend_type == LOWER then
                ExecEventHalfBlend(event, UPPER)
            end
            return TRUE
        end
        if lower_state == LOWER_END_TURN then
            ExecEventHalfBlendNoReset(event, LOWER)
            return TRUE
        end
    end
    return FALSE
    
end

function HalfBlendLowerCommonFunctionNoSync(event, lower_state, to_idle_on_cancel, is_fire_upper_on_move)
    if lower_state == LOWER_MOVE then
        if ExecStopHalfBlend(event, to_idle_on_cancel) == TRUE then
            return TRUE
        end
    else
        local blend_type = LOWER
        if TRUE == env(ESD_ENV_DS3IsMoveCancelPossible) then
            blend_type = ALLBODY
        end
        if MoveStart(blend_type, Event_MoveNoSync, FALSE) == TRUE then
            if is_fire_upper_on_move == TRUE and blend_type == LOWER then
                ExecEventHalfBlend(event, UPPER)
            end
            return TRUE
        end
        if lower_state == LOWER_END_TURN then
            ExecEventHalfBlendNoReset(event, LOWER)
            return TRUE
        end
    end
    return FALSE
    
end

function HalfBlendUpperCommonFunction(lower_state)
    if lower_state == LOWER_MOVE and env(ESD_ENV_DS3IsMoveCancelPossible) == TRUE then
        ExecEventHalfBlendNoReset(Event_Move, UPPER)
        return TRUE
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE or lower_state ~= LOWER_IDLE and env(ESD_ENV_GetEventEzStateFlag, 0) == TRUE then
        if lower_state == LOWER_TURN then
            local turn_state = GetVariable("UpperDefaultState01")
            local event = Event_QuickTurnRight180Mirror
            if turn_state == QUICKTURN_LEFT180_DEF1 then
                event = Event_QuickTurnLeft180Mirror
            end
            ExecEventHalfBlendNoReset(event)
        elseif lower_state == LOWER_MOVE then
            ExecEventHalfBlendNoReset(Event_Move, UPPER)
        else
            ExecEventNoReset("W_Idle")
        end
        return TRUE
    end
    return FALSE
    
end

function ArrowLowerCommonFunction(event, lower_state, to_idle_on_cancel, is_fire_upper_on_move)
    if lower_state == LOWER_MOVE then
        if ExecStopHalfBlend(event, to_idle_on_cancel) == TRUE then
            return TRUE
        end
    else
        if lower_state ~= LOWER_TURN then
            local style = c_Style
            local hand = HAND_RIGHT
            if style == HAND_LEFT_BOTH then
                hand = HAND_LEFT
            end
            if env(ESD_ENV_GetEquipWeaponCategory, hand) ~= WEAPON_CATEGORY_LARGE_ARROW then
                if TRUE == MoveStart(LOWER, Event_Move, FALSE) then
                    if is_fire_upper_on_move == TRUE then
                        ExecEventHalfBlend(event, UPPER)
                    end
                    return TRUE
                end
            elseif env(ESD_ENV_IsPrecisionShoot) == FALSE and TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
                return TRUE
            end
        end
        if lower_state == LOWER_END_TURN then
            ExecEventHalfBlendNoReset(event, LOWER)
            return TRUE
        end
    end
    return FALSE
    
end

function CultExecStop()
    if GetVariable("MoveSpeedLevel") <= 0 then
        act(2005, CEREMONY_STATE_IDLE)
        ExecEventAllBody("W_CultIdle")
        return TRUE
    end
    return FALSE
    
end

function CultForceQuit()
    act(2005, CEREMONY_STATE_FORCE_RELEASE)
    
end

function Idle_onActivate()
    SetVariable("MoveSpeedLevelReal", 0)
    ClearAttackQueue()
    act(9100)
    act(139)
    act(129, TRUE)
    act("自動捕捉対象クリア")
    
end

function Idle_onUpdate()
    if IdleCommonFunction() == TRUE then
        SetVariable("MenuOpenTime", 0)
        return 
    end
    if env(ESD_ENV_DS3IsEquipmentMenuOpen) == FALSE then
        SetVariable("MenuOpenTime", 0)
    else
        local time = GetVariable("MenuOpenTime")
        if time > 0.800000011920929 then
            SetVariable("MenuOpenTime", 0)
            ExecEventNoReset("W_InGameMenuIdleStart")
            return 
        end
        SetVariable("MenuOpenTime", time + GetDeltaTime())
        return 
    end
    
end

function Idle_onDeactivate()
    act(129, FALSE)
    
end

function InGameMenuIdleLoop_onUpdate()
    if IdleCommonFunction() == TRUE then
        SetVariable("MenuCloseTime", 0)
        return 
    end
    if TRUE == env(ESD_ENV_DS3IsEquipmentMenuOpen) then
        SetVariable("MenuCloseTime", 0)
    else
        local time = GetVariable("MenuCloseTime")
        if time > 2 then
            SetVariable("MenuCloseTime", 0)
            ExecEventNoReset("W_InGameMenuIdleEnd")
            return 
        end
        SetVariable("MenuCloseTime", time + GetDeltaTime())
        return 
    end
    
end

function InGameMenuIdleStart_onUpdate()
    if IdleCommonFunction() == TRUE then
        SetVariable("MenuCloseTime", 0)
        return 
    end
    if TRUE == env(ESD_ENV_DS3IsEquipmentMenuOpen) then
        SetVariable("MenuCloseTime", 0)
    else
        local time = GetVariable("MenuCloseTime")
        if time < 2 then
            SetVariable("MenuCloseTime", time + GetDeltaTime())
        end
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 3) then
        local time = GetVariable("MenuCloseTime")
        if time < 2 then
            ExecEventNoReset("W_InGameMenuIdleLoop")
        else
            SetVariable("MenuCloseTime", 0)
            ExecEventNoReset("W_InGameMenuIdleEnd")
        end
        return 
    end
    
end

function InGameMenuIdleEnd_onUpdate()
    if IdleCommonFunction() == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 3) then
        if TRUE == env(ESD_ENV_DS3IsEquipmentMenuOpen) then
            ExecEventNoReset("W_InGameMenuIdleStart")
        else
            ExecEventNoReset("W_Idle")
        end
        return 
    end
    
end

function DashStop_Upper_onActivate()
    act(9100)
    
end

function DashStop_Upper_onUpdate()
    if StopCommonFunction(TRUE) == TRUE then
        return 
    end
    
end

function RunStopFront_Upper_onActivate()
    act(9100)
    
end

function RunStopFront_Upper_onUpdate()
    if StopCommonFunction(FALSE) == TRUE then
        return 
    end
    
end

function RunStopBack_Upper_onActivate()
    act(9100)
    
end

function RunStopBack_Upper_onUpdate()
    if StopCommonFunction(FALSE) == TRUE then
        return 
    end
    
end

function RunStopLeft_Upper_onActivate()
    act(9100)
    
end

function RunStopLeft_Upper_onUpdate()
    if StopCommonFunction(FALSE) == TRUE then
        return 
    end
    
end

function RunStopRight_Upper_onActivate()
    act(9100)
    
end

function RunStopRight_Upper_onUpdate()
    if StopCommonFunction(FALSE) == TRUE then
        return 
    end
    
end

function WalkStopFront_onActivate()
    act(9100)
    
end

function WalkStopFront_Upper_onUpdate()
    if StopCommonFunction(FALSE) == TRUE then
        return 
    end
    
end

function WalkStopBack_Upper_onActivate()
    act(9100)
    
end

function WalkStopBack_Upper_onUpdate()
    if StopCommonFunction(FALSE) == TRUE then
        return 
    end
    
end

function WalkStopLeft_Upper_onActivate()
    act(9100)
    
end

function WalkStopLeft_Upper_onUpdate()
    if StopCommonFunction(FALSE) == TRUE then
        return 
    end
    
end

function WalkStopRight_Upper_onActivate()
    act(9100)
    
end

function WalkStopRight_Upper_onUpdate()
    if StopCommonFunction(FALSE) == TRUE then
        return 
    end
    
end

function Dash180_Upper_onActivate()
    act(9104)
    
end

function Dash180_Upper_onUpdate()
    act(9104)
    if QuickTurnCommonFunction() == TRUE then
        return 
    end
    
end

function Evasion_Activate()
    ActivateRightArmAdd(START_FRAME_NONE)
    
end

function Evasion_Update()
    UpdateRightArmAdd()
    
end

function Rolling_onUpdate()
    SetThrowAtkInvalid()
    if env(ESD_ENV_DS3GetSpecialEffectID, 100390) == TRUE then
        ResetDamageCount()
    end
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        if TRUE == GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) then
            act("精密射撃可能か")
        end
    elseif style == HAND_RIGHT_BOTH and TRUE == GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) then
        act("精密射撃可能か")
    end
    local rolling_angle = GetVariable("RollingAngleReal")
    local addratio = 0.4000000059604645
    local endratio = 1
    endratio = 1 + addratio * math.abs(math.sin(math.rad(2 * rolling_angle)))
    endratio = math.abs(endratio)
    act(2001, endratio)
    if TRUE == EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStep", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy2Start") then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        ExecEventAllBody("W_Idle")
        return 
    end
    SetRollingTurnCondition(FALSE)
    
end

function RollingSelftrans_onActivate()
    ResetDamageCount()
    
end

function RollingSelftrans_onUpdate()
    SetThrowAtkInvalid()
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
            act("精密射撃可能か")
        end
    elseif style == HAND_RIGHT_BOTH and GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
        act("精密射撃可能か")
    end
    local rolling_angle = GetVariable("RollingAngleRealSelftrans")
    local addratio = 0.4000000059604645
    local endratio = 1
    endratio = 1 + addratio * math.abs(math.sin(math.rad(2 * rolling_angle)))
    endratio = math.abs(endratio)
    act(2001, endratio)
    if TRUE == EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStep", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy2Start") then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventAllBody("W_Idle")
        return 
    end
    SetRollingTurnCondition(TRUE)
    
end

function BackStep_onActivate()
    ResetDamageCount()
    
end

function BackStep_onUpdate()
    if EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightDash", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothDash", "W_AttackBothHeavy1Start") == TRUE then
        return 
    end
    
end

function Jump_onActivate()
    ResetDamageCount()
    
end

function Jump_onUpdate()
    if EvasionCommonFunction(FALL_TYPE_JUMP, "W_AttackRightLightStep", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy2Start") == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100320) and GetVariable("MoveSpeedLevel") > 0.5 then
        ExecEventNoReset("W_JumpLong")
        return 
    end
    
end

function JumpLong_onUpdate()
    if EvasionCommonFunction(FALL_TYPE_JUMP, "W_AttackRightLightStep", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy2Start") == TRUE then
        return 
    end
    
end

function EStepDown_onActivate()
    ResetDamageCount()
    
end

function EStepDown_onUpdate()
    SetThrowAtkInvalid()
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        if GetEquipType(HAND_LEFT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
            act("精密射撃可能か")
        end
    elseif style == HAND_RIGHT_BOTH and GetEquipType(HAND_RIGHT, WEAPON_CATEGORY_SMALL_ARROW, WEAPON_CATEGORY_LARGE_ARROW, WEAPON_CATEGORY_CROSSBOW) == TRUE then
        act("精密射撃可能か")
    end
    local rolling_angle = GetVariable("RollingAngleReal")
    local addratio = 0.4000000059604645
    local endratio = 1
    endratio = 1 + addratio * math.abs(math.sin(math.rad(2 * rolling_angle)))
    endratio = math.abs(endratio)
    act(2001, endratio)
    if TRUE == EvasionCommonFunction(FALL_TYPE_DEFAULT, "W_AttackRightLightStep", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy2Start") then
        return 
    end
    SetRollingTurnCondition(FALSE)
    
end

function ChainRecover_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if DamageHalfBlendCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ChainRecoverMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function Move_Activate()
    SetMoveWeightIndex()
    SetVariable("ChangeStartWaistTwistAngle", 0)
    SetVariable("ChangeEndWaistTwistAngle", 0)
    
end

function Move_Update()
    SetMoveWeightIndex()
    ChangeWaistTwist(-10, 0, -20, 0)
    
end

function Move_onActivate()
    act(101, TRUE)
    
end

function Move_onUpdate()
    act(101, TRUE)
    local move_speed = GetVariable("MoveSpeedIndex")
    if move_speed == 2 then
        SetThrowAtkInvalid()
    end
    if GetVariable("MoveType") == 3 then
        act("4方向移動閾値設定", 60, 45, 60, 60)
    elseif GetVariable("MoveType") == 0 then
        act("4方向移動閾値設定", 70, 40, 60, 20)
    else
        act("4方向移動閾値設定", 40, 70, 60, 20)
    end
    SpeedUpdate()
    local f5461_local0 = env(ESD_ENV_IsCOMPlayer)
    local f5461_local1 = TRUE
    if f5461_local0 == f5461_local1 then
        local npc_turn_speed = 240
        if move_speed == 2 then
            npc_turn_speed = 210
        else
            local dir = GetVariable("MoveDirection")
            if dir == 0 then
                npc_turn_speed = 90
            end
        end
        SetTurnSpeed(npc_turn_speed)
    end
    local addratio = 0
    local endratio = 1
    local ratio = 1
    if GetVariable("MoveDirection") == 3 or GetVariable("MoveDirection") == 2 then
        act(2001, 0.9599999785423279 * ratio)
    elseif GetVariable("MoveDirection") == 1 then
        act(2001, 0.9599999785423279 * ratio)
    elseif GetVariable("MoveDirection") == 0 then
        act(2001, 0.9800000190734863 * ratio)
    end
    
end

function MoveNoSync_onActivate()
    act(101, TRUE)
    
end

function MoveNoSync_onUpdate()
    Move_onUpdate()
    
end

function Move_Upper_onActivate()
    act(9100)
    
end

function Move_Upper_onUpdate()
    if MoveCommonFunction(UPPER) == TRUE then
        return 
    end
    
end

function Guard_Activate()
    local style = c_Style
    if style == HAND_RIGHT_BOTH then
        SetAttackHand(HAND_RIGHT)
    else
        SetAttackHand(HAND_LEFT)
    end
    
end

function GuardStart_Upper_onActivate()
    if IsNodeActive("GuardStart_Upper Selector") == FALSE then
        act(9100)
    end
    
end

function GuardStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
        act(129, TRUE)
    else
        act(129, FALSE)
    end
    if GuardCommonFunction(FALSE, blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) or TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEventHalfBlend(Event_GuardOn, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GuardOn, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function GuardOn_Upper_onActivate()
    if IsNodeActive("GuardOn_Upper Selector") == FALSE then
        act(9100)
    end
    
end

function GuardOn_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
        act(129, TRUE)
    else
        act(129, FALSE)
    end
    if GuardCommonFunction(FALSE, blend_type) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GuardOn, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function GuardEnd_Upper_onActivate()
    if IsNodeActive("GuardEnd_Upper Selector") == FALSE then
        act(9100)
    end
    
end

function GuardEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
        act(129, TRUE)
    else
        act(129, FALSE)
    end
    if GuardCommonFunction(TRUE, blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GuardEnd, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function FallStart_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_DEFAULT) == TRUE then
        return 
    end
    
end

function FallJumpStart_onUpdate()
    if FallCommonFunction(TRUE, TRUE, FALL_DEFAULT) == TRUE then
        return 
    end
    
end

function FallLoop_onUpdate()
    if env(ESD_ENV_IsHamariFallDeath, 12) == TRUE then
        ExecEvent("W_FallDeath")
        return 
    end
    if FallCommonFunction(TRUE, FALSE, FALL_DEFAULT) == TRUE then
        return 
    end
    
end

function FallAttackStart_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_ATTACK) == TRUE then
        return 
    end
    
end

function FallAttackLoop_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_ATTACK) == TRUE then
        return 
    end
    
end

function FallAttackCancel_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_ATTACK) == TRUE then
        return 
    end
    
end

function Land_onUpdate()
    if LandCommonFunction() == TRUE then
        return 
    end
    
end

function LandLow_onActivate()
    act(9100)
    
end

function LandLow_onUpdate()
    if IdleCommonFunction() == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function LandFallAttack_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function FallStartFaceUp_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_FACEUP) == TRUE then
        return 
    end
    
end

function FallStartFaceDown_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_FACEDOWN) == TRUE then
        return 
    end
    
end

function FallLoopFaceUp_onUpdate()
    if env(ESD_ENV_IsHamariFallDeath, 12) == TRUE then
        ExecEvent("W_FallDeathFaceUp")
        return 
    end
    if FallCommonFunction(TRUE, FALSE, FALL_FACEUP) == TRUE then
        return 
    end
    
end

function FallLoopFaceDown_onUpdate()
    if env(ESD_ENV_IsHamariFallDeath, 12) == TRUE then
        ExecEvent("W_FallDeathFaceDown")
        return 
    end
    if FallCommonFunction(TRUE, FALSE, FALL_FACEDOWN) == TRUE then
        return 
    end
    
end

function LandFaceUp_onUpdate()
    if LandCommonFunction() == TRUE then
        return 
    end
    
end

function LandFaceDown_onUpdate()
    if LandCommonFunction() == TRUE then
        return 
    end
    
end

function Damage_Update()
    if env(ESD_ENV_DS3GetSpecialEffectID, 30) == FALSE then
        SetThrowDefInvalid()
    end
    
end

function DamageSmall_onUpdate()
    act(2001, 0)
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return 
    end
    
end

function DamageMiddle_onUpdate()
    act(2001, 0)
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return 
    end
    
end

function DamageLarge_onUpdate()
    act(2001, 0)
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return 
    end
    
end

function DamageLarge2_onUpdate()
    act(2001, 0)
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return 
    end
    
end

function DamageWeak_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return 
    end
    
end

function DamageMinimum_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return 
    end
    
end

function DamageFling_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FACEDOWN_LOOP) == TRUE then
        return 
    end
    
end

function DamageExLarge_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FORCE_LOOP) == TRUE then
        return 
    end
    
end

function DamagePush_onUpdate()
    act(2001, 0)
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_FORCE) == TRUE then
        return 
    end
    
end

function DamageSmallBlow_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FORCE_LOOP) == TRUE then
        return 
    end
    
end

function DamageUpper_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FACEDOWN_LOOP) == TRUE then
        return 
    end
    
end

function DamageExBlast_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FORCE_LOOP) == TRUE then
        return 
    end
    
end

function DamageBreath_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_FORCE_LOOP) == TRUE then
        return 
    end
    
end

function DamageParry_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    
end

function SpecialDamageUpper_onUpdate()
    if env(ESD_ENV_GetBehaviorID, 10) == TRUE then
        Replanning()
        ResetDamageCount()
        act(141, DAMAGE_FLAG_SMALL)
        ExecEvent("W_SpecialDamageUpper")
        return TRUE
    end
    if env(ESD_ENV_GetEventEzStateFlag, 0) == FALSE and env(ESD_ENV_IsTruelyLanding) == TRUE then
        ExecEvent("W_SpecialDamageUpperLand")
        return TRUE
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        ExecEvent("W_SpecialDamageUpperLoop")
    end
    
end

function SpecialDamageUpperLoop_onUpdate()
    if env(ESD_ENV_GetBehaviorID, 10) == TRUE then
        Replanning()
        ResetDamageCount()
        act(141, DAMAGE_FLAG_SMALL)
        ExecEvent("W_SpecialDamageUpper")
        return TRUE
    end
    if env(ESD_ENV_IsTruelyLanding) == TRUE then
        ExecEvent("W_SpecialDamageUpperLand")
        return TRUE
    end
    
end

function SpecialDamageUpperLand_onUpdate()
    if env(ESD_ENV_GetEventEzStateFlag, 0) == TRUE then
        if TRUE == IsDead() then
            SetVariable("IndexDeath", DEATH_TYPE_SPECIAL_UPPER)
            ExecEventAllBody("W_DeathStart")
            return 
        end
        if TRUE == DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) then
            return 
        end
    end
    
end

function GuardDamageSmall_onUpdate()
    act(110)
    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    
end

function GuardDamageMiddle_onUpdate()
    act(110)
    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    
end

function GuardDamageLarge_onUpdate()
    act(110)
    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    
end

function GuardBreak_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    
end

function GuardDamageSmall_GenTrans_onUpdate()
    act(110)
    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function GuardDamageMiddle_GenTrans_onUpdate()
    act(110)
    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function GuardDamageLarge_GenTrans_onUpdate()
    act(110)
    if DamageCommonFunction(TO_GUARDON, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function GuardBreak_GenTrans_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function GuardDamageBreak_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    
end

function GuardBreakWall_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_NONE, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    
end

function GuardDamageExLarge_onUpdate()
    if DamageCommonFunction(FALSE, ESTEP_DOWN, FALL_TYPE_DEFAULT) == TRUE then
        return 
    end
    
end

function DeathIdle_onActivate()
    act(126, TRUE)
    
end

function DeathIdle_onDeactivate()
    act(126, FALSE)
    
end

function QuickTurn_Activate()
    
end

function QuickTurn_Deactivate()
    
end

function QuickTurnLeft180_Upper_onUpdate()
    if QuickTurnCommonFunction() == TRUE then
        return 
    end
    if GetVariable("IsLockon") == false then
        ExecEventNoReset("W_Idle")
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventNoReset("W_Idle")
        return 
    end
    
end

function QuickTurnRight180_Upper_onUpdate()
    if QuickTurnCommonFunction() == TRUE then
        return 
    end
    if GetVariable("IsLockon") == false then
        ExecEventNoReset("W_Idle")
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventNoReset("W_Idle")
        return 
    end
    
end

function AttackRight_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    SetAttackHand(HAND_RIGHT)
    
end

function AttackRightLight1_onUpdate()
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1SubStart", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightLight2_onUpdate()
    if AttackCommonFunction("W_AttackRightLight3", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight3", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightLight3_onUpdate()
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1SubStart", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightLightKick_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightLightStep_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightLightStepSpecial_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightLightDash_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightLightDashSpecial_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightWhileGuard_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", TO_GUARDON, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightHeavy1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        act("特殊補間設定", 0, TRUE)
        ExecEventAllBody("W_AttackRightHeavy1Start")
        return 
    end
    
end

function AttackRightHeavy1Start_onUpdate()
    act("特殊補間設定", 0, FALSE)
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if 0 >= env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100280) then
        ExecEventAllBody("W_AttackRightHeavy1End")
        return 
    end
    
end

function AttackRightHeavy1End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightHeavy2Start_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100280) then
        ExecEventAllBody("W_AttackRightHeavy2End")
        return 
    end
    
end

function AttackRightHeavy2End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightHeavySpecial1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        act("特殊補間設定", 0, TRUE)
        ExecEventAllBody("W_AttackRightHeavySpecial1Start")
        return 
    end
    
end

function AttackRightHeavySpecial1Start_onUpdate()
    act("特殊補間設定", 0, FALSE)
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if 0 >= env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100280) then
        ExecEventAllBody("W_AttackRightHeavySpecial1End")
        return 
    end
    
end

function AttackRightHeavySpecial1End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightHeavySpecial2Start_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100280) then
        ExecEventAllBody("W_AttackRightHeavySpecial2End")
        return 
    end
    
end

function AttackRightHeavySpecial2End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightHeavyWepBroken1Start_onUpdate()
    AttackRightHeavy1Start_onUpdate()
    
end

function AttackRightHeavyWepBroken2Start_onUpdate()
    AttackRightHeavy2Start_onUpdate()
    
end

function AttackRightHeavyWepBroken1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        act("特殊補間設定", 0, TRUE)
        ExecEventAllBody("W_AttackRightHeavyWepBroken1Start")
        return 
    end
    
end

function AttackRightHeavyKick_onUpdate()
    if AttackCommonFunction("W_AttackRightLightStep", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightHeavyKickSpecial_onUpdate()
    if AttackCommonFunction("W_AttackRightLightStep", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackRightBackstep_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackLeft_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    SetAttackHand(HAND_LEFT)
    ActivateRightArmAdd(START_FRAME_A02)
    
end

function AttackLeft_Update()
    SetVariable("IndexDamageParryHand", 1)
    UpdateRightArmAdd()
    
end

function AttackLeft_Deactivate()
    SetVariable("IndexDamageParryHand", 0)
    
end

function AttackLeftLight1_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackLeftHeavy1_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy2", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackLeftHeavy2_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy3", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackLeftHeavy3_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", nil, "W_AttackLeftHeavy2", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackLeftHeavySp1_onUpdate()
    AttackLeftHeavy1_onUpdate()
    
end

function AttackLeftHeavySp2_onUpdate()
    AttackLeftHeavy2_onUpdate()
    
end

function AttackLeftHeavySp3_onUpdate()
    AttackLeftHeavy3_onUpdate()
    
end

function AttackBoth_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
    end
    
end

function AttackBothLight1_onUpdate()
    local b2 = "W_AttackBothHeavy1SubStart"
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand) == 232 then
        b2 = "W_AttackBothHeavy2Start"
    end
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackBothLeft2", "W_AttackLeftHeavy1", "W_AttackBothLight2", b2, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLight2_onUpdate()
    if AttackCommonFunction("W_AttackRightLight3", "W_AttackRightHeavy1Start", "W_AttackBothLeft3", "W_AttackLeftHeavy1", "W_AttackBothLight3", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLight3_onUpdate()
    local b1 = "W_AttackBothLight2"
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand) == 232 then
        b1 = "W_AttackBothLight1"
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100440) == TRUE then
        act(2001, 0.699999988079071)
    end
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackBothLeft2", "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1SubStart", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLeft1_onUpdate()
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackBothLeft2", "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLeft2_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft3", "W_AttackLeftHeavy1", "W_AttackBothLight3", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLeft3_onUpdate()
    if AttackCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy1Start", "W_AttackBothLeft2", "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLeftDash_onUpdate()
    local r1 = "W_AttackRightLight1"
    local l1 = "W_AttackBothLeft1"
    local b1 = "W_AttackBothLight1"
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand) == 161 then
        r1 = "W_AttackRightLight2"
        l1 = "W_AttackBothLeft2"
        b1 = "W_AttackBothLight2"
    end
    if AttackCommonFunction(r1, "W_AttackRightHeavy1Start", l1, "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLeftStep_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothHeavy1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        act("特殊補間設定", 0, TRUE)
        ExecEventAllBody("W_AttackBothHeavy1Start")
        return 
    end
    
end

function AttackBothHeavy1Start_onUpdate()
    act("特殊補間設定", 0, FALSE)
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if 0 >= env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100280) then
        ExecEventAllBody("W_AttackBothHeavy1End")
        return 
    end
    
end

function AttackBothHeavy1End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothHeavy2Start_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100280) then
        ExecEventAllBody("W_AttackBothHeavy2End")
        return 
    end
    
end

function AttackBothHeavy2End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothHeavySpecial1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        act("特殊補間設定", 0, TRUE)
        ExecEventAllBody("W_AttackBothHeavySpecial1Start")
        return 
    end
    
end

function AttackBothHeavySpecial1Start_onUpdate()
    act("特殊補間設定", 0, FALSE)
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if 0 >= env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100280) then
        ExecEventAllBody("W_AttackBothHeavySpecial1End")
        return 
    end
    
end

function AttackBothHeavySpecial1End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothHeavySpecial2Start_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 and TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100280) then
        ExecEventAllBody("W_AttackBothHeavySpecial2End")
        return 
    end
    
end

function AttackBothHeavySpecial2End_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothHeavyWepBroken1Start_onUpdate()
    AttackBothHeavy1Start_onUpdate()
    
end

function AttackBothHeavyWepBroken2Start_onUpdate()
    AttackBothHeavy2Start_onUpdate()
    
end

function AttackBothHeavyWepBroken1SubStart_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy2Start", FALSE, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        act("特殊補間設定", 0, TRUE)
        ExecEventAllBody("W_AttackBothHeavyWepBroken1Start")
        return 
    end
    
end

function AttackBothDash_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothDashSpecial_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLightStep_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLightStepSpecial_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothLightKick_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothHeavyKick_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothHeavyKickSpecial_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackBothBackstep_onUpdate()
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackBothLeft1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackArrowRight_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    if c_Style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
    end
    
end

function AttackArrowRightStart_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if ArrowCommonFunction(blend_type, FALSE, FALSE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if env(ESD_ENV_DS3GetBowAndArrowSlot, 0) == 0 then
            if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackArrowRightLoop, blend_type)
                return 
            else
                ExecEventAllBody("W_AttackArrowRightFire")
                return 
            end
        elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackArrowRightLoop, blend_type)
            return 
        else
            ExecEventAllBody("W_AttackArrowRightFire")
            return 
        end
    end
    if ArrowLowerCommonFunction(Event_AttackArrowRightStartMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackArrowRightLoop_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if ArrowCommonFunction(blend_type, FALSE, FALSE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetBowAndArrowSlot, 0) == 0 then
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) <= 0 then
            ExecEventAllBody("W_AttackArrowRightFire")
            return 
        end
    elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 then
        ExecEventAllBody("W_AttackArrowRightFire")
        return 
    end
    if ArrowLowerCommonFunction(Event_AttackArrowRightLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackArrowRightFire_onUpdate()
    act("精密射撃可能か")
    if ArrowCommonFunction(ALLBODY, TRUE, FALSE) == TRUE then
        return 
    end
    if env(ESD_ENV_GetStamina) <= 0 then
        return 
    end
    local request = GetAttackRequest(FALSE)
    if request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
        if env(ESD_ENV_GetEquipWeaponCategory, HAND_RIGHT) ~= WEAPON_CATEGORY_LARGE_ARROW then
            if TRUE == IsExistArrow() then
                ExecEventAllBody("W_NoArrow")
                return 
            else
                ExecEventHalfBlend(Event_AttackArrowRightStart, ALLBODY)
                return 
            end
        elseif TRUE == IsExistArrow() then
            ExecEventAllBody("W_NoArrow")
            return 
        else
            ExecEventHalfBlend(Event_AttackArrowRightStart, ALLBODY)
            return 
        end
    end
    if TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
        return 
    end
    
end

function AttackArrowRightFireDash_onUpdate()
    act("精密射撃可能か")
    if ArrowCommonFunction(ALLBODY, TRUE, TRUE) == TRUE then
        return 
    end
    if TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
        return 
    end
    
end

function AttackArrowRightFireStep_onUpdate()
    act("精密射撃可能か")
    if ArrowCommonFunction(ALLBODY, TRUE, TRUE) == TRUE then
        return 
    end
    if TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
        return 
    end
    
end

function NoArrow_onUpdate()
    if ArrowCommonFunction(ALLBODY, TRUE, TRUE) == TRUE then
        return 
    end
    if TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
        return 
    end
    
end

function AttackCrossbowRight_Activate()
    SetAttackHand(HAND_RIGHT)
    
end

function AttackCrossbowLeft_Activate()
    SetAttackHand(HAND_LEFT)
    ActivateRightArmAdd(START_FRAME_A02)
    
end

function AttackCrossbowLeft_Update()
    UpdateRightArmAdd()
    
end

function AttackCrossbowFire_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function AttackCrossbowRightStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if env(ESD_ENV_DS3GetBowAndArrowSlot, 1) == 0 then
            if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackCrossbowRightLoop, blend_type)
                return 
            else
                ExecEventHalfBlend(Event_AttackCrossbowRightFire, blend_type)
                return 
            end
        elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackCrossbowRightLoop, blend_type)
            return 
        else
            ExecEventHalfBlend(Event_AttackCrossbowRightFire, blend_type)
            return 
        end
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightLoop, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowRightLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetBowAndArrowSlot, 1) == 0 then
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) <= 0 then
            ExecEventHalfBlend(Event_AttackCrossbowRightFire, blend_type)
            return 
        end
    elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 then
        ExecEventHalfBlend(Event_AttackCrossbowRightFire, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackCrossbowRightFire_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightFire, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowRightReload_Upper_onUpdate()
    act("4方向移動閾値設定", 60, 80, 60, 60)
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightReload, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowRightEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowRightEmpty, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowLeftStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if env(ESD_ENV_DS3GetBowAndArrowSlot, 1) == 0 then
            if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L1) > 0 then
                ExecEventHalfBlend(Event_AttackCrossbowLeftLoop, blend_type)
                return 
            else
                ExecEventHalfBlend(Event_AttackCrossbowLeftFire, blend_type)
                return 
            end
        elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
            ExecEventHalfBlend(Event_AttackCrossbowLeftLoop, blend_type)
            return 
        else
            ExecEventHalfBlend(Event_AttackCrossbowLeftFire, blend_type)
            return 
        end
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftLoop, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowLeftLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetBowAndArrowSlot, 1) == 0 then
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L1) <= 0 then
            ExecEventHalfBlend(Event_AttackCrossbowLeftFire, blend_type)
            return 
        end
    elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 then
        ExecEventHalfBlend(Event_AttackCrossbowLeftFire, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackCrossbowLeftFire_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftFire, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowLeftReload_Upper_onUpdate()
    act("精密射撃可能か")
    act("4方向移動閾値設定", 60, 45, 60, 60)
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftReload, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowLeftEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowLeftEmpty, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothLeftStart_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if env(ESD_ENV_DS3GetBowAndArrowSlot, 1) == 0 then
            if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackCrossbowBothLeftLoop, blend_type)
                return 
            else
                ExecEventHalfBlend(Event_AttackCrossbowBothLeftFire, blend_type)
                return 
            end
        elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftLoop, blend_type)
            return 
        else
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftFire, blend_type)
            return 
        end
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftLoop, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothLeftLoop_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetBowAndArrowSlot, 1) == 0 then
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) <= 0 then
            ExecEventHalfBlend(Event_AttackCrossbowBothLeftFire, blend_type)
            return 
        end
    elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 then
        ExecEventHalfBlend(Event_AttackCrossbowBothLeftFire, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothLeftFire_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftFire, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothLeftReload_Upper_onUpdate()
    act("精密射撃可能か")
    act("4方向移動閾値設定", 60, 80, 60, 60)
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftReload, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothLeftEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothLeftEmpty, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothRightStart_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if env(ESD_ENV_DS3GetBowAndArrowSlot, 1) == 0 then
            if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) > 0 then
                ExecEventHalfBlend(Event_AttackCrossbowBothRightLoop, blend_type)
                return 
            else
                ExecEventHalfBlend(Event_AttackCrossbowBothRightFire, blend_type)
                return 
            end
        elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) > 0 then
            ExecEventHalfBlend(Event_AttackCrossbowBothRightLoop, blend_type)
            return 
        else
            ExecEventHalfBlend(Event_AttackCrossbowBothRightFire, blend_type)
            return 
        end
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothRightLoop, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothRightLoop_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetBowAndArrowSlot, 1) == 0 then
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) <= 0 then
            ExecEventHalfBlend(Event_AttackCrossbowBothRightFire, blend_type)
            return 
        end
    elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 then
        ExecEventHalfBlend(Event_AttackCrossbowBothRightFire, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothRightLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothRightFire_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothRightFire, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothRightReload_Upper_onUpdate()
    act("精密射撃可能か")
    act("4方向移動閾値設定", 60, 80, 60, 60)
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothRightReload, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function AttackCrossbowBothRightEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if CrossbowCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_AttackCrossbowBothRightEmpty, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function SwordArtsRight_Activate()
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
    end
    
end

function StepInRight_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function StepInRightStart_Upper_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight2", "W_StepInRightUppercut", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_StepInRightUppercut", FALSE, FALSE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function StepInRightUppercut_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function StepInRightSlash_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function SpinRightStart_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLightStep", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    
end

function SpinRightSelftrans_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLightStep", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLightStep", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    
end

function DrawStanceRight_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function DrawStanceRightNoSync_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function DrawStanceRightStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    local r1 = "W_DrawStanceRightAttackLight"
    local r2 = "W_DrawStanceRightAttackHeavy"
    local b1 = "W_DrawStanceRightAttackLight"
    local b2 = "W_DrawStanceRightAttackHeavy"
    if env(ESD_ENV_DS3GetSpecialEffectID, 100530) == TRUE then
        r1 = "W_DrawStanceRightAttackLightR90"
        r2 = "W_DrawStanceRightAttackHeavyR90"
        b1 = "W_DrawStanceRightAttackLightR90"
        b2 = "W_DrawStanceRightAttackHeavyR90"
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100540) == TRUE then
        r1 = "W_DrawStanceRightAttackLight180"
        r2 = "W_DrawStanceRightAttackHeavy180"
        b1 = "W_DrawStanceRightAttackLight180"
        b2 = "W_DrawStanceRightAttackHeavy180"
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100550) == TRUE then
        r1 = "W_DrawStanceRightAttackLightL90"
        r2 = "W_DrawStanceRightAttackHeavyL90"
        b1 = "W_DrawStanceRightAttackLightL90"
        b2 = "W_DrawStanceRightAttackHeavyL90"
    end
    if SwordArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100330) == TRUE and (env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) < 200 or env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) == TRUE) then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        if env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand) == 248 then
            g_LoopStanceCycles = 0
            ExecEventHalfBlendNoReset(Event_DrawStanceRightLoopNoSync, blend_type)
            if 1 == GetVariable("LocomotionState") then
                ExecEvent("W_MoveNoSync")
            end
        else
            ExecEventHalfBlendNoReset(Event_DrawStanceRightLoop, blend_type)
            if 1 == GetVariable("LocomotionState") then
                ExecEvent("W_Move")
            end
        end
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DrawStanceRightStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DrawStanceRightComboStartRight_onUpdate()
    if SwordArtsCommonFunction("W_DrawStanceRightAttackLight2", "W_DrawStanceRightAttackHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_DrawStanceRightAttackLight2", "W_DrawStanceRightAttackHeavy", FALSE, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    
end

function DrawStanceRightComboStartLeft_onUpdate()
    if SwordArtsCommonFunction("W_DrawStanceRightAttackLight3", "W_DrawStanceRightAttackHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_DrawStanceRightAttackLight.", "W_DrawStanceRightAttackHeavy", FALSE, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    
end

function DrawStanceStartDash_onUpdate()
    if SwordArtsCommonFunction("W_DrawStanceRightAttackLight2", "W_DrawStanceRightAttackHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_DrawStanceRightAttackLight2", "W_DrawStanceRightAttackHeavy", FALSE, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    
end

function DrawStanceStartRolling_onUpdate()
    if SwordArtsCommonFunction("W_DrawStanceRightAttackLight3", "W_DrawStanceRightAttackHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_DrawStanceRightAttackLight3", "W_DrawStanceRightAttackHeavy", FALSE, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    
end

function DrawStanceRightLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    local r1 = "W_DrawStanceRightAttackLight"
    local r2 = "W_DrawStanceRightAttackHeavy"
    local b1 = "W_DrawStanceRightAttackLight"
    local b2 = "W_DrawStanceRightAttackHeavy"
    if env(ESD_ENV_DS3GetSpecialEffectID, 100530) == TRUE then
        r1 = "W_DrawStanceRightAttackLightR90"
        r2 = "W_DrawStanceRightAttackHeavyR90"
        b1 = "W_DrawStanceRightAttackLightR90"
        b2 = "W_DrawStanceRightAttackHeavyR90"
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100540) == TRUE then
        r1 = "W_DrawStanceRightAttackLight180"
        r2 = "W_DrawStanceRightAttackHeavy180"
        b1 = "W_DrawStanceRightAttackLight180"
        b2 = "W_DrawStanceRightAttackHeavy180"
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100550) == TRUE then
        r1 = "W_DrawStanceRightAttackLightL90"
        r2 = "W_DrawStanceRightAttackHeavyL90"
        b1 = "W_DrawStanceRightAttackLightL90"
        b2 = "W_DrawStanceRightAttackHeavyL90"
    end
    if SwordArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 or env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) == TRUE then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return 
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand)
    if sp_kind == 248 and env(ESD_ENV_GetStamina) <= 0 then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DrawStanceRightLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function DrawStanceRightLoopNoSync_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    local r1 = "W_DrawStanceRightAttackLight"
    local r2 = "W_DrawStanceRightAttackHeavy"
    local b1 = "W_DrawStanceRightAttackLight"
    local b2 = "W_DrawStanceRightAttackHeavy"
    if env(ESD_ENV_DS3GetSpecialEffectID, 100530) == TRUE then
        r1 = "W_DrawStanceRightAttackLightR90"
        r2 = "W_DrawStanceRightAttackHeavyR90"
        b1 = "W_DrawStanceRightAttackLightR90"
        b2 = "W_DrawStanceRightAttackHeavyR90"
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100540) == TRUE then
        r1 = "W_DrawStanceRightAttackLight180"
        r2 = "W_DrawStanceRightAttackHeavy180"
        b1 = "W_DrawStanceRightAttackLight180"
        b2 = "W_DrawStanceRightAttackHeavy180"
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100550) == TRUE then
        r1 = "W_DrawStanceRightAttackLightL90"
        r2 = "W_DrawStanceRightAttackHeavyL90"
        b1 = "W_DrawStanceRightAttackLightL90"
        b2 = "W_DrawStanceRightAttackHeavyL90"
    end
    if SwordArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 or env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) == TRUE then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return 
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand)
    if sp_kind == 248 then
        if env(ESD_ENV_GetStamina) <= 0 then
            ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
            return 
        elseif env(ESD_ENV_GetEventEzStateFlag, 0) == TRUE and g_FrameCount - g_LoopStanceLastCycle > 5 then
            if g_LoopStanceCycles >= 1 then
                g_LoopStanceCycles = 0
                ExecEventHalfBlend(Event_DrawStanceRightLoopMaxNoSync, blend_type)
                return 
            else
                g_LoopStanceCycles = g_LoopStanceCycles + 1
                g_LoopStanceLastCycle = g_FrameCount
            end
        end
    end
    if HalfBlendLowerCommonFunctionNoSync(Event_DrawStanceRightLoopNoSync, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function DrawStanceRightLoopMaxNoSync_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    local r1 = "W_DrawStanceRightAttackMaxLight"
    local r2 = "W_DrawStanceRightAttackMaxHeavy"
    local b1 = "W_DrawStanceRightAttackMaxLight"
    local b2 = "W_DrawStanceRightAttackMaxHeavy"
    if env(ESD_ENV_DS3GetSpecialEffectID, 100530) == TRUE then
        r1 = "W_DrawStanceRightAttackMaxLightR90"
        r2 = "W_DrawStanceRightAttackMaxHeavyR90"
        b1 = "W_DrawStanceRightAttackMaxLightR90"
        b2 = "W_DrawStanceRightAttackMaxHeavyR90"
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100540) == TRUE then
        r1 = "W_DrawStanceRightAttackMaxLight180"
        r2 = "W_DrawStanceRightAttackMaxHeavy180"
        b1 = "W_DrawStanceRightAttackMaxLight180"
        b2 = "W_DrawStanceRightAttackMaxHeavy180"
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100550) == TRUE then
        r1 = "W_DrawStanceRightAttackMaxLightL90"
        r2 = "W_DrawStanceRightAttackMaxHeavyL90"
        b1 = "W_DrawStanceRightAttackMaxLightL90"
        b2 = "W_DrawStanceRightAttackMaxHeavyL90"
    end
    if SwordArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 or env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) == TRUE then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return 
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand)
    if sp_kind == 248 and env(ESD_ENV_GetStamina) <= 0 then
        ExecEventHalfBlend(Event_DrawStanceRightEnd, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunctionNoSync(Event_DrawStanceRightLoopMaxNoSync, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function DrawStanceRightEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if SwordArtsStanceCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", blend_type, FALSE, FALSE, TRUE) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DrawStanceRightEnd, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DrawStanceRightAttackLight_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    if env(ESD_ENV_GetEquipWeaponCategory, hand) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy2Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy2Start"
    end
    if sp_kind == 232 then
        r1 = "W_DrawStanceRightAttackLight2"
        b1 = "W_DrawStanceRightAttackLight2"
        is_artsr1 = TRUE
    elseif sp_kind == 251 or sp_kind == 256 then
        r1 = "W_DrawStanceRightAttackLight2"
        b1 = "W_DrawStanceRightAttackLight2"
        r2 = "W_AttackRightHeavy2Start"
        b2 = "W_AttackBothHeavy2Start"
        is_artsr1 = TRUE
    end
    if sp_kind ~= 248 and env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
        r2 = "W_DrawStanceRightAttackHeavy"
        b2 = "W_DrawStanceRightAttackHeavy"
        is_artsr2 = TRUE
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackLightR90_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackLight180_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackLightL90_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackMaxLight_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    if env(ESD_ENV_GetEquipWeaponCategory, hand) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r1 = "W_AttackRightLight2"
        r2 = "W_AttackRightHeavy2Start"
        b1 = "W_AttackBothLight2"
        b2 = "W_AttackBothHeavy2Start"
    end
    if sp_kind == 232 then
        r1 = "W_DrawStanceRightAttackLight2"
        b1 = "W_DrawStanceRightAttackLight2"
        is_artsr1 = TRUE
    elseif sp_kind == 251 or sp_kind == 256 then
        r1 = "W_DrawStanceRightAttackLight2"
        b1 = "W_DrawStanceRightAttackLight2"
        r2 = "W_AttackRightHeavy2Start"
        b2 = "W_AttackBothHeavy2Start"
        is_artsr1 = TRUE
    end
    if sp_kind ~= 248 and env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
        r2 = "W_DrawStanceRightAttackHeavy"
        b2 = "W_DrawStanceRightAttackHeavy"
        is_artsr2 = TRUE
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackMaxLightR90_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackMaxLight180_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackLight2_onUpdate()
    local r1 = "W_DrawStanceRightAttackLight3"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_DrawStanceRightAttackLight3"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = TRUE
    local is_artsr2 = FALSE
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if env(ESD_ENV_GetEquipWeaponCategory, hand) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r2 = "W_AttackRightHeavy2Start"
        b2 = "W_AttackBothHeavy2Start"
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
        r2 = "W_DrawStanceRightAttackHeavy"
        b2 = "W_DrawStanceRightAttackHeavy"
        is_artsr2 = TRUE
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackLight3_onUpdate()
    local r1 = "W_DrawStanceRightAttackLight2"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_DrawStanceRightAttackLight2"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = TRUE
    local is_artsr2 = FALSE
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if env(ESD_ENV_GetEquipWeaponCategory, hand) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r2 = "W_AttackRightHeavy2Start"
        b2 = "W_AttackBothHeavy2Start"
    end
    if sp_kind == 251 then
        r1 = "W_DrawStanceRightAttackLight"
        b1 = "W_DrawStanceRightAttackLight"
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
        r2 = "W_DrawStanceRightAttackHeavy"
        b2 = "W_DrawStanceRightAttackHeavy"
        is_artsr2 = TRUE
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackHeavy_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    local hand = HAND_RIGHT
    local style = c_Style
    if env(ESD_ENV_DS3GetSpecialEffectID, 100250) == TRUE then
        r2 = "W_DrawStanceRightAttackHeavy2"
        b2 = "W_DrawStanceRightAttackHeavy2"
        is_artsr2 = TRUE
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100680) == TRUE then
        r2 = "W_DrawStanceRightAttackHeavy"
        b2 = "W_DrawStanceRightAttackHeavy"
        is_artsr2 = TRUE
    elseif env(ESD_ENV_GetEquipWeaponCategory, hand) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r2 = "W_AttackRightHeavy2Start"
        b2 = "W_AttackBothHeavy2Start"
    else
        r2 = "W_AttackRightHeavy1Start"
        b2 = "W_AttackBothHeavy1Start"
    end
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
        if sp_kind == 232 or sp_kind == 256 then
            r1 = "W_DrawStanceRightAttackLight2"
            b1 = "W_DrawStanceRightAttackLight2"
            is_artsr1 = TRUE
        elseif sp_kind == 248 then

        else
            r1 = "W_DrawStanceRightAttackLight"
            b1 = "W_DrawStanceRightAttackLight"
            is_artsr1 = TRUE
        end
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100700) == TRUE then
        r1 = "W_DrawStanceRightAttackLight"
        b1 = "W_DrawStanceRightAttackLight"
        r2 = nil
        b2 = nil
        is_artsr1 = TRUE
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100450) == TRUE then
        ExecEventAllBody("W_DrawStanceRightAttackHeavyLoop")
        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackHeavyR90_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local f5649_local0 = HAND_LEFT_BOTH
    if style == f5649_local0 then
        hand = HAND_LEFT
    end
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackHeavy180_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local f5650_local0 = HAND_LEFT_BOTH
    if style == f5650_local0 then
        hand = HAND_LEFT
    end
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackHeavyl90_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local f5651_local0 = HAND_LEFT_BOTH
    if style == f5651_local0 then
        hand = HAND_LEFT
    end
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackMaxHeavy_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    local hand = HAND_RIGHT
    local style = c_Style
    if env(ESD_ENV_DS3GetSpecialEffectID, 100250) == TRUE then
        r2 = "W_DrawStanceRightAttackHeavy"
        b2 = "W_DrawStanceRightAttackHeavy"
        is_artsr2 = TRUE
    elseif env(ESD_ENV_GetEquipWeaponCategory, hand) == WEAPON_CATEGORY_STRAIGHT_SWORD then
        r2 = "W_AttackRightHeavy2Start"
        b2 = "W_AttackBothHeavy2Start"
    else
        r2 = "W_AttackRightHeavy1Start"
        b2 = "W_AttackBothHeavy1Start"
    end
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
        if sp_kind == 232 then
            r1 = "W_DrawStanceRightAttackLight2"
            b1 = "W_DrawStanceRightAttackLight2"
            is_artsr1 = TRUE
        elseif sp_kind == 248 then

        else
            r1 = "W_DrawStanceRightAttackLight"
            b1 = "W_DrawStanceRightAttackLight"
        end
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100700) == TRUE then
        r1 = "W_DrawStanceRightAttackLight"
        b1 = "W_DrawStanceRightAttackLight"
        r2 = nil
        b2 = nil
        is_artsr1 = TRUE
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100450) == TRUE then
        ExecEventAllBody("W_DrawStanceRightAttackHeavyLoop")
        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackMaxHeavyR90_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local f5653_local0 = HAND_LEFT_BOTH
    if style == f5653_local0 then
        hand = HAND_LEFT
    end
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackMaxHeavy180_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    local f5654_local0 = HAND_LEFT_BOTH
    if style == f5654_local0 then
        hand = HAND_LEFT
    end
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackHeavyLoop_onUpdate()
    local f5655_local0 = SwordArtsCommonFunction
    local f5655_local1 = "W_DrawStanceRightAttackLight"
    local f5655_local2, f5655_local3, f5655_local4 = nil
    if f5655_local0(f5655_local1, f5655_local2, f5655_local3, f5655_local4, "W_DrawStanceRightAttackLight", nil, FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    f5655_local0 = env
    f5655_local1 = 1108
    f5655_local2 = ACTION_ARM_R2
    if f5655_local0(f5655_local1, f5655_local2) <= 0 then
        ExecEventAllBody("W_DrawStanceRightAttackHeavyLoopEnd")
        return 
    end
    
end

function DrawStanceRightAttackHeavyLoopEnd_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    if env(ESD_ENV_DS3GetSpecialEffectID, 100420) == TRUE then
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
            r1 = "W_DrawStanceRightAttackLight"
            b1 = "W_DrawStanceRightAttackLight"
            is_artsr1 = TRUE
        else
            r1, r2, b1, b2 = nil
        end
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightAttackHeavy2_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_DrawStanceRightAttackHeavy"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_DrawStanceRightAttackHeavy"
    local hand = HAND_RIGHT
    local style = c_Style
    local is_artsr1 = FALSE
    local is_artsr2 = TRUE
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
        if sp_kind == 256 then
            r1 = "W_DrawStanceRightAttackLight3"
            b1 = "W_DrawStanceRightAttackLight3"
            is_artsr1 = TRUE
        else
            r1 = "W_DrawStanceRightAttackLight"
            b1 = "W_DrawStanceRightAttackLight"
            is_artsr1 = TRUE
        end
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, is_artsr2, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function DrawStanceRightHeavyLoopGuard_onUpdate()
    local f5658_local0 = SwordArtsCommonFunction
    local f5658_local1 = "W_DrawStanceRightAttackLight"
    local f5658_local2, f5658_local3, f5658_local4 = nil
    if f5658_local0(f5658_local1, f5658_local2, f5658_local3, f5658_local4, "W_DrawStanceRightAttackLight", nil, FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    f5658_local0 = env
    f5658_local1 = 301
    f5658_local2 = 0
    if f5658_local0(f5658_local1, f5658_local2) == TRUE then
        f5658_local0 = env
        f5658_local1 = 301
        f5658_local2 = 1
        if f5658_local0(f5658_local1, f5658_local2) == TRUE then
            f5658_local0 = env
            f5658_local1 = 1108
            f5658_local2 = ACTION_ARM_R2
            if f5658_local0(f5658_local1, f5658_local2) >= 0 then
                ExecEventAllBody("W_DrawStanceRightAttackHeavyLoop")
                f5658_local0 = SetSwordArtsPointInfo
                f5658_local1 = ACTION_ARM_R2
                f5658_local2 = TRUE
                f5658_local0(f5658_local1, f5658_local2)
                return 
            end
        else
            f5658_local0 = env
            f5658_local1 = 1108
            f5658_local2 = ACTION_ARM_R2
            if f5658_local0(f5658_local1, f5658_local2) <= 0 then
                ExecEventAllBody("W_DrawStanceRightAttackHeavyLoopEnd")
                return 
            end
        end
    end
    
end

function FourWayDrawStanceRightStart_onUpdate()
    local rolling_angle = GetVariable("CircleStepAngle")
    local addratio = 0.30000001192092896
    local endratio = 1
    endratio = 1 + addratio * math.abs(math.sin(math.rad(2 * rolling_angle)))
    endratio = math.abs(endratio)
    act(2001, endratio)
    if SwordArtsStanceCommonFunction("W_DrawStanceRightAttackLight", "W_DrawStanceRightAttackHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_DrawStanceRightAttackLight", "W_DrawStanceRightAttackHeavy", blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100330) then
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) < 200 or TRUE == env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) then
            ExecEventHalfBlend(Event_DrawStanceRightEnd, ALLBODY)
            return 
        else
            ExecEventHalfBlend(Event_DrawStanceRightLoop, ALLBODY)
        end
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_DrawStanceRightLoop, ALLBODY)
        return 
    end
    
end

function StrongBashRight_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function ParryRightStart_onUpdate()
    if SwordArtsParryCommonFunction() == TRUE then
        return 
    end
    
end

function ParryRightStart_WepBreak_onUpdate()
    if SwordArtsParryCommonFunction() == TRUE then
        return 
    end
    
end

function ChainShotRight_Upper_Activate()
    if c_Style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
    end
    
end

function ChainShotRightStart_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if ArrowCommonFunction(blend_type, FALSE, FALSE) == TRUE then
        return 
    end
    local request = GetAttackRequest(FALSE)
    if request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
        if TRUE == IsExistArrow() then
            ExecEventAllBody("W_NoArrow")
            return 
        elseif env(ESD_ENV_GetStamina) > 0 then
            if c_SwordArtsID == SWORDARTS_WIDESHOT then
                if env(ESD_ENV_DS3GetRemainingArrowCount, c_SwordArtsHand) > 2 then
                    SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
                    ExecEventAllBody("W_ChainShotRightFire")
                    return 
                else
                    ExecEventAllBody("W_NoArrow")
                    return 
                end
            else
                SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
                ExecEventAllBody("W_ChainShotRightFire")
                return 
            end
        end
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) and (env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) < 400 or TRUE == env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2)) then
        ExecEventHalfBlend(Event_ChainShotRightEnd, blend_type)
        if lower_state == LOWER_MOVE then
            ExecEventHalfBlendNoReset(Event_Move, LOWER)
        end
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlend(Event_ChainShotRightLoop, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ChainShotRightStartMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ChainShotRightLoop_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if ArrowCommonFunction(blend_type, FALSE, FALSE) == TRUE then
        return 
    end
    local request = GetAttackRequest(FALSE)
    if request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
        if TRUE == IsExistArrow() then
            ExecEventAllBody("W_NoArrow")
            return 
        elseif env(ESD_ENV_GetStamina) > 0 and env(ESD_ENV_GetStamina) > 0 then
            if c_SwordArtsID == SWORDARTS_WIDESHOT then
                if env(ESD_ENV_DS3GetRemainingArrowCount, c_SwordArtsHand) > 2 then
                    SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
                    ExecEventAllBody("W_ChainShotRightFire")
                    return 
                else
                    ExecEventAllBody("W_NoArrow")
                    return 
                end
            else
                SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
                ExecEventAllBody("W_ChainShotRightFire")
            end
        end
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 or TRUE == env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) then
        ExecEventHalfBlend(Event_ChainShotRightEnd, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ChainShotRightLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function ChainShot_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function ChainShotRightFire_onUpdate()
    act("精密射撃可能か")
    if ArrowCommonFunction(ALLBODY, TRUE, FALSE) == TRUE then
        return 
    end
    if c_SwordArtsID == SWORDARTS_CHAINSHOT then
        local request = GetAttackRequest(FALSE)
        if request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2 then
            if TRUE == IsExistArrow() then
                ExecEventAllBody("W_NoArrow")
                return 
            elseif env(ESD_ENV_GetStamina) > 0 then
                SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
                ExecEventAllBody("W_ChainShotRightFireCont")
                return 
            end
        end
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        local f5667_local0 = env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2)
        if f5667_local0 > 0 then
            local blend_type = ALLBODY
            if TRUE == MoveStart(LOWER, Event_Move, FALSE) then
                blend_type = UPPER
            end
            ExecEventHalfBlendNoReset(Event_ChainShotRightLoop, blend_type)
            return 
        end
    end
    if TRUE == MoveStartonCancelTiming(Event_Move, FALSE) then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlend(Event_ChainShotRightEnd, ALLBODY)
        return 
    end
    
end

function ChainShotRightFireCont_onUpdate()
    ChainShotRightFire_onUpdate()
    
end

function ChainShotRightEnd_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if ArrowCommonFunction(blend_type, FALSE, TRUE) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ChainShotRightEnd, lower_state, TRUE, FALSE) == TRUE then
        return 
    end
    
end

function StampedeRight_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function StampedeRightStart_onUpdate()
    if SwordArtsCommonFunction("W_StampedeRightAttackLight", "W_StampedeRightAttackHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_StampedeRightAttackLight", "W_StampedeRightAttackHeavy", FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function StampedeRightAttackLight_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function StampedeRightAttackHeavy_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function SpecialAttackRight_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function SpecialAttackRightStart_onUpdate()
    if SwordArtsCommonFunction("W_SpecialAttackRighLight", "W_SpecialAttackRightHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_SpecialAttackRightLight", "W_SpecialAttackRightHeavy", FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    
end

function SpecialAttackRightLight_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    
end

function SpecialAttackRightHeavy_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    
end

function AttackSpinStart_Upper_onUpdate()
    local r1 = "W_AttackRightLight2"
    local r2 = "W_AttackSpinHeavy"
    local b1 = "W_AttackBothLight2"
    local b2 = "W_AttackSpinHeavy"
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local kind = env(ESD_ENV_GetEquipWeaponCategory, hand)
    if kind == WEAPON_CATEGORY_CURVEDSWORD then
        local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
        if sp_kind ~= 51 and sp_kind ~= 101 and sp_kind ~= 137 and sp_kind ~= 139 and sp_kind ~= 195 then
            r1 = "W_AttackRightLight1"
            b1 = "W_AttackBothLight1"
        end
    end
    if env(ESD_ENV_GetEventEzStateFlag, 0) == FALSE then
        r2 = "W_AttackRightHeavy2Start"
        b2 = "W_AttackBothHeavy2Start"
        if kind == WEAPON_CATEGORY_CURVEDSWORD then
            local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
            if sp_kind ~= 51 and sp_kind ~= 101 and sp_kind ~= 137 and sp_kind ~= 139 and sp_kind ~= 195 then
                r2 = "W_AttackRightHeavy1Start"
                b2 = "W_AttackBothHeavy1Start"
            end
        end
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100570) == TRUE then
        r1 = "W_AttackSpinLight"
        b1 = "W_AttackSpinLight"
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100440) == TRUE then
        act(2001, 1.2000000476837158)
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight2", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        act(2001, 1)
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100590) == TRUE and env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) > 0 and env(ESD_ENV_GetStamina) > 0 then
        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        ExecEventAllBody("W_AttackSpinLoop")
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        act(2001, 1)
        return 
    end
    
end

function SpinAttack_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function AttackSpinLight_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function AttackSpinHeavy_onUpdate()
    local r1 = "W_AttackRightLight2"
    local r2 = "W_AttackRightHeavy2Start"
    local b1 = "W_AttackBothLight2"
    local b2 = "W_AttackBothHeavy2Start"
    local is_artsr1 = FALSE
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local kind = env(ESD_ENV_GetEquipWeaponCategory, hand)
    if kind == WEAPON_CATEGORY_CURVEDSWORD then
        local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
        if sp_kind ~= 51 and sp_kind ~= 137 and sp_kind ~= 139 and sp_kind ~= 166 and sp_kind ~= 195 then
            r1 = "W_AttackRightLight1"
            r2 = "W_AttackRightHeavy1Start"
            if sp_kind ~= 0 and sp_kind ~= 212 then
                b1 = "W_AttackBothLight1"
                b2 = "W_AttackBothHeavy1Start"
            end
        end
    end
    if env(ESD_ENV_GetStamina) > 0 and env(ESD_ENV_DS3GetSpecialEffectID, 100570) == TRUE then
        r1 = "W_AttackSpinLight"
        b1 = "W_AttackSpinLight"
        is_artsr1 = TRUE
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100240) == TRUE and env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) > 0 and env(ESD_ENV_GetStamina) > 0 then
        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        ExecEventAllBody("W_AttackSpinLoop")
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function AttackSpinHeavyL_onUpdate()
    local r1 = "W_AttackRightLight2"
    local r2 = "W_AttackRightHeavy2Start"
    local b1 = "W_AttackBothLight2"
    local b2 = "W_AttackBothHeavy2Start"
    local is_artsr1 = FALSE
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local kind = env(ESD_ENV_GetEquipWeaponCategory, hand)
    if kind == WEAPON_CATEGORY_CURVEDSWORD then
        local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
        if sp_kind ~= 51 and sp_kind ~= 137 and sp_kind ~= 139 and sp_kind ~= 166 and sp_kind ~= 195 then
            r1 = "W_AttackRightLight1"
            r2 = "W_AttackRightHeavy1Start"
            if sp_kind ~= 0 and sp_kind ~= 212 then
                b1 = "W_AttackBothLight1"
                b2 = "W_AttackBothHeavy1Start"
            end
        end
    end
    if env(ESD_ENV_GetStamina) > 0 and env(ESD_ENV_DS3GetSpecialEffectID, 100570) == TRUE then
        r1 = "W_AttackSpinLight"
        b1 = "W_AttackSpinLight"
        is_artsr1 = TRUE
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, is_artsr1, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100240) == TRUE and env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) > 0 and env(ESD_ENV_GetStamina) > 0 then
        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        ExecEventAllBody("W_AttackSpinLoop")
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function AttackSpinLoop_onUpdate()
    local r1 = "W_AttackRightLight2"
    local b1 = "W_AttackBothLight2"
    local is_artsr1 = FALSE
    if env(ESD_ENV_GetStamina) > 0 and env(ESD_ENV_DS3GetSpecialEffectID, 100570) == TRUE then
        r1 = "W_AttackSpinLight"
        b1 = "W_AttackSpinLight"
        is_artsr1 = TRUE
    end
    if SwordArtsCommonFunction(r1, "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, "W_AttackBothHeavy2Start", FALSE, is_artsr1, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100240) == TRUE and env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) > 0 and env(ESD_ENV_GetStamina) > 0 then
        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        ExecEventAllBody("W_AttackSpinLoop")
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100590) == TRUE and env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) > 0 then
        if env(ESD_ENV_GetStamina) > 0 then
            SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
            ExecEventAllBody("W_AttackSpinLoop")
            return 
        else
            ExecEventAllBody("W_AttackSpinHeavy")
            return 
        end
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100600) == TRUE then
        local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand)
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 then
            if sp_kind == 264 and ForwardLeg() == 1 then
                ExecEventAllBody("W_AttackSpinHeavyL")
                return 
            else
                ExecEventAllBody("W_AttackSpinHeavy")
                return 
            end
        end
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function AttackSpinLoopEnd_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight2", "W_AttackRightHeavy2Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight2", "W_AttackBothHeavy2Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function Charge_Upper_onUpdate()
    local r2 = "W_AttackRightHeavy1Start"
    local l2 = "W_AttackLeftHeavy1"
    local b2 = "W_AttackBothHeavy1Start"
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if env(ESD_ENV_DS3GetSpecialEffectID, 100260) == TRUE then
        r2 = "W_ChargeContinue"
        l2 = "W_ChargeContinue"
        b2 = "W_ChargeContinue"
        is_artsr2 = TRUE
    end
    if SwordArtsCommonFunction("W_AttackRightLight1", r2, "W_AttackLeftLight1", l2, "W_AttackBothLight1", b2, is_artsr1, is_artsr2, TRUE, GEN_TRANS_LFET) == TRUE then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function Charge_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function ChargeContinue_onUpdate()
    local r2 = "W_AttackRightHeavy1Start"
    local l2 = "W_AttackLeftHeavy1"
    local b2 = "W_AttackBothHeavy1Start"
    local is_artsr1 = FALSE
    local is_artsr2 = FALSE
    if env(ESD_ENV_DS3GetSpecialEffectID, 100260) == TRUE then
        r2 = "W_ChargeContinue"
        l2 = "W_ChargeContinue"
        b2 = "W_ChargeContinue"
        is_artsr2 = TRUE
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100610) == TRUE then
        r2 = "W_ChargeContinue2"
        l2 = "W_ChargeContinue2"
        b2 = "W_ChargeContinue2"
        is_artsr2 = TRUE
    end
    if SwordArtsCommonFunction("W_AttackRightLight1", r2, "W_AttackLeftLight1", l2, "W_AttackBothLight1", b2, is_artsr1, is_artsr2, TRUE, GEN_TRANS_LFET) == TRUE then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function ChargeContinue2_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function Warcry_onUpdate()
    local r2 = "W_AttackRightHeavySpecial1Start"
    local b2 = "W_AttackBothHeavySpecial1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    if env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand) == 242 then
        r2 = "W_AttackRightHeavy1Start"
        b2 = "W_AttackBothHeavy1Start"
    end
    if SwordArtsCommonFunction(g_r1, r2, g_l1, g_l2, g_b1, b2, FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100460) == TRUE and env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 then
        ExecEventAllBody("W_WarcryCancel")
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function WarcryCancel_onUpdate()
    if SwordArtsCommonFunction(g_r1, "W_AttackRightHeavySpecial1Start", g_l1, g_l2, g_b1, "W_AttackBothHeavySpecial1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function Endure_Upper_onUpdate()
    local r2 = "W_AttackRightHeavy1Start"
    local l2 = "W_AttackLeftHeavy1"
    local b2 = "W_AttackBothHeavy1Start"
    if env(ESD_ENV_DS3GetSpecialEffectID, 100290) == TRUE then
        r2 = "W_EndureRightHeavy"
        l2 = "W_EndureRightHeavy"
        b2 = "W_EndureRightHeavy"
        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
    end
    if SwordArtsCommonFunction("W_AttackRightLight1", r2, "W_AttackLeftLight1", l2, "W_AttackBothLight1", b2, FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function EndureRightHeavy_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function OneShotNoGenTrans_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function OneShotNoGenTransStart_onUpdate()
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    local hand = HAND_RIGHT
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    if env(ESD_ENV_DS3GetSpecialEffectID, 100250) == TRUE then
        SetSwordArtsPointInfo(ACTION_ARM_R2, TRUE)
        r2 = "W_OneShotNoGenTransContinue"
        b2 = "W_OneShotNoGenTransContinue"
    end
    if sp_kind == 247 then
        r1 = "W_AttackRightLight2"
        b1 = "W_AttackBothLight2"
    end
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, FALSE, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function OneShotNoGenTransContinue_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicBuffRight_Upper_Activate()
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
    end
    
end

function MagicBuffRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, FALSE) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicBuffRightMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicBuffRight2_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicBuffRight3_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function CircleStepStart_onUpdate()
    local rolling_angle = GetVariable("CircleStepAngle")
    local addratio = 0.30000001192092896
    local endratio = 1
    endratio = 1 + addratio * math.abs(math.sin(math.rad(2 * rolling_angle)))
    endratio = math.abs(endratio)
    act(2001, endratio)
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE) == TRUE then
        return 
    end
    
end

function CircleStepStartSelftrans_onUpdate()
    local rolling_angle = GetVariable("CircleStepAngleSelftrans")
    local addratio = 0.30000001192092896
    local endratio = 1
    endratio = 1 + addratio * math.abs(math.sin(math.rad(2 * rolling_angle)))
    endratio = math.abs(endratio)
    act(2001, endratio)
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ChargeShotRight_Upper_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
    end
    
end

function ChargeShotRightStart_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if SwordArtsChargeShotCommonFunction(blend_type) == TRUE then
        return 
    end
    local request = GetAttackRequest(FALSE)
    if (request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2) and env(ESD_ENV_GetStamina) > 0 then
        if TRUE == IsExistArrow() then
            ExecEventAllBody("W_NoArrow")
            return 
        else
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
            ExecEventHalfBlend(Event_ChargeShotRightHoldStart, ALLBODY)
            return 
        end
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) and env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 then
        ExecEventHalfBlend(Event_ChargeShotRightEnd, ALLBODY)
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlend(Event_ChargeShotRightLoop, ALLBODY)
        return 
    end
    
end

function ChargeShotRightLoop_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if SwordArtsChargeShotCommonFunction(blend_type) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 then
        ExecEventHalfBlend(Event_ChargeShotRightEnd, ALLBODY)
        return 
    end
    local request = GetAttackRequest(FALSE)
    if (request == ATTACK_REQUEST_ARROW_FIRE_RIGHT or request == ATTACK_REQUEST_ARROW_FIRE_RIGHT2) and env(ESD_ENV_GetStamina) > 0 then
        if TRUE == IsExistArrow() then
            ExecEventAllBody("W_NoArrow")
            return 
        else
            SetSwordArtsPointInfo(ACTION_ARM_R1, TRUE)
            ExecEventHalfBlend(Event_ChargeShotRightHoldStart, ALLBODY)
            return 
        end
    end
    if HalfBlendLowerCommonFunction(Event_ChargeShotRightLoop, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ChargeShotRightHoldStart_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if SwordArtsChargeShotCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if env(ESD_ENV_DS3GetBowAndArrowSlot, 0) == 0 then
            if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) <= 0 then
                ExecEventAllBody("W_ChargeShotRightFire")
                return 
            end
        elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 then
            ExecEventAllBody("W_ChargeShotRightFire")
            return 
        end
        ExecEventHalfBlend(Event_ChargeShotRightHoldLoop, ALLBODY)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ChargeShotRightHoldStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ChargeShotRightHoldLoop_Upper_onUpdate()
    act("精密射撃可能か")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if SwordArtsChargeShotCommonFunction(blend_type) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetBowAndArrowSlot, 0) == 0 then
        if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R1) <= 0 then
            ExecEventAllBody("W_ChargeShotRightFire")
            return 
        end
    elseif env(ESD_ENV_DS3ActionDuration, ACTION_ARM_R2) <= 0 then
        ExecEventAllBody("W_ChargeShotRightFire")
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ChargeShotRightHoldLoop, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ChargeShotRightEnd_Upper_onUpdate()
    act("精密射撃可能か")
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function ChargeShotFire_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function ChargeShotRightFire_onUpdate()
    act("精密射撃可能か")
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CrossbowStepInRightStart_Upper_onUpdate()
    act("精密射撃可能か")
    if SwordArtsCrossbowStepInFunction() == TRUE then
        return 
    end
    local request = GetAttackRequest(FALSE)
    if env(ESD_ENV_GetStamina) > 0 then
        if request == ATTACK_REQUEST_RIGHT_CROSSBOW or request == ATTACK_REQUEST_RIGHT_CROSSBOW2 then
            if TRUE == IsExistBolt(HAND_RIGHT) then
                ExecEventHalfBlend(Event_AttackCrossbowRightEmpty, ALLBODY)
                return 
            elseif TRUE == env(ESD_ENV_GetBoltLoadingState, 1) then
                ExecEventAllBody("W_CrossbowStepInFire")
                return 
            else
                ExecEventAllBody("W_CrossbowStepInReload")
                return 
            end
        elseif request == ATTACK_REQUEST_BOTHRIGHT_CROSSBOW or request == ATTACK_REQUEST_BOTHRIGHT_CROSSBOW2 then
            if TRUE == IsExistBolt(HAND_RIGHT) then
                ExecEventHalfBlend(Event_AttackCrossbowBothRightEmpty, ALLBODY)
                return 
            elseif TRUE == env(ESD_ENV_GetBoltLoadingState, 1) then
                ExecEventAllBody("W_CrossbowStepInFire")
                return 
            else
                ExecEventAllBody("W_CrossbowStepInReload")
                return 
            end
        end
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CrossbowStepInFire_onUpdate()
    act("精密射撃可能か")
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CrossbowStepInReload_onUpdate()
    act("精密射撃可能か")
    if AttackCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function HeadHunt_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function HeadHunt_Upper_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function OneShot_Upper_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function OneShot_Upper_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function OneShotFull_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function OneShotFullRightStart_onUpdate()
    SetVariable("IndexThrowHand", HAND_RIGHT)
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    
end

function OneShotFullBothStart_onUpdate()
    SetVariable("IndexThrowHand", HAND_RIGHT)
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    
end

function RandomOneShot1_onUpdate()
    local r2 = "W_RandomOneShotNext1"
    local b2 = "W_RandomOneShotNext1"
    local rand = math.random(0, 100)
    local next3active = env(ESD_ENV_DS3GetSpecialEffectID, 130092600)
    local next4active = env(ESD_ENV_DS3GetSpecialEffectID, 130092632)
    local ignorenext4 = env(ESD_ENV_DS3GetSpecialEffectID, 18000)
    if next3active == TRUE and next4active == TRUE then
        r2 = "W_RandomOneShotNext1"
        b2 = "W_RandomOneShotNext1"
    elseif next3active == TRUE then
        if ignorenext4 == TRUE then
            r2 = "W_RandomOneShotNext1"
            b2 = "W_RandomOneShotNext1"
        elseif rand > 50 then
            r2 = "W_RandomOneShotNext1"
            b2 = "W_RandomOneShotNext1"
        else
            r2 = "W_RandomOneShotNext4"
            b2 = "W_RandomOneShotNext4"
        end
    elseif next4active == TRUE then
        if rand > 50 then
            r2 = "W_RandomOneShotNext1"
            b2 = "W_RandomOneShotNext1"
        else
            r2 = "W_RandomOneShotNext3"
            b2 = "W_RandomOneShotNext3"
        end
    elseif ignorenext4 == TRUE then
        if rand > 50 then
            r2 = "W_RandomOneShotNext1"
            b2 = "W_RandomOneShotNext1"
        else
            r2 = "W_RandomOneShotNext3"
            b2 = "W_RandomOneShotNext3"
        end
    elseif rand > 66 then
        r2 = "W_RandomOneShotNext4"
        b2 = "W_RandomOneShotNext4"
    elseif rand > 33 then
        r2 = "W_RandomOneShotNext3"
        b2 = "W_RandomOneShotNext3"
    else
        r2 = "W_RandomOneShotNext1"
        b2 = "W_RandomOneShotNext1"
    end
    if SwordArtsCommonFunction("W_AttackRightLight1", r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", b2, FALSE, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function RandomOneShotNext1_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEvent("W_Idle")
        return 
    end
    
end

function RandomOneShotNext2_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(FALSE, TRUE)
        ExecEvent("W_Idle")
        return 
    end
    
end

function RandomOneShotNext3_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, TRUE, FALSE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEvent("W_Idle")
        return 
    end
    
end

function RandomOneShotNext4_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, TRUE, FALSE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEvent("W_Idle")
        return 
    end
    
end

function SwordArtsLeft_Activate()
    SetAttackHand(HAND_LEFT)
    
end

function ParryLeftStart_onUpdate()
    if SwordArtsParryCommonFunction() == TRUE then
        return 
    end
    
end

function ParryLeftStart_WepBreak_onUpdate()
    if SwordArtsParryCommonFunction() == TRUE then
        return 
    end
    
end

function MagicBuffLeft_Upper_Activate()
    SetAttackHand(HAND_LEFT)
    
end

function MagicBuffLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, FALSE) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicBuffLeftMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicBuffLeft2_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicBuffLeft3_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function OneShotFullLeftStart_onUpdate()
    SetVariable("IndexThrowHand", HAND_LEFT)
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    
end

function StormStanceRight_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function StormStanceStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if SwordArtsStanceCommonFunction("W_StormStanceLight", "W_StormStanceHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_StormStanceLight", "W_StormStanceHeavy", blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if style == HAND_LEFT_BOTH then
        act(2002, 100901)
    else
        act(2002, 100900)
    end
    if TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100330) and (env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) < 200 or TRUE == env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2)) then
        ExecEventHalfBlend(Event_StormStanceEnd, blend_type)
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_StormStanceLoop, blend_type)
        g_StormStanceHoldTime = env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_StormStanceStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function StormStanceLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if SwordArtsStanceCommonFunction("W_StormStanceLight", "W_StormStanceHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_StormStanceLight", "W_StormStanceHeavy", blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if style == HAND_LEFT_BOTH then
        act(2002, 100901)
    else
        act(2002, 100900)
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 or TRUE == env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) then
        ExecEventHalfBlend(Event_StormStanceEnd, blend_type)
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) - g_StormStanceHoldTime >= 2500 then
        ExecEventHalfBlend(Event_StormStanceFullLoop, blend_type)
        local style = c_Style
        if style == HAND_LEFT_BOTH then
            act(2002, 100911)
            act(2002, 100921)
        else
            act(2002, 100910)
            act(2002, 100920)
        end
    end
    if HalfBlendLowerCommonFunction(Event_StormStanceLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function StormStanceChange_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if SwordArtsStanceCommonFunction("W_StormStanceFullLight", "W_StormStanceFullHeavy", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_StormStanceFullLight", "W_StormStanceFullHeavy", blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE and TRUE == env(ESD_ENV_DS3IsMoveCancelPossible) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_StormStanceChange, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function StormStanceEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if SwordArtsStanceCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", blend_type, FALSE, FALSE, TRUE) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_StormStanceEnd, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function StormStanceLight_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function StormStanceHeavy_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function StormStanceFullStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    local r1 = "W_StormStanceFullLight_NonBoss"
    local r2 = "W_StormStanceFullHeavy_NonBoss"
    local b1 = "W_StormStanceFullLight_NonBoss"
    local b2 = "W_StormStanceFullHeavy_NonBoss"
    if env(ESD_ENV_DS3GetSpecialEffectID, 4510) == TRUE then
        r1 = "W_StormStanceFullLight"
        r2 = "W_StormStanceFullHeavy"
        b1 = "W_StormStanceFullLight"
        b2 = "W_StormStanceFullHeavy"
    end
    if SwordArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100330) == TRUE and (env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) < 200 or env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) == TRUE) then
        ExecEventHalfBlend(Event_StormStanceFullEnd, blend_type)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        ExecEventHalfBlendNoReset(Event_StormStanceFullLoop, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_StormStanceFullStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function StormStanceFullLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    local r1 = "W_StormStanceFullLight_NonBoss"
    local r2 = "W_StormStanceFullHeavy_NonBoss"
    local b1 = "W_StormStanceFullLight_NonBoss"
    local b2 = "W_StormStanceFullHeavy_NonBoss"
    if env(ESD_ENV_DS3GetSpecialEffectID, 4510) == TRUE then
        r1 = "W_StormStanceFullLight"
        r2 = "W_StormStanceFullHeavy"
        b1 = "W_StormStanceFullLight"
        b2 = "W_StormStanceFullHeavy"
    end
    if SwordArtsStanceCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, blend_type, TRUE, TRUE, FALSE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 or env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) == TRUE then
        ExecEventHalfBlend(Event_StormStanceFullEnd, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_StormStanceFullLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function StormStanceFullEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if SwordArtsStanceCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", blend_type, FALSE, FALSE, TRUE) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_StormStanceFullEnd, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function StormStanceFullLight_onUpdate()
    local style = c_Style
    if env(ESD_ENV_GetEventEzStateFlag, 0) == TRUE then
        if style == HAND_LEFT_BOTH then
            act(2002, 100931)
        else
            act(2002, 100930)
        end
    end
    if TRUE == SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function StormStanceFullHeavy_onUpdate()
    local style = c_Style
    if env(ESD_ENV_GetEventEzStateFlag, 0) == TRUE then
        if style == HAND_LEFT_BOTH then
            act(2002, 100931)
        else
            act(2002, 100930)
        end
    end
    if TRUE == SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function StormStanceFullLight_NonBoss_onUpdate()
    local style = c_Style
    if env(ESD_ENV_GetEventEzStateFlag, 0) == TRUE then
        if style == HAND_LEFT_BOTH then
            act(2002, 100931)
        else
            act(2002, 100930)
        end
    end
    if TRUE == SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function StormStanceFullHeavy_NonBoss_onUpdate()
    local style = c_Style
    if env(ESD_ENV_GetEventEzStateFlag, 0) == TRUE then
        if style == HAND_LEFT_BOTH then
            act(2002, 100931)
        else
            act(2002, 100930)
        end
    end
    if TRUE == SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, FALSE, FALSE, GEN_TRANS_LEFT) then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function FourWayAttackRight_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function FourWayAttackStart_onUpdate()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_FourWayAttackHeavy"
    local b2 = "W_FourWayAttackHeavy"
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand)
    if sp_kind == 263 then
        r1 = "W_FourWayAttackLight"
        b1 = "W_FourWayAttackLight"
    end
    if GetVariable("IsLockon") == true and IsNodeActive("Move_Upper Selector") == TRUE and env(ESD_ENV_GetEventEzStateFlag, 1) == TRUE then
        local angle = GetVariable("RollingAngle")
        local front, back, left, right = false
        if math.abs(angle) > 135 then
            back = true
        elseif angle > 45 then
            right = true
        elseif angle < -45 then
            left = true
        else
            front = true
        end
        SetVariable("EnableTAE_FourWayAttackStartFront", front)
        SetVariable("EnableTAE_FourWayAttackStartBack", back)
        SetVariable("EnableTAE_FourWayAttackStartLeft", left)
        SetVariable("EnableTAE_FourWayAttackStartRight", right)
        if angle >= 0 then
            SetVariable("FourWayAttackStartDirection", 1)
        else
            SetVariable("FourWayAttackStartDirection", 0)
        end
        SetVariable("FourWayAttackStartAngle", angle)
    end
    local rolling_angle = GetVariable("CircleStepAngle")
    local addratio = 0.30000001192092896
    local endratio = 1
    endratio = 1 + addratio * math.abs(math.sin(math.rad(2 * rolling_angle)))
    endratio = math.abs(endratio)
    act(2001, endratio)
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function FourWayAttackStart_SelfTrans_onUpdate()
    local r1 = "W_AttackRightLight1"
    local b1 = "W_AttackBothLight1"
    local r2 = "W_FourWayAttackHeavy"
    local b2 = "W_FourWayAttackHeavy"
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, c_SwordArtsHand)
    if sp_kind == 263 then
        r1 = "W_FourWayAttackLight"
        b1 = "W_FourWayAttackLight"
    end
    local rolling_angle = GetVariable("CircleStepAngle")
    local addratio = 0.30000001192092896
    local endratio = 1
    endratio = 1 + addratio * math.abs(math.sin(math.rad(2 * rolling_angle)))
    endratio = math.abs(endratio)
    act(2001, endratio)
    if SwordArtsCommonFunction(r1, r2, "W_AttackLeftLight1", "W_AttackLeftHeavy1", b1, b2, FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function FourWayAttackLight_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function FourWayAttackHeavy_onUpdate()
    if SwordArtsCommonFunction("W_AttackRightLight1", "W_AttackRightHeavy1Start", "W_AttackLeftLight1", "W_AttackLeftHeavy1", "W_AttackBothLight1", "W_AttackBothHeavy1Start", FALSE, TRUE, TRUE, GEN_TRANS_LEFT) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function GatlingStanceRightNoSync_Activate()
    SetInterruptType(INTERRUPT_FINDATTACK)
    
end

function GatlingStanceRightStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if GatlingStanceCommonFunction(blend_type, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_DS3GetSpecialEffectID, 100330) and (env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) < 200 or TRUE == env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2)) then
        ExecEventHalfBlend(Event_GatlingStanceRightEnd, blend_type)
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_GatlingStanceRightLoop, blend_type)
        if 1 == GetVariable("LocomotionState") then
            ExecEvent("W_Move")
        end
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GatlingStanceRightStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function GatlingStanceRightLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if GatlingStanceCommonFunction(blend_type, TRUE) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 or TRUE == env(ESD_ENV_DS3ActionCancelRequest, ACTION_ARM_L2) then
        ExecEventHalfBlend(Event_GatlingStanceRightEnd, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GatlingStanceRightLoop, lower_state, FALSE, TRUE) == TRUE then
        return 
    end
    
end

function GatlingStanceRightEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if GatlingStanceCommonFunction(blend_type, FALSE) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GatlingStanceRightEnd, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function GatlingStanceRightFireStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE and env(ESD_ENV_GetEventEzStateFlag, 1) == FALSE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if GetVariable("IsLockon") == true then
        if IsLowerQuickTurn() == TRUE then
            SetVariable("LookAtTwist60_NewTargetGain", 1)
            SetVariable("LookAtTwist70_NewTargetGain", 1)
            SetVariable("LookAtTwist70_OnGain", 0.30000001192092896)
        else
            SetVariable("LookAtTwist60_NewTargetGain", 0.20000000298023224)
            SetVariable("LookAtTwist70_NewTargetGain", 0.20000000298023224)
            SetVariable("LookAtTwist70_OnGain", 0.30000001192092896)
        end
    else
        SetVariable("LookAtTwist60_NewTargetGain", 0.5)
        SetVariable("LookAtTwist70_NewTargetGain", 0.4000000059604645)
        SetVariable("LookAtTwist70_OnGain", 0.30000001192092896)
    end
    local can_fire = FALSE
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
        can_fire = TRUE
    end
    if GatlingStanceCommonFunction(blend_type, can_fire) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GatlingStanceRightFireStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function GatlingStanceRightFireStartLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 15, 15)
    end
    if GetVariable("IsLockon") == true then
        SetVariable("LookAtTwist60_NewTargetGain", 0.10000000149011612)
        SetVariable("LookAtTwist70_NewTargetGain", 0.10000000149011612)
    else
        SetVariable("LookAtTwist60_NewTargetGain", 0.8999999761581421)
        SetVariable("LookAtTwist70_NewTargetGain", 0.20000000298023224)
    end
    local can_fire = FALSE
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
        can_fire = TRUE
    end
    if GatlingStanceCommonFunction(blend_type, can_fire) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        SetArtsGeneratorTransitionIndex(GEN_TRANS_LEFT, TRUE)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GatlingStanceRightFireStartLeft, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function WeaponChangeStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if WeaponChangeCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_WeaponChangeEnd, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_WeaponChangeStartMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function WeaponChangeEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if WeaponChangeCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_WeaponChangeEndMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function HandChangeStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if HandChangeCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_HandChangeEnd, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_HandChangeStartMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function HandChangeEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if HandChangeCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_HandChangeEndMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickItemEnchantNormal_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        ClearAttackQueue()
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickItemEnchantNormal, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickItemEnchantDash_Upper_onActivate()
    act("ロックオン中角度固定解除")
    
end

function QuickItemEnchantDash_Upper_onUpdate()
    act("ロックオン中角度固定解除")
    local r1 = "W_AttackRightLight1"
    local r2 = "W_AttackRightHeavy1Start"
    local b1 = "W_AttackBothLight1"
    local b2 = "W_AttackBothHeavy1Start"
    if GetVariable("MoveSpeedIndex") >= 1 then
        r1 = "W_AttackRightLightDash"
        r2 = "W_AttackRightHeavyKick"
        b1 = "W_AttackBothDash"
        b2 = "W_AttackBothHeavyKick"
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    if QuickItemCommonFunction(r1, r2, g_l1, g_l2, b1, b2, blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100220) == FALSE and HalfBlendLowerCommonFunction(Event_DashStop, lower_state, FALSE, FALSE) == TRUE then
        SetVariable("MoveSpeedLevelReal", 0)
        return 
    end
    if TRUE == env(ESD_ENV_DS3IsMoveCancelPossible) then
        ExecEvent("W_Idle")
        return 
    end
    
end

function QuickItemEnchantStep_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    
end

function QuickItemEnchantAttackRight_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    
end

function QuickItemEnchantAttackLeft_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    
end

function QuickItemThrowKnifeNormal_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    
end

function QuickItemThrowKnifeDash_Upper_onActivate()
    act("ロックオン中角度固定解除")
    
end

function QuickItemThrowKnifeDash_Upper_onUpdate()
    act("ロックオン中角度固定解除")
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    
end

function QuickItemThrowKnifeStep_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    
end

function QuickItemThrowKnifeAttackRight_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    
end

function QuickItemThrowKnifeAttackRight2_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_ATTACK) == TRUE then
        return 
    end
    
end

function QuickItemThrowKnifeAttackLeft_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    
end

function QuickItemThrowKnifeAttackLeft2_Upper_onUpdate()
    if QuickItemCommonFunction(g_r1, g_r2, g_l1, g_l2, g_b1, g_b2, ALLBODY, QUICKTYPE_ATTACK) == TRUE then
        return 
    end
    
end

function Item_Activate()
    ActivateRightArmAdd(START_FRAME_NONE)
    
end

function Item_Update()
    UpdateRightArmAdd()
    
end

function NormalItem_Upper_Activate()
    local upper_state = GetVariable("UpperDefaultState02")
    if upper_state == ITEMDRINKSTART_DEF2 or upper_state == ITEMDRINKSTARTMP_DEF2 then
        SetInterruptType(INTERRUPT_USEITEM)
    end
    
end

function ItemRecover_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemRecover, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemWeaponEnchant_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemWeaponEnchant, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemThrowKnife_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemThrowKnife, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemThrowBottle_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemThrowBottle, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemMeganeStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlend(Event_ItemMeganeLoop, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemMeganeStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemMeganeLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemMeganeLoop, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemMeganeEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemMeganeEnd, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemWeaponRepair_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemWeaponRepair, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemSoul_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemSoul, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemMessage_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemMessage, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemPray_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemPray, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemTrap_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemTrap, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEventHalfBlendNoReset(Event_ItemDrinking, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonHeadStartBefore_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_DragonHeadEndBefore, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonHeadStartBefore, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonHeadEndBefore_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonHeadEndBefore, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonHeadStartAfter_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_DragonHeadLoopAfter, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonHeadStartAfter, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonHeadLoopAfter_Upper_onUpdate()
    local dT = GetDeltaTime()
    dash_dt_sum = dash_dt_sum + dT
    if dash_dt_sum > 0.10000000149011612 then
        dash_dt_sum = 0
        act(1001, -1)
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if 0 >= env(ESD_ENV_DS3ActionDuration, ACTION_ARM_USE_ITEM) then
        ExecEventHalfBlend(Event_DragonHeadEndAfter, blend_type)
    elseif 0 >= env(ESD_ENV_GetStamina) then
        ExecEventHalfBlend(Event_DragonHeadEndAfter, blend_type)
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonHeadLoopAfter, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonHeadEndAfter_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonHeadEndAfter, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonHeadStartAfterLVL2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_DragonHeadLoopAfterLVL2, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonHeadStartAfterLVL2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonHeadLoopAfterLVL2_Upper_onUpdate()
    local dT = GetDeltaTime()
    dash_dt_sum = dash_dt_sum + dT
    if dash_dt_sum > 0.06499999761581421 then
        dash_dt_sum = 0
        act(1001, -1)
    end
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if 0 >= env(ESD_ENV_DS3ActionDuration, ACTION_ARM_USE_ITEM) then
        ExecEventHalfBlend(Event_DragonHeadEndAfterLVL2, blend_type)
    elseif 0 >= env(ESD_ENV_GetStamina) then
        ExecEventHalfBlend(Event_DragonHeadEndAfterLVL2, blend_type)
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonHeadLoopAfterLVL2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonHeadEndAfterLVL2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonHeadEndAfterLVL2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonFullStartBefore_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_DragonFullEndBefore, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonFullStartBefore, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonFullEndBefore_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonFullEndBefore, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonFullStartAfter_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonFullStartAfter, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function DragonFullStartAfterLVL2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_DragonFullStartAfterLVL2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkNothing_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkNothing, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinking_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_ItemDrinkEnd, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkingMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkEnd, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemShockWeaveStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemShockWeaveStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemShockWeaveEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemShockWeaveEnd, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkStartMP_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEventHalfBlendNoReset(Event_ItemDrinkingMP, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkStartMP, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkingMP_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_ItemDrinkEndMP, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkingMPMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkEndMP_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkEndMP, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkNothingMP_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkNothingMP, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkStartSake_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEventHalfBlendNoReset(Event_ItemDrinkingSake, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkStartSake, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkingSake_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlendNoReset(Event_ItemDrinkEndSake, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkingSakeMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkEndSake_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkEndSake, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemDrinkEmpty_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemDrinkEmpty, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemBackBottle_Upper_onUpdate()
    act("ロックオン中角度固定解除")
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if lower_state == LOWER_IDLE and TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEventAllBody("W_Idle")
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemBackBottle, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemChameleon_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemChameleon, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemOldMonk_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemOldMonk, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemInvalid_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if ItemCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_ItemInvalid, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderRecoverRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderSoulRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderDrinkStartRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEvent("W_ItemLadderDrinkingRight")
        return 
    end
    
end

function ItemLadderDrinkingRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEvent("W_ItemLadderDrinkEndRight")
        return 
    end
    
end

function ItemLadderDrinkEndRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderDrinkStartMPRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEvent("W_ItemLadderDrinkingMPRight")
        return 
    end
    
end

function ItemLadderDrinkingMPRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEvent("W_ItemLadderDrinkEndMPRight")
        return 
    end
    
end

function ItemLadderDrinkEndMPRight_onUpdate()
    ItemLadderDrinkEndRight_onUpdate()
    
end

function ItemLadderDrinkNothingMPRight_onUpdate()
    ItemLadderDrinkNothingRight_onUpdate()
    
end

function ItemLadderDrinkStartSakeRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEvent("W_ItemLadderDrinkingSakeRight")
        return 
    end
    
end

function ItemLadderDrinkingSakeRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEvent("W_ItemLadderDrinkEndSakeRight")
        return 
    end
    
end

function ItemLadderDrinkEndSakeRight_onUpdate()
    ItemLadderDrinkEndRight_onUpdate()
    
end

function ItemLadderDrinkEmptyRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderDrinkNothingRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderInvalidRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderItemCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderRecoverLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderSoulLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderDrinkStartLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEvent("W_ItemLadderDrinkingLeft")
        return 
    end
    
end

function ItemLadderDrinkingLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEvent("W_ItemLadderDrinkEndLeft")
        return 
    end
    
end

function ItemLadderDrinkEndLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderDrinkStartMPLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEvent("W_ItemLadderDrinkingMPLeft")
        return 
    end
    
end

function ItemLadderDrinkingMPLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEvent("W_ItemLadderDrinkEndMPLeft")
        return 
    end
    
end

function ItemLadderDrinkEndMPLeft_onUpdate()
    ItemLadderDrinkEndLeft_onUpdate()
    
end

function ItemLadderDrinkNothingMPLeft_onUpdate()
    ItemLadderDrinkNothingLeft_onUpdate()
    
end

function ItemLadderDrinkEmptyLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderDrinkNothingLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function ItemLadderDrinkStartSakeLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEvent("W_ItemLadderDrinkingSakeLeft")
        return 
    end
    
end

function ItemLadderDrinkingSakeLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEvent("W_ItemLadderDrinkEndSakeLeft")
        return 
    end
    
end

function ItemLadderDrinkEndSakeLeft_onUpdate()
    ItemLadderDrinkEndLeft_onUpdate()
    
end

function ItemLadderInvalidLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderItemCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function Gesture_Activate()
    ActivateRightArmAdd(START_FRAME_NONE)
    
end

function Gesture_Update()
    UpdateRightArmAdd()
    
end

function GestureStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if GestureCommonFunction(blend_type) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GestureStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function GestureLoopStart_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if GestureLoopCommonFunction(blend_type, lower_state, TRUE) == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        ExecEventHalfBlend(Event_GestureLoop, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GestureLoopStart, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function GestureLoop_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if GestureLoopCommonFunction(blend_type, lower_state, FALSE) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GestureLoop, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function GestureEnd_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if GestureCommonFunction() == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_GestureEnd, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function Magic_Upper_Activate()
    if IsAttackMagic(GetVariable("IndexMagicType")) then
        SetInterruptType(INTERRUPT_FINDATTACK)
    end
    
end

function MagicRight_Upper_Activate()
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
    end
    
end

function MagicLeft_Upper_Activate()
    SetAttackHand(HAND_LEFT)
    
end

function MagicLaunchRight_Upper_onActivate()
    act("魔法ID切り替え無効")
    
end

function MagicLaunchRight_Upper_onUpdate()
    act("魔法ID切り替え無効")
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsAnimEndBySkillCancel) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        local style = c_Style
        local hand = HAND_RIGHT
        if style == HAND_LEFT_BOTH then
            hand = HAND_LEFT
        end
        local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
        local button = ACTION_ARM_R1
        if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
            button = ACTION_ARM_R2
        end
        if TRUE == IsHoldMagic() then
            if env(ESD_ENV_DS3ActionDuration, button) > 0 then
                ExecEventHalfBlend(Event_MagicLoopRight, blend_type)
                return 
            else
                ExecEventHalfBlend(Event_MagicFireRight, blend_type)
                return 
            end
        elseif TRUE == IsQuickMagic() then
            ExecEventHalfBlend(Event_QuickMagicFireRightNormal, blend_type)
            return 
        else
            ExecEventHalfBlend(Event_MagicFireRight, blend_type)
            return 
        end
    end
    if HalfBlendLowerCommonFunction(Event_MagicLaunchRight, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicLaunchRightSA_Upper_onActivate()
    act("魔法ID切り替え無効")
    
end

function MagicLaunchRightSA_Upper_onUpdate()
    act("魔法ID切り替え無効")
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsAnimEndBySkillCancel) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if TRUE == IsHoldMagic() then
            if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
                ExecEventHalfBlend(Event_MagicLoopRightSA, blend_type)
                return 
            else
                ExecEventHalfBlend(Event_MagicFireRight, blend_type)
                return 
            end
        else
            ExecEventHalfBlend(Event_MagicFireRight, blend_type)
            return 
        end
    end
    if HalfBlendLowerCommonFunction(Event_MagicLaunchRightSA, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicLoopRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 45, 45)
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    local magic_type = env(ESD_ENV_GetMagicAnimType)
    if magic_type >= 254 then
        ExecEventHalfBlend(Event_MagicFireRight, blend_type)
        return 
    end
    local style = c_Style
    local hand = HAND_RIGHT
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    local button = ACTION_ARM_R1
    if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
        button = ACTION_ARM_R2
    end
    if env(ESD_ENV_DS3ActionDuration, button) <= 0 then
        ExecEventHalfBlend(Event_MagicFireRight, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicLoopRight, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    if magic_type == MAGIC_REQUEST_SLASHHOLD and TRUE == env(ESD_ENV_IsAnimEndBySkillCancel) then
        ExecEventHalfBlend(Event_MagicLoopRightLvl2, blend_type)
    end
    
end

function MagicLoopRightSA_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 45, 45)
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if env(ESD_ENV_GetMagicAnimType) >= 254 then
        ExecEventHalfBlend(Event_MagicFireRight, blend_type)
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 then
        ExecEventHalfBlend(Event_MagicFireRight, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicLoopRightSA, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicLoopRightLvl2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 45, 45)
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if env(ESD_ENV_GetMagicAnimType) >= 254 then
        ExecEventHalfBlend(Event_MagicFireRightLvl2, blend_type)
        return 
    end
    local style = c_Style
    local hand = HAND_RIGHT
    if style == HAND_LEFT_BOTH then
        hand = HAND_LEFT
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, hand)
    local button = ACTION_ARM_R1
    if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
        button = ACTION_ARM_R2
    end
    if env(ESD_ENV_DS3ActionDuration, button) <= 0 then
        ExecEventHalfBlend(Event_MagicFireRightLvl2, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicLoopRightLvl2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicFireRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    SetVariable("IndexThrowHand", HAND_RIGHT)
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRight, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicFireRight2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    SetVariable("IndexThrowHand", HAND_RIGHT)
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRight2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicFireRight3_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    SetVariable("IndexThrowHand", HAND_RIGHT)
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRight2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicFireRightLvl2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    SetVariable("IndexThrowHand", HAND_RIGHT)
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireRightLvl2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicLaunchLeft_Upper_onActivate()
    act("魔法ID切り替え無効")
    
end

function MagicLaunchLeft_Upper_onUpdate()
    act("魔法ID切り替え無効")
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsAnimEndBySkillCancel) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
        local button = ACTION_ARM_L1
        if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
            button = ACTION_ARM_L2
        end
        if TRUE == IsHoldMagic() then
            if env(ESD_ENV_DS3ActionDuration, button) > 0 then
                ExecEventHalfBlend(Event_MagicLoopLeft, blend_type)
                return 
            else
                ExecEventHalfBlend(Event_MagicFireLeft, blend_type)
                return 
            end
        elseif TRUE == IsQuickMagic() then
            ExecEventHalfBlend(Event_QuickMagicFireLeftNormal, blend_type)
            return 
        else
            ExecEventHalfBlend(Event_MagicFireLeft, blend_type)
            return 
        end
    end
    if HalfBlendLowerCommonFunction(Event_MagicLaunchLeft, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicLaunchLeftSA_Upper_onActivate()
    act("魔法ID切り替え無効")
    
end

function MagicLaunchLeftSA_Upper_onUpdate()
    act("魔法ID切り替え無効")
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if blend_type ~= UPPER and TRUE == ExecQuickTurn(LOWER) then
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsAnimEndBySkillCancel) or TRUE == env(ESD_ENV_IsAnimEnd, 1) then
        if TRUE == IsHoldMagic() then
            if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) > 0 then
                ExecEventHalfBlend(Event_MagicLoopLeftSA, blend_type)
                return 
            else
                ExecEventHalfBlend(Event_MagicFireLeft, blend_type)
                return 
            end
        else
            ExecEventHalfBlend(Event_MagicFireLeft, blend_type)
            return 
        end
    end
    if HalfBlendLowerCommonFunction(Event_MagicLaunchLeftSA, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicLoopLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 45, 45)
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    local magic_type = env(ESD_ENV_GetMagicAnimType)
    if magic_type >= 254 then
        ExecEventHalfBlend(Event_MagicFireRight, blend_type)
        return 
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    local button = ACTION_ARM_L1
    if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
        button = ACTION_ARM_L2
    end
    if env(ESD_ENV_DS3ActionDuration, button) <= 0 then
        ExecEventHalfBlend(Event_MagicFireLeft, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicLoopLeft, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    if magic_type == MAGIC_REQUEST_SLASHHOLD and TRUE == env(ESD_ENV_IsAnimEndBySkillCancel) then
        ExecEventHalfBlend(Event_MagicLoopLeftLvl2, blend_type)
    end
    
end

function MagicLoopLeftSA_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 45, 45)
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if env(ESD_ENV_GetMagicAnimType) >= 254 then
        ExecEventHalfBlend(Event_MagicFireLeft, blend_type)
        return 
    end
    if env(ESD_ENV_DS3ActionDuration, ACTION_ARM_L2) <= 0 then
        ExecEventHalfBlend(Event_MagicFireLeft, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicLoopLeftSA, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicLoopLeftLvl2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 45, 45)
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if env(ESD_ENV_GetMagicAnimType) >= 254 then
        ExecEventHalfBlend(Event_MagicFireLeftLvl2, blend_type)
        return 
    end
    local sp_kind = env(ESD_ENV_DS3GetEquipWeaponSpecialCategoryNumber, HAND_LEFT)
    local button = ACTION_ARM_L1
    if sp_kind == 178 or sp_kind == 207 or sp_kind == 217 or sp_kind == 220 or sp_kind == 234 or sp_kind == 257 then
        button = ACTION_ARM_L2
    end
    if env(ESD_ENV_DS3ActionDuration, button) <= 0 then
        ExecEventHalfBlend(Event_MagicFireLeftLvl2, blend_type)
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicLoopLeftLvl2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicFireLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    SetVariable("IndexThrowHand", HAND_LEFT)
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeft, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicFireLeft2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    SetVariable("IndexThrowHand", HAND_LEFT)
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeft2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicFireLeft3_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    SetVariable("IndexThrowHand", HAND_LEFT)
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeft2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicFireLeftLvl2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    SetVariable("IndexThrowHand", HAND_LEFT)
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicFireLeftLvl2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireRightNormal_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightNormal, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireRightDash_Upper_onActivate()
    act("ロックオン中角度固定解除")
    
end

function QuickMagicFireRightDash_Upper_onUpdate()
    act("ロックオン中角度固定解除")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightDash, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireRightStep_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightStep, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireRightAttackRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightAttackRight, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireRightAttackRight2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightAttackRight2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireRightAttackLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightAttackLeft, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireRightAttackLeft2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireRightAttackLeft2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireLeftNormal_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftNormal, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireLeftDash_Upper_onActivate()
    act("ロックオン中角度固定解除")
    
end

function QuickMagicFireLeftDash_Upper_onUpdate()
    act("ロックオン中角度固定解除")
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftDash, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireLeftStep_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftStep, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireLeftAttackRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftAttackRight, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireLeftAttackRight2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftAttackRight2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireLeftAttackLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_COMBO) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftAttackLeft, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function QuickMagicFireLeftAttackLeft2_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if lower_state == LOWER_TURN or lower_state == LOWER_END_TURN then
        act("魔法ID切り替え無効")
    end
    if MagicCommonFunction(blend_type, QUICKTYPE_ATTACK) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_QuickMagicFireLeftAttackLeft2, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicInvalidRight_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicInvalidRightMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function MagicInvalidLeft_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if MagicCommonFunction(ALLBODY, QUICKTYPE_NORMAL) == TRUE then
        return 
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_MagicInvalidLeftMirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function ThrowBackStab_Activate()
    act("バックスタブ発動")
    local style = c_Style
    if style == HAND_LEFT_BOTH then
        SetAttackHand(HAND_LEFT)
    else
        SetAttackHand(HAND_RIGHT)
    end
    
end

function ThrowBackStab_onUpdate()
    if env(ESD_ENV_DS3HasThrowRequest) == FALSE then
        if BackStabCommonFunction() == TRUE then
            return 
        end
    else
        ResetRequest()
        return 
    end
    
end

function Throw_Activate()
    ResetRequest()
    SetVariable("MoveSpeedLevelReal", 0)
    SetThrowInvalid()
    local id = env(ESD_ENV_GetThrowAnimID)
    local style = c_Style
    if id >= 0 then
        SetVariable("ThrowID", id)
    end
    if IsNodeActive("MagicFireLeft_Upper_Selector", "OneShotFullLeftStart Selector") == TRUE then
        SetAttackHand(HAND_LEFT)
    elseif IsNodeActive("MagicFireRight_Upper_Selector", "OneShotFullRightStart Selector") == TRUE then
        if style == HAND_LEFT_BOTH then
            SetAttackHand(HAND_LEFT)
        else
            SetAttackHand(HAND_RIGHT)
        end
    else
        local style = c_Style
        if style == HAND_LEFT_BOTH then
            SetAttackHand(HAND_LEFT)
        else
            SetAttackHand(HAND_RIGHT)
        end
    end
    SetVariable("ThrowHoldBlendWeight", 0)
    SetVariable("ThrowHolding", false)
    SetVariable("ThrowNoRegistTime", 0)
    
end

function Throw_Update()
    SetThrowInvalid()
    
end

function Throw_Deactivate()
    act(139)
    
end

function ThrowAtk_onActivate()
    Replanning()
    
end

function ThrowAtk_onUpdate()
    if ThrowCommonFunction(FALSE) == TRUE then
        act(139)
        return 
    end
    
end

function ThrowDef_onActivate()
    Replanning()
    
end

function ThrowDef_onUpdate()
    SetThrowDefBlendWeight()
    if env(ESD_ENV_IsThrowSelfDeath) == TRUE then
        ExecEvent("ThrowDeath")
        return 
    end
    if env(ESD_ENV_IsThrowSuccess) == TRUE then
        ExecEvent("W_ThrowEscape")
        return 
    end
    if TRUE == ThrowCommonFunction(ESTEP_DOWN) then
        act(139)
        return 
    end
    
end

function ThrowEscape_onUpdate()
    if ThrowCommonFunction() == TRUE then
        act(139)
        return 
    end
    
end

function ThrowDeath_onActivate()
    act(136, THROW_TYPE_DEATH)
    
end

function ThrowDeathIdle_onActivate()
    act(136, THROW_TYPE_INVALID)
    
end

function Event_Activate()
    ResetEventState()
    ActivateRightArmAdd(START_FRAME_NONE)
    SetVariable("IsEventActivate", true)
    
end

function Event_RightArmAddStartFrame_Activate()
    ResetEventState()
    ActivateRightArmAdd(START_FRAME_ALL)
    SetVariable("IsEventActivate", true)
    
end

function Event_Update()
    if GetVariable("IsEventActivate") == false then
        UpdateRightArmAdd()
    end
    SetVariable("IsEventActivate", false)
    
end

function Event26001_onActivate()
    act(9105, 90)
    
end

function Event26001_onUpdate()
    act(9104)
    if env(ESD_ENV_GetEventEzStateFlag, 0) == FALSE then
        act(9102)
    end
    if QuickTurnCommonFunction() == TRUE then
        return 
    end
    
end

function Event26011_onActivate()
    act(9105, 90)
    
end

function Event26011_onUpdate()
    act(9104)
    if env(ESD_ENV_GetEventEzStateFlag, 0) == FALSE then
        act(9102)
    end
    if QuickTurnCommonFunction() == TRUE then
        return 
    end
    
end

function Event26021_onActivate()
    act(9105, 180)
    
end

function Event26021_onUpdate()
    act(9104)
    if env(ESD_ENV_GetEventEzStateFlag, 0) == FALSE then
        act(9102)
    end
    if QuickTurnCommonFunction() == TRUE then
        return 
    end
    
end

function Event26031_onActivate()
    act(9105, 180)
    
end

function Event26031_onUpdate()
    act(9104)
    if env(ESD_ENV_GetEventEzStateFlag, 0) == FALSE then
        act(9102)
    end
    if QuickTurnCommonFunction() == TRUE then
        return 
    end
    
end

function Event60000_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60000_onDeactivate()
    act(138, FALSE)
    
end

function Event60001_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60001_onDeactivate()
    act(138, FALSE)
    
end

function Event60002_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60002_onDeactivate()
    act(138, FALSE)
    
end

function Event60003_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60003_onDeactivate()
    act(138, FALSE)
    
end

function Event60010_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60020_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60030_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60030_onDeactivate()
    act(138, FALSE)
    
end

function Event60040_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60060_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60070_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60070_onDeactivate()
    act(138, FALSE)
    
end

function Event60080_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60090_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60090_onDeactivate()
    act(138, FALSE)
    
end

function Event60100_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60160_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60160_onDeactivate()
    act(138, FALSE)
    
end

function Event60170_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60170_onDeactivate()
    act(138, FALSE)
    
end

function Event60180_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60180_onDeactivate()
    act(138, FALSE)
    
end

function Event60190_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60190_onDeactivate()
    act(138, FALSE)
    
end

function Event60200_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60202_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60210_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60220_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60230_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60231_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60240_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60241_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60250_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60260_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60270_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60370_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event60380_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60390_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60400_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60410_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60420_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60430_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60440_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60750_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60760_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60780_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60790_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60800_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event60810_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event61000_Upper_onUpdate()
    local blend_type, lower_state = GetHalfBlendInfo()
    if DamageHalfBlendCommonFunction(blend_type) == TRUE then
        return 
    end
    if lower_state == LOWER_IDLE then
        act("ロックオン時システム旋回不可角度", 90, 90)
    end
    if HalfBlendUpperCommonFunction(lower_state) == TRUE then
        return 
    end
    if HalfBlendLowerCommonFunction(Event_Event61000Mirror, lower_state, FALSE, FALSE) == TRUE then
        return 
    end
    
end

function Event63000_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event63010_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event63020_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event63060_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event63070_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event65012_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event65013_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event69000_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event69001_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event69001_onDeactivate()
    act(138, FALSE)
    
end

function Event69002_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event69003_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event69003_onDeactivate()
    act(138, FALSE)
    
end

function Event69010_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event69030_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event69040_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event69050_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event69060_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event69070_onUpdate()
    act(9102)
    
end

function Event90360_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90361_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90370_onUpdate()
    act(9102)
    
end

function Event90970_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90430_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_DS3IsConversationEnd) then
        ExecEvent("W_Event90450")
        return 
    end
    
end

function Event90460_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event90510")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE then
        ExecEvent("W_Event90500")
        return 
    end
    
end

function Event90470_onUpdate()
    Event90460_onUpdate()
    
end

function Event90480_onUpdate()
    Event90460_onUpdate()
    
end

function Event90490_onUpdate()
    act(9102)
    
end

function Event90500_onUpdate()
    Event90460_onUpdate()
    
end

function Event90510_onUpdate()
    act(9102)
    
end

function Event90550_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event90600")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE then
        ExecEvent("W_Event90590")
        return 
    end
    
end

function Event90560_onUpdate()
    Event90550_onUpdate()
    
end

function Event90570_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event90600")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE then
        ExecEvent("W_Event90590")
        return 
    end
    if TRUE == env(ESD_ENV_DS3IsConversationEnd) then
        ExecEvent("W_Event90560")
        return 
    end
    
end

function Event90580_onUpdate()
    act(9102)
    
end

function Event90590_onUpdate()
    Event90550_onUpdate()
    
end

function Event90600_onUpdate()
    act(9102)
    
end

function Event90610_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event90990")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE then
        ExecEvent("W_Event90930")
        return 
    end
    
end

function Event90620_onUpdate()
    Event90610_onUpdate()
    
end

function Event90630_onUpdate()
    Event90610_onUpdate()
    
end

function Event90640_onUpdate()
    act(9102)
    
end

function Event90641_onUpdate()
    act(9102)
    
end

function Event90680_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90690_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90960_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90691_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90710_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90720_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90721_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90390_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90400_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    if TRUE == env(ESD_ENV_DS3IsConversationEnd) then
        ExecEvent("W_Event90390")
        return 
    end
    
end

function Event90410_onUpdate()
    act(9102)
    
end

function Event90420_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90450_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90650_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90660_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90671_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90810_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90820_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90900_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90300_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90730_onUpdate()
    Event90610_onUpdate()
    
end

function Event90930_onUpdate()
    Event90610_onUpdate()
    
end

function Event90980_onUpdate()
    Event90550_onUpdate()
    
end

function Event90990_onUpdate()
    act(9102)
    
end

function Event90991_onDeactivate()
    function Event90830_onUpdate()
        if EventCommonFunction() == TRUE then
            return 
        end
        
    end

    function Event90831_onUpdate()
        if EventCommonFunction() == TRUE then
            return 
        end
        
    end

    
end

function Event90840_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90841_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90850_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90851_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90860_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90861_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90870_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90890_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90740_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90750_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90760_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90780_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90800_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event90950")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE then
        ExecEvent("W_Event90940")
        return 
    end
    
end

function Event90801_onUpdate()
    Event90800_onUpdate()
    
end

function Event90940_onUpdate()
    Event90800_onUpdate()
    
end

function Event90950_onUpdate()
    act(9102)
    
end

function Event90340_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event99999_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90250_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90260_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90270_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event90280_onUpdate()
    act(9102)
    act(138, TRUE)
    
end

function Event90290_onUpdate()
    act(9102)
    act(138, TRUE)
    
end

function Event90291_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event90291_onDeactivate()
    act(138, FALSE)
    
end

function Event91010_onUpdate()
    act(9102)
    act(138, TRUE)
    
end

function Event91011_onUpdate()
    act(9102)
    act(138, TRUE)
    
end

function Event91012_onUpdate()
    act(138, TRUE)
    if TRUE == EventCommonFunction() then
        act(138, FALSE)
        return 
    end
    
end

function Event91012_onDeactivate()
    act(138, FALSE)
    
end

function Event91013_onUpdate()
    act(9102)
    act(138, TRUE)
    
end

function Event91020_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91030_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91040_onUpdate()
    act(9102)
    
end

function Event91050_onUpdate()
    act(9102)
    
end

function Event91051_onUpdate()
    act(9102)
    
end

function Event91052_onUpdate()
    act(9102)
    
end

function Event91060_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event91061")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE and TRUE == env(ESD_ENV_HasReceivedAnyDamage) then
        ExecEvent("W_Event91070")
        return 
    end
    
end

function Event91061_onUpdate()
    act(9102)
    
end

function Event91070_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event91061")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE and TRUE == env(ESD_ENV_HasReceivedAnyDamage) then
        ExecEvent("W_Event91070")
        return 
    end
    
end

function Event91080_onUpdate()
    act(9102)
    SetThrowDefInvalid()
    if IsDead() == TRUE then
        ExecDeath()
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE and TRUE == env(ESD_ENV_HasReceivedAnyDamage) then
        ExecEvent("W_Event91090")
        return 
    end
    
end

function Event91090_onActivate()
    SetThrowDefInvalid()
    
end

function Event91090_onUpdate()
    SetThrowDefInvalid()
    act(9102)
    
end

function Event91100_onUpdate()
    act(9102)
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE and env(ESD_ENV_HasReceivedAnyDamage) == TRUE then
        ExecEvent("W_Event91110")
        return 
    end
    
end

function Event91120_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event91061")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE and TRUE == env(ESD_ENV_HasReceivedAnyDamage) then
        ExecEvent("W_Event91070")
        return 
    end
    
end

function Event91130_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event91061")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE and TRUE == env(ESD_ENV_HasReceivedAnyDamage) then
        ExecEvent("W_Event91070")
        return 
    end
    
end

function Event91140_onUpdate()
    act(9102)
    if IsDead() == TRUE then
        ExecEvent("W_Event91061")
        return 
    end
    if env(ESD_ENV_GetDamageLevel) > DAMAGE_LEVEL_NONE and TRUE == env(ESD_ENV_HasReceivedAnyDamage) then
        ExecEvent("W_Event91070")
        return 
    end
    
end

function Event91150_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91160_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91170_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91180_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91190_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91200_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91210_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91220_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function Event91230_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function BonfireInitialize_onUpdate()
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function BonfireStart_onActivate()
    act("貪欲者の印スリップダメージ無効")
    
end

function BonfireStart_onUpdate()
    act("貪欲者の印スリップダメージ無効")
    if env(ESD_ENV_IsAnimEnd, 1) == FALSE then
        act(9102)
    end
    
end

function BonfireLoop_onActivate()
    act("貪欲者の印スリップダメージ無効")
    
end

function BonfireLoop_onUpdate()
    act("貪欲者の印スリップダメージ無効")
    act(9102)
    act(138, TRUE)
    
end

function BonfireLoop_onDeactivate()
    act(138, FALSE)
    
end

function BonfireEnd_onActivate()
    act("貪欲者の印スリップダメージ無効")
    
end

function BonfireEnd_onUpdate()
    act("貪欲者の印スリップダメージ無効")
    if EventCommonFunction() == TRUE then
        return 
    end
    
end

function BonfireGiveHeroPoint_onActivate()
    act("貪欲者の印スリップダメージ無効")
    
end

function BonfireGiveHeroPoint_onUpdate()
    act("貪欲者の印スリップダメージ無効")
    act(9102)
    
end

function BonfireWarp_onActivate()
    act("貪欲者の印スリップダメージ無効")
    
end

function BonfireWarp_onUpdate()
    act("貪欲者の印スリップダメージ無効")
    act(9102)
    
end

function BonfireWarp2_onActivate()
    act("貪欲者の印スリップダメージ無効")
    
end

function BonfireWarp2_onUpdate()
    act("貪欲者の印スリップダメージ無効")
    act(9102)
    
end

function BonfireWarpEnd_onActivate()
    act("貪欲者の印スリップダメージ無効")
    
end

function BonfireWarpEnd_onUpdate()
    act("貪欲者の印スリップダメージ無効")
    act(9102)
    
end

function BonfireHumanRestore_onActivate()
    act("貪欲者の印スリップダメージ無効")
    
end

function BonfireHumanRestore_onUpdate()
    act("貪欲者の印スリップダメージ無効")
    if env(ESD_ENV_IsAnimEnd, 1) == FALSE then
        act(9102)
    end
    
end

function Ladder_Activate()
    act(145)
    Flag_LadderDamage = LADDER_DAMAGE_NONE
    Flag_LadderJump = LADDER_JUMP_INVALID
    SetThrowInvalid()
    
end

function Ladder_Update()
    SetThrowInvalid()
    LadderSetActionState(INVALID)
    
end

function LadderAttachBottom_onUpdate()
    if env(ESD_ENV_IsObjActInterpolatedMotion) == TRUE then
        return 
    end
    ExecEvent("W_LadderStartBottom")
    
end

function LadderAttachTop_onUpdate()
    if env(ESD_ENV_IsObjActInterpolatedMotion) == TRUE then
        return 
    end
    ExecEvent("W_LadderStartTop")
    
end

function LadderStartTop_onActivate()
    act(145)
    
end

function LadderStartTop_onUpdate()
    LadderSetActionState(LADDER_ACTION_START_TOP)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return 
    end
    
end

function LadderStartBottom_onActivate()
    act(145)
    
end

function LadderStartBottom_onUpdate()
    LadderSetActionState(LADDER_ACTION_START_BOTTOM)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return 
    end
    
end

function LadderUpRight_onActivate()
    LadderSendCommand(LADDER_CALL_UP)
    
end

function LadderUpRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_UP_RIGHT)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function LadderUpLeft_onActivate()
    LadderSendCommand(LADDER_CALL_UP)
    
end

function LadderUpLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_UP_LEFT)
    if LadderMoveCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function LadderDownLeft_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
    
end

function LadderDownLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_DOWN_LEFT)
    if LadderMoveCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function LadderDownRight_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
    
end

function LadderDownRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_DOWN_RIGHT)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function LadderEndBottomLeft_onActivate()
    LadderSendCommand(LADDER_EVENT_COMMAND_EXIT)
    
end

function LadderEndBottomLeft_onUpdate()
    if LadderEndCommonFunction() == TRUE then
        return 
    end
    
end

function LadderEndBottomRight_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
    
end

function LadderEndBottomRight_onUpdate()
    if LadderEndCommonFunction() == TRUE then
        return 
    end
    
end

function LadderEndTopLeft_onActivate()
    LadderSendCommand(LADDER_CALL_UP)
    
end

function LadderEndTopLeft_onUpdate()
    if LadderEndCommonFunction() == TRUE then
        return 
    end
    
end

function LadderEndTopRight_onActivate()
    LadderSendCommand(LADDER_CALL_UP)
    
end

function LadderEndTopRight_onUpdate()
    if LadderEndCommonFunction() == TRUE then
        return 
    end
    
end

function LadderIdleLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_LEFT)
    if LadderIdleCommonFunction(HAND_STATE_LEFT) == TRUE then
        return 
    end
    
end

function LadderIdleRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_IDLE_RIGHT)
    if LadderIdleCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return 
    end
    
end

function LadderAttackUpRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_ATTACK_UP_RIGHT)
    if LadderAttackCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return 
    end
    
end

function LadderAttackUpLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_ATTACK_UP_LEFT)
    if LadderAttackCommonFunction(HAND_STATE_LEFT) == TRUE then
        return 
    end
    
end

function LadderAttackDownRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_ATTACK_DOWN_RIGHT)
    if LadderAttackCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return 
    end
    
end

function LadderAttackDownLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_ATTACK_DOWN_RIGHT)
    if LadderAttackCommonFunction(HAND_STATE_LEFT) == TRUE then
        return 
    end
    
end

function LadderCoastStart_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_START)
    if LadderCoastCommonFunction(HAND_STATE_LEFT, TRUE) == TRUE then
        return 
    end
    
end

function LadderCoastRight_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
    
end

function LadderCoastRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_RIGHT)
    if LadderCoastCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function LadderCoastLeft_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
    
end

function LadderCoastLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_LEFT)
    if LadderCoastCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function LadderCoastStopLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_STOP)
    if LadderMoveCommonFunction(HAND_STATE_LEFT, FALSE) == TRUE then
        return 
    end
    
end

function LadderCoastStopRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_COAST_STOP)
    if LadderMoveCommonFunction(HAND_STATE_RIGHT, FALSE) == TRUE then
        return 
    end
    
end

function LadderCoastLanding_onActivate()
    LadderSendCommand(LADDER_CALL_DOWN)
    
end

function LadderCoastLanding_onUpdate()
    if LadderEndCommonFunction() == TRUE then
        return 
    end
    
end

function LadderDamageLargeRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_DAMAGE_LARGE)
    if LadderDamageCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return 
    end
    
end

function LadderDamageSmallRight_onUpdate()
    LadderSetActionState(LADDER_ACTION_DAMAGE_SMALL)
    if LadderDamageCommonFunction(HAND_STATE_RIGHT) == TRUE then
        return 
    end
    
end

function LadderDamageLargeLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_DAMAGE_LARGE)
    if LadderDamageCommonFunction(HAND_STATE_LEFT) == TRUE then
        return 
    end
    
end

function LadderDamageSmallLeft_onUpdate()
    LadderSetActionState(LADDER_ACTION_DAMAGE_SMALL)
    if LadderDamageCommonFunction(HAND_STATE_LEFT) == TRUE then
        return 
    end
    
end

function LadderDeathStart_onActivate()
    LadderSendCommand(LADDER_EVENT_COMMAND_EXIT)
    
end

function LadderDeathLoop_onUpdate()
    if env(ESD_ENV_IsLanding) == TRUE then
        ExecEvent("LadderDeathLand")
    end
    local height = env(ESD_ENV_GetFallHeight) / 100
    if height > 60 then
        ExecEvent("W_LadderDeathIdle")
    end
    
end

function LadderDeathIdle_onActivate()
    act(126, TRUE)
    
end

function LadderDeathIdle_onDeactivate()
    act(126, FALSE)
    
end

function LadderFallStart_onActivate()
    LadderSendCommand(LADDER_EVENT_COMMAND_EXIT)
    
end

function LadderFallLoop_onUpdate()
    if FallCommonFunction(TRUE, FALSE, FALL_LADDER) == TRUE then
        return 
    end
    
end

function LadderFallLanding_onUpdate()
    if LandCommonFunction() == TRUE then
        return 
    end
    
end

function LadderDrop_onUpdate()
    act(2001, math.random(160, 200) / 100)
    act(147)
    if env(ESD_ENV_IsFalling) == TRUE then
        ExecEventAllBody("W_FallLoop")
        return 
    end
    
end

function SlideStart_onActivate()
    SetVariable("SlideAngle", 0)
    act(142, TRUE)
    
end

function SlideStart_onUpdate()
    act(142, TRUE)
    if SlideCommonFunction(TRUE) == TRUE then
        act(142, FALSE)
        return TRUE
    end
    if TRUE == env(ESD_ENV_IsAnimEnd, 0) or TRUE == env(ESD_ENV_GetEventEzStateFlag, 0) then
        ExecEvent("W_SlideLoop")
        return 
    end
    
end

function SlideLoop_onUpdate()
    if SlideCommonFunction(TRUE) == TRUE then
        act(142, FALSE)
        return TRUE
    end
    local turn_angle = hkbGetVariable("TurnAngle")
    local target_val = nil
    if turn_angle > 90 then
        target_val = 90
    elseif turn_angle < -90 then
        target_val = -90
    else
        target_val = turn_angle
    end
    SetVariable("SlideAngle", ConvergeValue(target_val, hkbGetVariable("SlideAngle"), 180, 180))
    
end

function SlideEnd_onActivate()
    act(142, FALSE)
    return TRUE
    
end

function SlideEnd_onUpdate()
    if SlideCommonFunction(FALSE) == TRUE then
        return TRUE
    end
    
end

function Init_onUpdate()
    ResetDamageCount()
    if env(ESD_ENV_IsCOMPlayer) == TRUE then
        local event_id = env(ESD_ENV_GetCommandIDFromEvent, 1)
        if event_id == 800 then
            ExecEvent("W_Event90700")
            return 
        elseif event_id == 1200 then
            ExecEvent("W_Event90380")
            return 
        elseif event_id == 1300 then
            ExecEvent("W_Event91000")
            return 
        elseif event_id == 1700 then
            ExecEvent("W_Event90670")
            return 
        elseif event_id == 1900 then
            ExecEvent("W_Event90770")
            return 
        elseif event_id == 1901 then
            ExecEvent("W_Event90790")
            return 
        end
    end
    ExecEvent("W_Idle")
    return 
    
end

function SetThrowAtkInvalid()
    act(102, THROW_STATE_INVALID)
    
end

function SetThrowDefInvalid()
    act(103, THROW_STATE_INVALID)
    
end

function SetThrowInvalid()
    act(102, THROW_STATE_INVALID)
    act(103, THROW_STATE_INVALID)
    
end

function CultStart1_onActivate()
    ResetEventState()
    act(138, FALSE)
    
end

function CultStart1_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultCont1_onActivate()
    act(138, FALSE)
    
end

function CultCont1_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultEnd1_onActivate()
    act(138, FALSE)
    
end

function CultEnd1_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultInterrupt1_onActivate()
    act(138, FALSE)
    
end

function CultInterrupt1_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultStart2_onActivate()
    ResetEventState()
    act(138, FALSE)
    
end

function CultStart2_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultCont2_onActivate()
    act(138, FALSE)
    
end

function CultCont2_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultEnd2_onActivate()
    act(138, FALSE)
    
end

function CultEnd2_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultInterrupt2_onActivate()
    act(138, FALSE)
    
end

function CultInterrupt2_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultStart3_onActivate()
    ResetEventState()
    act(138, FALSE)
    
end

function CultStart3_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultCont3_onActivate()
    act(138, FALSE)
    
end

function CultCont3_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultEnd3_onActivate()
    act(138, FALSE)
    
end

function CultEnd3_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultInterrupt3_onActivate()
    act(138, FALSE)
    
end

function CultInterrupt3_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultStart4_onActivate()
    ResetEventState()
    act(138, FALSE)
    
end

function CultStart4_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultCont4_onActivate()
    act(138, FALSE)
    
end

function CultCont4_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultEnd4_onActivate()
    act(138, FALSE)
    
end

function CultEnd4_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultInterrupt4_onActivate()
    act(138, FALSE)
    
end

function CultInterrupt4_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultStart5_onActivate()
    ResetEventState()
    act(138, FALSE)
    
end

function CultStart5_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultCont5_onActivate()
    act(138, FALSE)
    
end

function CultCont5_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultEnd5_onActivate()
    act(138, FALSE)
    
end

function CultEnd5_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultInterrupt5_onActivate()
    act(138, FALSE)
    
end

function CultInterrupt5_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultStart6_onActivate()
    ResetEventState()
    act(138, FALSE)
    
end

function CultStart6_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultCont6_onActivate()
    act(138, FALSE)
    
end

function CultCont6_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultEnd6_onActivate()
    act(138, FALSE)
    
end

function CultEnd6_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultInterrupt6_onActivate()
    act(138, FALSE)
    
end

function CultInterrupt6_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultStart7_onActivate()
    ResetEventState()
    act(138, FALSE)
    
end

function CultStart7_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultCont7_onActivate()
    act(138, FALSE)
    
end

function CultCont7_onUpdate()
    if CultCommonFunction(1, FALSE) == TRUE then
        act(138, TRUE)
        return 
    end
    
end

function CultEnd7_onActivate()
    act(138, FALSE)
    
end

function CultEnd7_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function CultInterrupt7_onActivate()
    act(138, FALSE)
    
end

function CultInterrupt7_onUpdate()
    if CultCommonFunction(1, TRUE) == TRUE then
        act(138, TRUE)
        return 
    end
    if env(ESD_ENV_IsAnimEnd, 1) == TRUE then
        act(138, TRUE)
        ExecEventAllBody("W_Idle")
        return 
    end
    
end

function AddDamageDefault_onUpdate()
    SetVariable("AddDamageBlend", 0)
    
end

function AddDamageDefaultGuard_onUpdate()
    SetVariable("AddDamageGuardBlend", 0)
    
end

function SAMagic_Default_onUpdate()
    SetVariable("SAMagicBlendRate", 0)
    
end

function DamageDirNoAdd_onUpdate()
    SetVariable("DamageDirBlendRate", 0)
    
end

function SpeedUpdate()
    local stick_level = GetVariable("MoveSpeedLevel")
    local move_angle = GetVariable("MoveAngle")
    local is_aim = env(ESD_ENV_IsPrecisionShoot)
    local move_id = env(ESD_ENV_GetMoveAnimParamID)
    if is_aim == TRUE then
        stick_level = 0
    elseif move_id == WEIGHT_OVERWEIGHT or move_id == WEIGHT_OVERWEIGHT + 20 or move_id == WEIGHT_OVERWEIGHT + 40 or move_id == WEIGHT_OVERWEIGHT + 60 then
        stick_level = 0
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 130110) == TRUE then
        if stick_level > 1.100000023841858 then
            stick_level = 1
        end
    elseif env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_GRAVITY_MEDIUM) == TRUE then
        stick_level = 0
    elseif env(ESD_ENV_GetStateChangeType, CONDITION_TYPE_GRAVITY_WEAK) == TRUE then
        if stick_level > 1.100000023841858 then
            stick_level = 1
        elseif stick_level > 0 then
            stick_level = 0
        end
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100220) == TRUE then
        stick_level = 2
    elseif env(ESD_ENV_DS3GetSpecialEffectID, 100020) == TRUE then
        if stick_level > 1.100000023841858 then
            stick_level = 1
        end
    elseif GetVariable("MoveType") ~= 3 and stick_level > 0.5 then
        stick_level = 0.5
    end
    if stick_level > 1.100000023841858 then
        if GetVariable("MoveType") == 3 then
            act("ロックオン中角度固定解除")
        end
        SetVariable("MoveSpeedIndex", 2)
    elseif stick_level > 0.6000000238418579 then
        SetVariable("MoveSpeedIndex", 1)
    else
        SetVariable("MoveSpeedIndex", 0)
    end
    local speed = GetMoveSpeed(stick_level)
    SetVariable("MoveSpeedLevelReal", speed)
    if env(ESD_ENV_GetStamina) <= 0 then
        act(2002, 100020)
    end
    if env(ESD_ENV_DS3GetSpecialEffectID, 100002) == TRUE then
        act(110)
        local dT = GetDeltaTime()
        dash_dt_sum = dash_dt_sum + dT
        if dash_dt_sum > 0.06499999761581421 then
            dash_dt_sum = 0
            act(1001, -1)
        end
    end
    
end

function Update()
    GetConstVariable()
    SetStyleSpecialEffect()
    UpdateOldMonkState()
    act(101, FALSE)
    act("ロックオン時システム旋回不可角度", 0, 0)
    SetVariable("LocomotionState", GetLocomotionState())
    SetVariable("ArtsTransition", 0)
    SetMoveType()
    if IsLowerQuickTurn() == TRUE then
        SetVariable("LookAtTwist30_OnGain", 1)
        SetVariable("LookAtTwist60_OnGain", 1)
    else
        SetVariable("LookAtTwist30_OnGain", 0.10000000149011612)
        SetVariable("LookAtTwist60_OnGain", 0.20000000298023224)
    end
    SetSwordArtsCancelType()
    SetGender()
    if FALSE == IsNodeActive("QuickItem_Script", "SwordArtsRight_Script") then
        ClearAttackQueue()
    end
    SetTimeActEditorVariable()
    UpdateFemaleBlend()
    UpdateShoulderTwist()
    UpdateWristTwist()
    g_FrameCount = g_FrameCount + 1
    
end

function ModifiersLayer_onGenerate()
    
end

function Master_onGenerate()
    
end

global = {}
function dummy()
    
end

global.__index = function (table, element)
    return dummy
    
end

setmetatable(_G, global)

end
