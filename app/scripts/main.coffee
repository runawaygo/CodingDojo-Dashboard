refreshData = ->
  url = if  window.location.search then "results/#{window.location.search}" else '/mock_results'

  $.getJSON url, (data)->
    $('.card-list-container').html('')  
    template = Handlebars.compile($("#card-template").html())
    for item in data
      item.testsuite.$.pass = item.testsuite.$.tests-item.testsuite.$.failures-item.testsuite.$.skipped
      for testcase in item.testsuite.testcase
        testcase.status = if testcase.failure then 'failed' else 'pass'

      item.group = ({name:key, testcase: groupItem} for key, groupItem of _.groupBy(item.testsuite.testcase, (testcase)->testcase.$.classname))

      html = template(item)
      $('.card-list-container').append(html)

    $('#last-update').html('last update:'+(new Date()).toString().split(' ')[4])  
    $('.card').addClass('flash')
    setTimeout ->
      $('.card').removeClass('flash')
    , 1000
  
$ ->
  $('.card-list-container').delegate '.card', 'click', (event)->
    $(@).toggleClass('detail')

  $('#last-update').click refreshData
  refreshData()
  setInterval refreshData,300000