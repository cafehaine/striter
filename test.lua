-- ignore environment variables to prevent any conflicts with and installed
-- version of striter
package.path = "?.lua;?/init.lua"

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

local text = [[
Bonjour :)
Lorem ipsum
Dolor sit amet]]

iter = striter.new(text)
assert(iter:peek_pattern(":%(") == nil)
assert(iter:peek_pattern(":%)") == "Bonjour :)")
assert(iter:next_pattern("\n") == "Bonjour :)\n")
assert(iter:peek_line() == "Lorem ipsum")
assert(iter:peek_line(true) == "Lorem ipsum\n")
assert(iter:next_line() == "Lorem ipsum")
assert(iter:peek_line() == "Dolor sit amet")
assert(iter:next_line(true) == "Dolor sit amet")
assert(iter:peek_line() == nil)
