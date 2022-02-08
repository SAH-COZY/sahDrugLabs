Scaleform = {}
setmetatable(Scaleform, {})


-------------------------------
-- @param scaleformname string
-- @public
-- @return void
-------------------------------
function Scaleform:LoadScaleformMovie(scaleformname)
    local scaleformhandle = RequestScaleformMovie(scaleformname)
    while not HasScaleformMovieLoaded(scaleformhandle) do 
        Wait(1) 
    end
    return scaleformhandle
end

-------------------------------
-- @param scaleform_handle string
-- @param func_name string
-- @param params_list table
-- @private
-- @return void
-------------------------------
function Scaleform:ExecFunctionWithVoidReturn(scaleform_handle, func_name, params_list)
    PushScaleformMovieFunction(scaleform_handle, func_name)
    for i,v in ipairs(params_list) do
        if v.type == "string" then
            PushScaleformMovieFunctionParameterString(tostring(v.value))
        elseif v.type == "int" then
            PushScaleformMovieFunctionParameterInt(tonumber(v.value))
        elseif v.type == "bool" then
            PushScaleformMovieFunctionParameterBool(v.value)
        elseif v.type == "float" then
            PushScaleformMovieFunctionParameterFloat(v.value)
        elseif v.type == 'txt_string' then
            ScaleformMovieMethodAddParamTextureNameString(tostring(v.value))
        end
    end
    PopScaleformMovieFunctionVoid()
end

-------------------------------
-- @param scaleform_handle string
-- @param func_name string
-- @private
-- @return int
-------------------------------
function Scaleform:ExecFunctionWithReturn(scaleform_handle, func_name)
    BeginScaleformMovieMethod(scaleform_handle, func_name)
    local a = EndScaleformMovieMethodReturnValue()
    while not IsScaleformMovieMethodReturnValueReady(a) do
        Wait(0)
    end
    return GetScaleformMovieMethodReturnValueInt(a)                  
end