# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  male = "<div class='male human'>&nbsp;</div>"
  female = "<div class='female human'>&nbsp;</div>"

  newPos = ->
    h = $('#world').height() - 20
    w = $('#world').width() - 20

    nh = Math.floor(Math.random() * h)
    nw = Math.floor(Math.random() * w)

    [nh, nw]

  getLocation = ->
    posA = {top:[], left: [], gender: []}

    $.each $('.human'), (i, v) ->
      if $(v).attr('data-energy') <= 0
        $(v).remove()

        return

      pos = $(v).position()
      topIndex = posA.top.indexOf(pos.top)
      leftIndex = posA.left.indexOf(pos.left)

      if $(v).hasClass('male')
        gender = 'male'
      else
        gender = 'female'

      if (!topIndex || !leftIndex)
        if topIndex > -1
          gIndex = topIndex
        else
          gIndex = leftIndex

        sGender = posA.gender[gIndex]

        if gender != sGender
          generatePop()
        else
          animateThis(v)
      else
        posA.top.push(pos.top)
        posA.left.push(pos.left)

        if $(v).hasClass('male')
          posA.gender.push('male')
        else
          posA.gender.push('female')


  animateThis = (elem) ->
    pos = new newPos()

    $(elem).animate({top: pos[0], left: pos[1]}, ->
      getLocation()
      animateDiv()
    )

  animateDiv = ->
    $.each $('.male'), (i, v)->
      animateThis(v)

    $.each $('.female'), (i, v)->
      animateThis(v)

  generatePop = () ->
    energy = Math.floor(Math.random() * 80)
    rand = Math.floor(Math.random() * 2)

    if rand == 0
      elem = male
    else
      elem = female

    elem = $(elem).attr('data-energy', energy)

    $('#world').append(elem)

  deathClock = ->
    $.each $('.human'), (i, v) ->
      elem = $(v)
      energy = elem.attr('data-energy')

      elem.attr('data-energy', energy - 1)

    setTimeout(deathClock, 1000)

  i = 0
  while i <= 20
    generatePop()

    i++

  animateDiv()
  deathClock()
