local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    error("telescope-gitmoji.nvim requires telescope.nvim - https://github.com/nvim-telescope/telescope.nvim")
end

local gm_actions = require("telescope._extensions.gitmoji.actions")
local gm_picker = require("telescope._extensions.gitmoji.picker")
local gm_emojis = require("telescope._extensions.gitmoji.emojis")

local action = gm_actions.commit
local commit_type = gm_emojis.emojis

local search = function(opts)
    opts = opts or {}

    defaults = {
        action = action,
        commit_type = commit_type,
    }

    gm_picker(vim.tbl_extend("force", defaults, opts), commit_type)
end

return telescope.register_extension({
    setup = function(cfg)
        commit_type = cfs.commit_type or gm_emojis.emojis
        action = cfg.action or gm_actions.commit
    end,
    exports = {
        gitmoji = search,
    },
})
