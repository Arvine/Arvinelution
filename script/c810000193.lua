--fluffal wing
function c810000193.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45705025,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c810000193.condition)
	e1:SetTarget(c810000193.target)
	e1:SetOperation(c810000193.operation)
	c:RegisterEffect(e1)
end
function c810000193.cfilter(c)
	return c:IsFaceup() and c:IsCode(70245411)
end
function c810000193.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c810000193.cfilter,tp,LOCATION_SZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(c810000193.filter,tp,LOCATION_GRAVE,0,2,e:GetHandler())
end
function c810000193.filter(c)
	return c:IsCode(810000193) and c:IsAbleToRemove()
end
function c810000193.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c810000193.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c810000193.filter,tp,LOCATION_GRAVE,0,2,e:GetHandler(),e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c810000193.filter,tp,LOCATION_GRAVE,0,2,2,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c810000193.cfilter2(c,e)
	return c:IsRelateToEffect(e)
end
function c810000193.cfilter3(c)
	return c:IsFaceup() and c:IsCode(70245411) and c:IsReleasable()
end
function c810000193.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c810000193.cfilter2,nil,e,tp)
	if tc:GetCount()<2 then return end
	if tc and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
		Duel.Draw(tp,2,REASON_EFFECT)
		local bg=Duel.GetMatchingGroup(c810000193.cfilter3,tp,LOCATION_SZONE,0,nil,e,tp)
		if Duel.SelectYesNo(tp,aux.Stringid(126218,1)) then
			local sg=bg:Select(tp,1,1,nil)
			Duel.Release(sg,REASON_COST)
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end