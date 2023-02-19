#!/bin/bash

#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

function ctrl_c(){
    echo -e "\n${red}[!] Saliendo ...${end}"
    tput cnorm; exit 1
}

trap ctrl_c INT

function helpPanel(){
    echo -e "\n${yellow}[i]${end}${gray} Uso:${end}\n"

    echo -e "\t${purple}-u${end}${gray} Introducir el numero de unidades${end}"
    echo -e "\t${purple}-m${end}${gray} Introducir la medida en la que esta la unidad ${end}${blue}($0 -m show para visualizar las medidas disponibles)${end}"
}

function helpPanelMedidas(){
    echo -e "\n${yellow}[i]${end}${gray} Medidas de longitud:${end}\n"

    echo -e "\t${gray}Pulgadas: ${end}${purple}in${end}"
    echo -e "\t${gray}Yardas: ${end}${purple}yard${end}"
    echo -e "\t${gray}Metros: ${end}${purple}m${end}"
    echo -e "\t${gray}Centimetros: ${end}${purple}cm${end}"
    echo -e "\t${gray}Milimetros: ${end}${purple}mm${end}"
    echo -e "\t${gray}Kilometros: ${end}${purple}km${end}"

    echo -e "\n${yellow}[i]${end}${gray} Medidas de peso:${end}\n"

    echo -e "\t${gray}Libras: ${end}${purple}lb${end}"
    echo -e "\t${gray}Kilogramos: ${end}${purple}kg${end}"
    echo -e "\t${gray}Gramos: ${end}${purple}g${end}"
    echo -e "\t${gray}Toneladas: ${end}${purple}t${end}"
}

function calcular_medida(){
    unidad=$1
    medida=$2
    convertir=$3

    declare -a medidas=("in" "yard" "m" "cm" "mm" "km" "lb" "kg" "g" "t" )

    for i in "${medidas[@]}"; do
        if [ "$i" == "$medida" ]; then
            medida_correcta=true
        fi

        if [ "$i" == "$convertir" ]; then
            convertir_correcto=true
        fi
    done

    if [ "$medida_correcta" != "true" ] && [ "$convertir_correcto" != "true" ]; then
        echo -e "\n${red}[!]${end}${gray} Introduce una medida y una conversion disponible de la lista"
        echo -e "\n${yellow}[i]${end}${gray} Usa ${blue}\"$0 -m show\"${end}${gray} para visualizar la lista de medidas disponibles${end}"
        exit 1
    elif [ "$medida_correcta" != "true" ]; then
        echo -e "\n${red}[!]${end}${gray} Introduce una medida disponible de la lista"
        echo -e "\n${yellow}[i]${end}${gray} Usa ${blue}\"$0 -m show\"${end}${gray} para visualizar la lista de medidas disponibles${end}"
        exit 1
    elif [ "$convertir_correcto" != "true" ]; then
        echo -e "\n${red}[!]${end}${gray} Introduce una conversion disponible de la lista"
        echo -e "\n${yellow}[i]${end}${gray} Usa ${blue}\"$0 -m show\"${end}${gray} para visualizar la lista de medidas disponibles${end}"
        exit 1
    fi

    if [ "$medida" == "$convertir" ]; then
        echo -e "\n${green}[+]${end}${yellow} $unidad$medida${end}${gray} = ${end}${yellow}$unidad$convertir${end}"
    fi

    # Convirtiendo medidas de longitud
    if [ "$medida" == "in" ] && [ "$convertir" == "yard" ]; then # Convirtiendo Pulgadas a Yardas
        resultado=`echo "scale=2; $unidad/36" | bc`

    elif [ "$medida" == "yard" ] && [ "$convertir" == "in" ]; then # Convirtiendo Pulgadas a Yardas
        resultado=`echo "scale=2; $unidad*36" | bc`

    elif [ "$medida" == "in" ] && [ "$convertir" == "m" ]; then # Convirtiendo Pulgadas a Metros
        resultado=`echo "scale=2; $unidad*0.0254" | bc`

    elif [ "$medida" == "m" ] && [ "$convertir" == "in" ]; then # Convirtiendo Metros a Pulgadas
        resultado=`echo "scale=2; $unidad/0.0254" | bc`

    elif [ "$medida" == "in" ] && [ "$convertir" == "cm" ]; then # Convirtiendo Pulgadas a Centimetros
        resultado=`echo "scale=2; $unidad*2.54" | bc`
    
    elif [ "$medida" == "cm" ] && [ "$convertir" == "in" ]; then # Convirtiendo Centimetros a Pulgadas
        resultado=`echo "scale=2; $unidad/2.54" | bc`

    elif [ "$medida" == "in" ] && [ "$convertir" == "mm" ]; then # Convirtiendo Pulgadas a Kilometros
        resultado=`echo "scale=2; $unidad*25.4" | bc`
    
    elif [ "$medida" == "mm" ] && [ "$convertir" == "in" ]; then # Convirtiendo Kilometros a Pulgadas
        resultado=`echo "scale=2; $unidad/25.4" | bc`

    elif [ "$medida" == "in" ] && [ "$convertir" == "km" ]; then 
        echo -e "\n${red}[!]${end}${gray} La conversion no tiene sentido ...${end}"
        exit 0
    elif [ "$medida" == "km" ] && [ "$convertir" == "in" ]; then 
        echo -e "\n${red}[!]${end}${gray} La conversion no tiene sentido ...${end}"
        exit 0

    elif [ "$medida" == "in" ] && [ "$convertir" == "mm" ]; then # Convirtiendo Pulgadas a Kilometros
        resultado=`echo "scale=2; $unidad*25.4" | bc`
    
    elif [ "$medida" == "mm" ] && [ "$convertir" == "in" ]; then # Convirtiendo Kilometros a Pulgadas
        resultado=`echo "scale=2; $unidad/25.4" | bc`

    elif [ "$medida" == "lb" ] && [ "$convertir" == "kg" ]; then # Convirtiendo Pulgadas a Kilometros
        resultado=`echo "scale=2; $unidad*0.45359237" | bc`
    
    elif [ "$medida" == "kg" ] && [ "$convertir" == "lb" ]; then # Convirtiendo Kilometros a Pulgadas
        resultado=`echo "scale=2; $unidad*2.20462262" | bc`

    elif [ "$medida" == "lb" ] && [ "$convertir" == "g" ]; then # Convirtiendo Pulgadas a Kilometros
        resultado=`echo "scale=2; $unidad*453.59237 " | bc`
    
    elif [ "$medida" == "g" ] && [ "$convertir" == "lb" ]; then # Convirtiendo Kilometros a Pulgadas
        resultado=`echo "scale=2; $unidad/453.59237 " | bc`
    
    elif [ "$medida" == "lb" ] && [ "$convertir" == "t" ]; then # Convirtiendo Pulgadas a Kilometros
        resultado=`echo "scale=2; $unidad/2000" | bc`
    
    elif [ "$medida" == "t" ] && [ "$convertir" == "lb" ]; then # Convirtiendo Kilometros a Pulgadas
        resultado=`echo "scale=2; $unidad*2000" | bc`

    else
        echo -e "\n${red}[!]${end}${gray} Elige unidades dentro de su medida${end}"
        exit 0
    fi

    echo -e "\n${green}[+]${end}${yellow} $unidad$medida${end}${gray} = ${end}${yellow}$resultado$convertir${end}"
}

declare -i parameter_counter=0

while getopts "hu:m:c:" arg; do
    case $arg in
        h) ;;
        u) unidad="$OPTARG"; let parameter_counter+=1;;
        m) medida="$OPTARG"; let parameter_counter+=2;;
        c) convertir="$OPTARG"; let parameter_counter+=3;;
    esac
done

if [ $unidad ] && [ $medida ] && [ $convertir ]; then
    calcular_medida $unidad $medida $convertir
elif [ "$medida" == "show" ]; then
    helpPanelMedidas
else 
    helpPanel
fi