require("comment-divider").setup({
	maxLineWidth = 80,
	defaultStyle = {
		lineStart = "#",
		barrierCharacter = "-",
		lineEnd = "#",
	},
	filetypeStyles = {
		cpp = {
			lineStart = "/*",
			barrierCharacter = "-",
			lineEnd = "*/",
		},
		python = {
			lineStart = "#",
			barrierCharacter = "-",
			lineEnd = "#",
		},
		lua = {
			lineStart = "--",
			barrierCharacter = "-",
			lineEnd = "--",
		},
		markdown = {
			lineStart = "#",
			barrierCharacter = "-",
			lineEnd = "#",
		},
		nix = {
			lineStart = "#",
			barrierCharacter = "-",
			lineEnd = "#",
		},
		javascript = {
			lineStart = "/*",
			barrierCharacter = "-",
			lineEnd = "*/",
		},
		typescript = {
			lineStart = "/*",
			barrierCharacter = "-",
			lineEnd = "*/",
		},
	},
})
