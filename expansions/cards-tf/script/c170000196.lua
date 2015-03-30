--Big Bang Dragon Blow
function c170000196.initial_effect(c)
    --fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,110000110,c170000196.ffilter,1,true,true)
    --Big Bang Attack!
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(170000196,0))
    e1:SetCategory(CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
    e1:SetCost(c170000196.cost)
    e1:SetTarget(c170000196.tar)
    e1:SetOperation(c170000196.act)
    c:RegisterEffect(e1)
    --Equip Limit
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetValue(c170000196.eqlimit)
	c:RegisterEffect(e3)
end
function c170000196.eqlimit(e,c)
   return c:IsFaceup()
end
function c170000196.ffilter(c)
	return c:IsCode(170000153) and c:IsType(TYPE_SPELL)
end
function c170000196.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,e:GetHandler():GetEquipTarget(),RACE_DRAGON) end
    local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,e:GetHandler():GetEquipTarget(),RACE_DRAGON)
	Duel.Release(g,REASON_COST)
end
function c170000196.tar(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0,nil)
end
function c170000196.act(e,tp,eg,ep,ev,re,r,rp)
   if not e:GetHandler():IsFaceup() then return end
   local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
   if Duel.Destroy(g,REASON_EFFECT) and Duel.SelectYesNo(tp,aux.Stringid(13579,11)) then
   local sum=g:GetSum(Card.GetAttack)
   Duel.Damage(1-tp,sum,REASON_EFFECT)
end
end