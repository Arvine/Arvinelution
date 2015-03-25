--Destruction Magician
function c810000169.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--peffect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chkc then return chkc:IsLocation(LOCATION_MZONE) and c810000169.filter1(chkc) end
		if chk==0 then return not e:GetHandler():IsLocation(LOCATION_GRAVE)
			and Duel.IsExistingTarget(c810000169.filter1,tp,LOCATION_MZONE,0,1,nil) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,c810000169.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	end)
	e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) and c:IsRelateToEffect(e) then
			tc:RegisterFlagEffect(810000169,RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END,0,1)
		end
	end)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(0,0x1c0)
	e3:SetCountLimit(1)
	e3:SetTarget(c810000169.postg)
	e3:SetOperation(c810000169.posop)
	c:RegisterEffect(e3)
	-------------
	if not c810000169.global_check then
		c810000169.global_check=true
		local cxyzm=Duel.CheckXyzMaterial
		Duel.CheckXyzMaterial=function(c,f,lv,minc,maxc,og)
			local g=Duel.GetMatchingGroup(function(fc,flg,f,lv,c)
				return fc:GetFlagEffect(flg)>0 and fc:GetRank()==lv and (f==nil or f(fc))
			end,c:GetControler(),LOCATION_MZONE,0,nil,810000169,f,lv,c)
			minc=math.max(minc-g:GetCount(),0)
			maxc=math.max(maxc-g:GetCount(),0)
			return cxyzm(c,f,lv,minc,maxc,og)
		end
		local sxyzm=Duel.SelectXyzMaterial
		Duel.SelectXyzMaterial=function(tp,c,f,lv,minc,maxc)
			local g1=Duel.GetMatchingGroup(function(fc,flg,f,lv,c)
				return fc:GetFlagEffect(flg)>0 and fc:GetRank()==lv and (f==nil or f(fc))
			end,c:GetControler(),LOCATION_MZONE,0,nil,810000169,f,lv,c)
			local b=false
			local g2=Group.CreateGroup()
			if minc-g1:GetCount()<1 then b=Duel.SelectYesNo(tp,aux.Stringid(810000169,0)) end
			if not b then g2=sxyzm(tp,c,f,lv,math.max(minc-g1:GetCount(),1),maxc) end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local g=Duel.SelectMatchingCard(tp,function(fc,flg,f,lv,c)
				return fc:GetFlagEffect(flg)>0 and fc:GetRank()==lv and (f==nil or f(fc))
			end,c:GetControler(),LOCATION_MZONE,0,minc-g2:GetCount(),maxc-g2:GetCount(),nil,810000169,f,lv,c)
			local og=Group.CreateGroup()
			local ogc=g:GetFirst()
			while ogc do
				og:Merge(ogc:GetOverlayGroup())
				ogc=g:GetNext()
			end
			Duel.SendtoGrave(og,REASON_RULE)
			g:Merge(g2)
			return g
			 
		end
	end
end
function c810000169.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c810000169.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c810000169.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000169.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c810000169.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c810000169.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsDisabled() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e2)
	end
end
-----------------
function c810000169.filter1(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetFlagEffect(810000169)==0
end