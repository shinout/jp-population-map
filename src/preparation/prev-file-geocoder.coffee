
debug = require('debug')('prev-file-geocoder')

GeocoderResponsible = require './geocoder-responsible'

class PrevFileGeocoder extends GeocoderResponsible

    @HEATMAP_FILE_JSON: __dirname + '/../data/jp-population-2010.json'

    constructor: ->
        @name = 'prev-file'
        @prevDataDict = @loadPrevDataAsDict()


    geocode: (locationName) ->

        debug('start loading geocode via %s, %s', @name, locationName)

        prevData = @prevDataDict[locationName]
        if prevData?.geocode
            debug 'successfully loaded via %s, %s[lat=%d, lng=%d]',
                @name,
                locationName,
                prevData.geocode.latitude,
                prevData.geocode.longitude
            Promise.resolve prevData.geocode

        else
            return @next.geocode(locationName) if @next
            return Promise.reject new Error "no prev data found: #{locationName}"



    loadPrevDataAsDict: ->
        dict = {}
        try
            data = require(@constructor.HEATMAP_FILE_JSON)
            for cityData in data
                dict[cityData.pref + cityData.city] = cityData
        catch e
            debug e

        return dict




module.exports = PrevFileGeocoder
