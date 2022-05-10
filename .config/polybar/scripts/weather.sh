#!/bin/sh

get_icon() {
    case $1 in
        01d) icon="";;     # clear sky (day)
        01n) icon="";;     # clear sky (night)
        02d) icon="";;    # few clouds (day)
        02n) icon="";;   # few clouds (night)
        03*) icon="";;    # scattered clouds (day)
        04*) icon="";;     # broken clouds (day)
        09d) icon="";;     # shower rain (day)
        09n) icon="";;     # shower rain (night)
        10d) icon="";;    # rain (day)
        10n) icon="";;   # rain (night)
        11d) icon="";;    # thunderstorm (day)
        11n) icon="";;     # thunderstorm (night)
        13d) icon="";;    # snow (day)
        13n) icon="";;     # snow (night)
        50d) icon="";;   # mist (day)
        50n) icon="";;   # mist (night)
        *) icon="";
    esac

    echo $icon
}

DIR=$(dirname $(realpath $0))
KEY_FILE="${DIR}/openweathermap.key"

if [ ! -f ${KEY_FILE} ]; then
    echo "Access key required in 'openweathermap.key'"
    exit 1
fi

KEY=$(cat ${KEY_FILE})
CITY=""
UNITS="imperial"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi

    weather=$(curl -s "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)
		
    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        weather=$(curl -s "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi


if [ -n "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp | values" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon | values")
    weather_message=$(echo "$weather" | jq -r ".message | values") 

    if [ -n "$weather_message" ]; then
        echo ${weather_message}
    else
        echo "$(get_icon "$weather_icon")" "$weather_temp$SYMBOL"
    fi
fi

