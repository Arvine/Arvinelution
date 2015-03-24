--Odd-Eyes Rebellion Dragon
function c810000171.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),7,2)
	c:EnableReviveLimit()
	--Place a Pendulum Card
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c810000171.condition1)
	e1:SetTarget(c810000171.target1)
	e1:SetOperation(c810000171.operation1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetCondition(c810000171.descon)
	e2:SetTarget(c810000171.destg)
	e2:SetOperation(c810000171.desop)
	c:RegisterEffect(e2)
	--Destroy and Damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c810000171.ddestg)
	e3:SetOperation(c810000171.ddesop)
	c:RegisterEffect(e3)
end
--Place a Pendulum Card
function c810000171.condition1(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,13-seq)
	return tc==nil
end
function c810000171.pfilter(c)
	return c:IsType(TYPE_PENDULUM)
end
function c810000171.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000171.pfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c810000171.operation1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c810000171.pfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,7,POS_FACEUP,true)
		Duel.ChangePosition(tc,POS_FACEUP)
	end
end
--ToPendulum
function c810000171.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_MZONE) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c810000171.desfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsDestructable()
end
function c810000171.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c810000171.desfilter,tp,LOCATION_SZONE,0,1,c) end
	local sg=Duel.GetMatchingGroup(c810000171.desfilter,tp,LOCATION_SZONE,0,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c810000171.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c810000171.desfilter,tp,LOCATION_SZONE,0,e:GetHandler())
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,7,POS_FACEUP,true)
		Duel.ChangePosition(e:GetHandler(),POS_FACEUP)
	end
end
--Destroy and Damage
function c810000171.ddfilter(c)
	return c:IsFaceup() and c:GetLevel()<=7 and c:IsDestructable()
end
function c810000171.ddestg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000171.ddfilter,tp,0,LOCATION_MZONE,1,nil) 
	and e:GetHandler():GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_XYZ) end
	local g=Duel.GetMatchingGroup(c810000171.ddfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c810000171.ddesop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c810000171.ddfilter,tp,0,LOCATION_MZONE,nil)
	local dam=Duel.Destroy(g,REASON_EFFECT)*1000
	Duel.Damage(1-tp,dam,REASON_EFFECT)	
	--multiattack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(2)
	c:RegisterEffect(e1)
end
