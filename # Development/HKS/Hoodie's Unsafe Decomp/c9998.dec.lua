﻿function ()
function Init_onUpdate()
    if env(ESD_ENV_GetReceivedDamageType) == 8 then
        ExecEvent("W_DeathIdle")
        return 
    end
    if env(ESD_ENV_GetHP) <= 0 then
        ExecEvent("W_DeathIdle")
        return 
    end
    SetVariable("IndexIdleType", IDLE_TYPE_DEFAULT)
    SetVariable("IndexTurnType", IDLE_TYPE_DEFAULT)
    IdleCommonFunction()
    if ExecUniqueIdle() == TRUE then
        return 
    end
    ExecEvent("IdleRoot")
    
end

function Idle_onActivate()
    SetIdleFlag()
    env(133, -1)
    
end

function Idle_onDeactivate()
    act(102, 255)
    act(111, TRUE)
    act(101, FALSE)
    
end

function IdleDefault_onActivate()
    SetIdleFlag()
    
end

function IdleDefault_onUpdate()
    IdleCommonFunction()
    SetVariable("IndexTurnType", IDLE_TYPE_DEFAULT)
    
end

function IdleDefault_onDeactivate()
    act(102, 255)
    act(111, TRUE)
    act(101, FALSE)
    
end

function IdleGuard_onActivate()
    SetIdleFlag()
    SetVariable("IndexTurnType", IDLE_TYPE_DEFAULT)
    
end

function IdleGuard_onUpdate()
    g_IsGuard = TRUE
    IdleCommonFunction()
    SetVariable("IndexTurnType", IDLE_TYPE_GUARD)
    
end

function IdleGuard_onDeactivate()
    act(102, 255)
    act(111, TRUE)
    act(101, FALSE)
    
end

function IdleCaution_onActivate()
    SetIdleFlag()
    
end

function IdleCaution_onUpdate()
    IdleCommonFunction()
    SetVariable("IndexTurnType", IDLE_TYPE_CAUTION)
    
end

function IdleCaution_onDeactivate()
    act(102, 255)
    act(111, TRUE)
    act(101, FALSE)
    
end

function IdleBattle_onActivate()
    SetIdleFlag()
    
end

function IdleBattle_onUpdate()
    IdleCommonFunction()
    SetVariable("IndexTurnType", IDLE_TYPE_BATTLE)
    
end

function IdleBattle_onDeactivate()
    act(102, 255)
    act(111, TRUE)
    act(101, FALSE)
    
end

function IdleUnique_onActivate()
    SetIdleFlag()
    
end

function IdleUnique_onUpdate()
    if env(ESD_ENV_DS3HasThrowRequest) == TRUE then
        return 
    end
    if TRUE == ExecDamage() then
        return 
    end
    if TRUE == ExecGuardAction() then
        return 
    end
    if TRUE == g_IsAIStateChange then
        SetVariable("IndexIdleType", IDLE_TYPE_BATTLE)
        if env(ESD_ENV_DS3DoesAnimExist, 5010) == TRUE then
            SetVariable("IndexTurnType", IDLE_TYPE_BATTLE)
        else
            SetVariable("IndexTurnType", IDLE_TYPE_DEFAULT)
        end
        ExecEvent("W_TransIdleUnique")
        return 
    end
    if TRUE == ExecUniqueIdle() then
        return 
    end
    
end

function IdleUnique_onDeactivate()
    act(102, 255)
    act(111, TRUE)
    act(101, FALSE)
    
end

function TransIdleUnique_onUpdate()
    if env(ESD_ENV_DS3HasThrowRequest) == TRUE then
        return 
    end
    if TRUE == ExecDamage() then
        return 
    end
    if TRUE == ExecGuardAction() then
        return 
    end
    if env(ESD_ENV_GetFallHeight) > 0 and env(ESD_ENV_IsTruelyLanding) == TRUE then
        local anim_id = env(ESD_ENV_GetSpecialStayAnimID)
        if env(ESD_ENV_DS3DoesAnimExist, 7800 + anim_id - 700) == TRUE then
            ExecEvent("W_LandIdleUnique")
        else
            ExecEvent("W_Land")
        end
    end
    
end

function TransDefaultToCaution_onUpdate()
    act(9104)
    TransCommonFunction()
    
end

function TransBattleToDefault_onUpdate()
    TransCommonFunction()
    
end

function TransBattleToCaution_onUpdate()
    TransCommonFunction()
    
end

function TransDefaultToBattle_onUpdate()
    TransCommonFunction()
    
end

function TransCautionToDefault_onUpdate()
    TransCommonFunction()
    
end

function TransCautionToBattle_onUpdate()
    TransCommonFunction()
    
end

function GuardStart_onUpdate()
    g_IsGuard = TRUE
    SetVariable("IndexTurnType", IDLE_TYPE_GUARD)
    GuardCommonTransFunction()
    
end

function GuardEnd_onUpdate()
    SetVariable("IndexTurnType", IDLE_TYPE_GUARD)
    GuardCommonTransFunction()
    
end

function Guard_onUpdate()
    DamageCommonFunction()
    
end

function Move_Activate()
    SetIdleFlag()
    
end

function Move_Update()
    
end

function Move_Deactivate()
    
end

function WalkFront_onUpdate()
    MoveCommonFunction()
    
end

function WalkBack_onUpdate()
    MoveCommonFunction()
    
end

function WalkLeft_onUpdate()
    MoveCommonFunction()
    
end

function WalkRight_onUpdate()
    MoveCommonFunction()
    
end

function Run_onUpdate()
    MoveCommonFunction()
    
end

function Step700_onUpdate()
    StepCommonFunction()
    
end

function Step701_onUpdate()
    StepCommonFunction()
    
end

function Step702_onUpdate()
    StepCommonFunction()
    
end

function Step703_onUpdate()
    StepCommonFunction()
    
end

function Step711_onUpdate()
    StepCommonFunction()
    
end

function Step6000_onUpdate()
    StepCommonFunction()
    
end

function Step6001_onUpdate()
    StepCommonFunction()
    
end

function Step6002_onUpdate()
    StepCommonFunction()
    
end

function Step6003_onUpdate()
    StepCommonFunction()
    
end

function Step6100_onUpdate()
    StepCommonFunction()
    
end

function Step6101_onUpdate()
    StepCommonFunction()
    
end

function Turn_onUpdate()
    TurnCommonFunction()
    
end

local move_amount = 1
function TurnDefault_onUpdate()
    TurnCommonFunction()
    
end

function TurnBattle_onUpdate()
    TurnCommonFunction()
    
end

function TurnGuard_onUpdate()
    g_IsGuard = TRUE
    TurnCommonFunction()
    
end

function DamageSmall_onUpdate()
    act(2001, 0)
    DamageCommonFunction()
    
end

function DamageMiddle_onUpdate()
    act(2001, 0)
    DamageCommonFunction()
    
end

function DamageLarge_onUpdate()
    act(2001, 0)
    DamageCommonFunction()
    
end

function DamageExLarge_onUpdate()
    DamageCommonFunction()
    
end

function DamagePushed_onUpdate()
    act(2001, 0)
    DamageCommonFunction()
    
end

function DamageDuster_onUpdate()
    act(2001, 0)
    DamageCommonFunction()
    
end

function DamageBlast_onUpdate()
    DamageCommonFunction()
    
end

function DamageParry_onUpdate()
    act(2001, 0)
    DamageCommonFunction()
    
end

function DamageGuardBreak_onUpdate()
    DamageCommonFunction()
    
end

function DamageAttackBound_onUpdate()
    DamageCommonFunction()
    
end

function DamageWeak_onUpdate()
    act(2001, 0)
    DamageCommonFunction()
    
end

function DamageUpper_onUpdate()
    act(2001, 0)
    DamageCommonFunction()
    
end

function DamageAfterPushed_onUpdate()
    DamageCommonFunction()
    
end

function PartDamageNoAdd1_onActivate()
    SetVariable("BlendPart1", 0)
    
end

function PartDamageNoAdd2_onActivate()
    SetVariable("BlendPart2", 0)
    
end

function PartDamageNoAdd3_onActivate()
    SetVariable("BlendPart3", 0)
    
end

function PartDamageNoAdd4_onActivate()
    SetVariable("BlendPart4", 0)
    
end

function PartDamageNoAdd5_onActivate()
    SetVariable("BlendPart5", 0)
    
end

function PartDamageNoAdd6_onActivate()
    SetVariable("BlendPart6", 0)
    
end

function PartDamageNoAdd7_onActivate()
    SetVariable("BlendPart7", 0)
    
end

function PartDamageNoAdd8_onActivate()
    SetVariable("BlendPart8", 0)
    
end

function Fall_onUpdate()
    FallCommonFunction()
    
end

function Land_onUpdate()
    LandCommonFunction()
    
end

function LadderIdleLeft_onActivate()
    SendLadderCommand()
    g_LadderFireCommand = LADDER_COMMAND_INVALID
    SetLadderCondition(LADDER_CONDITION_IDLE_RIGHT, TRUE)
    
end

function LadderIdleLeft_onUpdate()
    CallActionState(LADDER_STATE_IDLE)
    if UpdateLadderState() == TRUE then
        return 
    end
    LadderCommonFunction()
    
end

function LadderIdleRight_onActivate()
    SendLadderCommand()
    g_LadderFireCommand = LADDER_COMMAND_INVALID
    SetLadderCondition(LADDER_CONDITION_IDLE_RIGHT, TRUE)
    
end

function LadderIdleRight_onUpdate()
    CallActionState(LADDER_STATE_IDLE)
    if UpdateLadderState() == TRUE then
        return 
    end
    LadderCommonFunction()
    
end

function LadderUpRight_onActivate()
    SetLadderCondition(LADDER_CONDITION_ATTACK_UP_RIGHT, FALSE)
    SetVariable("IndexLadderHand", 0)
    
end

function LadderUpRight_onUpdate()
    LadderCommonFunction()
    return 
    if env(ESD_ENV_DS3GetGeneralTAEFlag, 0) == TRUE then
        CallActionState(LADDER_STATE_UP)
    else
        CallActionState(0)
    end
    UpdateLadderState()
    
end

function LadderUpLeft_onActivate()
    SetLadderCondition(LADDER_CONDITION_ATTACK_UP_RIGHT, FALSE)
    SetVariable("IndexLadderHand", 1)
    
end

function LadderUpLeft_onUpdate()
    LadderCommonFunction()
    return 
    if env(ESD_ENV_DS3GetGeneralTAEFlag, 0) == TRUE then
        CallActionState(LADDER_STATE_UP)
    else
        CallActionState(0)
    end
    UpdateLadderState()
    
end

function LadderDownRight_onActivate()
    SetLadderCondition(LADDER_CONDITION_ATTACK_DOWN_RIGHT, FALSE)
    
end

function LadderDownRight_onUpdate()
    LadderCommonFunction()
    return 
    if env(ESD_ENV_DS3GetGeneralTAEFlag, 0) == TRUE then
        CallActionState(LADDER_STATE_DOWN)
    else
        CallActionState(0)
    end
    UpdateLadderState()
    
end

function LadderDownLeft_onActivate()
    SetLadderCondition(LADDER_CONDITION_ATTACK_DOWN_RIGHT, FALSE)
    
end

function LadderDownLeft_onUpdate()
    LadderCommonFunction()
    return 
    if env(ESD_ENV_DS3GetGeneralTAEFlag, 0) == TRUE then
        CallActionState(LADDER_STATE_DOWN)
    else
        CallActionState(0)
    end
    UpdateLadderState()
    
end

function LadderStartTop_onActivate()
    SetVariable("IndexLadderHand", LADDER_HAND_LEFT)
    SetLadderCondition(LADDER_CONDITION_START_TOP, FALSE)
    g_LadderFireCommand = LADDER_COMMAND_DOWN
    
end

function LadderStartBottom_onActivate()
    SetVariable("IndexLadderHand", LADDER_HAND_LEFT)
    SetLadderCondition(LADDER_CONDITION_START_BOTTOM, FALSE)
    g_LadderFireCommand = LADDER_COMMAND_UP
    
end

function LadderStartBottom_onUpdate()
    LadderCommonFunction()
    
end

function LadderEndTop_onActivate()
    SetLadderCondition(LADDER_CONDITION_END_TOP, FALSE)
    
end

function LadderEndTop_onUpdate()
    LadderCommonFunction()
    
end

function LadderEndTop_onDeactivate()
    SetLadderCondition("LADDER_CONDITION_INVALID")
    
end

function LadderEndBottom_onActivate()
    SetLadderCondition(LADDER_CONDITION_END_BOTTOM, FALSE)
    
end

function LadderEndBottom_onUpdate()
    LadderCommonFunction()
    
end

function LadderAttackDownLeft_onUpdate()
    LadderCommonFunction()
    
end

function LadderAttackDownRight_onUpdate()
    LadderCommonFunction()
    
end

function LadderAttackUpLeft_onUpdate()
    LadderCommonFunction()
    
end

function LadderAttackUpRight_onUpdate()
    LadderCommonFunction()
    
end

function LadderFall_onUpdate()
    if env(ESD_ENV_IsLanding) == TRUE then
        SetVariable("DeathIndex", DEATH_INDEX_LADDER)
        ExecEvent("W_Death")
        return 
    end
    
end

function AttackBlend_onUpdate()
    AttackCommonFunction()
    
end

function Attack3000_onUpdate()
    AttackCommonFunction()
    
end

function Attack3001_onUpdate()
    AttackCommonFunction()
    
end

function Attack3002_onUpdate()
    act(2001, hkbGetVariable("AttackMoveRate"))
    AttackCommonFunction()
    
end

function Attack3002_onDeactivate()
    SetVariable("AttackMoveRate", 1)
    
end

function Attack3003_onUpdate()
    act(2001, hkbGetVariable("AttackMoveRate"))
    AttackCommonFunction()
    
end

function Attack3003_onDeactivate()
    SetVariable("AttackMoveRate", 1)
    
end

function Attack3004_onUpdate()
    AttackCommonFunction()
    
end

function Attack3005_onUpdate()
    AttackCommonFunction()
    
end

function Attack3006_onUpdate()
    act(2001, hkbGetVariable("AttackMoveRate"))
    AttackCommonFunction()
    
end

function Attack3006_onDeactivate()
    SetVariable("AttackMoveRate", 1)
    
end

function Attack3007_onUpdate()
    AttackCommonFunction()
    
end

function Attack3008_onUpdate()
    AttackCommonFunction()
    
end

function Attack3008_onDeactivate()
    SetVariable("DistanceRate", 1)
    
end

function Attack3009_onUpdate()
    AttackCommonFunction()
    
end

function Attack3010_onUpdate()
    AttackCommonFunction()
    
end

function Attack3011_onUpdate()
    AttackCommonFunction()
    
end

function Attack3012_onUpdate()
    AttackCommonFunction()
    
end

function Attack3013_onUpdate()
    AttackCommonFunction()
    
end

function Attack3014_onUpdate()
    AttackCommonFunction()
    
end

function Attack3015_onUpdate()
    AttackCommonFunction()
    
end

function Attack3016_onUpdate()
    AttackCommonFunction()
    
end

function Attack3017_onUpdate()
    AttackCommonFunction()
    
end

function Attack3018_onUpdate()
    AttackCommonFunction()
    
end

function Attack3019_onUpdate()
    AttackCommonFunction()
    
end

function Attack3020_onUpdate()
    AttackCommonFunction()
    
end

function Attack3021_onUpdate()
    AttackCommonFunction()
    
end

function Attack3022_onUpdate()
    AttackCommonFunction()
    
end

function Attack3023_onUpdate()
    AttackCommonFunction()
    
end

function Attack3024_onUpdate()
    AttackCommonFunction()
    
end

function Attack3100_onUpdate()
    AttackCommonFunction()
    
end

function Attack3999_onUpdate()
    if env(ESD_ENV_DS3GetGeneralTAEFlag, 0) == TRUE then
        act(2001, 5)
    end
    CallActionState(g_ActionNumber)
    if TRUE == ExecAICancelAction() then
        CallActionState(0)
        return 
    end
    if env(ESD_ENV_DS3IsMoveCancelPossible) == TRUE and TRUE == MoveStart() then
        CallActionState(0)
        return TRUE
    end
    
end

function EstStart_onUpdate()
    AttackCommonFunction()
    if env(ESD_ENV_DS3GetGeneralTAEFlag, 0) == TRUE and env(ESD_ENV_GetStateChangeType, 154) == TRUE then
        ExecEvent("W_EstFailure")
        return 
    end
    
end

function EstSuccess_onUpdate()
    AttackCommonFunction()
    
end

function EstFailure_onUpdate()
    AttackCommonFunction()
    
end

function WeaponChange_onUpdate()
    AttackCommonFunction()
    
end

function TransHeatup_onUpdate()
    AttackCommonFunction()
    
end

function Event3000_onUpdate()
    act(9102)
    
end

function Event3001_onUpdate()
    act(9102)
    
end

function Event3002_onUpdate()
    act(9102)
    
end

function Event3003_onUpdate()
    act(9102)
    
end

function Event3004_onUpdate()
    act(9102)
    
end

function Event3005_onUpdate()
    act(9102)
    
end

function Event3006_onUpdate()
    act(9102)
    
end

function Test_onUpdate()
    AttackCommonFunction()
    if env(ESD_ENV_DS3GetGeneralTAEFlag, 0) == TRUE then
        hkbSetVariable("MotionSpeedRate", 0.009999999776482582)
    end
    
end

function Event3006_onUpdate()
    act(9102)
    
end

function Event3007_onUpdate()
    act(9102)
    
end

function Event3008_onUpdate()
    act(9102)
    
end

function Event3009_onUpdate()
    act(9102)
    
end

function Event3010_onUpdate()
    act(9102)
    
end

function Event3011_onUpdate()
    act(9102)
    
end

function Event3012_onUpdate()
    act(9102)
    
end

function Event3013_onUpdate()
    act(9102)
    
end

function Event14000_onUpdate()
    act(9102)
    
end

function Event14100_onUpdate()
    if env(ESD_ENV_DS3GetGeneralTAEFlag, 0) == TRUE then
        return 
    end
    act(9102)
    
end

function Event14101_onUpdate()
    act(9102)
    
end

function Event14102_onUpdate()
    act(9102)
    
end

function Event14103_onUpdate()
    act(9102)
    
end

function Event14104_onUpdate()
    act(9102)
    
end

function Event14021_onUpdate()
    act(9102)
    
end

function Event20000_onUpdate()
    act(9102)
    
end

function Event20001_onUpdate()
    act(9102)
    
end

function Event30000_onUpdate()
    act(9102)
    
end

function CultCaught_onUpdate()
    local cult_state = env(ESD_ENV_DS3GetCeremonyState)
    if cult_state <= 0 then
        return 
    end
    if cult_state == CULT_STATE_MOVE then
        ExecEvent("W_CultMove")
        return 
    end
    if cult_state == CULT_STATE_RELESE then
        ExecEvent("W_CeremonyReleased")
        return 
    end
    
end

function CultIdle_onUpdate()
    local cult_state = env(ESD_ENV_DS3GetCeremonyState)
    if cult_state <= 0 then
        return 
    end
    if cult_state == CULT_STATE_MOVE then
        ExecEvent("W_CultMove")
        return 
    end
    if cult_state == CULT_STATE_RELESE then
        ExecEvent("W_CeremonyReleased")
        return 
    end
    
end

function CultMove_onUpdate()
    local cult_state = env(ESD_ENV_DS3GetCeremonyState)
    if cult_state <= 0 then
        return 
    end
    if cult_state == CULT_STATE_IDLE then
        ExecEvent("W_CultIdle")
        return 
    end
    if cult_state == CULT_STATE_RELESE then
        ExecEvent("W_CeremonyReleased")
        return 
    end
    
end

function CultDeathLoop_onUpdate()
    act(103, 0)
    
end

function ThrowAtk_onActivate()
    SetVariable("ThrowID", env(ESD_ENV_GetThrowAnimID))
    
end

function ThrowAtk_onDeactivate()
    act(135)
    act(139)
    
end

function ThrowDef_onActivate()
    SetVariable("ThrowID", env(ESD_ENV_GetThrowAnimID))
    act(143)
    
end

function ThrowDef_onUpdate()
    if CommonThrowDefFunction() == TRUE then
        act(135)
        act(139)
    end
    
end

function ThrowDef_onDeactivate()
    act(135)
    act(139)
    
end

global = {}
function dummy()
    
end

global.__index = function (table, element)
    return dummy
    
end

setmetatable(_G, global)

end
