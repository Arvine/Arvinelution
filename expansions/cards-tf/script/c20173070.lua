--Final Attack Orders
function c20173070.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c20173070.target)
	e1:SetOperation(c20173070.operation)
	c:RegisterEffect(e1)
	--Pos Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_POSITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e3)
end
function c20173070.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return  Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 and  Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>2 end
	
end
function c20173070.operation(e,tp,eg,ep,ev,re,r,rp)	
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(20173070,0))
	local g1=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,3,3,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(20173070,0))
	local g2=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_DECK,0,3,3,nil)
	local d=Duel.GetFieldGroup(tp,LOCATION_DECK,LOCATION_DECK)
	d:Sub(g1)
	d:Sub(g2)
	Duel.DisableShuffleCheck()
	Duel.SendtoGrave(d,REASON_EFFECT)
	if d:GetCount()>0 then
		Duel.SortDecktop(tp,tp,3)
		Duel.SortDecktop(1-tp,1-tp,3)
	end
end
