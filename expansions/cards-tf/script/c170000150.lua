--Doom Virus Dragon
function c170000150.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,170000151,57728570,false,false)
	--Doom Virus (Faceup)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)	
	e1:SetTarget(c170000150.destg)
	e1:SetOperation(c170000150.desop)
	c:RegisterEffect(e1)
	--Doom Virus (Facedown)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_MZONE)	
	e2:SetTarget(c170000150.destg2)
	e2:SetOperation(c170000150.desop2)
	c:RegisterEffect(e2)
end
function c170000150.filter(c,g,pg)
	return c:IsFaceup() and c:GetAttack()>=1500 and c:IsDestructable() and not c:IsCode(170000150)
end
function c170000150.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c170000150.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0,nil)
end
function c170000150.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c170000150.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c170000150.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c170000150.filter2,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c170000150.filter2(c)
	return c:IsFacedown() and c:IsAttackAbove(1500)
end
function c170000150.desop2(e,tp,eg,ep,ev,re,r,rp)
		local conf=Duel.GetFieldGroup(tp,0,LOCATION_MZONE,POS_FACEDOWN)
	if conf:GetCount()>0 then
		Duel.ConfirmCards(tp,conf)
		local dg=conf:Filter(c170000150.filter2,nil)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end