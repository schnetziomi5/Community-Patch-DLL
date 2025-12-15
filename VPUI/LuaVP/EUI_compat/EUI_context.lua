if CodeBuddy.vpRegisterContext and not CodeBuddy.vpRegisterContext() then return end
local pairs= pairs
local print = print
print("==================================================================================================")
print("EUI CONTEXT",ContextPtr)
print("==================================================================================================")

include( "VPL_EUI" )

if not EUI then
	include( "EUI_core_library" )
	include( "EUI_tooltip_library" )
end

local EUI = EUI

for _, v in pairs( ContentManager.GetAllPackageIDs() ) do
	print( ContentManager.IsActive(v, ContentType.GAMEPLAY) and "Active DLC:" or "Disabled:", v, Locale.Lookup(ContentManager.GetPackageDescription(v)) )
end

for _, v in pairs( Modding.GetActivatedMods() ) do
	print("Active MOD:", v.ID, Modding.GetModProperty(v.ID, v.Version, "Name"), "Version", v.Version )
	if v.ID == "34fb6c19-10dd-4b65-b143-fd00b2c0826f" then
		EUI.deluxe_scenario = true
	end
end

if MapModData then
	MapModData.UI_bc1 = EUI
	ContextPtr:SetShutdown( function()
		print( "Shutdown", ContextPtr )
		MapModData.UI_bc1 = nil
	end)
end
print("==================================================================================================")
