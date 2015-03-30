--Frightfur Backup
--scripted by: UnknownGuest
function c810000107.initial_effect(c)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN+EFFECT_DESTROY_REPLACE)
	--e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetTarget(c810000107.destg)
	e1:SetValue(c810000107.value)
	e1:SetOperation(c810000107.desop)
	c:RegisterEffect(e1)
end
function c810000107.dfilter(c)
	return c:IsControler(tp) and c:IsSetCard(0xad) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c810000107.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c810000107.dfilter,1,nil,tp) end
	if Duel.SelectYesNo(tp,aux.Stringid(810000107,0)) then
		Duel.SetTargetCard(eg)
		return  true
	else
		return false
	end
end
function c810000107.value(e,c)
	return c:IsControler(e:GetHandlerPlayer()) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c810000107.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(800)
	tc:RegisterEffect(e1)
end
