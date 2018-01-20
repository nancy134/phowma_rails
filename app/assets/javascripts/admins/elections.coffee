$ ->
  $('#admins_election_state_id').on "change", ->
    $.ajax
      url: "/api/v1/districts?state_id="+$(this).val()
      type: "GET"
      dataType: "json"
      success: (data) ->
        $el = $('#admins_election_district_id');
        $el.empty();
        $el.append $('<option></option>').attr('value', "0").text('Select district')
        for i in [0...data.length - 1] by 1
          $el.append $('<option></option>').attr('value', data[i].id).text(data[i].name)

    error: ->
      console.log("NANCY: error")

  $('#admins_election_position').on "change", ->
    console.log("Position change val: "+$(this).val());
    $el = $('#admins_election_district_id');
    if ($(this).val().indexOf('house') == 0)
      $el.prop("disabled", false);
    else
      $el.prop("disabled", true);

  $('.pdate').datepicker({
    autoclose: true,
    format: "yyyy-mm-dd"
  });
