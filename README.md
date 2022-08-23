# Unmaintained project!

I might take another stab at this, but at the moment I no longer plan on developing this.

# striter

The simple lua library to iterate through files and strings.

## What is striter
striter is a simple, pure-lua library to iterate through files and strings. It
can read or peek value from the iterator, which is really useful when writing a
parser.

It is not meant to be used as a "traditional" lua iterator like `pairs` or
`ipairs`. If you want to do that you can use the following example.

```lua
-- Iterate through each characters of a string
for c in str:gmatch(".") do
        print(c)
end
```

Instead, striter is meant to be used in parsers, where peeking while keeping
track of the current position is useful.
