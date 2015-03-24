--Toon Kingdom
function c810000160.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c810000160.rmtg)
	e1:SetOperation(c810000160.rmop)
	c:RegisterEffect(e1)
	--code
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_CODE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetValue(15259703)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTarget(c810000160.destg)
	e3:SetValue(c810000160.value)
	e3:SetOperation(c810000160.desop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(c810000160.tgtg)
	e4:SetValue(c810000160.tgval)
	c:RegisterEffect(e4)
end
function c810000160.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,5,tp,LOCATION_DECK)
end
function c810000160.rmop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local c=e:GetHandler()
	local g1=Duel.GetDecktopGroup(tp,3)
	Duel.DisableShuffleCheck()
	Duel.Remove(g1,POS_FACEDOWN,REASON_EFFECT)
end

function c810000160.dfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c810000160.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local count=eg:FilterCount(c810000160.dfilter,nil)
		e:SetLabel(count)
		return count>0
	end
	return Duel.SelectYesNo(tp,aux.Stringid(810000160,0))
end
function c810000160.value(e,c)
	return c:IsFaceup() and c:GetLocation()==LOCATION_MZONE and c:IsType(TYPE_TOON)
end
function c810000160.desop(e,tp,eg,ep,ev,re,r,rp)
	local count=e:GetLabel()
	local g1=Duel.GetDecktopGroup(tp,count)
	Duel.DisableShuffleCheck()
	Duel.Remove(g1,POS_FACEDOWN,REASON_EFFECT)
end


function c810000160.tgtg(e,c)
	return c:IsType(TYPE_TOON)
end
function c810000160.tgval(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
