
fs = require 'fs'

class PopulationDataLoader

    load: (file) ->

        data = []

        lines = fs.readFileSync(file, 'utf-8').split('\n')

        for line,i in lines
            continue if i < 58
            [x,x,x,x,x,
                type
                pref
                city
                population
                x,x,x,x
                density
            ] = line.split('\t')

            continue if type is 'a' # filter prefecture line
            continue if city is '特別区部'
            continue if type is '0' and pref isnt '東京都'

            population = Number population.split(',').join('')
            density    = Number density.split(',').join('')

            data.push
                type       : type
                pref       : pref
                city       : city
                population : population
                density    : density

        return data



module.exports = PopulationDataLoader
