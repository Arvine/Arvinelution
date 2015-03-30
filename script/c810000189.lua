--RRR By Kent Arvine
function c810000189.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c810000189.xyzcon)
	e1:SetOperation(c810000189.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
end
function c810000189.tfilter(c)
	local lv=c:GetLevel()
	return lv>0 and c:IsFaceup()
end
function c810000189.xyzfilter1(c,g)
	return g:IsExists(c810000189.xyzfilter2,1,c,c:GetLevel())
end
function c810000189.xyzfilter2(c,lv)
	return c:IsSetCard(0x88) and c:GetLevel()==lv
end
function c810000189.xyzcon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c810000189.tfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and mg:IsExists(c810000189.xyzfilter1,1,nil,mg)
end
function c810000189.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local mg=Duel.GetMatchingGroup(c810000189.mfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g1=mg:FilterSelect(tp,c810000189.xyzfilter1,1,1,nil,mg)
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g2=mg:FilterSelect(tp,c810000189.xyzfilter2,1,1,tc1,tc1:GetLevel())
	local tc2=g2:GetFirst()
	g1:Merge(g2)
	c:SetMaterial(g1)
	Duel.Overlay(c,g1)
end