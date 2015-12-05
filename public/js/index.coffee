#= require jquery-1.8.2.min.js
#

$(->
  $('#serverinfo').text('You are connected to: ' + localStorage.getItem('server'))
  $('#server').change(->
    localStorage.setItem('server', $(this).val())
  )

  $('#home-intro-btn').click(->
    $('#tabs > div').hide()
    $('#home-intro').show()
  )
  $('#my-transactions-btn').click(->
    $('#tabs > div').hide()
    $('#my-transactions').show()
  )
  $('#send-coins-btn').click(->
    $('#tabs > div').hide()
    $('#send-coins').show()
  )
  $('#receive-coins-btn').click(->
    $('#tabs > div').hide()
    $('#receive-coins').show()
  )
  $('#import-export-btn').click(->
    $('#tabs > div').hide()
    $('#import-export').show()
  )

  if $('#mynym').length
    $.getJSON('/shownyms', (data) ->
      $('#mynym').html('')
      $('#mynym').removeAttr('disabled')
      $.each(data, ->
        $('#mynym').append("<option value=\"#{this.nym}\">#{this.label}</option>")
      )
    )

  if $('#mypurse').length
    $.getJSON('/showassets', (data) ->
      $('#mypurse').html('')
      $('#mypurse').removeAttr('disabled')
      $.each(data, ->
        $('#mypurse').append("<option value=\"#{this.asset}\">#{this.name}</option>")
      )
    )
)
