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
    $('#affiliateform').click(function (e) {
    e.preventDefault();
    // console.log(e.target.id);
    addItem(memid, "person", e.target.id);

  });


  }).
  on('ajax:error', function(xhr, status, error) {
    console.log('failed: ' + error);
  });


  //new adminsitrator / username search
  $('#adminusername').keyup(function() {
    value = $('#adminusername').val();
    $('#usersearchform').submit();
  })
  $('#adminrow_last').on('ajax:success', function(evt, data, status, xhr) {
    var htmlstring = "";
    $.each(data, function(i, result) {
      htmlstring += "<tr><td>"+result.username+"</td><td><button class='btn btn-primary addadmin' id='"+ result.id +"add_admin'>Add</button></td></tr>";
    });
    $('#adminsuggestions').html(htmlstring);
    $('.addadmin').click(function(e) {
      addAdmin(itemid, parseInt(e.target.id));
    })
  }).
  on('ajax:error', function(xhr, status, error) {
    console.log('failed: ' + error);
  });
  
  $('#usersearchform').on('ajax:success', function(evt, data, status, xhr) {
    console.log(data);
    var htmlstring = "<ul id='suggestionlist'>";
    $.each(data, function(i, result) {
      htmlstring += "<li id='" + result.id + "''>" + result.username + "</li>";
    })
    htmlstring += "</ul>";
    $('.sugglist').html(htmlstring);
    $('#suggestionlist').click(function(e) {
  $('#message_reciever_id').val(e.target.id);
  console.log(e.target.id); });
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


    addItem = function(memid, itemtype, itemid) {
  $.ajax({
      type: "POST",
      url: memid + '/additem.json',
      data: { 
        type: itemtype,
        itemid: itemid
      },
      dataType: 'json',
      success: function(msg) {
        console.log(msg);
      }
    });
  };


});
