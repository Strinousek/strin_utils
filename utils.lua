Utils = {}

Utils.sortTableValues = function(tbl, valKey, factor)
    if(not factor) then
        table.sort(tbl, function(a, b)
            if(valKey) then
                return a[valKey] < b[valKey]
            else
                return a < b
            end
        end)
        return tbl
    end
end

Utils.areTableValuesTrue = function(tbl, checkTables)
    local valid = true
    for k,v in pairs(tbl)
        if(checkTables and type(v) == "table") then
            if(not next(v)) then
                valid = false
            else
                if(not Utils.areTableValuesTrue(v, true)) then
                    valid = false
                end
            end
        elseif(not v) then
            valid = false
        end
        if(not valid) then
            break
        end
    end
    return valid
end

Utils.doesTableContain = function(tbl, reqVal, valKey)
    local doesContain = false
    if(not valKey) then
        for _,v in pairs(tbl) do
            if(doesContain) then
                break;
            end
            if(type(v) == "table") then
                doesContain = Utils.doesTableContain(v, reqVal)
            else
                doesContain = (v == reqVal) and true or false
            end
        end
    else
        local v = tbl[valKey]
        if(v and (not (type(v) == "table"))) then
            doesContain = (v == reqVal) and true or false
        elseif(v and (type(v) == "table")) then
            doesContain = Utils.doesTableContain(v, reqVal)
        end
    end
    return doesContain
end
 
Utils.dprint = function(val)
    if(type(val) == "table") then
        print("[DEBUG]: "..json.encode(val))
    elseif(type(val) == "boolean") then
        print("[DEBUG]: "..tostring(val))
    else
        print("[DEBUG]: "..val)
    end
end

export("getUtils", function()
    return Utils
end)