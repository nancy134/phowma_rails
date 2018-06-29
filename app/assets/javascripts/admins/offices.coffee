# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ -> 
  $(window).on "load", =>
    console.log("Office:OnLoad");
    #setDistricts();

  $("#admins_office_position").on "change", ->
    setDistricts();

  $("#admins_office_state_id").on "change", ->
    setDistricts();

  $("#admins_office_incumbent_name").autocomplete({
    source: $('#admins_office_incumbent_name').data('autocomplete-source')
    select: (event, ui) -> 
      console.log("ui.item.id: "+ui.item.id);
      $('#admins_office_politician_id').val(ui.item.id);
    });

setDistricts = () ->
  console.log("Office:setDistricts()");
  position = $('#admins_office_position').find('option:selected').val();
  console.log("position: "+position);
  state_id = $('#admins_office_state_id').find('option:selected').val();
  console.log("state_id: "+state_id);
  if (state_id && position && position.indexOf('representative') == 0)
    console.log("enable districts");
    $('#admins_office_district_id').prop("disabled", false);
    getDistricts();
  else
    console.log("disable districts");
    $('#admins_office_district_id').prop("disabled", true);

getDistricts = () ->
  console.log("getDistricts()");
  state_id = $('#admins_office_state_id').find('option:selected').val();
  $.ajax
    url: "/api/api/v1/districts?state_id="+state_id
    type: "GET"
    dataType: "json"
    success: (data) ->
      console.log("data");
      $el = $('#admins_office_district_id');
      $el.empty();
      $el.append $('<option></option>').attr('value',"0").text('Select district')
      for i in [0...data.length] by 1
        $el.append $('<option></option>').attr('value', data[i].id).text(data[i].name)

    error: ->
      console.log("Error getting districts");


