#!/bin/bash

# ---------------------------------------------------------
# Script de Respaldo y Mantenimiento - Proyecto CodeCraft
# ---------------------------------------------------------

# Variables
BACKUP_DIR="$HOME/proyecto-codecraft/backups"
LOG_FILE="$HOME/proyecto-codecraft/backup.log"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')
CONFIG_FILE="$HOME/proyecto-codecraft/config.txt"
SCRIPT_FILE="$HOME/proyecto-codecraft/script.sh"

# Función para registrar eventos en el log
log_event() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Comprobación de la existencia de los archivos a respaldar
if [ ! -f "$CONFIG_FILE" ]; then
    log_event "Error: El archivo config.txt no existe. No se puede respaldar."
    echo "Error: El archivo config.txt no existe."
    exit 1
fi

if [ ! -f "$SCRIPT_FILE" ]; then
    log_event "Error: El archivo script.sh no existe. No se puede respaldar."
    echo "Error: El archivo script.sh no existe."
    exit 1
fi

# Crear el directorio de respaldo si no existe
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    log_event "Directorio de respaldo '$BACKUP_DIR' creado."
fi

# Respaldo de archivos importantes con nombre único
cp "$CONFIG_FILE" "$BACKUP_DIR/config_$DATE.txt"
cp "$SCRIPT_FILE" "$BACKUP_DIR/script_$DATE.sh"

log_event "Respaldo de archivos completado. Archivos respaldados en $BACKUP_DIR."

# Mensaje de confirmación
echo "Respaldo de archivos completado correctamente."

# Subir los archivos al repositorio de GitHub
cd "$HOME/proyecto-codecraft"
git add "$BACKUP_DIR/*"
git commit -m "Respaldo realizado el $DATE"
git push origin master

log_event "Respaldo subido a GitHub con éxito."

# Eliminar respaldos antiguos (más de 7 días)
find "$BACKUP_DIR" -type f -mtime +7 -exec rm {} \;
log_event "Archivos de respaldo antiguos eliminados."

# Fin del script
echo "Respaldo y limpieza completados."
log_event "Proceso de respaldo y limpieza finalizado."
