#!/bin/bash

# Definir el directorio de respaldo
BACKUP_DIR="$HOME/proyecto-codecraft/backups"

# Crear el directorio de respaldo si no existe
if [ ! -d "$BACKUP_DIR" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - El directorio de respaldo no existe. Creando directorio."
    mkdir -p "$BACKUP_DIR"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - El directorio de respaldo ya existe."
fi

# Definir los archivos que se deben respaldar
FILES_TO_BACKUP=("$HOME/proyecto-codecraft/config.txt")

# Iterar sobre los archivos y respaldarlos
for FILE in "${FILES_TO_BACKUP[@]}"; do
    if [ -f "$FILE" ]; then
        BACKUP_FILE="$BACKUP_DIR/$(basename $FILE)_$(date '+%Y-%m-%d_%H-%M-%S').bak"
        cp "$FILE" "$BACKUP_FILE"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Respaldo exitoso de $FILE en $BACKUP_FILE."
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Advertencia: El archivo $FILE no se encuentra."
    fi
done

# Limpiar los respaldos más antiguos de más de 7 días
find "$BACKUP_DIR" -type f -mtime +7 -exec rm {} \;
echo "$(date '+%Y-%m-%d %H:%M:%S') - Respaldo completado y respaldos antiguos eliminados."
