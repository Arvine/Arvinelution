--Fluffal Mouse
function c810000190.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3534077,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCost(c810000190.spcost)
	e1:SetTarget(c810000190.sptg)
	e1:SetOperation(c810000190.spop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(810000190,ACTIVITY_SPSUMMON,c810000190.counterfilter)
end
function c810000190.counterfilter(c)
	return c:IsSetCard(0xad) or c:GetSummonLocation()~=LOCATION_EXTRA
end
function c810000190.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(810000190,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c810000190.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c810000190.splimit(e,c)
	return c:IsLocation(LOCATION_EXTRA) and not c:IsSetCard(0xad)
end
function c810000190.filter(c,e,tp)
	return c:GetCode()==810000190 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c810000190.filter2(c,g)
	return g:IsExists(Card.IsCode,1,c,c:GetCode())
end
function c810000190.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c810000190.filter,tp,LOCATION_DECK,0,nil,e,tp)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:IsExists(c810000190.filter2,1,nil,g)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c810000190.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c810000190.filter,tp,LOCATION_DECK,0,nil,e,tp)
	local dg=g:Filter(c810000190.filter2,nil,g)
	if dg:GetCount()>=1 then
		local fid=e:GetHandler():GetFieldID()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=dg:Select(tp,1,1,nil)
		local tc1=sg:GetFirst()
		dg:RemoveCard(tc1)
		local tc2=dg:Filter(Card.IsCode,nil,tc1:GetCode()):GetFirst()
		Duel.SpecialSummon(tc1,0,tp,tp,false,false,POS_FACEUP)
		Duel.SpecialSummon(tc2,0,tp,tp,false,false,POS_FACEUP)
	end
end
