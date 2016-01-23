$(function() {

  // sidebar search
  $('#searchform').on('ajax:success', function(evt, data, status, xhr) {
    console.log('success: ' + data);
    $('#side_memories').html(data); 
  }).
  on('ajax:error', function(xhr, status, error) {
    console.log('failed: ' + error);
  });
  $('#search-field').on('keyup', function() {
    $('#searchform').submit();
  });

  // front page people search

  $('#pplgo').click(function() {
    value = $('#peopleinput').val();
    window.location.href = "/search/person?q=" + value;
  });
  $('#peopleinput').keyup(function() {
    value = $('#peopleinput').val();
    $('#peoplesearchform').submit();
  });
  $('#peoplesearchform').on('ajax:success', function(evt, data, status, xhr) {
    console.log(data);
    // $('#side_memories').html(data);
    var name = $('#peopleinput').val();
    var newperson = '<div id="searchresult">Not here? <a href="/people/new?name='+name+'">Create '+name+'</a></div>'
    $('#peopleresultsdiv').html(data);
    $('#peopleresultsdiv').append(newperson);
  }).
  on('ajax:error', function(xhr, status, error) {
    console.log('failed: ' + error);
  });


  //new adminsitrator search
  $('#adminusername').keyup(function() {
    value = $('#adminusername').val();
    $('#usersearchform').submit();
  })
  $('#adminrow_last').on('ajax:success', function(evt, data, status, xhr) {
    var htmlstring = "";
    $.each(data, function(i, result) {
      // console.log(result);
      // htmlstring += "<div id='adminusername_" + result.id + "'>" + result.username + "</div>";
      htmlstring += "<tr><td>"+result.username+"</td><td><button class='btn btn-primary addadmin' id='"+ result.id +"add_admin'>Add</button></td></tr>";
    });
    $('#adminsuggestions').html(htmlstring);
    $('.addadmin').click(function(e) {
      // console.log(parseInt(e.target.id));
      // console.log(e);
      addAdmin(itemid, parseInt(e.target.id));
    })
  }).
  on('ajax:error', function(xhr, status, error) {
    console.log('failed: ' + error);
  });


  // new person suggestion search
  $('.new_person #person_firstname').keyup(function() {
    newPersonSuggestion();
  })
  $('.new_person #person_middlenames').keyup(function() {
    newPersonSuggestion();
  })
  $('.new_person #person_lastname').keyup(function() {
    newPersonSuggestion();
  })
  newPersonSuggestion = function() {
    var firstname = $('.new_person #person_firstname').val();
    var middlenames = $('.new_person #person_middlenames').val();
    var lastname = $('.new_person #person_lastname').val();
    console.log(firstname + ' ' + middlenames + ' ' + lastname);
  $.ajax({
      type: "GET",
      url: '/search/new_person_suggestion.json',
      data: { 
        q: firstname,
        middlenames: middlenames,
        lastname: lastname  
      },
      dataType: 'json',
      success: function(msg) {
        console.log(msg);
        var htmlstring = "";
        $.each(msg, function(i, name){
          htmlstring += "<li><a href='/people/" + name.id +"/'> " + name.firstname + " " + name.lastname;
          if (name.dob != null) {
            htmlstring += " (born " + name.dob + ")";
          }
          htmlstring += "</a></li>";
        })
        $('#suggestedpeoplelist').html(htmlstring);
      }
    });
  };

});
