--ヘルモスの爪
function c5686.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,5686+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c5686.target)
	e1:SetOperation(c5686.activate)
	c:RegisterEffect(e1)
	--add code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_ADD_CODE)
	e2:SetValue(10000052)
	c:RegisterEffect(e2)
end
function c5686.tgfilter0(c,e,tp)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
		and c:IsCanBeFusionMaterial() and Duel.IsExistingMatchingCard(c5686.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
end
function c5686.tgfilter(c,e,tp)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
		and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
		and Duel.IsExistingMatchingCard(c5686.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
end
function c5686.spfilter(c,e,tp,code)
	if not c:IsCode(810000211) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) then return false end
	return false
end
function c5686.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc==0 then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c5686.tgfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c5686.tgfilter0,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c5686.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c5686.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsCanBeFusionMaterial() and not tc:IsImmuneToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c5686.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		local sc=sg:GetFirst()
		if sc then
			sc:SetMaterial(Group.FromCards(tc))
			Duel.SendtoGrave(tc,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(sc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
			sc:CompleteProcedure()
		end
	end
end
