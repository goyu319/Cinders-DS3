RegisterTableGoal(GOAL_MoujaSoldier_SwordShield_110000_Battle, "MoujaSoldier_SwordShield_110000_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_MoujaSoldier_SwordShield_110000_Battle, true)
Goal.Initialize = function (self, ai, goal, arg3)
    return 
end

Goal.Activate = function (self, ai, goal)
    local local0 = {}
    local local1 = {}
    local local2 = {}
    Common_Clear_Param(local0, local1, local2)
    Init_Pseudo_Global(ai, goal)
    ai:SetStringIndexedNumber("Dist_SideStep", 2.7 + 1)
    ai:SetStringIndexedNumber("Dist_BackStep", 2.5 + 1)
    local local3 = ai:GetDist(TARGET_ENE_0)
    local local4 = ai:GetDistYSigned(TARGET_ENE_0)
    local local5 = ai:GetEventRequest(0)
    local local6 = ai:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local local7 = ai:GetRandam_Int(1, 100)
    local local8 = ai:GetRandam_Int(1, 100)
    local local9 = 0
    local local10 = 0
    local local11 = 0
    local local12 = 0
    if ai:GetNpcThinkParamID() == 144010 and ai:GetHpRate(TARGET_SELF) <= 0.5 then
        local12 = 1
    end
    if ai:GetNpcThinkParamID() == 110001 then
        local9 = 1
    elseif ai:GetNpcThinkParamID() == 110003 then
        local10 = 1
    end
    if ai:GetNpcThinkParamID() == 110004 then
        local11 = 1
        local10 = 1
    end
    if ai:GetEventRequest(1) == 100 then
        local0[20] = 100
    elseif local6 == 1 and ai:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        local0[11] = 60
        local0[12] = 40
    elseif local6 == 1 and ai:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        local0[1] = 3
        local0[4] = 3
        local0[7] = 6
        local0[8] = 3
        local0[11] = 50
        local0[12] = 35
    elseif ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 240) then
        local0[13] = 100
    elseif local9 == 1 and 8 <= ai:GetAttackPassedTime(3007) and 5 - ai:GetMapHitRadius(TARGET_SELF) <= local3 and local7 <= 65 then
        local0[6] = 100
    elseif local11 == 1 and 13 - ai:GetMapHitRadius(TARGET_SELF) + math.abs(local4) <= local3 and local4 < -2 then
        local0[16] = 100
    elseif local11 == 1 and 5 - ai:GetMapHitRadius(TARGET_SELF) <= local3 and local4 < -2 then
        local0[15] = 100
    elseif local11 == 1 and 5 - ai:GetMapHitRadius(TARGET_SELF) <= local3 and local7 <= 85 then
        local0[9] = 100
    elseif local10 == 1 and 8 <= ai:GetAttackPassedTime(3011) and 5 - ai:GetMapHitRadius(TARGET_SELF) <= local3 and local7 <= 65 then
        local0[9] = 100
    elseif ai:IsTargetGuard(TARGET_ENE_0) and 2.5 < local3 and local3 <= 5 and local8 <= 40 then
        local0[10] = 100
    elseif ai:IsTargetGuard(TARGET_ENE_0) and local3 <= 2.5 and ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 60) and local8 <= 50 then
        local0[10] = 100
    elseif 10 <= local3 then
        local0[1] = 15
        local0[2] = 30
        local0[4] = 5
        local0[7] = 15
        local0[8] = 10
        local0[12] = 15
        local0[14] = 10
        local0[20] = 10 * local12
        local0[21] = 5 * local12
    elseif 5.5 <= local3 then
        local0[1] = 5
        local0[2] = 20
        local0[4] = 5
        local0[7] = 10
        local0[8] = 10
        local0[12] = 20
        local0[14] = 15
        local0[20] = 5 * local12
        local0[21] = 10 * local12
    elseif 3 <= local3 then
        local0[1] = 15
        local0[2] = 15
        local0[4] = 5
        local0[7] = 10
        local0[8] = 10
        local0[12] = 30
        local0[20] = 0 * local12
        local0[21] = 15 * local12
    elseif 1 <= local3 then
        local0[1] = 15
        local0[2] = 0
        local0[4] = 5
        local0[7] = 10
        local0[8] = 15
        local0[12] = 30
        local0[14] = 20
        local0[20] = 0 * local12
        local0[21] = 5 * local12
    else
        local0[1] = 30
        local0[2] = 0
        local0[4] = 15
        local0[7] = 15
        local0[8] = 20
        local0[12] = 0
        local0[14] = 20
        local0[20] = 0 * local12
        local0[21] = 0 * local12
    end
    local1[1] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act01)
    local1[2] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act02)
    local1[4] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act04)
    local1[5] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act05)
    local1[6] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act06)
    local1[7] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act07)
    local1[8] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act08)
    local1[9] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act09)
    local1[10] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act10)
    local1[11] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act11)
    local1[12] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act12)
    local1[13] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act13)
    local1[14] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act14)
    local1[15] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act15)
    local1[16] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act16)
    local1[20] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act20)
    local1[21] = REGIST_FUNC(ai, goal, MoujaSoldier110000_Act21)
    Common_Battle_Activate(ai, goal, local0, local1, REGIST_FUNC(ai, goal, MoujaSoldier110000_ActAfter_AdjustSpace), local2)
    return 
end

function MoujaSoldier110000_Act01(self, ai, goal)
    Approach_Act_Flex(self, ai, 3.2 - self:GetMapHitRadius(TARGET_SELF), 3.2 - self:GetMapHitRadius(TARGET_SELF) + 1, 3.2 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = 3000
    local local1 = 3001
    local local2 = 2.4 - self:GetMapHitRadius(TARGET_SELF) + 1
    local local3 = 5 - self:GetMapHitRadius(TARGET_SELF)
    local local4 = 0
    local local5 = 0
    local local6 = self:GetRandam_Int(1, 100)
    if local6 <= 35 then
        ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, local0, TARGET_ENE_0, local3, local4, local5, 0, 0)
    elseif local6 <= 75 then
        ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, local0, TARGET_ENE_0, local2, local4, local5, 0, 0)
        ai:AddSubGoal(GOAL_COMMON_ComboFinal, 10, local1, TARGET_ENE_0, local3, 0, 0)
    else
        ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, local0, TARGET_ENE_0, local2, local4, local5, 0, 0)
        ai:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, local1, TARGET_ENE_0, 3.9 - self:GetMapHitRadius(TARGET_SELF) + 1, 0, 0)
        ai:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, local3, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act02(self, ai, goal)
    Approach_Act_Flex(self, ai, 7 - self:GetMapHitRadius(TARGET_SELF), 7 - self:GetMapHitRadius(TARGET_SELF) + 1, 7 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 5 - self:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act04(self, ai, goal)
    Approach_Act_Flex(self, ai, 3.5 - self:GetMapHitRadius(TARGET_SELF), 3.5 - self:GetMapHitRadius(TARGET_SELF) + 1, 3.5 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, 5 - self:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act05(self, ai, goal)
    Approach_Act_Flex(self, ai, 2.3 - self:GetMapHitRadius(TARGET_SELF), 2.3 - self:GetMapHitRadius(TARGET_SELF) + 1, 2.3 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 5 - self:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act06(self, ai, goal)
    Approach_Act_Flex(self, ai, 13 - self:GetMapHitRadius(TARGET_SELF), 13 - self:GetMapHitRadius(TARGET_SELF) + 1, 13 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 50, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, 5 - self:GetMapHitRadius(TARGET_SELF), -1, 45, 0, 0)
    local local1 = ai:AddSubGoal(GOAL_COMMON_Wait, self:GetRandam_Float(1.4, 2.2), TARGET_ENE_0, 0, 0, 0)
    local1:SetTargetRange(0, 4, 999)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act07(self, ai, goal)
    Approach_Act_Flex(self, ai, 3.5 - self:GetMapHitRadius(TARGET_SELF), 3.5 - self:GetMapHitRadius(TARGET_SELF) + 1, 3.5 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3008, TARGET_ENE_0, 5 - self:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act08(self, ai, goal)
    Approach_Act_Flex(self, ai, 2.2 - self:GetMapHitRadius(TARGET_SELF), 2.2 - self:GetMapHitRadius(TARGET_SELF) + 1, 2.2 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 5 - self:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act09(self, ai, goal)
    Approach_Act_Flex(self, ai, 13 - self:GetMapHitRadius(TARGET_SELF), 13 - self:GetMapHitRadius(TARGET_SELF) + 1, 13 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 50, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 5 - self:GetMapHitRadius(TARGET_SELF), -1, 45, 0, 0)
    local local1 = ai:AddSubGoal(GOAL_COMMON_Wait, self:GetRandam_Float(1.4, 2.2), TARGET_ENE_0, 0, 0, 0)
    local1:SetTargetRange(0, 4, 999)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act10(self, ai, goal)
    Approach_Act_Flex(self, ai, 2.8 - self:GetMapHitRadius(TARGET_SELF), 2.8 - self:GetMapHitRadius(TARGET_SELF) + 1, 2.8 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_GuardBreakTunable, 10, 3004, TARGET_ENE_0, 13 - self:GetMapHitRadius(TARGET_SELF) + 1, 0, 0, 0, 0)
    ai:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3008, TARGET_ENE_0, 5 - self:GetMapHitRadius(TARGET_SELF), 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act11(self, ai, goal)
    local local0 = self:GetDist(TARGET_ENE_0)
    local local1 = 10
    if local1 <= self:GetDist(TARGET_ENE_0) then
        Approach_Act(self, ai, local1, 12, 75, 3)
    end
    ai:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, 10, TARGET_ENE_0, true, 9910)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act12(self, ai, goal)
    local local0 = 100
    if 8 <= self:GetDist(TARGET_ENE_0) then
        local0 = 75
    end
    local local1 = -1
    if self:GetRandam_Int(1, 100) <= local0 then
        local1 = 9910
    end
    ai:AddSubGoal(GOAL_COMMON_SidewayMove, 4, TARGET_ENE_0, self:GetRandam_Int(0, 1), self:GetRandam_Int(30, 45), true, true, local1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act13(self, ai, goal)
    ai:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, self:GetRandam_Int(15, 20))
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act14(self, ai, goal)
    Approach_Act_Flex(self, ai, 2.8 - self:GetMapHitRadius(TARGET_SELF), 2.8 - self:GetMapHitRadius(TARGET_SELF) + 1, 2.8 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, 13 - self:GetMapHitRadius(TARGET_SELF) + 1, 0, 0, 0, 0)
    ai:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3008, TARGET_ENE_0, 5 - self:GetMapHitRadius(TARGET_SELF), 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act15(self, ai, goal)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 999, -1, 45, 0, 0)
    local local0 = ai:AddSubGoal(GOAL_COMMON_Wait, self:GetRandam_Float(1.4, 2.2), TARGET_ENE_0, 0, 0, 0)
    local0:SetTargetRange(0, 4, 999)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act16(self, ai, goal)
    local local0 = ai:AddSubGoal(GOAL_COMMON_Wait, self:GetRandam_Float(1.4, 2.2), TARGET_ENE_0, 0, 0, 0)
    local0:SetTargetRange(0, 4, 999)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act20(self, ai, goal)
    Approach_Act_Flex(self, ai, 20 - self:GetMapHitRadius(TARGET_SELF), 20 - self:GetMapHitRadius(TARGET_SELF) + 1, 20 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 20005, TARGET_ENE_0, 999, -1, 90, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_Act21(self, ai, goal)
    Approach_Act_Flex(self, ai, 15 - self:GetMapHitRadius(TARGET_SELF), 15 - self:GetMapHitRadius(TARGET_SELF) + 1, 15 - self:GetMapHitRadius(TARGET_SELF) + 10, 50, 100, 4, 8)
    local local0 = self:GetRandam_Int(1, 100)
    ai:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 20006, TARGET_ENE_0, 999, -1, 90, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

function MoujaSoldier110000_ActAfter_AdjustSpace(self, ai, goal)
    ai:AddSubGoal(GOAL_MoujaSoldier_SwordShield_110000_AfterAttackAct, 10)
    return 
end

Goal.Update = function (self, ai, goal)
    return Update_Default_NoSubGoal(self, ai, goal)
end

Goal.Terminate = function (self, ai, goal)
    return 
end

Goal.Interrupt = function (self, ai, goal)
    if ai:IsInterupt(INTERUPT_Damaged) then
        local local0 = ai:GetDist(TARGET_ENE_0)
        local local1 = ai:GetDistYSigned(TARGET_ENE_0)
        if (ai:GetNpcThinkParamID() == 110004 or ai:GetNpcThinkParamID() == 110006) and 13 - ai:GetMapHitRadius(TARGET_SELF) + math.abs(local1) <= local0 and local1 < -2 then
            goal:ClearSubGoal()
            Approach_Act_Flex(ai, goal, 13 - ai:GetMapHitRadius(TARGET_SELF) - 1, 13 - ai:GetMapHitRadius(TARGET_SELF) + 0, 13 - ai:GetMapHitRadius(TARGET_SELF) + 10, 100, 100, 4, 8)
            return true
        elseif local0 <= 3.5 and ai:GetRandam_Int(1, 100) <= 80 then
            goal:ClearSubGoal()
            goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Float(1, 2), TARGET_ENE_0, ai:GetRandam_Int(0, 1), 45, true, true, 9910)
            return true
        end
    end
    if ai:IsInterupt(INTERUPT_TargetOutOfRange) and ai:IsTargetOutOfRangeInterruptSlot(0) then
        goal:ClearSubGoal()
        return true
    else
        return false
    end
end

RegisterTableGoal(GOAL_MoujaSoldier_SwordShield_110000_AfterAttackAct, "MoujaSoldier_SwordShield_110000_AfterAttackAct")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_MoujaSoldier_SwordShield_110000_AfterAttackAct, true)
Goal.Activate = function (self, ai, goal)
    local local0 = ai:GetDist(TARGET_ENE_0)
    local local1 = ai:GetRandam_Int(1, 100)
    local local2 = 100
    local local3 = ai:GetRandam_Float(2.5, 4.5)
    local local4 = ai:GetRandam_Int(0, 1)
    local local5 = ai:GetRandam_Int(30, 45)
    local local6 = ai:GetRandam_Float(2.5, 4.5)
    local local7 = local0 + ai:GetRandam_Float(2.5, 4.5)
    if 8 <= local0 then
        local2 = 75
    end
    local local8 = -1
    if ai:GetRandam_Int(1, 100) <= local2 then
        local8 = 9910
    end
    if ai:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if local0 <= 6 then
            goal:AddSubGoal(GOAL_COMMON_LeaveTarget, local6, TARGET_ENE_0, 8, TARGET_ENE_0, true, local8)
        else
            goal:AddSubGoal(GOAL_COMMON_SidewayMove, local3, TARGET_ENE_0, local4, local5, true, true, local8)
        end
    elseif ai:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if local0 <= 6 then
            goal:AddSubGoal(GOAL_COMMON_LeaveTarget, local6, TARGET_ENE_0, 8, TARGET_ENE_0, true, local8)
        else
            goal:AddSubGoal(GOAL_COMMON_SidewayMove, local3, TARGET_ENE_0, local4, local5, true, true, local8)
        end
    elseif 6 <= local0 then
        if local1 <= 50 then
            goal:AddSubGoal(GOAL_COMMON_SidewayMove, local3, TARGET_ENE_0, local4, local5, true, true, local8)
        else
            goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 4, TARGET_SELF, false, -1)
        end
    elseif 4 <= local0 then
        if local1 <= 55 then
            goal:AddSubGoal(GOAL_COMMON_SidewayMove, local3, TARGET_ENE_0, local4, local5, true, true, local8)
        end
    elseif 2 <= local0 then
        if local1 <= 40 then
            goal:AddSubGoal(GOAL_COMMON_SidewayMove, local3, TARGET_ENE_0, local4, local5, true, true, local8)
        elseif local1 <= 50 then
            goal:AddSubGoal(GOAL_COMMON_LeaveTarget, local6, TARGET_ENE_0, local7, TARGET_ENE_0, true, local8)
        end
    elseif 0.5 <= local0 then
        if local1 <= 10 then
            goal:AddSubGoal(GOAL_COMMON_SidewayMove, local3, TARGET_ENE_0, local4, local5, true, true, local8)
        elseif local1 <= 30 then
            goal:AddSubGoal(GOAL_COMMON_LeaveTarget, local6, TARGET_ENE_0, local7, TARGET_ENE_0, true, local8)
        end
    elseif local1 <= 0 then
        goal:AddSubGoal(GOAL_COMMON_SidewayMove, local3, TARGET_ENE_0, local4, local5, true, true, local8)
    elseif local1 <= 35 then
        goal:AddSubGoal(GOAL_COMMON_LeaveTarget, local6, TARGET_ENE_0, local7, TARGET_ENE_0, true, local8)
    end
    return 
end

Goal.Update = function (self, ai, goal)
    return Update_Default_NoSubGoal(self, ai, goal)
end

return 
