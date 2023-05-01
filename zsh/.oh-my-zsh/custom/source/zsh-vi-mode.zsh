#-------------------------------------------------------------------
# ZSH-VI-MODE

# Always starting with normal mode for each command line
# ZVM_LINE_INIT_MODE=$ZVM_MODE_NORMAL
ZVM_LINE_INIT_MODE=$ZVM_MODE_LAST

# Realizar la inicialización de forma ininterrumpida cuando este complemento se está abasteciendo.
ZVM_INIT_MODE=sourcing

# Define an init function and append to zvm_after_init_commands
#function my_init() {
#  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#}
#zvm_after_init_commands+=(my_init)

