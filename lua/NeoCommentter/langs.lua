local json_filename = vim.fn.stdpath("data") .. "/neocommentter_langs.json"

local function get_lang_info()
    local extension = vim.api.nvim_buf_get_name(0):match("^.+(%..+)$"):gsub("^%.", "", 1)
    local file = io.open(json_filename, "r")
    local langs = vim.fn.json_decode(file:read("*a"))
    file:close()
    local lang_info = nil

    for lang, info in pairs(langs) do
        if lang == extension then
            lang_info = info
            break
        end
    end

    return lang_info
end

local function add_langs(prop_langs)
    local file = io.open(json_filename, "r")
    local data = vim.fn.json_decode(file:read("*a"))
    file:close()

    for lang, info in pairs(prop_langs) do
        data[lang] = info
    end

    file = io.open(json_filename, "w")
    file:write(vim.fn.json_encode(data))
    file:close()
end

return {
    json_filename = json_filename,
    get_lang_info = get_lang_info,
    add_langs = add_langs
}

