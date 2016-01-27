$(function() {

// sidebar search
$('#searchform').on('ajax:success', function(evt, data, status, xhr) {

  $('#side_memories').html(data); 
}).
on('ajax:error', function(xhr, status, error) {

});
$('#search-field').on('keyup', function() {
  $('#searchform').submit();
});

// DRY up cos this is shiz baby
// Hows that Michael? 96 lines down to 4 :P
frontPageForm('person', 'people');
frontPageForm('place', 'places');
frontPageForm('pet', 'pets');
frontPageForm('occasion', 'occasions');
frontPageForm('all', 'all');
frontPageForm('groupadd', 'groupadds');

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
    addAdmin(itemid, parseInt(e.target.id), controllername);
  })
}).
on('ajax:error', function(xhr, status, error) {

});

$('#usersearchform').on('ajax:success', function(evt, data, status, xhr) {

  var htmlstring = "<ul id='suggestionlist'>";
  $.each(data, function(i, result) {
    htmlstring += "<li id='" + result.id + "''>" + result.username + "</li>";
  })
  htmlstring += "</ul>";
  $('.sugglist').html(htmlstring);
  $('#suggestionlist').click(function(e) {
    $('#message_reciever_id').val(e.target.id);
  });
}).
on('ajax:error', function(xhr, status, error) {

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


// sitewide functions
// definitely need cleaned up
newPersonSuggestion = function() {
  var firstname = $('.new_person #person_firstname').val();
  var middlenames = $('.new_person #person_middlenames').val();
  var lastname = $('.new_person #person_lastname').val();
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
      var htmlstring = "";
      $.each(msg, function(i, name){
        htmlstring += "<li><a href='/people/" + name.id +"/'> " + name.firstname + " " + name.lastname;
        if (name.dob != null) {
          htmlstring += " (born " + name.dob + ")";
        }
        if (name.brief_description != null) {
          htmlstring += " (" + name.brief_description + ")";
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

    }
  });
};
});

//  also for groups etc search
frontPageForm = function(singular, plural) {
  $('#' + singular + 'go').click(function() {
    value = $('#' + plural + 'input').val();
    window.location.href = '/search/' + singular + '?q=' + value;

  });
  $('#' + plural + 'input').keyup(function() {
    value = $('#' + plural + 'input').val();
    if (value.length >= 2) {
      $('#' + plural + 'searchform').submit();
    } else {
      $('#' + plural + 'resultsdiv').html(' ');
    }
  });
  $('#' + plural + 'searchform').on('ajax:success', function(evt, data, status, xhr) {

    var name = $('#' + plural + 'input').val();
    var newplace = '<div id="searchresult">Not here? <a href="/' + plural + '/new?name='+name+'">Create '+name+'</a></div>'
    $('#' + plural + 'resultsdiv').html(data);
    if (singular != "all") {
      $('#' + plural + 'resultsdiv').append(newplace);
    }
    $('#affiliateform').click(function (e) {
      e.preventDefault();
      addItem(memid, plural, e.target.id);
    });
  }).
  on('ajax:error', function(xhr, status, error) {

  });
}