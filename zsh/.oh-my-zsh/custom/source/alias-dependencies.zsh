#-------------------------------------------------------------------
# Alias important
case $(type diff) in
  (*alias*) unalias diff;;
esac

case $(type yout) in
  (*alias*) unalias yout;;
esac

case $(type ll) in
    (*alias*) unalias ll;;
esac

case $(type la) in
    (*alias*) unalias la;;
esac

case $(type l) in
    (*alias*) unalias l;;
esac

case $(type lla) in
    (*alias*) unalias lla;;
esac

case $(type ls) in
    (*alias*) unalias ls;;
esac

case $(type lsa) in
    (*alias*) unalias lsa;;
esac

case $(type rm) in
    (*alias*) unalias rm;;
esac


#-------------------------------------------------------------------
# Functions important

alias rmnn="$(which rm)"
alias rmn="rmnn -f"

diff() {

    delta --dark --line-numbers --navigate --tabs 4 --syntax-theme 'Monokai Extended' \
        --file-style='brightyellow' --minus-style='syntax #750000' \
        --minus-emph-style='syntax #c71a1a' --plus-style='syntax #01573f' \
        --plus-emph-style='syntax #198c6c' "$@"
}
