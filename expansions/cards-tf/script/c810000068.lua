--Beast Machine King Barbaros Ür (Anime)
--scripted by: UnknownGuest
function c810000068.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,78651105,96938777,true,true)
	--multiple attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c810000068.value)
	c:RegisterEffect(e1)
	--half damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c810000068.rdcon)
	e2:SetOperation(c810000068.rdop)
	c:RegisterEffect(e2)
	--cannot attack directly
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e3:SetCondition(c810000068.con)
	c:RegisterEffect(e3)
	--register
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCode(EVENT_DAMAGE_STEP_END)
	e4:SetCondition(c810000068.condition)
	e4:SetOperation(c810000068.operation)
	c:RegisterEffect(e4)
end
function c810000068.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetAttacker()==e:GetHandler()
end
function c810000068.operation(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(810000068,RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END,0,0)
end
function c810000068.con(e)
	return e:GetHandler():GetFlagEffect(810000068)>0
end
function c810000068.value(e,c)
	return e:GetHandler():GetLevel()-1
end
function c810000068.rdcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c810000068.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev/2)
end
