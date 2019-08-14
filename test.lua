local striter = require('striter')

local iter = striter.new("abcdefgh")

assert(iter:next() == "a")
assert(iter:next(2) == "bc")
assert(iter:peek() == "d")
assert(iter:peek(2) == "de")
assert(iter:next(6) == "defgh")
assert(iter:next() == nil)
assert(iter:next(2) == nil)
assert(iter:peek() == nil)
assert(iter:peek(2) == nil)
