
fs = require 'fs'

class PopulationDataLoader

    load: (file) ->

        data = []

        lines = fs.readFileSync(file, 'utf-8').split('\n')

        for line,i in lines
            continue if i < 58
            [x,x,x,x,x,type, pref, city, population] = line.split('\t')
            continue if type in ['0', 'a']
            continue if city is '特別区部'

            population = Number population.split(',').join('')

            data.push type: type, pref: pref, city: city, population: population

        return data



module.exports = PopulationDataLoader
