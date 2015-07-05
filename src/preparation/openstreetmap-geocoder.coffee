
nodeGeocoder = require 'node-geocoder'

GeocoderResponsible = require './geocoder-responsible'

class OpenStreetMapGeocoder extends GeocoderResponsible

    constructor: ->
        @nodeGeocoder = nodeGeocoder('openstreetmap')
        @name = 'openstreetmap'

module.exports = OpenStreetMapGeocoder
