local M = {}
local utils = require("nvim-commenter.utils")
local langs = require("nvim-commenter.langs")

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
    return start_num, end_num
end

function M.setup(props)
    if props then
        langs.add_langs(props)
    end
end

function M.toggle_comment(start_arg, end_arg)
    local start_num, end_num = M.find_line_pos()
    if start_arg and end_arg then
        start_num = start_arg
        end_num = end_arg
    end
    local lines = vim.api.nvim_buf_get_lines(0, start_num, end_num, false)
    local info = utils.get_f_buff_lang()
    local commented = false

    print(start_num, end_num)
    for _, l in ipairs(lines) do
        print(l)
    end

    for _, line in ipairs(lines) do
        local start_match = string.match(line, "^" .. utils.insert_char_before(info[1]) .. " ")
        if start_match then
            commented = true
            break
        end
    end

    if commented then
        utils.uncomment_lines(start_num, lines, info)
    else
        utils.comment_lines(start_num, lines, info)
    end
end

function M.uncomment()
    local start_num, end_num = utils.find_line_pos()
    local lines = vim.api.nvim_buf_get_lines(0, start_num, end_num, false)
    utils.uncomment_lines(start_num, end_num, lines)
end

function M.comment()
    local start_num, end_num = utils.find_line_pos()
    local lines = vim.api.nvim_buf_get_lines(0, start_num, end_num, false)
    utils.comment_lines(start_num, end_num, f_buff)
end

M.setup()

return M
