
debug = require('debug')('geocoder')
OpenStreetMapGeocoder = require('./openstreetmap-geocoder')
GoogleGeocoder        = require('./google-geocoder')

require('es6-promise').polyfill()

class Geocoder


    constructor: ->
        @osmGeocoder    = new OpenStreetMapGeocoder()
        @googleGeocoder = new GoogleGeocoder()

        @osmGeocoder.setNext(@googleGeocoder)

    geocode: (locationName) ->

        debug('start loading geocode, %s', locationName)
        @osmGeocoder.geocode(locationName)


module.exports = Geocoder
