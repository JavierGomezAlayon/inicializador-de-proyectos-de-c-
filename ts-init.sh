#!/bin/bash
# Script para inicializar proyectos en TypeScript
# Crea, para cada nombre de proyecto dado:
#   - una carpeta en el directorio indicado
#   - un archivo entrada.txt vacío
#   - un archivo <nombre_proyecto>.ts con un ejemplo de código
#   - un archivo <nombre_proyecto>.test.ts con tests de ejemplo

# Directorio base para la creación de los proyectos
DIRECTORIO="$HOME/practicas/2024-2025-pai-p05-oop-JavierGomezAlayon/src/home-work/"

# Comprobar que se ha pasado al menos un argumento
if [ "$#" -lt 1 ]; then
  echo "Uso: $0 <nombre_proyecto> [<nombre_proyecto> ...]"
  exit 1
fi

# Iterar sobre cada proyecto pasado como argumento
for PROJECT_NAME in "$@"; do
  # Crear la carpeta del proyecto
  mkdir -p "$DIRECTORIO$PROJECT_NAME"

  # Crear el archivo entrada.txt vacío
  touch "$DIRECTORIO$PROJECT_NAME/entrada.txt"

  # Crear el archivo <nombre_proyecto>.ts
  cat <<EOF > "$DIRECTORIO$PROJECT_NAME/$PROJECT_NAME.ts"
/**
 * Universidad de La Laguna
 * Escuela Superior de Ingeniería y Tecnología
 * Grado en Ingeniería Informática
 * Programación de Aplicaciones Interactivas
 *
 * @author Javier Gómez Alayón
 * @since $(date +%D)
 * @desc 
 *       
 * @see {@link } 
 * 
 * Usage: ts-node $PROJECT_NAME.ts < entrada.txt
 * Test: npm test -- $PROJECT_NAME
 */

import * as FILESYS from 'fs';
// Si estás ejecutando los tests, no se lee el input.
const INPUT = process.env.NODE_ENV === 'test' ? '' : FILESYS.readFileSync('/dev/stdin', 'utf-8'); 

/**
 * 
 * @returns {number} - 
 */
export function $PROJECT_NAME(hours: number, minutes: number): number {
  return 0;
}

export function main(): void {
  const lines: string[] = INPUT.trim().split('\n');
  for (const line of lines) {
    if (line === '') { continue; }
    let numbers: string[] = line.split(/\s+/g);
    if (numbers === undefined) {
      const USAGE: string = 'Usage: ts-node $PROJECT_NAME.ts < entrada.txt';
      console.log(USAGE);
      return;
    }
    let hours: number = parseInt(numbers[0]);
    let minutes: number = parseInt(numbers[1]);
    let seconds: number = parseInt(numbers[2]);
    let time: number = $PROJECT_NAME(hours, minutes);
    console.log(time);
  }
  return;
}

main();
EOF

  # Crear el archivo <nombre_proyecto>.test.ts
  cat <<EOF > "$DIRECTORIO$PROJECT_NAME/$PROJECT_NAME.test.ts"
import { $PROJECT_NAME } from './$PROJECT_NAME';

EOF

  echo "Proyecto '$PROJECT_NAME' creado correctamente en $DIRECTORIO$PROJECT_NAME"
done
