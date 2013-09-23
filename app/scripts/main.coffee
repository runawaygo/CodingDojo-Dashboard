console.log('\'Allo \'Allo!');
$ ->
  animation = ->
    $('.last .card').addClass('tada')
    setTimeout ->
      $('.last .card').removeClass('tada')
    ,2000

    oldCards = $('.card-list-container .card')
    count = oldCards.length
    $('.card-list-container .card').each (index, item)->
      return if count-index>10 
      setTimeout ->
        $(item).addClass('animated flipInX')  
        setTimeout ->
          $(item).removeClass('animated flipInX')  
        ,1000
      ,(count-index)*150+500

      
  # setInterval ->
  #   animation()
  # ,3000


  addOne = ->
    oldCards = $('.card-list-container .card')
    count = oldCards.length
    $('.card-list-container .card').each (index, item)->
      return if count-index>10 
      setTimeout ->
        $(item).addClass('animated flipInX')  
        setTimeout ->
          $(item).removeClass('animated flipInX')  
        ,1000
      ,(count-index)*150+500

    $('.last .card').addClass('animated lightSpeedIn')
    setTimeout ->
      $('.last .card').removeClass('animated lightSpeedIn')
    ,2000

  setInterval ->
    addOne()
  ,3000