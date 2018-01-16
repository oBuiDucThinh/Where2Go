document.addEventListener("turbolinks:load", function() {
  getLocation.initialize();
});

var getLocation = {
  initialize: function() {
    getLocation.fetch_data();
  },

  fetch_data: function() {
    var url_path = window.location.pathname;
    $.get(url_path, function(data) {
      var latitude = data['latitude'];
      var longitude = data['longitude'];
      getLocation.draw_map(latitude, longitude);
    }, 'json');
  },

  draw_map: function(lat, lng) {
    var companyLatlng = new google.maps.LatLng(lat, lng);
    var mapOptions = {
      zoom: 15,
      center: companyLatlng,
      styles: [
        {
            "featureType": "administrative",
            "elementType": "labels.text.fill",
            "stylers": [
                {
                    "color": "#444444"
                }
            ]
        },
        {
            "featureType": "landscape",
            "elementType": "all",
            "stylers": [
                {
                    "color": "#f2f2f2"
                }
            ]
        },
        {
            "featureType": "poi",
            "elementType": "all",
            "stylers": [
                {
                    "visibility": "off"
                }
            ]
        },
        {
            "featureType": "road",
            "elementType": "all",
            "stylers": [
                {
                    "saturation": -100
                },
                {
                    "lightness": 45
                }
            ]
        },
        {
            "featureType": "road.highway",
            "elementType": "all",
            "stylers": [
                {
                    "visibility": "simplified"
                }
            ]
        },
        {
            "featureType": "road.arterial",
            "elementType": "labels.icon",
            "stylers": [
                {
                    "visibility": "off"
                }
            ]
        },
        {
            "featureType": "transit",
            "elementType": "all",
            "stylers": [
                {
                    "visibility": "off"
                }
            ]
        },
        {
            "featureType": "water",
            "elementType": "all",
            "stylers": [
                {
                    "color": "#46bcec"
                },
                {
                    "visibility": "on"
                }
            ]
        }
    ],
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    var marker = new google.maps.Marker({
      position: companyLatlng,
      map: map
    });
  }
}
