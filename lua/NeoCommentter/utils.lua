local langs = require("NeoCommentter.langs")

local function get_selection()
    local start_idx, end_idx = 0, 0
    local mode = vim.api.nvim_get_mode().mode

    if mode == "n" then
        end_idx = vim.api.nvim_win_get_cursor(0)[1]
        start_idx = end_idx - 1
    elseif mode == "V" then
        start_idx = vim.fn.getpos("v")[2]
        end_idx = vim.fn.getpos(".")[2]
        if start_idx > end_idx then
            start_idx, end_idx = end_idx, start_idx
        else
            start_idx = start_idx - 1
        end
    end
    return start_idx, end_idx
end

local function escape_seq(str)
    local res = ""
    for i = 1, #str do
        res = res .. "%" .. str:sub(i, i)
    end
    return res
end

local function add_comment(first_comment, last_comment, lines)
    local new_lines = {}

    for _, line in ipairs(lines) do
        local whitespace = string.match(line, "^%s*")
        local text = string.match(line, "^%s*(%S.*)")
        if text then
            line = whitespace .. first_comment .. " " .. text
            if last_comment ~= "" then
                line = line .. " " .. last_comment
            end
        end
        table.insert(new_lines, line)
    end

    return new_lines
end

local function remove_comment(first_comment, last_comment, lines)
    local new_lines = {}

    for _, line in ipairs(lines) do
        local start_whitespace = string.match(line, "^%s*")
        local start_match = nil
        local end_match = nil
        local pos = nil

        if first_comment ~= "" then
            start_match = string.match(line, "^%s*" .. escape_seq(first_comment) .. "%s*")
        end
        if last_comment ~= "" then
            end_match = string.match(line, "%s*" .. escape_seq(last_comment) .. "%s*$")
        end

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

    return new_lines
end

local function has_comment(lines, first_comment)
    local has = false
    for _, line in ipairs(lines) do
        if string.match(line, "^%s*" .. escape_seq(first_comment) .. " ") then
            has = true
            break
        end
    end
    return has
end

return {
    has_comment = has_comment,
    remove_comment = remove_comment,
    add_comment = add_comment,
    get_selection = get_selection,
}

