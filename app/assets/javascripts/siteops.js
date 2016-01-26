$(document).ready(function(){
	$('#mobilemenuimage').click(function() {
		$('.topmenu').slideToggle();
	});

  $('#diedcheckbox').click(function() {
   $('#diedfield').toggle();
 })



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

  $('#adminlist').on('ajax:success', function(evt, data, status, xhr) {
     // console.log(evt.target.id);
     console.log(data);
     var user_id = parseInt(data.id);
     $('#adminrow_' + user_id).hide();
   }).
  on('ajax:error', function(xhr, status, error) {
   console.log(error);
   console.log(status);
 });

  // image clickers

// $('.thumbnail').click(function(event) {
//   var clicked = (event.target.id);
//   alert(clicked + " clicked");
//   console.log(event.target)
// });

$('#editmemstable').on('ajax:success', function(evt, data) {
  // console.log(data);
  // var searchstring= (data.target.search);
  // var memoryid = parseInt(searchstring.replace('?memory=', ''));
  // console.log(('#mem_' + data.id));
  $('#mem_' + data.id).hide();
});

$('#new_link').on('ajax:success', function(ev, data) {
  console.log(data);
  var htmlstring = "<li><a href='" + data.address + "'>" + data.title + '</a></li>';
  $('#linkslist').prepend(htmlstring);
});

$('#new_memory').on('ajax:success', function(ev, data) {
  console.log(data);
  $('#other_peoples_memories').prepend(data['div']);
});

$('#new_memory').on('ajax:error', function(ev, data) {
  console.log(data);
  // $.each(data, function(i, result) {
      // console.log(result);
      // htmlstring += "<div id='adminusername_" + result.id + "'>" + result.username + "</div>";
      // htmlstring += "<tr><td>"+result.username+"</td><td><button class='btn btn-primary addadmin' id='"+ result.id +"add_admin'>Add</button></td></tr>";
    // });
$('#other_peoples_memories').prepend(data.responseText);
  // var info = data.responseText;
  // console.log(info);
});


$('.nav-tabs a').click(function(e){
  $(this).tab('show');
  console.log(this)
})


$('.new_message').on('ajax:success', function(ev, data) {
  console.log(data);
  $('.conversation').prepend(data);
  $('#msgstatus').text('Your message has been sent.');

});

$('.reply').hide();
$('#replybut').click(function() {
  console.log('clicked')
  $('.reply').slideToggle();
  $('#message_title').val(' ');
  $('#message_message').val(' ');
});


$('#currentlocation').click(function() {
  console.log(pos);
  $('#place_lat').val(pos['lat']);
  $('#place_lng').val(pos['lng']);
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
    type: "POST",
    url: '/memories/' + memory_id + '/flag_memory.json',
    data: { 
      flag: { 
        memory_id: memory_id,
        message: message,
        user_id: userid,
      } 
    },
    dataType: 'json',
    success: function(msg) {
        // console.log(msg);
        $('#collapseMem' + memory_id).html('<strong>Your flag has been noted and will be reviewed. Thanks for your feedback.</strong>');
        $('.flag_' + memory_id).html('<strong>Your flag has been noted and will be reviewed. Thanks for your feedback.</strong>')
      }
    });
}

addAdmin = function(itemid, adminid, controllername) {
  // change to use mdoel
  $.ajax({
    type: "PUT",
    url: '/' + controllername + '/'+ itemid + '/add_administrator.json',
    data: {
        adminstrator: adminid,
        person: {id: itemid},
        place: {id: itemid},
        pet: {item: itemid},
        occasion: {item: itemid}
    },
    dataType: 'json',
    success: function(data, msg) {
          var htmlstring = '<tr><td>' + data.username + '</td><td><a href="#" class="btn btn-default">Added</a></td></tr>';
          $('#adminlistoptions').prepend(htmlstring);
        }
      });


  $('#affiliateform').click(function (e) {
    // e.preventDefault();
    // console.log(e);
  });


}