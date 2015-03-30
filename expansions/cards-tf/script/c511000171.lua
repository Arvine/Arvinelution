--Spell Sanctuary
function c511000171.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000171.target)
	e1:SetOperation(c511000171.activate)
	c:RegisterEffect(e1)
	--make quickplay
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_SZONE+LOCATION_HAND,LOCATION_SZONE+LOCATION_HAND)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetTarget(c511000171.spell)
	e2:SetValue(TYPE_QUICKPLAY)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c511000171.target1)
	e3:SetOperation(c511000171.operation)
	c:RegisterEffect(e3)
end
function c511000171.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511000171.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511000171.spell(e,c)
	return c:IsType(TYPE_SPELL)
end
function c511000171.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,c511000171.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(1-tp,c511000171.filter,tp,0,LOCATION_DECK,1,1,nil)
	local tc2=g2:GetFirst()
	g1:Merge(g2)
	Duel.SendtoHand(g1,nil,REASON_EFFECT)
	if tc1 then Duel.ConfirmCards(1-tp,tc1) end
	if tc2 then	Duel.ConfirmCards(tp,tc2) end
end
function c511000171.filter1(c)
return (c:IsPosition(POS_FACEDOWN) and c:IsLocation(LOCATION_SZONE) and c:IsType(TYPE_SPELL) and c:CheckActivateEffect(false,false,false)~=nil)
	or (c:IsLocation(LOCATION_HAND) and c:IsType(TYPE_SPELL) and c:CheckActivateEffect(false,false,false)~=nil and not c:IsPublic())
end
function c511000171.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetTurnPlayer()==tp then
			if Duel.IsExistingMatchingCard(c511000171.filter1,tp,LOCATION_HAND,0,1,nil) and not Duel.IsExistingMatchingCard(c511000171.filter1,tp,LOCATION_SZONE,0,1,nil) then
				return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
			else
				return Duel.IsExistingMatchingCard(c511000171.filter1,tp,LOCATION_HAND+LOCATION_SZONE,0,1,nil)
			end
		else
			return Duel.IsExistingMatchingCard(c511000171.filter1,tp,LOCATION_SZONE,0,1,nil)
		end
	end
	local g=nil
	if Duel.GetTurnPlayer()==tp then
		if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then
			g=Duel.SelectTarget(tp,c511000171.filter1,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
		else
			g=Duel.SelectTarget(tp,c511000171.filter1,tp,LOCATION_HAND+LOCATION_SZONE,0,1,1,nil,e,tp)
		end
	end
	if Duel.GetTurnPlayer()~=tp and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		g=Duel.SelectTarget(tp,c511000171.filter1,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	end
	if g:GetFirst():IsLocation(LOCATION_SZONE) then
		Duel.ChangePosition(g:GetFirst(),POS_FACEUP)
	end
	if g:GetFirst():IsLocation(LOCATION_HAND) then
		local tpe=g:GetFirst():GetType()
		if bit.band(tpe,TYPE_FIELD)~=0 then
			local of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if of then
				if Duel.Destroy(of,REASON_RULE)==0 then
					Duel.SendtoGrave(tc,REASON_RULE)
				end
			end
		end
		Duel.MoveToField(g:GetFirst(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
function c511000171.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	local tpe=tc:GetType()
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	local co=te:GetCost()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	Duel.Hint(HINT_CARD,0,tc:GetCode())
	tc:CreateEffectRelation(te)
	if tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD) or tc:GetCode()==72302403 or tc:GetCode()==84808313 or tc:GetCode()==511000217 then
		tc:CancelToGrave()
	else
		Duel.SendtoGrave(tc,REASON_RULE)
	end
	if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
	if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
	Duel.BreakEffect()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
		local etc=g:GetFirst()
		while etc do
			etc:CreateEffectRelation(te)
			etc=g:GetNext()
		end
	end
	if op then op(te,tp,eg,ep,ev,re,r,rp) end
	tc:ReleaseEffectRelation(te)
	if etc then	
		etc=g:GetFirst()
		while etc do
			etc:ReleaseEffectRelation(te)
			etc=g:GetNext()
		end
	end
end