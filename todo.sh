#!/bin/bash

FILE="todo_list.txt"
touch "$FILE"

list_todos() {
    if [[ ! -s "$FILE" ]]; then
        echo "No TODOs found!"
    else
        echo -e "\n Your TODO List:\n"
        echo "No | priority | task"
        awk '{printf "%-3d | %s\n", NR, $0}' "$FILE"
        echo ""
    fi
}

add_todo() {
    local task="$1"
    local priority="$2"

    if [[ -z "$task" || -z "$priority" ]]; then
        echo "Usage: add <task> <priority: Low|Medium|High>"
        return 1
    fi

    case "$priority" in
    High) priority="1" ;;
    Medium) priority="2" ;;
    Low) priority="3" ;;
    *)
        echo "Invalid priority! Use High, Medium, or Low."
        return 1
        ;;
    esac

    echo "$priority | $task" >>"$FILE"
    echo "Added: $task with priority $priority"
}

remove_todo() {
    if [[ -z "$1" ]]; then
        echo "Usage: remove <line number | task text>"
        return 1
    fi

    if [[ "$1" =~ ^[0-9]+$ ]]; then
        sed -i "${1}d" "$FILE"
        echo "Removed item #$1"
    else
        sed -i "/| $1$/d" "$FILE"
        echo "Removed item: $1"
    fi
}

sort_todos() {
    sort -t '|' -k1,1n -o "$FILE" "$FILE"
    echo "TODO list sorted by priority!"
}

prepend_todo() {
    local task="$1"
    local priority="$2"

    case "$priority" in
    High) priority="1" ;;
    Medium) priority="2" ;;
    Low) priority="3" ;;
    *)
        echo "Invalid priority! Use High, Medium, or Low."
        return 1
        ;;
    esac

    echo "$priority | $task" | cat - "$FILE" >temp && mv temp "$FILE"
    echo "Prepended: $task"
}

append_todo() {
    local task="$1"
    local priority="$2"
    echo "$priority | $task" >>"$FILE"
    echo "Appended: $task"
}

deduplicate_todos() {
    sort -t '|' -k1,1n -u -o "$FILE" "$FILE"
    echo "Duplicates removed!"
}

show_help() {
    echo "Usage: $0 <command> [task] [priority]"
    echo "Commands:"
    echo "  list                          - Show the TODO list"
    echo "  add <task> <priority>         - Add a task (priority: Low, Medium, High)"
    echo "  remove <line number/task>     - Remove a task"
    echo "  sort                          - Sort tasks by priority"
    echo "  prepend <task> <priority>     - Add task at the beginning"
    echo "  append <task> <priority>      - Add task at the end"
    echo "  dedup                         - Remove duplicate tasks"
    echo "  help                          - Show this help menu"
}

case "$1" in
list) list_todos ;;
add)
    shift
    add_todo "$1" "$2"
    ;;
remove)
    shift
    remove_todo "$1"
    ;;
sort) sort_todos ;;
prepend)
    shift
    prepend_todo "$1" "$2"
    ;;
append)
    shift
    append_todo "$1" "$2"
    ;;
dedup) deduplicate_todos ;;
help | *) show_help ;;
esac
