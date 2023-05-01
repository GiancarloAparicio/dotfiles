#-------------------------------------------------------------------
# FZF

export FZF_IGNORE="{**/node_modules,/vendor,.cache,src/vendor,**/*.org,**/*.com,**/honnef.co,**/cache,**/.vscode,**/tags,**/tags.*,**/.git}"

export FZF_COMPLETION_TRIGGER='**'

# FZF input
export FZF_DEFAULT_COMMAND=" fd -E '$FZF_IGNORE' "
# FZF configuration
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=100%
--multi
--ansi
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl+:#E64731,hl:#218B21,pointer:#E64731,marker:100,bg+:#6F91B4,gutter:#354753'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
--bind 'ctrl-v:execute(code {+})'
"

# CTRL-T: FZF input
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type=f"
# CTRL-T: FZF configuration
export FZF_CTRL_T_OPTS="--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) "

# ALT-C: FZF input
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND -c always --follow  --type=d"
# ALT-C: FZF configuration
export FZF_ALT_C_OPTS=""

# CTRL-R: FZF configuration
export FZF_CTRL_R_OPTS=" --no-preview "
