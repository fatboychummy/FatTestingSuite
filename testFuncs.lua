local funcs = {}

function funcs.EXPECT_EQ(a, b)
  return a == b, "EXPECT_EQ: " .. a .. " does not equal " .. b .. "."
end

function funcs.EXPECT_NEAR(a, b, diff)
  return a > b - diff and a < b + diff,
    "EXPECT_NEAR: " .. a .. ", and " .. b .. " are " .. math.abs(a - b)
    .. " apart, which is greater than " .. diff .. "."
end

function funcs.EXPECT_THROW(a,err,...)
  local ok,er = pcall(a,...)
  er = string.match(er,":%d+: (%S+)")
  return not ok and er == err,
    ok and "EXPECT_THROW: function did not throw error." or
    "EXPECT_THROW: \n    " .. er .. " (thrown)\n    " .. err .. " (expected)\n  errors do not match."
end

function funcs.FAIL()
  return false, "Forceful failure"
end

function funcs.PASS()
  return true
end

function funcs.ERR()
  error("Forced Error")
end

return funcs
