--Tomato Paradise
function c511000103.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000103,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c511000103.tkcon)
	e2:SetTarget(c511000103.tktg)
	e2:SetOperation(c511000103.tkop)
	c:RegisterEffect(e2)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTarget(c511000103.filter)
	e3:SetValue(c511000103.val)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c511000103.filter(e,c)
	return c:IsRace(RACE_PLANT)
end
function c511000103.filter2(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c511000103.val(e,c)
	return Duel.GetMatchingGroupCount(c511000103.filter2,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
function c511000103.ctfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT) and c:IsPreviousLocation(LOCATION_HAND) and c:GetCode()~=511000104
end
function c511000103.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000103.ctfilter,1,nil)
end
function c511000103.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
    local ec=eg:Filter(c511000103.ctfilter,nil):GetFirst()
    if chk==0 then return Duel.GetLocationCount(ec:GetControler(),LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(ec:GetControler(),511000104,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000103.tkop(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:Filter(c511000103.ctfilter,nil):GetFirst()
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(ec:GetControler(),511000104,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) then return end
	if Duel.SelectYesNo(ec:GetControler(),aux.Stringid(511000103,1)) then
		local token=Duel.CreateToken(ec:GetControler(),511000104)
		Duel.SpecialSummon(token,0,ec:GetControler(),ec:GetControler(),false,false,POS_FACEUP)
	end
end