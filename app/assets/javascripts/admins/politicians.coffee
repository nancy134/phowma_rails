# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
$ ->
  $('#admins_politician_state_id').on "change", ->
    console.log('The option with value ' + $(this).val())
    $.ajax
      url: "/api/v1/districts?state_id="+$(this).val()
      type: "GET"
      dataType: "json"
      success: (data) ->
        console.log("data[0].name: "+data[0].name);
        console.log("data.length: "+data.length);
        $el = $('#admins_politician_district_id');
        $el.empty();
        for i in [0...data.length - 1] by 1
          $el.append $('<option></option>').attr('value', data[i].id).text(data[i].name)

      error: ->
        console.log("NANCY: Error")
