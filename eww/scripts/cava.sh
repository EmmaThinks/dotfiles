#!/bin/bash

# Configuración temporal para que CAVA devuelva números crudos en lugar de una interfaz
config_file="/tmp/eww_cava_config"
cat > "$config_file" << 'EOF'
[general]
framerate = 30
bars = 8
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# Lee la salida cruda (ej. "1;4;7;2;") y mapea cada número a un bloque Unicode
cava -p "$config_file" | awk -F';' '{
    bars=" ▂▃▄▅▆▇█"
    str=""
    for(i=1; i<=NF-1; i++) {
        str = str substr(bars, $i+1, 1)
    }
    print str
    fflush()
}'
