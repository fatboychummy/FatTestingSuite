local testAll = require("./FatTest")
local tests = require("./testFuncs")
local a = {
  testEQ = {
    Pass = {tests.EXPECT_EQ,3,3},
    Fail = {tests.EXPECT_EQ,3,5}
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
  }
}

testAll(a)
