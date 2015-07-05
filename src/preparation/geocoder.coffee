
debug = require('debug')('geocoder')
PrevFileGeocoder      = require('./prev-file-geocoder')
OpenStreetMapGeocoder = require('./openstreetmap-geocoder')
GoogleGeocoder        = require('./google-geocoder')

require('es6-promise').polyfill()

class Geocoder


    constructor: ->
        @prevFileGeocoder = new PrevFileGeocoder()
        @osmGeocoder      = new OpenStreetMapGeocoder()
        @googleGeocoder   = new GoogleGeocoder()

        @prevFileGeocoder.setNext(@osmGeocoder)
        @osmGeocoder.setNext(@googleGeocoder)

    geocode: (locationName) ->

        debug('start loading geocode, %s', locationName)
        @prevFileGeocoder.geocode(locationName)


module.exports = Geocoder
