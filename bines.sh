#!/bin/bash

echo -e "\e[35m
╔══╗─────╔═══╗
║╔╗║─────║╔═╗║
║╚╝╚╦╦═╗─║║─╚╬══╦═╗
║╔═╗╠╣╔╗╗║║╔═╣║═╣╔╗╗
║╚═╝║║║║║║╚╩═║║═╣║║║
╚═══╩╩╝╚╝╚═══╩══╩╝╚╝\e[0m"






echo -e "\e[31mGENERADOR DE CONTRASEÑAS SANHOMI\e[0m"


# Función para generar una contraseña aleatoria segura
generate_password() {
    local NAME=$1
    local LENGTH=$2
    head /dev/urandom | tr -dc 'a-zA-Z0-9@#$%&' | head -c $LENGTH | xargs echo -n
    echo -n "$NAME"
}

# Solicitar al usuario la cantidad de contraseñas a generar
read -p "Ingrese la cantidad de contraseñas a generar: " NUM_PASSWORDS

# Verificar si se ingresó un número válido
if ! [[ $NUM_PASSWORDS =~ ^[0-9]+$ ]]; then
    echo "Por favor ingrese un número válido."
    exit 1
fi

# Crear directorio en la tarjeta SD si no existe
SDCARD_DIR="/sdcard/passwords"
mkdir -p $SDCARD_DIR

# Generar contraseñas y guardar en archivos en la tarjeta SD
for ((i=1; i<=$NUM_PASSWORDS; i++)); do
    PASSWORD=$(generate_password $(date '+%s') 12)
    echo $PASSWORD > "$SDCARD_DIR/password_$i.txt"
    echo "Contraseña $i generada y guardada en $SDCARD_DIR/password_$i.txt"
done

echo "Proceso completado."