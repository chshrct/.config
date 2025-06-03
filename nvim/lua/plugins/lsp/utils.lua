local M = {}

M.get_monorepo_root = function(startpath)
	return vim.fs.dirname(
		vim.fs.find(
			{ ".git", "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb" },
			{ path = startpath, upward = true }
		)[1]
	)
end

---@type fun(bufnr: number, on_dir: fun(dir: string))
M.get_root_dir = function(bufnr, on_dir)
	local full_path = vim.api.nvim_buf_get_name(bufnr)
	local root_path = M.get_monorepo_root(full_path)

	if root_path and vim.fn.isdirectory(root_path) == 1 then
		on_dir(root_path)
	else
		on_dir(vim.fs.dirname(full_path))
	end
end

-- Check if a file exists
function M.file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- Find solution files in the current directory and parent directories
function M.find_solution_files(start_path)
	local solution_files = {}
	local current_path = start_path or vim.fn.getcwd()
	
	-- Check current directory and up to 5 parent directories
	for i = 0, 5 do
		local sln_pattern = current_path .. "/*.sln"
		local matches = vim.fn.glob(sln_pattern, false, true)
		
		if #matches > 0 then
			for _, match in ipairs(matches) do
				table.insert(solution_files, match)
			end
			break
		end
		
		-- Move to parent directory
		local parent = vim.fn.fnamemodify(current_path, ":h")
		if parent == current_path then
			break
		end
		current_path = parent
	end
	
	return solution_files
end

-- Enhanced csharp-ls configuration with solution detection
function M.get_csharp_ls_config()
	return {
		cmd = { "csharp-ls" },
		filetypes = { "cs" },
		root_dir = function(fname)
			local root = require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git")(fname)
			return root
		end,
		settings = {
			csharp = {
				solution = nil, -- Will be auto-detected
				applyFormattingOptions = true,
			},
		},
		on_attach = function(client, bufnr)
			-- Custom on_attach logic for C#
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })
			
			-- Enable inlay hints if supported
			if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end,
	}
end

-- Enhanced OmniSharp configuration
function M.get_omnisharp_config()
	return {
		cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
		filetypes = { "cs", "vb" },
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git")(fname)
		end,
		settings = {
			FormattingOptions = {
				OrganizeImports = true,
				EnableEditorConfigSupport = true,
			},
			MsBuild = {
				LoadProjectsOnDemand = false,
			},
			RoslynExtensionsOptions = {
				EnableAnalyzersSupport = true,
				EnableImportCompletion = true,
				AnalyzeOpenDocumentsOnly = false,
				EnablePackageAutoRestore = true,
			},
		},
		handlers = {
			["textDocument/definition"] = function(...)
				if pcall(require, "omnisharp_extended") then
					return require("omnisharp_extended").handler(...)
				end
				return vim.lsp.handlers["textDocument/definition"](...)
			end,
		},
		on_attach = function(client, bufnr)
			-- Disable semantic tokens as they can be slow
			client.server_capabilities.semanticTokensProvider = nil
			
			-- Custom keymaps
			vim.keymap.set("n", "gd", function()
				if pcall(require, "omnisharp_extended") then
					require("omnisharp_extended").lsp_definitions()
				else
					vim.lsp.buf.definition()
				end
			end, { buffer = bufnr, desc = "Go to definition" })
			
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
		end,
	}
end

-- Roslyn LSP setup instructions
function M.get_roslyn_setup_info()
	return {
		plugin = "seblyng/roslyn.nvim",
		installation = [[
-- Add to your plugin manager (lazy.nvim example):
{
  "seblyng/roslyn.nvim",
  ft = "cs",
  opts = {
    -- Configuration options
    filewatching = "auto",
    broad_search = false,
    lock_target = false,
  },
  config = function(_, opts)
    require("roslyn").setup(opts)
  end,
}
]],
		features = {
			"Modern Microsoft Roslyn LSP",
			"Better performance than OmniSharp",
			"Support for multiple solutions",
			"Source generated files support",
			"Fix all and nested code actions",
			"Auto solution detection",
		},
	}
end

-- Function to install csharp-ls via dotnet tool
function M.install_csharp_ls()
	vim.fn.system("dotnet tool install --global csharp-ls")
	print("csharp-ls installed globally")
end

-- Check if required tools are available
function M.check_dependencies()
	local deps = {
		{ name = "dotnet", cmd = "dotnet --version", desc = ".NET SDK" },
		{ name = "csharp-ls", cmd = "csharp-ls --version", desc = "C# Language Server" },
		{ name = "omnisharp", cmd = "omnisharp --version", desc = "OmniSharp Language Server" },
	}
	
	print("Checking C# development dependencies:")
	for _, dep in ipairs(deps) do
		local result = vim.fn.system(dep.cmd)
		if vim.v.shell_error == 0 then
			print("✓ " .. dep.desc .. " is available")
		else
			print("✗ " .. dep.desc .. " is NOT available")
			if dep.name == "csharp-ls" then
				print("  Install with: dotnet tool install --global csharp-ls")
			elseif dep.name == "omnisharp" then
				print("  Install via Mason or package manager")
			end
		end
	end
end

return M
