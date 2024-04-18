local M = {}
local langs = require("nvim-commenter.langs")

function M.insert_char_before(str)
    local res = ""
    for i = 1, #str do
        res = res .. "%" .. str:sub(i, i)
    end
    return res
end

function M.comment_lines(start_idx, lines, info)
    local new_lines = {}

    for _, line in ipairs(lines) do
        local new_l = info[1] .. " " .. line
        if info[2] ~= "" then
            new_l = new_l .. " " .. info[2]
        end
        table.insert(new_lines, new_l)
    end

    for _, line in ipairs(new_lines) do
        print(line)
    end
    vim.api.nvim_buf_set_lines(0, start_idx, start_idx, false, new_lines)
end

function M.uncomment_lines(line_idx, lines, info)
    local new_lines = {}

    for _, line in ipairs(lines) do
        local start_match = string.match(line, "^%s*" .. M.insert_char_before(info[1]) .. "%s*")
        local end_match = string.match(line, "%s*" .. M.insert_char_before(info[2]) .. "$s*$")
        local new_l = line
        if start_match then
            new_l = string.gsub(new_l, start_match, "", 1)
        end
        if end_match then
            new_l = string.gsub(new_l, end_match, "", 1)
        end
        table.insert(new_lines, new_l)
    end

    vim.api.nvim_buf_set_lines(0, start_idx, start_idx, false, new_lines)
end

function M.find_line_pos()
    local start_num = 0
    local end_num = 0
    local mode = vim.api.nvim_get_mode().mode

    if mode == "n" then
        end_num, _ = unpack(vim.api.nvim_win_get_cursor(0))
        start_num = end_num - 1
    else
        start_num = vim.fn.getpos("'<")[2]
        end_num = vim.fn.getpos("'>")[2]
    end
    print(start_num, end_num)
    return start_num, end_num
end

function M.get_f_buff_lang()
    local extension = vim.api.nvim_buf_get_name(0):match("^.+(%..+)$"):gsub("^%.", "", 1)
    local info = {
        langs.languages[extension].first_comment,
        langs.languages[extension].last_comment
    }
    if not info then
        info = { "//", "" }
    end
    return info
end

return M
