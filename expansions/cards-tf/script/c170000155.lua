--Tyrant Burst Dragon
function c170000155.initial_effect(c)
  	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,170000151,170000149,false,false)
    --Give Power to a Dragon
   	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c170000155.condition)
    e1:SetCost(c170000155.cost)
	e1:SetTarget(c170000155.target)
	e1:SetOperation(c170000155.operation)
	c:RegisterEffect(e1)
end
function c170000155.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c170000155.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c170000155.filter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c170000155.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c170000155.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
function c170000155.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c170000155.filter(chkc,e) end
	if chk==0 then return Duel.IsExistingTarget(c170000155.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c170000155.filter,tp,LOCATION_MZONE,0,1,1,nil)
    local tc=g:GetFirst()
	e:SetLabelObject(tc)
    tc:CreateEffectRelation(e)
end
function c170000155.operation(e,tp,eg,ep,ev,re,r,rp)
   local tc=e:GetLabelObject()
   if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
    --Update Attack
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(400)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
    --All Attack
    local e2=Effect.CreateEffect(tc)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_ALL)
	e2:SetValue(1)
	tc:RegisterEffect(e2)
end