# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(window).on "load", =>
    console.log("Campaign:onLoad");
    if ($("#campaigns").length)
      setDistricts();

  $("#admins_campaign_district_id").on "load", ->
    console.log("district onload");

  $("#admins_campaign_position").on "change", ->
    setDistricts();

  $("#admins_campaign_state_id").on "change", ->
    setDistricts();

  $("#admins_campaign_politician_last_name").autocomplete({
    source: $('#admins_campaign_politician_last_name').data('autocomplete-source')
    select: (event, ui) -> 
      console.log("ui.item.id: "+ui.item.id);
      $('#admins_campaign_politician_id').val(ui.item.id);
    });

setDistricts = () ->
  console.log("campains:setDistricts");
  position = $("#admins_campaign_position").find("option:selected").val();
  state_id = $("#admins_campaign_state_id").find("option:selected").val();
  if (state_id && position && position.indexOf('representative') == 0)
    $("#admins_campaign_district_id").prop("disabled", false);
    getDistricts();
  else
    $("#admins_campaign_district_id").prop("disabled", true);

getDistricts = () ->
  console.log("campaigns:getDistricts");
  state_id = $("admins_campaign_state_id").find("option:selected").val();
  $.ajax
    url: "/api/v1/districts?state_id="+state_id
    type: "GET"
    dataType: "json"
    success: (data) ->
      $el = $("#admins_campaign_district_id");
      $el.append $("<option></option>").attr("value", "0").text("Select district")
      for i in [0...data.length] by 1
        $el.append $("<option></option>").attr("value", data[i].id).text(data[i].name)
    error: ->
      console.log("Error getting districts");


