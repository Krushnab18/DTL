#!/bin/bash

view_menu() {
    echo "Enter operation"
    echo "1. Addition"
    echo "2. Subtraction"
    echo "3. Multiplication"
    echo "4. Division"
    echo "5. Exit"
}

is_number() {
    [[ "$1" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]
}

while true; do
    read -p "Enter first number: " a
    read -p "Enter second number: " b

    # Validate input
    if ! is_number "$a" || ! is_number "$b"; then
        echo "invalid input. please enter numeric values."
        continue
    fi

    view_menu
    read -p "choose operation: " op

    case "$op" in
    1)
        ans=$(echo "$a + $b" | bc -l)
        echo "Result: $ans"
        ;;
    2)
        ans=$(echo "$a - $b" | bc -l)
        echo "Result: $ans"
        ;;
    3)
        ans=$(echo "$a * $b" | bc -l)
        echo "Result: $ans"
        ;;
    4)
        if [[ "$b" == 0 ]]; then
            echo "Error: Division by zero is not allowed."
        else
            ans=$(echo "scale=5; $a / $b" | bc -l)
            echo "Result: $ans"
        fi
        ;;
    5)
        echo "Exiting..."
        break
        ;;
    *)
        echo "Invalid Operation"
        ;;
    esac
done
