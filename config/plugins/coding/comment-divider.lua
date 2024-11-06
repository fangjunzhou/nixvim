require("comment-divider").setup({
	debug = false,
	commentLength = 64,
	defaultConfig = {
		lineStart = "#",
		lineSeperator = "-",
		lineEnd = "#",
	},
	languageConfig = {
		cpp = {
			lineStart = "/*",
			lineSeperator = "-",
			lineEnd = "*/",
		},
		python = {
			lineStart = "#",
			lineSeperator = "-",
			lineEnd = "#",
		},
		lua = {
			lineStart = "--",
			lineSeperator = "-",
			lineEnd = "--",
		},
    markdown = {
			lineStart = "#",
			lineSeperator = "-",
			lineEnd = "#",
    },
    nix = {
			lineStart = "#",
			lineSeperator = "-",
			lineEnd = "#",
    },
		javascript = {
			lineStart = "/*",
			lineSeperator = "-",
			lineEnd = "*/",
		},
		typescript = {
			lineStart = "/*",
			lineSeperator = "-",
			lineEnd = "*/",
		},
	},
})
