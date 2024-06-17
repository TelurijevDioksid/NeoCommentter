local utils = require("NeoCommentter.utils")
local langs = require("NeoCommentter.langs")

local function setup(props)
    if io.open(langs.json_filename, "r") == nil then
        local file = io.open(langs.json_filename, "w")
        file:write("{}")
        file:close()
    end
    if props["langs"] then
        langs.add_langs(props["langs"])
    end
end

local function toggle_comment()
    local start_idx, end_idx = utils.get_selection()
    local lines = vim.api.nvim_buf_get_lines(0, start_idx, end_idx, false)
    local info = langs.get_lang_info()
    if not info then
        error("Cannot find comment for this language. Check your setup.")
    end
    local new_lines = {}
    if utils.has_comment(lines, info.begin) then
        new_lines = utils.remove_comment(info.begin, info.last, lines)
    else
        new_lines = utils.add_comment(info.begin, info.last, lines)
    end
    vim.api.nvim_buf_set_lines(0, start_idx, end_idx, false, new_lines)
end

local function uncomment()
    local start_idx, end_idx = utils.get_selection()
    local lines = vim.api.nvim_buf_get_lines(0, start_idx, end_idx, false)
    local info = langs.get_lang_info()
    if not info then
        error("Cannot find comment for this language. Check your setup.")
    end
    local new_lines = utils.remove_comment(info.begin, info.last, lines)
    vim.api.nvim_buf_set_lines(0, start_idx, end_idx, false, new_lines)
end

local function comment()
    local start_idx, end_idx = utils.get_selection()
    local lines = vim.api.nvim_buf_get_lines(0, start_idx, end_idx, false)
    local info = langs.get_lang_info()
    if not info then
        error("Cannot find comment for this language. Check your setup.")
    end
    local new_lines = utils.add_comment(info.begin, info.last, lines)
    vim.api.nvim_buf_set_lines(0, start_idx, end_idx, false, new_lines)
end

return {
    setup = setup,
    uncomment = uncomment,
    comment = comment,
    toggle_comment = toggle_comment,
}

