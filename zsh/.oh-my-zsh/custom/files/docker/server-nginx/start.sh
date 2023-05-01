#!/bin/bash

app_is_run=.run_app

run_main() {
	if [[ -f "$app_is_run" ]]; then
		docker compose start
        echo ".run_app" >>.gitignore

	else
		docker compose up -d
		touch .run_app

	fi
}

down_main() {
	docker compose down
}

#-------------------------------------------------------------------
# Execute

run_main || down_main
