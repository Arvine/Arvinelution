--Frightfoor merch
function c810000196.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c810000196.condition)
	e1:SetTarget(c810000196.target)
	e1:SetOperation(c810000196.activate)
	c:RegisterEffect(e1)
end
function c810000196.tgfilter(c)
	return c:IsSetCard(0xad)
end
function c810000196.spfilter(c,e,tp)
	return (c:IsCode(810000197) or c:IsCode(83866861)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
end
function c810000196.tfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsFaceup() and c:IsSetCard(0xad)
end
function c810000196.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c810000196.tfilter,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function c810000196.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c810000196.tfilter,nil)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c810000196.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.NegateEffect(ev)
	local tc=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c810000196.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SendtoGrave(g,REASON_EFFECT)
		local xg=Duel.SelectMatchingCard(tp,c810000196.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		if xg:GetCount()>0 then
			Duel.SpecialSummon(xg,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		end
	end
end
