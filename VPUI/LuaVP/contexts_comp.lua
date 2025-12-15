if __MapModData then
	if CPK then
		__MapModData.CPK = CPK ;
	end

	if VP then
		__MapModData.VP = VP ;
		if not ContextPtr:LookUpControl("VPUI_common") then
			__MapModData.CommonContext = ContextPtr:LoadNewContext("VPUI_common") ;
		end
	end

	if EUI then
		__MapModData.UI_bc1 = EUI ;
		local EUI_context = ContextPtr:LookUpControl("EUI_context");
		if EUI_context then
			ContextPtr:ReleaseChild(EUI_context);
		end
		ContextPtr:LoadNewContext("EUI_context");
	end
	
end
