
nodeGeocoder = require 'node-geocoder'

GeocoderResponsible = require './geocoder-responsible'

class GoogleGeocoder extends GeocoderResponsible


    constructor: ->
        @nodeGeocoder = nodeGeocoder('google')
        @name = 'google'

module.exports = GoogleGeocoder
