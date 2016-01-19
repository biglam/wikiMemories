$(document).ready(function(){
	$('#mobilemenuimage').click(function() {
		$('.topmenu').slideToggle();
	});

  $('#diedcheckbox').click(function() {
     $('#diedfield').toggle();
  })

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

 $('.rankdiv').on('ajax:success', function(evt, data, status, xhr) {
    console.log(data);
    var ajaxdata = data;
    // console.log();
    $('#rank_' + ajaxdata.id).text(ajaxdata.ranking);
  }).
  on('ajax:error', function(xhr, status, error) {
    console.log(error);
    console.log(status);
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



  // image clickers

// $('.thumbnail').click(function(event) {
//   var clicked = (event.target.id);
//   alert(clicked + " clicked");
//   console.log(event.target)
// });

$('#editmemstable').on('ajax:success', function(data) {
  var searchstring= (data.target.search);
  var memoryid = parseInt(searchstring.replace('?memory=', ''));
  $('#mem_' + memoryid).hide();
});

$('#linkform').on('ajax:success', function(ev, data) {
  $('#linkslist').html(data['div']);
});

$('.new_memory').on('ajax:success', function(ev, data) {
  $('#other_peoples_memories').prepend(data['div']);
});




});

  // function initMap(lat, lng) {
  //   map = new google.maps.Map(document.getElementById('map'), {
  //     center: {lat: lat, lng: lng},
  //     zoom: 16
  //   });
  // }


// postMemory = function(title, story, userid, reciever_type, reciever_id) {
//   $.ajax({
//       type: "POST",
//       url: '/memories.json',
//       data: { 
//         memory: { 
//           title: title,
//           story: story,
//           user_id: userid,
//           reciever_type: reciever_type,
//           reciever_id: reciever_id
//         } 
//       },
//       dataType: 'json',
//       success: function(msg) {
//         console.log(msg);
//         $('#other_peoples_memories').prepend(msg['div']);
//       }
//     });
// }


// postFlag

postFlag = function(message, userid, memory_id) {
  $.ajax({
      type: "GET",
      url: '/memories/flag_memory.' + memory_id,
      data: { 
        flag: { 
          memory_id: memory_id,
          message: message,
          user_id: userid,
        } 
      },
      dataType: 'json',
      success: function(msg) {
        console.log(msg);
        $('.flag_' + memory_id).html('<strong>Your flag has been noted and will be reviewed. Thanks for your feedback.</strong>')
      }
    });
}

