local platform = require('utils.platform')

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   -- Start local Windows sessions in Git Bash by default.
   options.default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe', '--login', '-i' }
   options.launch_menu = {
      { label = 'PowerShell Core', args = { 'powershell.exe', '-NoLogo' }, domain = { DomainName = 'local' } },
      { label = 'PowerShell Desktop', args = { 'powershell' }, domain = { DomainName = 'local' } },
      { label = 'Command Prompt', args = { 'cmd' }, domain = { DomainName = 'local' } },
      { label = 'Msys2', args = { 'ucrt64.cmd' }, domain = { DomainName = 'local' } },
      {
         label = 'Bash',
         args = { 'C:\\Windows\\System32\\bash.exe' },
         domain = { DomainName = 'local' },
      },
      {
         label = 'Git Bash',
         args = { 'C:\\Program Files\\Git\\bin\\bash.exe' },
         domain = { DomainName = 'local' },
      },
   }
elseif platform.is_mac then
   options.default_prog = { '/opt/homebrew/bin/fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { '/opt/homebrew/bin/fish', '-l' } },
      { label = 'Nushell', args = { '/opt/homebrew/bin/nu', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
end

return options
