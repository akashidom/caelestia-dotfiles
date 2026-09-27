local home   = os.getenv("HOME")
local custom = home .. "/.config/caelestia/custom"
local hypr   = home .. "/.config/hypr"
package.path = package.path .. ";" .. home .. "/.config/caelestia/?.lua"
package.path = package.path .. ";" .. home .. "/.config/caelestia/custom/?.lua"

-- Create a file if it doesn't exist, optionally with initial content
local function maybe_create(file, content)
    local f = io.open(file)

    if f then
        f:close()
        return
    end

    f = io.open(file, "w")
    if f then
        if content then f:write(content) end
        f:close()
    end
end

-- Copy src to dst, but only if dst doesn't already exist
local function maybe_copy(src, dst)
    local out = io.open(dst)
    if out then
        out:close()
        return
    end

    local input = io.open(src, "r")
    if not input then return end

    out = io.open(dst, "w")
    if out then
        out:write(input:read("*a"))
        out:close()
    end
    input:close()
end

local function maybe_require(path)
    local file = path:match("([^/]+)%.%w+$")

    maybe_create(path)
    require(file)
end

local function list_dir(path)
    local files = {}
    local handle = io.popen('ls -1 "' .. path .. '"')
    if handle then
        for file in handle:lines() do
            table.insert(files, file)
        end
        handle:close()
    end
    return files
end

for _, file in ipairs(list_dir("/home/qasha/.config/caelestia/custom")) do
    maybe_require(custom .. "/" .. file)
end
