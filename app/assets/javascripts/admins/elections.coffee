$ ->
  $('#admins_election_state_id').on "change", ->
    getDistricts();

  $('#admins_election_position').on "change", ->
    console.log("Position change val: "+$(this).val());
    $el = $('#admins_election_district_id');
    if ($(this).val().indexOf('house') == 0)
      $el.prop("disabled", false);
      getDistricts();
    else
      $el.prop("disabled", true);

  $('.pdate').datepicker({
    autoclose: true,
    format: "yyyy-mm-dd"
  });

getDistricts = () ->
  console.log("getDistricts()");
  state_id = $('#admins_election_state_id').find('option:selected').val();
  console.log("state_id: "+state_id);
  $.ajax
    url: "/api/v1/districts?state_id="+state_id
    type: "GET"
    dataType: "json"
    success: (data) ->
      $el = $('#admins_election_district_id');
      $el.empty();
      $el.append $('<option></option>').attr('value', "0").text('Select district')
      for i in [0...data.length] by 1
        console.log("data[i].name: "+data[i].name);
        $el.append $('<option></option>').attr('value', data[i].id).text(data[i].name)
  error: ->
    console.log("Error getting districts")
