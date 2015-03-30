--Goddess Bow
function c170000194.initial_effect(c)
    --fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,25652259,c170000194.ffilter,1,true,true)
    --Double ATK
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_EQUIP)
    e1:SetCode(EFFECT_SET_BASE_ATTACK)
    e1:SetValue(c170000194.atkval)
    c:RegisterEffect(e1)
    --Equip Limit
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetValue(c170000194.eqlimit)
	c:RegisterEffect(e3)
	--Activates a monster effect they control
   	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_F)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c170000194.con)
	e3:SetOperation(c170000194.op)
	c:RegisterEffect(e3)
end
function c170000194.indes(e,c)
return c:GetAttack()==e:GetHandler():GetEquipTarget():GetAttack()
end
function c170000194.eqlimit(e,c)
return c:IsFaceup()
end
function c170000194.ffilter(c)
return c:IsCode(170000153) and c:IsType(TYPE_SPELL)
end
function c170000194.atkval(e,c)
return c:GetBaseAttack()*2
end
function c170000194.con(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ph=Duel.GetCurrentPhase()
	return not e:GetHandler():GetEquipTarget():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp
		and (ph>PHASE_MAIN1 and ph<PHASE_MAIN2) and re:IsActiveType(TYPE_MONSTER)
		and (Duel.GetAttacker()==e:GetHandler():GetEquipTarget() or Duel.GetAttackTarget()==e:GetHandler():GetEquipTarget())
end
function c170000194.op(e,tp,eg,ep,ev,re,r,rp)
	
	local et=e:GetHandler():GetEquipTarget()
	
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(1)
    et:RegisterEffect(e1)
	Duel.ChainAttack()
end