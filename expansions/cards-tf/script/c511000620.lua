--Hardship
function c511000620.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000620.target)
	e1:SetOperation(c511000620.operation)
	c:RegisterEffect(e1)
	--Equip limit
    local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--no damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(511000563,0))
	e3:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c511000620.con)
	e3:SetCost(c511000620.cost)
	e3:SetOperation(c511000620.op)
	c:RegisterEffect(e3)
	--salvage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000620,1))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCost(c511000620.descost)
	e4:SetTarget(c511000620.destg)
	e4:SetOperation(c511000620.desop)
	c:RegisterEffect(e4)
end
function c511000620.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000620.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511000620.con(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and (cp==tp or cp==PLAYER_ALL) then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ex and (cp==tp or cp==PLAYER_ALL) and Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER) and ep~=tp and re:IsActiveType(TYPE_MONSTER)
end
function c511000620.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then return eq:GetAttack()>0 and eq:GetDefence()>0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(0)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	eq:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_DEFENCE_FINAL)
	e2:SetValue(0)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	eq:RegisterEffect(e2)
end
function c511000620.op(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c511000620.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
end
function c511000620.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then return 0
	else return val end
end
function c511000620.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
	e:SetLabelObject(eq)
end
function c511000620.filter(c)
	return c:IsType(TYPE_EQUIP) and (c:IsDestructable() or c:IsAbleToGrave())
end
function c511000620.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000620.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,c) 
	or eq:IsDestructable() or eq:IsAbleToGrave() end
	local g=Duel.GetMatchingGroup(c511000620.filter,tp,LOCATION_SZONE,LOCATION_SZONE,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511000620.senfilter(c)
	return c:IsLocation(LOCATION_ONFIELD)
end
function c511000620.desop(e,tp,eg,ep,ev,re,r,rp)
	local g2=Group.CreateGroup()
	g2:AddCard(e:GetLabelObject())
	local g=Duel.GetMatchingGroup(c511000620.filter,tp,LOCATION_SZONE,LOCATION_SZONE,e:GetHandler())
	g:Merge(g2)
	Duel.Destroy(g,REASON_EFFECT)
	g=g:Filter(c511000620.senfilter,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
