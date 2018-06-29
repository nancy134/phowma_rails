$ ->
  $(window).on "load", ->
    console.log("Election.OnLoad");
    if ($('#elections').length)
      office_id = $('#admins_election_office_id').find('option:selected').val();
      $('#admins_election_incumbent_id').val(office_id);
   
  $('#admins_election_office_attributes_state_id').on "change", ->
    console.log("state:onChange");
    setDistricts();
    setOffice();

  $('#admins_election_office_attributes_position').on "change", ->
    console.log("position:onChange");
    setDistricts();
    setOffice();

  $('#admins_election_office_attributes_district_id').on "change", ->
    console.log("district:onChange");
    setOffice();

  $('#admins_election_office_id').on "change", ->
    console.log("office_id:onChange");
    office_id = $('#admins_election_office_id').find('option:selected').val();
    console.log("office_id: "+office_id);
    $('#admins_election_incumbent_id').val(office_id);

  $('.pdate').datepicker({
    autoclose: true,
    format: "yyyy-mm-dd"
  });

setDistricts = () ->
  position = $('#admins_election_office_attributes_position').find('option:selected').val();
  state_id = $('#admins_election_office_attributes_state_id').find('option:selected').val();
  console.log("position: "+position+" state_id: "+state_id);
  if (state_id && position && position.indexOf('representative') == 0)
    $('#admins_election_office_attributes_district_id').prop("disabled",false);
    getDistricts();
  else
    $('#admins_election_office_attributes_district_id').prop("disabled",true);

setOffice = () ->
  position = $('#admins_election_office_attributes_position').find('option:selected').val();
  state_id = $('#admins_election_office_attributes_state_id').find('option:selected').val();
  console.log("position: "+position+" state_id: "+state_id);
  if (position && position.indexOf('representative') == 0)
    district_id = $('#admins_election_office_attributes_district_id').find('option:selected').val();
    if (state_id && position && district_id)
      getOffice();
  else
    if (state_id && position)
      getOffice(); 

getOffice = () ->
  position_enum = $('#admins_election_office_attributes_position').find('option:selected').attr('enum');
  position = $('#admins_election_office_attributes_position').find('option:selected').val();
  state_id = $('#admins_election_office_attributes_state_id').find('option:selected').val();
  if (!position || !state_id)
    return;
  district_id = $('#admins_election_office_attributes_district_id').find('option:selected').val();
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
      $el = $('#admins_election_office_id');
      $el.empty();
      $el.append $('<option></option>').attr('value', "0").text('Select incumbent');
      for i in [0...data.length] by 1
        if (data[i].politician)
          $el.append $('<option></option>').attr('value',data[i].id).text(data[i].politician.last_name);
        else
          $el.append $('<option></option>').attr('value',data[i].id).text('Vacant');
    error: ->
      console.log("error");

getDistricts = () ->
  state_id = $('#admins_election_office_attributes_state_id').find('option:selected').val();
  $.ajax
    url: "/api/api/v1/districts?state_id="+state_id
    type: "GET"
    dataType: "json"
    success: (data) ->
      $el = $('#admins_election_office_attributes_district_id');
      $el.empty();
      $el.append $('<option></option>').attr('value', "0").text('Select district')
      for i in [0...data.length] by 1
        $el.append $('<option></option>').attr('value', data[i].id).text(data[i].name)
  error: ->
    console.log("Error getting districts")
