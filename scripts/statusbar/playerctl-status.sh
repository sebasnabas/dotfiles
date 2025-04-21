#!/usr/bin/env bash

PLAYER='playerctld'
# {% raw %}
FORMAT='{{ title }} - {{ artist }}'
# {% endraw %}

case "$(playerctl --player=$PLAYER status 2>/dev/null)" in
    Playing )
        playerctl --player=$PLAYER metadata --format "$FORMAT"
        ;;
    * )
        echo ""
        exit
        ;;
esac
