
-- This file shows an example structure of the tests.
-- This file may change depending on changes to the internal testing suite
local testAll = require("./FatTest")
local tests = require("./testFuncs")

local function returnFive()
  return 5
end

local a = {
  testEQ = {
    Pass = {tests.EXPECT_EQ,3,3},
    Fail = {tests.EXPECT_EQ,3,returnFive()}
  },
  testNEAR = {
    Pass = {tests.EXPECT_NEAR,15.87,15.89,0.020001},
    Fail = {tests.EXPECT_NEAR,100.30,93.5,5}
  },
  auto = {
    autoPass = {tests.PASS},
    autoFail = {tests.FAIL},
    autoErr = {tests.ERR}
  },
  expTHROW = {
    throwFailOk = {tests.EXPECT_THROW,function(a) return a end,"anError",3},
    throwFailWrongErr = {tests.EXPECT_THROW,function(a) error(a) end,"b","a"},
    throwPass = {tests.EXPECT_THROW,function(a) error(a) end,"a","a"}
  },
  expNOTHROW = {
    noThrowFail = {tests.EXPECT_NOTHROW,function(a) error(a) end,"a"},
    noThrowPass = {tests.EXPECT_NOTHROW,function(a) return a end,"a"}
  },
  expCUSTOM = {
    passTest = {tests.EXPECT_CUSTOM,function(a) return a end,true},
    failTest = {tests.EXPECT_CUSTOM,function(a, b) return a,b end,false,
                "This is a custom error message!"},
    errTest = {tests.EXPECT_CUSTOM,function(a) error(a) end,"Custom error!"},
  },
  expANYTHROW = {
    passSomeError = {tests.EXPECT_ANY_THROW,function(a) error(a) end,"blablabla"},
    failNoError = {tests.EXPECT_ANY_THROW,function(a) return a end,"h"}
  }
}

testAll(a)
