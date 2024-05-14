local M = {}

M.languages = {
    ["py"] = {
        first_comment = "#",
        last_comment = ""
    },
    ["lua"] = {
        first_comment = "--",
        last_comment = ""
    },
    ["c"] = {
        first_comment = "//",
        last_comment = ""
    },
    ["cpp"] = {
        first_comment = "//",
        last_comment = ""
    },
    ["cc"] = {
        first_comment = "//",
        last_comment = ""
    },
    ["js"] = {
        first_comment = "//",
        last_comment = ""
    },
    ["ts"] = {
        first_comment = "//",
        last_comment = ""
    },
    ["html"] = {
        first_comment = "<!--",
        last_comment = "-->"
    },
    ["css"] = {
        first_comment = "/*",
        last_comment = "*/"
    },
    ["sh"] = {
        first_comment = "#",
        last_comment = ""
    },
    ["go"] = {
        first_comment = "//",
        last_comment = ""
    },
    ["rs"] = {
        first_comment = "//",
        last_comment = ""
    }
}

function M.add_langs(langs)
    for l_name, l_info in pairs(langs) do
        M.languages[l_name] = l_info
    end
end

return M
