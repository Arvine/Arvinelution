--デストーイ・シザー・タイガー
function c810000197.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c810000197.fscon)
	e1:SetOperation(c810000197.fsop)
	c:RegisterEffect(e1)
	--spsum
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(73580471,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c810000197.descon)
	e2:SetTarget(c810000197.destg)
	e2:SetOperation(c810000197.desop)
	c:RegisterEffect(e2)
end
c810000197.material_count=1
function c810000197.mfilter(c,mg)
	return (c:IsSetCard(0xad) and c:GetLevel()>=6) and (mg:IsExists(Card.IsSetCard,1,c,0xa9) or mg:IsExists(Card.IsSetCard,1,c,0xc3))
end
function c810000197.fscon(e,mg,gc)
	if mg==nil then return false end
	if gc then return (gc:IsSetCard(0xad) and gc:GetLevel()>=6)
		and (mg:IsExists(Card.IsSetCard,1,gc,0xa9) or mg:IsExists(Card.IsSetCard,1,c,0xc3)) end
	return mg:IsExists(c810000197.mfilter,1,nil,mg)
end
function c810000197.fsop(e,tp,eg,ep,ev,re,r,rp,gc)
	if gc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		--local g1=eg:FilterSelect(tp,Card.IsSetCard,1,63,nil,0xa9)
		local g1=eg:Filter(Card.IsSetCard,nil,0xa9)
		local g2=eg:Filter(Card.IsSetCard,nil,0xc3)
		g1:merge(g2)
		local sg=g1:Select(tp,1,99,nil)
		Duel.SetFusionMaterial(sg)
		return
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:FilterSelect(tp,c810000197.mfilter,1,1,nil,eg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	--local g2=eg:FilterSelect(tp,Card.IsSetCard,1,63,g1:GetFirst(),0xa9)
	local g2=eg:Filter(Card.IsSetCard,nil,0xa9)
	local g3=eg:Filter(Card.IsSetCard,nil,0xc3)
	g2:merge(g3)
	local sg=g2:Select(tp,1,99,nil)
	g1:Merge(sg)
	Duel.SetFusionMaterial(g1)
end

function c810000197.filter2(c)
	return c:IsSetCard(0xad)
end
function c810000197.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c810000197.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c810000197.filter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c810000197.filter2,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,2,0,0)
end
function c810000197.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end