#!/bin/bash

# VARIABLES DE CONFIGURACIÓN
DIRECTORIO=$HOME/clases/IA/2ºpractica/src/
numero_de_practica="02"
nombre_de_practica="Busqueda informada" # Si pones algo con espacios, deberás cambiar el makefile
Asignatura="IA"

# VARIABLES GLOBALES
proyecto=false
todo=()

# FUNCIONES
crear_directorio() {
  local dir=$1
  mkdir -p "$dir"
}

crear_archivo() {
  local dir=$1
  local archivo=$2
  local plantilla=$3
  local extension=$4
  local filepath="$dir/$archivo.$extension"
  touch "$filepath"
  sed \
    -e "s/¬/$archivo.$extension/g" \
    -e "s|\*date*|$(date +%D)|g" \
    -e "s|\*Asignatura|$Asignatura|g" \
    -e "s|\*programa_sin_cc|$archivo|g" \
    -e "s|\*numero|$numero_de_practica|g" \
    -e "s|\*nombre_practica|$nombre_de_practica|g" \
    "$plantilla" > "$filepath"
  
  # Añadir el archivo a la variable global todo
}

crear_makefile() {
  local dir=$1
  cp makefile "$dir/../makefile"
}

crear_proyecto() {
  local dir=$1
  crear_directorio "$dir/../data"
  crear_directorio "$dir/../docs"
  crear_archivo "$dir" "main" "maincc.txt" "cc"
  crear_directorio "$dir/funciones_main"
  crear_archivo "$dir/funciones_main/" "funciones_main" "funcionescc.txt" "cc"
  crear_archivo "$dir/funciones_main/" "funciones_main" "funcionesh.txt" "h"
  crear_makefile "$dir"
}

# PROGRAMA PRINCIPAL
if [ "$1" == "p" ]; then
  shift
  crear_proyecto "$DIRECTORIO"
  proyecto=true
fi
  crear_directorio "$DIRECTORIO"

while [ "$1" != "" ]; do
  PROGRAMA=$1
  shift
  crear_directorio "$DIRECTORIO$PROGRAMA"
  crear_archivo "$DIRECTORIO$PROGRAMA" "$PROGRAMA" "formatocc.txt" "cc"
  crear_archivo "$DIRECTORIO$PROGRAMA" "$PROGRAMA" "formatoh.txt" "h"
  todo+=("$PROGRAMA")
  todo+=("$PROGRAMA")
done

if [ "$proyecto" == true ]; then
  todo_string=$(printf " src/%s/%s.cc" "${todo[@]}")
  sed -e "s|\*title|$nombre_de_practica|g" -e "s|\*todo|$todo_string|g" makefile > "$DIRECTORIO"../makefile
fi
