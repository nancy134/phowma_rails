# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
$ ->
  $(window).on "load", =>
    console.log("onLoad")
    setDistricts();

  $('#office_state_id').on "change", ->
    setDistricts();

  $('#office_position').on "change", ->
    setDistricts();

setDistricts = () ->
  position = $('#office_position').find('option:selected').val()
  console.log("position: "+position);
  state_id = $('#office_state_id').find('option:selected').val()
  console.log("state_id: "+state_id);
  if (state_id && position && position.indexOf('representative') == 0)
    console.log("enable districts");
    $('#office_district_id').prop("disabled",false);
    getDistricts();
  else
    console.log("disable districts");
    $('#office_district_id').prop("disabled",true);


getDistricts = () ->
  console.log("getDistricts()");
  state_id = $('#office_state_id').find('option:selected').val();
  $.ajax
    url: "/api/v1/districts?state_id="+state_id
    type: "GET"
    dataType: "json"
    success: (data) ->
      $el = $('#office_district_id');
      $el.empty();
      $el.append $('<option></option>').attr('value', "0").text('Select district')
      for i in [0...data.length] by 1
        $el.append $('<option></option>').attr('value', data[i].id).text(data[i].name)
    error: ->
      console.log("Error getting districts")
