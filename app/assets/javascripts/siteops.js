$(document).ready(function(){
  // mobile menu toggle
  $('#mobilemenuimage').click(function() {
    $('.topmenu').slideToggle();
  });
  // stops rails from filling in defaults if date of death unknown
  $('#diedcheckbox').click(function() {
    $('#diedfield').toggle();
  })

  //ajax responses
  $('.rankdiv').on('ajax:success', function(evt, data, status, xhr) {
    var ajaxdata = data;
    $('#rank_' + ajaxdata.id).text(ajaxdata.ranking);
  }).
  on('ajax:error', function(xhr, status, error) {
  });

  $('.flaglist').on('ajax:success', function(evt, data, status, xhr) {
    var ajaxdata = data;
    $('#fc_' + ajaxdata.id).text(ajaxdata.flagcount);
  }).
  on('ajax:error', function(xhr, status, error) {
  });

  $('#adminlist').on('ajax:success', function(evt, data, status, xhr) {
    var user_id = parseInt(data.id);
    $('#adminrow_' + user_id).hide();
  }).
  on('ajax:error', function(xhr, status, error) {
  });

  $('#editmemstable').on('ajax:success', function(evt, data) {
    $('#mem_' + data.id).hide();
  });

  $('#new_link').on('ajax:success', function(ev, data) {
    var htmlstring = "<li><a href='" + data.address + "'>" + data.title + '</a></li>';
    $('#linkslist').prepend(htmlstring);
  });

  $('#new_memory').on('ajax:success', function(ev, data) {
    $('#other_peoples_memories').prepend(data['div']);
  });

  $('#new_memory').on('ajax:error', function(ev, data) {
    $('#other_peoples_memories').prepend(data.responseText);
  });

  $('.new_message').on('ajax:success', function(ev, data) {
    $('.conversation').prepend(data);
    $('#msgstatus').text('Your message has been sent.');
  });

  $('#imgtable').on('ajax:success', function(ev, data) {
    $('#img' + data.id).hide();
  });

  $('#linktable').on('ajax:success', function(ev, data) {
    $('#lnk' + data.id).hide();
  });

  $('#grouplist').on('ajax:success', function(ev, data) {$(document).ready(function(){
  $('#mobilemenuimage').click(function() {
    $('.topmenu').slideToggle();
  });

  $('.rankdiv').on('ajax:success', function(evt, data, status, xhr) {
    var ajaxdata = data;
    $('#rank_' + ajaxdata.id).text(ajaxdata.ranking);
  }).
  on('ajax:error', function(xhr, status, error) {
  });

  $('.flaglist').on('ajax:success', function(evt, data, status, xhr) {
    var ajaxdata = data;
    $('#fc_' + ajaxdata.id).text(ajaxdata.flagcount);
  }).
  on('ajax:error', function(xhr, status, error) {
  });

  $('#adminlist').on('ajax:success', function(evt, data, status, xhr) {
    var user_id = parseInt(data.id);
    $('#adminrow_' + user_id).hide();
  }).
  on('ajax:error', function(xhr, status, error) {
  });

  $('#editmemstable').on('ajax:success', function(evt, data) {
    $('#mem_' + data.id).hide();
  });

  $('#new_link').on('ajax:success', function(ev, data) {
    var htmlstring = "<li><a href='" + data.address + "'>" + data.title + '</a></li>';
    $('#linkslist').prepend(htmlstring);
  });

  $('#new_memory').on('ajax:success', function(ev, data) {
    $('#other_peoples_memories').prepend(data['div']);
  });
  $('#new_memory').on('ajax:error', function(ev, data) {
    $('#other_peoples_memories').prepend(data.responseText);  // FIXME very stinky 
  });

  $('.new_message').on('ajax:success', function(ev, data) {
    $('.conversation').prepend(data);
    $('#msgstatus').text('Your message has been sent.');
  });

  $('#imgtable').on('ajax:success', function(ev, data) {
    $('#img' + data.id).hide();
  });

  $('#linktable').on('ajax:success', function(ev, data) {
    $('#lnk' + data.id).hide();
  });

  $('#grouplist').on('ajax:success', function(ev, data) {
    $('#itm' + data.id).hide();
  });

  $('.reply').hide();
  $('#replybut').click(function() {
    $('.reply').slideToggle();
    $('#message_title').val(' ');
    $('#message_message').val(' ');
  });

  $('#currentlocation').click(function() {
    $('#place_lat').val(pos['lat']);
    $('#place_lng').val(pos['lng']);
  });

  $('.nav-tabs a').click(function(e){
    $(this).tab('show');
  })

  $('.reply').hide();
  $('#replybut').click(function() {
    $('.reply').slideToggle();
    $('#message_title').val(' ');
    $('#message_message').val(' ');
  });

    $('#currentlocation').click(function() {
    $('#place_lat').val(pos['lat']);
    $('#place_lng').val(pos['lng']);
  });
});

// Ajax Request functions

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
      $('#collapseMem' + memory_id).html('<strong>Your flag has been noted and will be reviewed. Thanks for your feedback.</strong>');
      $('.flag_' + memory_id).html('<strong>Your flag has been noted and will be reviewed. Thanks for your feedback.</strong>')
    }
  });
}

addAdmin = function(itemid, adminid, controllername) {
// change to use model
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

});


}
$('#itm' + data.id).hide();
  });

});



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
      $('#collapseMem' + memory_id).html('<strong>Your flag has been noted and will be reviewed. Thanks for your feedback.</strong>');
      $('.flag_' + memory_id).html('<strong>Your flag has been noted and will be reviewed. Thanks for your feedback.</strong>')
    }
  });
}

addAdmin = function(itemid, adminid, controllername) {
// change to use model
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

});


}