local debug = debug ;
local G = debug.getregistry()._LOADED._G ;

local setfenv = G.setfenv ;
local getfenv = G.getfenv ;
local setmetatable = G.setmetatable ;
local collectgarbage = G.collectgarbage

local pcall = G.pcall ;
local print = G.print ;

local include = include ;
local env = function( tab ) if tab then setfenv(0,tab) else return getfenv(0) end end;
local mem = function() return collectgarbage("count")*1024 end ;
local gc = function() return mem() - mem(collectgarbage("collect")) end ;

debug.G = G ;
debug.include = include ;
debug.env = env ;
debug.mem = mem ;
debug.memdiff = memdiff ;


debug.testinclude = function(what)
	debug.TESTINGINCLUDES = true ;
	local backup = env() ;
	
	env( G.setmetatable( {include=function()end; print=function()end; ContextPtr={}; MapModData={} }, {__index = backup} ) );
	local _,ret = pcall(include,what)
	env(backup)
	
	debug.TESTINGINCLUDES = nil ;
	return ret[1] ;
end

debug.printincludes = function()
	print("This function doesn't always print its output correctly to the tuner, even if finished successfully. Check 'lua.log'!")
	local results = {}
	local out = "" ;
	for k,v in pairs(G.Threads) do
		k = "\\" .. v.StateName .. ".lua" ;
		incl = debug.testinclude( k ) ;
		out = out .. "\n" .. k .. "	" .. tostring(incl)  ;
		results[k] = incl ;
	end
	print("Done! Results:")
	print(out);
	return out, results ;
end




--include("debug_memtrack") ;

 