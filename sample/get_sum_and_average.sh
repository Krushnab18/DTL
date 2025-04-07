#!/bin/bash

sum=0
count=0

is_valid_number() {
    if [[ $1 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
        return 0
    else
        return 1
    fi
}

echo "Enter numbers: (q to stop): "

while true; do
    read num

    if [[ "$num" == "q" ]]; then
        break
    fi

    if ! is_valid_number "$num"; then
        echo "Invalid input! Please enter a valid number."
        continue
    fi

    sum=$(echo "$sum + $num" | bc -l)
    count=$((count + 1))
done

if [[ $count -eq 0 ]]; then
    echo "No numbers entered."
else
    average=$(echo "$sum / $count" | bc -l)
    echo "Sum: $sum"
    echo "Average: $average"
fi
