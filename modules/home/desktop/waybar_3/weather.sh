#!/usr/bin/env bash

set -e

get_weather() {
    RAW=$(curl -s --max-time 5 "wttr.in/Madrid?format=%c|%t&lang=en" || echo "")

    if [[ -z "$RAW" || ! "$RAW" == *"|"* ]]; then
        echo '{"text": "󰖐 --°C", "tooltip": "Error: wttr.in unreachable or timed out"}'
        return 0
    fi

    CONDITION_EMOJI=$(echo "$RAW" | cut -d'|' -f1 | xargs)
    TEMP=$(echo "$RAW" | cut -d'|' -f2 | xargs)

    ICON="$CONDITION_EMOJI"

    case "$CONDITION_EMOJI" in
        "✨"*) ICON="󱐋" ;;
        "☁️"*|"☁"*) ICON="󰖐" ;;
        "🌫️"*|"🌫"*) ICON="󰖑" ;;
        "🌧️"*|"🌧"*) ICON="󰖗" ;;
        "❄️"*|"❄"*) ICON="󰼶" ;;
        "🌦️"*|"🌦"*) ICON="󰖕" ;;
        "🌨️"*|"🌨"*) ICON="󰼴" ;;
        "⛅️"*|"⛅"*) ICON="󰖕" ;;
        "☀️"*|"☀"*) ICON="󰖙" ;;
        "🌩️"*|"🌩"*) ICON="󰖓" ;;
        "⛈️"*|"⛈"*) ICON="󰙾" ;;
    esac

    TOOLTIP=$(curl -s --max-time 5 "wttr.in/Madrid?0QT&lang=en" | sed 's/\x1b\[[0-9;]*m//g' || echo "Tooltip unavailable")

    jq -n \
        --arg text "$ICON $TEMP" \
        --arg tooltip "$TOOLTIP" \
        '{"text": $text, "tooltip": $tooltip}' | tr -d '\n\r'
}

if ! get_weather; then
    echo '{"text": "󰖐 --°C", "tooltip": "Script encountered an unhandled execution error"}'
fi
