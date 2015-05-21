window.App = {}
window.App.Views = []

App.Site = class
  render: ->
    for view in App.Views
      if view.cssClass && view.jsClass && $(document.body).is(view.cssClass)
        new view.jsClass()
        console.log("loaded #{view.cssClass}")

  constructor: ->
    @render()
    console.log('done')


# Use these two instead of "$ ->" to work with Turbolinks
# http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links

$(document).ready ->
  new App.Site()

$(document).on 'page:load', ->
  new App.Site()