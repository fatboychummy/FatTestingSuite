local funcs = {}

--[[
function funcs.

end
]]

local function err(section,inf)
  return "Unexpected error in section " .. section .. ", function "
          .. inf .. "."
end

--[[Test list setup:
  list = {
    keySectionName = {
      keyTestName = functionTest
      ...
    },
    ...
  }
  function return setup:

{
  ok,
  error,
  passedTest,
  message --if failed
}

]]
function funcs.runTests(list)
  for k,v in pairs(list) do
    for k2, v2 in pairs(v) do
      local f = k .. "." .. k2 .. "()"
      print("[RUN  ]: " .. f)
      -- print what function is being tested
      local ok, er, passedTest, message = pcall(v2)
      -- run the function
      if not ok then
        printError(err(k,k2))
        printError(er)
        -- if there is an error, print the info and the error
      else
        if passedTest then
          print("[OKAY ]: " .. f)
        else
          printError("[ERROR]: " .. f)
          print(message)
        end
      end
    end
  end
end


return funcs
