local M = {}
local langs = require("nvim-commenter.langs")

function M.insert_char_before(str)
    local res = ""
    for i = 1, #str do
        res = res .. "%" .. str:sub(i, i)
    end
    return res
end

function M.comment_lines(start_idx, end_idx, lines, info)
    local new_lines = {}

    for _, line in ipairs(lines) do
        local line_whitespace = string.match(line, "^%s*")
        local line_text = string.match(line, "^%s*(%S.*)")
        if line_text and line_whitespace then
            line = line_whitespace .. info[1] .. " " .. line_text
            if info[2] ~= "" then
                line = line .. " " .. info[2]
            end
        end
        table.insert(new_lines, line)
    end

    vim.api.nvim_buf_set_lines(0, start_idx, end_idx, false, new_lines)
end

function M.uncomment_lines(start_idx, end_idx, lines, info)
    local new_lines = {}

    for _, line in ipairs(lines) do
        local start_whitespace = string.match(line, "^%s*")
        local start_match = string.match(line, "^%s*" .. M.insert_char_before(info[1]) .. "%s*")
        local end_match = string.match(line, "%s*" .. M.insert_char_before(info[2]) .. "$s*$")
        local pos = nil
        if start_match then
            _, pos = string.find(line, start_match, 1, true)
            line = string.sub(line, pos + 1)
        end
        if end_match then
            pos, _ = string.find(line, end_match, 1, true)
            line = string.sub(line, 1, pos - 1)
        end
        line = start_whitespace .. line
        table.insert(new_lines, line)
    end

    vim.api.nvim_buf_set_lines(0, start_idx, end_idx, false, new_lines)
end

function M.find_line_pos()
    local start_num = 0
    local end_num = 0

    if vim.api.nvim_get_mode().mode == "n" then
        end_num = vim.api.nvim_win_get_cursor(0)[1]
        start_num = end_num - 1
    else
        start_num = vim.fn.getpos("v")[2]
        end_num = vim.fn.getpos(".")[2]
        local help = 0
        if start_num > end_num then
            help = start_num
            start_num = end_num - 1
            end_num = help
        else
            start_num = start_num - 1
        end
    end
    return start_num, end_num
end

function M.get_f_buff_lang()
    local extension = vim.api.nvim_buf_get_name(0):match("^.+(%..+)$"):gsub("^%.", "", 1)
    local info = langs.languages[extension]
    if info then
        info = {
            langs.languages[extension].first_comment,
            langs.languages[extension].last_comment
        }
    else
        print("Unknown file type, defaulting to //")
        info = { "//", "" }
    end
    return info
end

return M
