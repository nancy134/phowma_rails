# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(window).on "load", ->
    if ($('#campaigns').length)
      console.log("onLoad:Campaigns");
      election_id = $('#admins_campaign_election_id').find('option:selected').val();
      $('#admins_campaign_date_id').val(election_id);

  $("#admins_campaign_election_attributes_office_attributes_district_id").on "change", ->
    console.log("district onload");
    setOffice();

  $("#admins_campaign_election_attributes_office_attributes_position").on "change", ->
    console.log("campaign:onChange:position");
    setDistricts();

  $("#admins_campaign_election_attributes_office_attributes_state_id").on "change", ->
    console.log("campaign:onChange:state");
    setDistricts();

  $("#admins_campaign_election_attributes_office_id").on "change", ->
    console.log("campaign:onChange:office_id");
    getDates();

  $("#admins_campaign_candidate_name").autocomplete({
    source: $('#admins_campaign_candidate_name').data('autocomplete-source')
    select: (event, ui) -> 
      console.log("ui.item.id: "+ui.item.id);
      $('#admins_campaign_politician_id').val(ui.item.id);
    });

  $("#admins_campaign_election_attributes_office_id").on "change", ->
    console.log("campaign:onchange:incumbent(office_id)");

  $('#admins_campaign_election_id').on "change", ->
    election_id = $('#admins_campaign_election_id').find('option:selected').val();
    console.log("election_id: "+election_id);
    $('#admins_campaign_date_id').val(election_id);

setDistricts = () ->
  console.log("campains:setDistricts");
  position = $("#admins_campaign_election_attributes_office_attributes_position").find("option:selected").val();
  state_id = $("#admins_campaign_election_attributes_office_attributes_state_id").find("option:selected").val();

  console.log("position: "+position+" state_id: "+state_id);
  if (state_id && position && position.indexOf('representative') == 0)
    $("#admins_campaign_election_attributes_office_attributes_district_id").prop("disabled", false);
    getDistricts();
  else
    $("#admins_campaign_election_attributes_office_attributes_district_id").prop("disabled", true);
    setOffice();

getDistricts = () ->
  state_id = $("#admins_campaign_election_attributes_office_attributes_state_id").find("option:selected").val();
  position = $("#admins_campaign_election_attributes_office_attributes_position").find("option:selected").val();
  $.ajax
    url: "/api/api/v1/districts?state_id="+state_id
    type: "GET"
    dataType: "json"
    success: (data) ->
      $el = $("#admins_campaign_election_attributes_office_attributes_district_id");
      $el.empty();
      $el.append $("<option></option>").attr("value", "0").text("Select district")
      for i in [0...data.length] by 1
        $el.append $("<option></option>").attr("value", data[i].id).text(data[i].name)
    error: ->
      console.log("Error getting districts");


setOffice = () ->
  console.log("setOffice");
  position = $('#admins_campaign_election_attributes_office_attributes_position').find('option:selected').val();
  state_id = $('#admins_campaign_election_attributes_office_attributes_state_id').find('option:selected').val();
  console.log("position: "+position+" state_id: "+state_id);
  if (position && position.indexOf('representative') == 0)
    district_id = $('admins_campaign_election_attributes_office_attributes_district_id').find('option:selected').val();
    if (state_id && position && district_id)
      getOffice();
    else
      if (state_id && position)
        getOffice();
  else
    getOffice();


getOffice = () ->
  console.log("getOffice");
  position_enum = $('#admins_campaign_election_attributes_office_attributes_position').find('option:selected').attr('enum');
  position = $('#admins_campaign_election_attributes_office_attributes_position').find('option:selected').val();
  state_id = $('#admins_campaign_election_attributes_office_attributes_state_id').find('option:selected').val();
  console.log("position: "+position+" state_id: "+state_id);
  if (!position || !state_id)
    return;
  district_id = $('#admins_campaign_election_attributes_office_attributes_district_id').find('option:selected').val();
  console.log("district_id: "+district_id);
  if (position.indexOf('representative') == 0 && district_id)
    query = "?q[position_eq]="+position_enum+"&q[state_id_eq]="+state_id+"&q[district_id_eq]="+district_id;
  else
    query = "?q[position_eq]="+position_enum+"&q[state_id_eq]="+state_id;
  console.log("query: "+query);
  $.ajax 
    url: "/api/api/v1/offices"+query
    type: "GET"
    dataType: "json"
    success: (data) ->
      $el = $('#admins_campaign_election_attributes_office_id');
      $el.empty();
      $el.append $('<option></option>').attr('value', "0").text('Select incumbent');
      for i in [0...data.length] by 1
        if (data[i].politician)
          $el.append $('<option></option>').attr('value',data[i].id).text(data[i].politician.last_name);
        else
          $el.append $('<option></option>').attr('value',data[i].id).text('Vacant');
    error: ->
      console.log("error");

getDates = () ->
  setDates();

setDates = () ->
  office_id = $('#admins_campaign_election_attributes_office_id').find('option:selected').val();
  query = "/api/api/v1/elections?q[office_id_eq]="+office_id;
  console.log("query: "+query);
  $.ajax
    url: query 
    type: "GET"
    dataType: "json"
    success: (data) ->
      console.log("sucess");
      $el = $('#admins_campaign_election_id');
      $el.empty();
      $el.append $('<option></option>').attr('value',"0").text('Select date');
      for i in [0...data.length] by 1
        $el.append $('<option></option').attr('value',data[i].id).text(data[i].date);
    error: ->
      console.log("error");
