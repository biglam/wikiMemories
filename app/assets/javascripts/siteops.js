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

   $('.flaglist').on('ajax:success', function(evt, data, status, xhr) {
    console.log(data);
    var ajaxdata = data;
    // console.log();
    $('#fc_' + ajaxdata.id).text(ajaxdata.flagcount);
  }).
  on('ajax:error', function(xhr, status, error) {
    console.log('failed: ' + error);
  });


});

postMemory = function(title, story, userid, reciever_type, reciever_id) {
  $.ajax({
      type: "POST",
      url: '/memories.json',
      data: { 
        memory: { 
          title: title,
          story: story,
          user_id: userid,
          reciever_type: reciever_type,
          reciever_id: reciever_id
        } 
      },
      dataType: 'json',
      success: function(msg) {
        console.log(msg);
        $('.postmemory').append(msg);
      }
    });
}