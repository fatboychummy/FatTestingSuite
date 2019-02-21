
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
  local failedSections = {}

  local function addSection(key)
    local isIn = false
    for i = 1,#failedSections do
      if failedSections[i][1] == key then
        isIn = true
        failedSections[i][2] = failedSections[i][2] + 1
        break
      end
    end
    -- Above: Checks if the current section is there
    if not isIn then
      failedSections[#failedSections + 1] = {key, 1}
    end
    -- If the current section is not there, add it.
  end

  -- Loop through the Sections (v)
  for k,v in pairs(list) do
    local testFails = 0

    -- Loop through the Tests (k2) in section k
    for k2, v2 in pairs(v) do
      --
      local f = k .. "." .. k2 .. "("
      for i = 2,#v2 do
        f = (type(v2[i]) == "string" and f .. "\"" .. v2[i] .. "\"")
          or (type(v2[i]) ~= "function" and type(v2[i]) ~= "table" and f
              .. tostring(v2[i]))
          or (f .. type(v2[i]))
          -- if function or table, just add the type of var
          -- if string, add "quotes"
          -- otherwise, just add the var
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
        print("  " .. tostring(passedTest))
        print("[ FAULT]: " .. f)
        -- if there is an error, print the info and the error
        testFails = testFails + 1
        addSection(k)
      else
        if passedTest then
          print("[    OK]: " .. f)
        else
          print("  " .. message)
          print("[ ERROR]: " .. f)
          testFails = testFails + 1
          addSection(k)
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
  print("Failures:")
  for i = 1,#failedSections do
    local s = failedSections[i]
    print(s[2] > 1 and "  " .. s[1] .. " (" .. s[2] .. " failures)"
      or "  " .. s[1] .. " (" .. s[2] .. " failure)")
  end
  if totalFails > 0 then
    return -1
  end
  return 1
end

function styleTest(file)
  --TODO: Figure out in what ways the files need to be tested
  --TODO: Figure out how to make the test "customizable"
  --TODO: Implement this
end


return runTests
-- Compatible with ??os.loadAPI??, require, dofile
