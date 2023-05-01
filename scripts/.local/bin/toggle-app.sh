#!/bin/bash

# Nombre de la aplicación a buscar
APP_NAME="$1"

# Obtener el ID de la ventana de la aplicación
WINDOW_ID=$(xdotool search --name "$APP_NAME" )

# Verificar si se obtuvo el ID de la ventana correctamente
if [[ -z "$WINDOW_ID" ]]; then
  echo "No se pudo encontrar la ventana de $APP_NAME"
  eval "$2 &"
  exit 1
fi

echo $WINDOW_ID


for id in $WINDOW_ID; do

  # Obtener el número de escritorio de la ventana
  DESKTOP=$(xdotool get_desktop_for_window $id 2>/dev/null)

  if [[ $DESKTOP = "$(xdotool get_desktop)" ]]; then
   
    echo "Ocultar"
    xdotool set_desktop_for_window $id 4


  else
    echo "Mostrar"
    xdotool set_desktop_for_window $id $(xdotool get_desktop)

  fi

done
exit 0
