
local function err(section,inf)
  return "Unexpected error in section " .. section .. ", function "
          .. inf .. "."
end

--[[Test list setup:
  list = {
    keySectionName = {
      keyTestName = {functionTest, input1, input2, ... }
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
function runTests(list)
  local totalFails = 0
  for k,v in pairs(list) do
    local testFails = 0
    for k2, v2 in pairs(v) do
      --
      local f = k .. "." .. k2 .. "("
      for i = 2,#v2 do
        f = (type(v2[i]) == "string" and f .. "\"" .. v2[i] .. "\"")
          or (type(v2[i]) ~= "function" and type(v2[i]) ~= "table" and f .. v2[i])
          or (f .. type(v2[i]))
        if i < #v2 then
          f = f .. ", "
        end
      end
      f = f .. ")"
      -- above: combine name of tests into section.testName(inputs...)
      print("[RUN   ]: " .. f)
      -- print what function is being tested
      local ok, passedTest, message = pcall(table.unpack(v2))
      -- run the function
      if not ok then
        print(err(k,k2))
        print("  " .. passedTest)
        print("[ FAULT]: " .. f)
        -- if there is an error, print the info and the error
        testFails = testFails + 1
      else
        if passedTest then
          print("[  OKAY]: " .. f)
        else
          print("  " .. message)
          print("[ ERROR]: " .. f)
          testFails = testFails + 1
        end
      end
    end

    totalFails = totalFails + testFails
    print("All tests for section " .. k .. " completed.")
    print(tostring(testFails) .. " failed test(s).")
    print("---------------------------------")
  end
  print("All tests complete.")
  print("There were " .. tostring(totalFails) .. " failed test(s).")
  if totalFails > 0 then
    return -1
  end
  return 1
end

function styleTest(file)

end


return runTests
-- Compatible with os.loadAPI, require, dofile
