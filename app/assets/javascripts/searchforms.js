$(function() {

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

});