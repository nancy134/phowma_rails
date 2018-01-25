$ ->
  $('#admins_election_state_id').on "change", ->
    getDistricts();
    getPoliticians();

  $('#admins_election_position').on "change", ->
    $el = $('#admins_election_district_id');
    if ($(this).val().indexOf('house') == 0)
      $el.prop("disabled", false);
      getDistricts();
      getPoliticians();
    else
      $el.prop("disabled", true);
      getPoliticians();

  $('.pdate').datepicker({
    autoclose: true,
    format: "yyyy-mm-dd"
  });

getDistricts = () ->
  state_id = $('#admins_election_state_id').find('option:selected').val();
  $.ajax
    url: "/api/v1/districts?state_id="+state_id
    type: "GET"
    dataType: "json"
    success: (data) ->
      $el = $('#admins_election_district_id');
      $el.empty();
      $el.append $('<option></option>').attr('value', "0").text('Select district')
      for i in [0...data.length] by 1
        $el.append $('<option></option>').attr('value', data[i].id).text(data[i].name)
  error: ->
    console.log("Error getting districts")

getPoliticians = () ->
  state_id = $('#admins_election_state_id').find('option:selected').val();
  district_id = $('#admins_election_district_id').find('option:selected').val();
  position = $('#admins_election_position').find('option:selected').val();

  query = "";
  query = query.concat("q[state_id_eq]="+state_id+"&");

  if (position == "senate")
    query = query.concat("q[position_in][]=0&");
  else if (position == "house")
    query = query.concat("q[position_in][]=1&");
    query = query.concat("q[district_id_eq][]="+district_id+"&");
  else if (position == "governor")
    query = query.concat("q[position_in][]=2&");


  $.ajax
    url: "/api/v1/politicians?"+query
    type: "GET"
    dataType: "json"
    success: (data) ->
      $el = $('#admins_election_politician_id');
      $el.empty();
      $el.append $('<option></option>').attr('value', "0").text('Select politician')
      for i in [0...data.length] by 1
        $el.append $('<option></option>').attr('value', data[i].id).text(data[i].last_name)
  error: ->
    console.log("Error getting politicians")
