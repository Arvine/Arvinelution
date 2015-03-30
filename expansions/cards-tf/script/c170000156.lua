--Blue-Eyes Tyrant Dragon
function c170000156.initial_effect(c)
   	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,170000155,89631139,false,false)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c170000156.spcon)
	e2:SetOperation(c170000156.spop)
	c:RegisterEffect(e2)
  	--All Attack
   	local e3=Effect.CreateEffect(c)
   	e3:SetType(EFFECT_TYPE_SINGLE)
   	e3:SetCode(EFFECT_ATTACK_ALL)
   	e3:SetValue(1)
   	c:RegisterEffect(e3)
end
function c170000156.spfilter(c,code)
	if c:GetCode()~=code then return false end
	if c:IsType(TYPE_FUSION) then return c:IsAbleToExtraAsCost()
	else return c:IsAbleToDeckAsCost() end
end
function c170000156.spcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
		and Duel.IsExistingMatchingCard(c170000156.spfilter,tp,LOCATION_ONFIELD,0,1,nil,170000155)
		and Duel.IsExistingMatchingCard(c170000156.spfilter,tp,LOCATION_ONFIELD,0,1,nil,89631139)
end
function c170000156.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c170000156.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil,170000155)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c170000156.spfilter,tp,LOCATION_ONFIELD,0,1,1,nil,89631139)
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
