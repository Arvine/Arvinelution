--Legend of Heart
function c170000201.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c170000201.cost)
    e1:SetTarget(c170000201.target)
    e1:SetOperation(c170000201.operation)
	c:RegisterEffect(e1)
end
function c170000201.costfilter(c,code)
	return c:GetCode()==code and c:IsAbleToRemoveAsCost()
end
function c170000201.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckLPCost(tp,1000) and Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_WARRIOR) and 
    Duel.IsExistingMatchingCard(c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,nil,170000152)
 	and Duel.IsExistingMatchingCard(c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,nil,170000151)
	and Duel.IsExistingMatchingCard(c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,nil,170000153) end
    Duel.PayLPCost(tp,1000)
	local rg=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_WARRIOR)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREMOVE)
	local g1=Duel.SelectMatchingCard(tp,c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil,170000152)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil,170000151)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g3=Duel.SelectMatchingCard(tp,c170000201.costfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,1,nil,170000153)
	g1:Merge(g2)
	g1:Merge(g3)
		Duel.DisableShuffleCheck()
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
	Duel.DisableShuffleCheck()
	Duel.Release(rg,REASON_COST)
end
function c170000201.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c170000201.filter(c)
return c:IsCode(48179392) or c:IsCode(110000100) or c:IsCode(110000101)
end
function c170000201.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=3
	and Duel.IsExistingTarget(c170000201.spfilter,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil,e,tp,170000202)
	and Duel.IsExistingTarget(c170000201.spfilter,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil,e,tp,170000203)
	and Duel.IsExistingTarget(c170000201.spfilter,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil,e,tp,170000204) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c170000201.spfilter,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,1,nil,e,tp,170000202)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c170000201.spfilter,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,1,nil,e,tp,170000203)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectTarget(tp,c170000201.spfilter,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,1,nil,e,tp,170000204)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,4,0,0)
end
function c170000201.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()>ft then return end
	Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(c170000201.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
	Duel.SendtoGrave(g,REASON_EFFECT)
end