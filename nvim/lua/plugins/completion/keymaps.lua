local M = {}

M.cmp = function(cmp, luasnip)
  return {
    -- confirm selection
    ["<CR>"] = cmp.mapping({
      i = cmp.mapping.confirm({ select = true }),
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ select = false }),
    }),

    -- toggle completion
    ["<C-e>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()
        fallback()
      else
        cmp.complete()
      end
    end, {
      "i",
      "s",
      "c",
    }),

    ["<C-j>"] = cmp.mapping(function()
      cmp.select_next_item()
    end, {
      "i",
      "s",
      "c",
    }),
    ["<C-k>"] = cmp.mapping(function()
      cmp.select_prev_item()
    end, {
      "i",
      "s",
      "c",
    }),

    -- scrol docs
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),

    -- snippet
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    -- ["<C-S-l>"] = cmp.mapping(function()
    --   if luasnip.locally_jumpable(-1) then
    --     luasnip.jump(-1)
    --   end
    -- end, { "i", "s" }),
  }
end

return M
