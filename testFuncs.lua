local funcs = {}

-- expects a and b to be equal.
function funcs.EXPECT_EQ(a, b)
  return a == b, "EXPECT_EQ: " .. tostring(a) .. " does not equal "
    .. tostring(b) .. "."
end

-- expects a and b to be near eachother, with a
-- maximum difference of "diff"
function funcs.EXPECT_NEAR(a, b, diff)
  return a > b - diff and a < b + diff,
    "EXPECT_NEAR: " .. tostring(a) .. ", and " .. tostring(b) .. " are " .. tostring(math.abs(a - b))
    .. " apart, which is greater than " .. tostring(diff) .. "."
end

-- expects an error to be thrown
-- a is the function to be tested, err is the error,
-- after that is function inputs
-- NOTE: ignores line numbers, only takes the stuff after "fileName.lua:53: "
function funcs.EXPECT_THROW(a, err, ...)
  local ok, er = pcall(a,...)
  er = string.match(er, ":%d+: (%S+)")
  return not ok and er == err,
    ok and "EXPECT_THROW: function did not throw error." or
    "EXPECT_THROW: \n    " .. tostring(er) .. " (thrown)\n    "
    .. tostring(err) .. " (expected)\n  errors do not match."
end

-- expects no error to be thrown
-- a is a function, then the function inputs are after
function funcs.EXPECT_NOTHROW(a, ...)
  local ok, er = pcall(a, ...)
  return ok, not ok and "EXPECT_NOTHROW: function threw error:\n  "
    .. tostring(er) or nil
end

-- create your own function to test, useful for testing
-- the structures of data, like a custom table or etc!
function funcs.EXPECT_CUSTOM(func, ...)
  local ok, good, er = pcall(func, ...)
  return ok and good,
    (not ok and "EXPECT_CUSTOM: Test function threw an error \n    "
    .. tostring(good))
    or (ok and not good and "EXPECT_CUSTOM: " .. tostring(er))
end

-- force a failed test.  Just to check if this is working
function funcs.FAIL()
  return false, "Forceful failure"
end

-- force a passed test.  Just to check if this is working
function funcs.PASS()
  return true
end

-- force an error.  Just to test if this is working
function funcs.ERR()
  error("Forced Error")
end

return funcs
