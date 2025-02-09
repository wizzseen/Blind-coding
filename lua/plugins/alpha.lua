
return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
   
dashboard.section.header.val = {

"████████╗ █████╗ ██╗      ██████╗ ███████╗",        
"╚══██╔══╝██╔══██╗██║     ██╔═══██╗██╔════╝",        
"   ██║   ███████║██║     ██║   ██║███████╗",        
"   ██║   ██╔══██║██║     ██║   ██║╚════██║",        
"   ██║   ██║  ██║███████╗╚██████╔╝███████║",        
"   ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝",        
                                                      

    }







    -- Function to create a file
    _G.create_file = function(extension)
      vim.cmd("e code." .. extension)
    end

    -- Custom Buttons for File Creation
    dashboard.section.buttons.val = {
      dashboard.button("1", "  New Python File", function() create_file("py") end),
      dashboard.button("2", "  New Java File", function() create_file("java") end),
      dashboard.button("3", "  New C File", function() create_file("c") end),
      dashboard.button("4", "  New C++ File", function() create_file("cpp") end),
    }

    -- Apply changes
    alpha.setup(dashboard.config)
  end,
}



