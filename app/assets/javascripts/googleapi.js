$(function(){

});



var pos = {
  lat: 0,
  lng: 0
};

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 55.9615730339918, lng: -3.165215849876404},
    zoom: 16
  });
  var infoWindow = new google.maps.InfoWindow({map: map});

  google.maps.event.addListener(map, 'click', function( event ){
    // alert( "Latitude: "+event.latLng.lat()+" "+", longitude: "+event.latLng.lng() );
    pos = { lat: event.latLng.lat(), 
      lng: event.latLng.lng() };
      $('#currentlocation').hide();
      $('#place_lat').val(pos['lat']);
      $('#place_lng').val(pos['lng']); 
  });

  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      // infoWindow.setPosition(pos);
      // infoWindow.setContent('Location found.');
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
    handleLocationError(false, infoWindow, map.getCenter());
  }
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
}

