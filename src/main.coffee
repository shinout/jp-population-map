
#require('es6-promise').polyfill()

class Main

    @init: ->

        google.maps.event.addDomListener(window, 'load', -> new Main(google))


    constructor: (@google) ->

        @gmaps = @google.maps
        @geocoder = new @gmaps.Geocoder()

        mapOptions =
            center : @latLng(38, 138)
            zoom   : 4
            # mapTypeId: @gmaps.MapTypeId.SATELLITE

        @map = new @gmaps.Map(document.getElementById('map-canvas'), mapOptions)

        data = @loadJPPopulationHeatmap()

        @heatmap = new @gmaps.visualization.HeatmapLayer(data: data, radius: 30)
        @heatmap.setMap @map


    loadJPPopulationHeatmap: ->

        heatMapData = []

        data = require('./data/jp-population-2010')

        for cityData in data
            if cityData.geocode
                heatMapData.push
                    location: @latLng(cityData.geocode.latitude, cityData.geocode.longitude)
                    weight : Math.log cityData.population

        return heatMapData



    getLatLngByName: (name) ->
        new Promise (resolve, reject) =>

            @geocoder.geocode { address: name }, (result, status) =>

                console.log name, result

                if status is @gmaps.GeocoderStatus.OK
                    resolve result[0].geometry.location
                else
                    e = new Error("Geocode was not successful for the following reason: #{status}")
                    reject e



    ###*
    create google.maps.LatLng

    @method latLng
    @return {google.maps.LatLng}
    ###
    latLng: (lat, lng) ->

        new @gmaps.LatLng lat, lng


Main.init()
