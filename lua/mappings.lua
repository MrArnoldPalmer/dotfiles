local M = {
  abc = {
    n = {
      ["<F5>"] = {
        function()
          if vim.fn.filereadable(".vscode/launch.json") then
            require("dap.ext.vscode").load_launchjs(nil, {
              codelldb = {"rust"}
            })
          end
          require("dap").continue()
        end,
        "Launch Debugger",
      },
      ["<Leader>b"] = {
        function()
          require("dap").toggle_breakpoint()
        end,
        "Toggle Breakpoint"
      }
    }
  }
}

return M
