--Singing Lanius
function c810000121.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCondition(c810000121.spcon)
	c:RegisterEffect(e1)
end
function c810000121.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c810000121.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000121.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
