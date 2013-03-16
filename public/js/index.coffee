#= require jquery-1.8.2.min.js
#

$(->
  $('#server').change(->
    localStorage.setItem('server', $(this).val())
  )
)
