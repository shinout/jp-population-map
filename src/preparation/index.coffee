
debug = require('debug')('preparation-index')

require('es6-promise').polyfill()
fs = require 'fs'

Geocoder             = require './geocoder'
PopulationDataLoader = require './population-data-loader'

class PreparationIndex

    @POPULATION_FILE_TSV: __dirname + '/resources/jp-population-2010.tsv'
    @HEATMAP_FILE_JSON  : __dirname + '/../data/jp-population-2010.json'

    ###*
    load population data, append location info

    @method prepare
    @public
    @return {Promise}
    ###
    prepare: ->

        popLoader = new PopulationDataLoader()
        data = popLoader.load(@constructor.POPULATION_FILE_TSV)

        @geocoder = new Geocoder()

        promises = (@appendLocation(cityData) for cityData in data)

        Promise.all(promises).then =>

            debug 'writing a heatmap file to %s', @constructor.HEATMAP_FILE_JSON
            fs.writeFileSync @constructor.HEATMAP_FILE_JSON, JSON.stringify(data, null, 4)

        .catch (e) ->
            debug e


    ###*

    @method check
    @public
    @return {Promise}
    ###
    check: ->




    ###*
    append location info to cityData via Geocoder

    @method appendLocation
    @private
    @param {CityData} cityData
    @return {Promise}
    ###
    appendLocation: (cityData) ->

        if cityData.geocode
            debug('%s already has geocode data', cityData.pref + cityData.city)
            return Promise.resolve()

        locationName = cityData.pref + cityData.city

        @geocoder.geocode(locationName).then (result) ->

            cityData.geocode = result

        .catch (e) ->
            debug e
            debug cityData
            return cityData


module.exports = new PreparationIndex()
