

dotfile=$(fd -t d  | fzf | tr -d "/")

files=$( cd $dotfile && fd -t f -H )

while IFS= read -r line; do
	eval "rm -r ~/$line"
done <<<"$files"

stow --adopt $dotfile

