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
  $('#peopleinput').keyup(function() {
    value = $('#peopleinput').val();
    $('#peoplesearchform').submit();
  })
  $('#peoplesearchform').on('ajax:success', function(evt, data, status, xhr) {
    console.log('success: ' + data);
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
      console.log(result);
      // htmlstring += "<div id='adminusername_" + result.id + "'>" + result.username + "</div>";
      htmlstring += "<tr><td>"+result.username+"</td><td><button class='btn btn-primary addadmin' id='"+ result.id +"add_admin'>Add</button></td></tr>";
    });
    $('#adminsuggestions').html(htmlstring);
    $('.addadmin').click(function(e) {
      // console.log(parseInt(e.target.id));
      addAdmin(itemid, parseInt(e.target.id));
    })
  }).
  on('ajax:error', function(xhr, status, error) {
    console.log('failed: ' + error);
  });
});