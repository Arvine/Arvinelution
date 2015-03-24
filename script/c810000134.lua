--Protector
function c810000134.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c810000134.dccon)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10530913,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCountLimit(1,810000134)
	e2:SetCondition(c810000134.spcon)
	e2:SetTarget(c810000134.sptg)
	e2:SetOperation(c810000134.spop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10530913,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e3:SetCountLimit(1,810000134)
	e3:SetCondition(c810000134.spcon2)
	e3:SetTarget(c810000134.sptg2)
	e3:SetOperation(c810000134.spop2)
	c:RegisterEffect(e3)
end
function c810000134.dccon(e,c)
	return c:IsRace(RACE_DRAGON)
end

function c810000134.cfilter(c)
	return (c:IsRace(RACE_DRAGON) and not c:IsCode(810000134) and not (c:IsType(TYPE_NORMAL) or c:IsType(TYPE_DUAL))) and not c:IsReason(REASON_RETURN)
end
function c810000134.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c810000134.cfilter,1,nil)
end
function c810000134.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c810000134.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end

function c810000134.cfilter2(c)
	return (c:IsRace(RACE_DRAGON) and not c:IsCode(810000134) and (c:IsType(TYPE_NORMAL) or c:IsType(TYPE_DUAL))) and not c:IsReason(REASON_RETURN)
end
function c810000134.thfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsType(TYPE_NORMAL)
end
function c810000134.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c810000134.cfilter2,1,nil)
end
function c810000134.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c810000134.spop2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c810000134.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end