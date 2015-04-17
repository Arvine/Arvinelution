--Multiple Destruction
function c810000233.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c810000233.target)
	e1:SetOperation(c810000233.activate)
	c:RegisterEffect(e1)
end
function c810000233.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		if e:GetHandler():IsLocation(LOCATION_HAND) then h1=h1-1 end
		local h2=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
		return h1>2 and h2>2 and Duel.IsPlayerCanDraw(tp,5) and Duel.IsPlayerCanDraw(1-tp,5)
	end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,5)
end
function c810000233.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(p,LOCATION_HAND,0)
	if g1:GetCount()==0 then return end
	local tc1=Duel.SendtoDeck(g1,nil,1,REASON_EFFECT)
	local ct1=tc1:GetCount()
	local g2=Duel.GetFieldGroup(p,LOCATION_HAND,0)
	if g2:GetCount()==0 then return end
	local tc2=Duel.SendtoDeck(g1,nil,1,REASON_EFFECT)
	local ct2=tc2:GetCount()
	local dmg=ct1+ct2
	Duel.SetLP(tp,Duel.GetLP(tp)-dmg*300)
	Duel.BreakEffect()
	Duel.Draw(tp,5,REASON_EFFECT)
	Duel.Draw(1-tp,5,REASON_EFFECT)
end
