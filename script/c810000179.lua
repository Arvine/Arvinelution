--Dark Magician of Chaos
function c810000179.initial_effect(c)
  --salvage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c810000179.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--redirect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e3:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e3)
	--leave
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e4:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e4)
end
function c810000179.recon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsPreviousLocation()==LOCATION_ONFIELD
end
function c810000179.op(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	if c:IsFaceup() then 
	local e1=Effect.CreateEffect(c)
	    e1:SetCategory(CATEGORY_TOHAND)
	    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	    e1:SetCode(EVENT_PHASE+PHASE_END)
	    e1:SetRange(LOCATION_MZONE)
		e1:SetCost(c810000179.addcost)
	    e1:SetTarget(c810000179.addtg)
	    e1:SetOperation(c810000179.addop)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_EVENT+0x1fe0000)
	    c:RegisterEffect(e1)
	end
end
function c810000179.filter(c)
    return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c810000179.addcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetFlagEffect(tp,810000179)==0 end
	Duel.RegisterFlagEffect(tp,810000179,RESET_PHASE+PHASE_END,0,1)
end
function c810000179.addtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingTarget(c810000179.filter,tp,LOCATION_GRAVE,0,1,nil) end 
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c810000179.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c810000179.addop(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then 
	    Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end