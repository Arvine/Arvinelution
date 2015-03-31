--Frightfur Sabre Tiger
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
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xad))
	e3:SetValue(c810000197.atkval)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_BE_MATERIAL)
	e4:SetCondition(c810000197.immcon)
	e4:SetOperation(c810000197.immop)
	c:RegisterEffect(e4)
end
c810000197.material_count=1
function c810000197.ffilter(c)
	return (c:IsSetCard(0xad) and c:GetLevel()>=6)
end
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
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:Filter(Card.IsSetCard,nil,0xa9)
	local g2=eg:Filter(Card.IsSetCard,nil,0xc3)
	local g3=eg:Filter(c810000197.ffilter,nil,tp)
	local ag=g1:Clone()
	ag:Merge(g2)
	ag:Merge(g3)
	local ct=63
	local mg=Group.CreateGroup()
	while ct>0 and Duel.SelectYesNo(tp,aux.Stringid(5632,3)) do
		local tc=ag:Select(tp,1,1,nil):GetFirst()
		ag:RemoveCard(tc)
		if tc:GetCode()==464362 or tc:GetCode()==10383554 or tc:GetCode()==11039171 or tc:GetCode()==83866861 or tc:GetCode()==85545073
			or tc:GetCode()==810000109 or tc:GetCode()==810000110 or tc:GetCode()==810000197 then
			ag:Remove(Card.IsCode,nil,464362)
			ag:Remove(Card.IsCode,nil,10383554)
			ag:Remove(Card.IsCode,nil,11039171)
			ag:Remove(Card.IsCode,nil,83866861)
			ag:Remove(Card.IsCode,nil,85545073)
			ag:Remove(Card.IsCode,nil,810000109)
			ag:Remove(Card.IsCode,nil,810000110)
			ag:Remove(Card.IsCode,nil,810000197)
			ct=ct-1
		end
		mg:AddCard(tc)
	end
	Duel.SetFusionMaterial(mg)
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

function c810000197.atkfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0xa9) or c:IsSetCard(0xad))
end
function c810000197.atkval(e,c)
	return Duel.GetMatchingGroupCount(c810000197.atkfilter,c:GetControler(),LOCATION_MZONE,0,nil)*400
end

function c810000197.immcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_FUSION
end
function c810000197.immop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2095764,1))
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	rc:RegisterEffect(e1)
end