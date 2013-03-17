#= require jquery-1.8.2.min.js
#

$(->
  $('#serverinfo').text('You are connected to: ' + localStorage.getItem('server'))
  $('#server').change(->
    localStorage.setItem('server', $(this).val())
  )
)
