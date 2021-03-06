package "vim"

cookbook_file "vim_config" do
  source "vim_config"
  path ZZ::Path.vim_config
end

directory "create syntax directory" do
  path ZZ::Path.vim_syntax_directory
  recursive true
end

cookbook_file "indent_1_space" do
  source "indent_1_space"
  path "#{ZZ::Path.vim_syntax_directory}/nerdtree.vim"
end

directory "create autoload directory" do
  path ZZ::Path.vim_autoload_directory
  recursive true
end

remote_file "download vim-plug" do
  source ZZ::Path.vim_plug_remote
  path   ZZ::Path.vim_plug_local
end

ruby_block "install vim plugins" do
  not_if { ZZ::Exec.vim_plugins_installed? }
  block { ZZ::Exec.install_vim_plugins }
end
