#!/bin/bash

# Ruta a tu binario de Rust recién compilado
RUST_BIN="$HOME/.config/eww/scripts/network-eww"

while true; do
    # Ejecuta el programa. Todo lo que imprima (println!) pasará directo a eww.
    $RUST_BIN

    # Si el programa de Rust muere (ej. exit(1) porque no hay interfaz),
    # el script llega a este punto.
    
    # Imprime el estado de desconexión para que eww lo muestre en la barra
    echo "192.168.1.72 DOWN"
    sleep 5
done
