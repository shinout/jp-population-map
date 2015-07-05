
debug = require('debug')('geocoder-responsible')

class GeocoderResponsible

    setNext: (geocoder) ->
        @next = geocoder
        return @


    geocode: (locationName) ->

        debug('start loading geocode via %s, %s', @name, locationName)

        new Promise (resolve, reject) =>

            @nodeGeocoder.geocode locationName, (err, res) =>

                if err
                    debug('error in geocoding %s via %s: %s', locationName, @name, err.message)
                    if @next
                        return resolve @next.geocode(locationName)
                    else
                        return reject err

                result = res[0]

                if not result?
                    debug('no result via %s: %s', @name, locationName)
                    if @next
                        return resolve @next.geocode(locationName)
                    else
                        return reject new Error("no result in geocoding #{locationName}")

                debug('successfully loaded via %s, %s[lat=%d, lng=%d]',
                    @name,
                    locationName,
                    result.latitude,
                    result.longitude
                )

                return resolve result


module.exports = GeocoderResponsible
