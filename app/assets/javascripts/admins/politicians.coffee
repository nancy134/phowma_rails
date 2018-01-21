# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
$ ->
  $('#admins_politician_state_id').on "change", ->
    getDistricts();

  $('#admins_politician_position').on "change", ->
    console.log("Position change val: "+$(this).val());
    $el = $('#admins_politician_district_id');
    if ($(this).val().indexOf('representative') == 0)
      $el.prop("disabled",false);
      getDistricts();
    else
      $el.prop("disabled",true);


getDistricts = () ->
  console.log("getDistricts()");
  state_id = $('#admins_politician_state_id').find('option:selected').val();
  $.ajax
    url: "/api/v1/districts?state_id="+state_id
    type: "GET"
    dataType: "json"
    success: (data) ->
      $el = $('#admins_politician_district_id');
      $el.empty();
      $el.append $('<option></option>').attr('value', "0").text('Select district')
      for i in [0...data.length] by 1
        $el.append $('<option></option>').attr('value', data[i].id).text(data[i].name)
    error: ->
      console.log("Error getting districts")
