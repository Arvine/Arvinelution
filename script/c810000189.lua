--RRR By Kent Arvine
function c810000189.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c810000189.spcon)
	e1:SetOperation(c810000189.spop)
	c:RegisterEffect(e1)
end

function c810000189.spfilter(c)
	return c:IsSetCard(xxx) and c:IsAbleToRemoveAsCost()
end
function c810000189.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000189.spfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil)
end
function c810000189.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c810000189.spfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEDOWN,REASON_COST)
end