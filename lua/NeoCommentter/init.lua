local M = {}
local utils = require("NeoCommentter.utils")
local langs = require("NeoCommentter.langs")

function M.setup(props)
    if props then
        langs.add_langs(props)
    end
end

function M.toggle_comment()
    local start_num, end_num = utils.find_line_pos()
    local lines = vim.api.nvim_buf_get_lines(0, start_num, end_num, false)
    local info = utils.get_f_buff_lang()
    local commented = false

    for _, line in ipairs(lines) do
        local start_match = string.match(line, "^%s*" .. utils.insert_char_before(info[1]) .. " ")
        if start_match then
            commented = true
            break
        end
    end

    if commented then
        utils.uncomment_lines(start_num, end_num, lines, info)
    else
        utils.comment_lines(start_num, end_num, lines, info)
    end
end

function M.uncomment()
    local start_num, end_num = utils.find_line_pos()
    local lines = vim.api.nvim_buf_get_lines(0, start_num, end_num, false)
    local info = utils.get_f_buff_lang()
    utils.uncomment_lines(start_num, end_num, lines, info)
end

function M.comment()
    local start_num, end_num = utils.find_line_pos()
    local info = utils.get_f_buff_lang()
    local lines = vim.api.nvim_buf_get_lines(0, start_num, end_num, false)
    utils.comment_lines(start_num, end_num, lines, info)
end

return M
