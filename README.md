# Earthquakes JSON API

This is an app which provides a JSON API of worldwide earthquakes in the past 7 days.

## API:

This API is read-only which responds to GET requests.

- With no params, return all earthquakes in the past 7 days.


It accepts the following optional parameters:

- `on` &ndash; Returns earthquakes on the same day (UTC) as the 10-digit unix timestamp it's passed.

- `since` &ndash; Returns all earthquakes since the 10-digit unix timestamp it's passed.

- `over` &ndash; Returns all earthquakes greater than the decimal number representing the earthquake's magnitude that it's passed.

- `near` &ndash; Returns all earhtquakes within 5-mile radius of the latitude and longitude that it's passed.

## EXAMPLES:

    GET /earthquakes.json
    # Returns all earthquakes

    GET /earthquakes.json?on=1364582194
    # Returns earthquakes on the same day (UTC) as the unix timestamp 1364582194

    GET /earthquakes.json?since=1364582194
    # Returns earthquakes since the unix timestamp 1364582194

    GET /earthquakes.json?over=3.2
    # Returns earthquakes > 3.2 magnitude

    GET /earthquakes.json?near=36.6702,-114.8870
    # Returns all earthquakes within 5 miles of lat: 36.6702, lng: -114.8870

Note that if `on` and `since` are both specified, it will return results since the timestamp until the end of that day.

    GET /earthquakes.json?over=3.2&near=36.6702,-114.8870&since=1364582194
    # Returns all earthquakes over 3.2 magnitude within 5 miles of 36.6702,-114.8870 since 2013-03-29 18:36:34 UTC

    GET /earthquakes.json?over=3.2&on=1364582194&since=1364582194
    # Returns all earthquakes over 3.2 magnitude between 2013-03-29 18:36:34 UTC and 2013-03-29 23:59:59 UTC
