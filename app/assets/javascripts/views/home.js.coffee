App.Views.push

  cssClass: '.app.home.index'

  jsClass: class
    homeLoaded: ->
      console.log('home loaded')

    constructor: ->
      @homeLoaded()