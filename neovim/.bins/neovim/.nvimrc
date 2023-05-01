colorscheme onedark

command -nargs=* -complete=file -bar Artisan :!docker-compose run --rm artisan <args>
