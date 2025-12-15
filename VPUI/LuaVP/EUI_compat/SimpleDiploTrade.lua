if CodeBuddy.vpRegisterContext and not CodeBuddy.vpRegisterContext() then return end

-- Vanilla file with the bugfix from EUI/bc1 taken over

include( "TradeLogic" );
Events.OpenPlayerDealScreenEvent.Add( OnOpenPlayerDealScreen );
Controls.ModifyButton:RegisterCallback( Mouse.eLClick, OnModify );

ContextPtr:SetInputHandler( InputHandler );

Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnBack );

----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnDiploActivePlayerChanged()
	if not ContextPtr:IsHidden() then
		OnBack();
	end
end
Events.GameplaySetActivePlayer.Add(OnDiploActivePlayerChanged);

----------------------------------------------------------------        
----------------------------------------------------------------  
ContextPtr:SetShowHideHandler( function( isHide, isInit )
	OnShowHide( isHide, isInit );
	if not isInit and not isHide then
		LuaEvents.OpenSimpleDiploTrade();
	end
end);

----------------------------------------------------------------        
----------------------------------------------------------------  
function OnOpenAILeaderDiploTrade()
	-- An AI leader trade was started while we're open, close ourselves.
	if not ContextPtr:IsHidden() then
		OnBack();
	end
end
LuaEvents.OpenAILeaderDiploTrade.Add(OnOpenAILeaderDiploTrade);
