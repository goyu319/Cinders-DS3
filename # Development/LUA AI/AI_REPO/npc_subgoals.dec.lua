REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 0, "移動対象【Type】", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 1, "攻撃開始距離【m】", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 2, "攻撃EzState番号", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 3, "ガードEzState番号", 0)
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_DashAttack, true)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_DashAttack, true)
function DashAttack_Activate(arg0, arg1)
    arg0:StartDash()
    local local0 = arg1:GetParam(0)
    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, local0, arg1:GetParam(1), TARGET_SELF, false, arg1:GetParam(3))
    arg1:AddSubGoal(GOAL_COMMON_DashAttack_Attack, 10, local0, arg1:GetParam(2))
    return 
end

function DashAttack_Terminate(arg0, arg1)
    arg0:EndDash()
    return 
end

function DashAttack_Update(arg0, arg1, arg2)
    return GOAL_RESULT_Continue
end

function DashAttack_Interupt(arg0, arg1)
    return false
end

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack_Attack, 0, "移動対象【Type】", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack_Attack, 1, "攻撃EzState番号", 0)
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_DashAttack_Attack, true)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_DashAttack_Attack, true)
function DashAttack_Attack_Activate(arg0, arg1)
    local local0 = arg1:GetParam(0)
    arg0:MoveTo(local0, AI_DIR_TYPE_CENTER, 0, false)
    arg1:AddSubGoal(GOAL_COMMON_Attack, 10, arg1:GetParam(1), local0, DIST_None)
    return 
end

function DashAttack_Attack_Update(arg0, arg1)
    return GOAL_RESULT_Continue
end

function DashAttack_Attack_Terminate(arg0, arg1)
    return 
end

function DashAttack_Attack_Interupt(arg0, arg1)
    return false
end

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashTarget, 0, "移動対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashTarget, 1, "到達判定距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashTarget, 2, "旋回対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashTarget, 3, "ガードEzState番号", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashTarget, 4, "ガードゴール終了タイプ", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashTarget, 5, "ガード寿命が尽きたら成功とするか", 0)
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_DashTarget, true)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_DashTarget, true)
function DashTarget_Activate(arg0, arg1)
    arg0:StartDash()
    arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, arg1:GetLife(), arg1:GetParam(0), arg1:GetParam(1), arg1:GetParam(2), false, arg1:GetParam(3), arg1:GetParam(4), arg1:GetParam(5))
    return 
end

function DashTarget_Terminate(arg0, arg1)
    arg0:EndDash()
    return 
end

function DashTarget_Update(arg0, arg1, arg2)
    return GOAL_RESULT_Continue
end

function DashTarget_Interupt(arg0, arg1)
    return false
end

return 
