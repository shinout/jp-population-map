
fs = require 'fs'

module.exports = (grunt) ->

    grunt.initConfig()


    grunt.registerTask 'html',  ->

        try
            apiKey = fs.readFileSync(__dirname + '/google-map-api-key', 'utf-8').trim()
        catch e
            console.log e
            throw new Error 'you must put file "google-map-api-key" (like AIza...) on the project root'

        ect = require 'ect'
        #renderer = ect(root: __dirname + '/src/views')
        renderer = ect(root: 'src/views')
        fs.writeFileSync __dirname + '/public/index.html', renderer.render('index.ect', apiKey: apiKey)




    grunt.registerTask 'browserify',  ->
        done = @async()
        browserify = require('browserify')

        b = browserify './src/main.coffee',
            extensions: '.coffee'

        b.transform('coffeeify')

        b.bundle (err, buf) ->
            require('fs').writeFileSync 'public/js/main.js', buf.toString()
            done()



    grunt.registerTask 'prepare-data',  ->

        done = @async()
        process.env.DEBUG = '*'
        require('./src/preparation/index').prepare().then -> done()


    grunt.registerTask 'build', ['html', 'browserify']
    grunt.registerTask 'default', ['browserify']
