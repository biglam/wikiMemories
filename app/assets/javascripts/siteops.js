$(document).ready(function(){
	$('#mobilemenuimage').click(function() {
		$('.topmenu').slideToggle();
	});

  $('#diedcheckbox').click(function() {
     $('#diedfield').toggle();
    // alert("clicked");
  })

  $('#searchform').on('ajax:success', function(evt, data, status, xhr) {
    console.log('success: ' + data);
    $('#side_memories').html(data);

  }).
  on('ajax:error', function(xhr, status, error) {
    console.log('failed: ' + error);
  });

  $('#search-field').on('keyup', function() {
    // alert('hi)');
    $('#searchform').submit();
  });

 $('.rankdiv').on('ajax:success', function(evt, data, status, xhr) {
    console.log(data);
    var ajaxdata = data;
    // console.log();
    $('#rank_' + ajaxdata.id).text(ajaxdata.ranking);
  }).
  on('ajax:error', function(xhr, status, error) {
    console.log('failed: ' + error);
  });

});