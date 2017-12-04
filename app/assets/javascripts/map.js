  window.pins = [];

  function clearPins() {
    for (i = 0; i < pins.length; i++) {
      pins[i].setMap(null);
    }
    pins = [];
  }

  function formatReleaseEventString(release) {
    var ret = ""
    ret += "Facility: " + release.facility.name + "<br>" +
      "Chemical: " + release.chemical.name + "<br>";
    if (release.amount)
      ret += "Amount: " + release.amount + " " + release.units + "<br>";
    ret += "Year: " + release.year + "<br>";
    ret += "Location: " + release.facility.address + ", " + release.facility.city +
       ", " + release.facility.state + "<br>";
    return ret;
  }

  function attachContent(marker, release) {
      var infowindow = new google.maps.InfoWindow({
        content: formatReleaseEventString(release)
      });

      marker.addListener('click', function() {
        infowindow.open(marker.get('map'), marker);
      });
  }

  function dropPins() {
    console.log("dropPins()");
    clearPins();
    var bounds = map.getBounds();
    var fields = {
      n: bounds.getNorthEast().lat(),
      s: bounds.getSouthWest().lat(),
      w: bounds.getSouthWest().lng(),
      e: bounds.getNorthEast().lng(),
      releases: {
        year: document.getElementById("release_year").value
      },
      chemicals: {
        clear_air_act_chemical: document.getElementById("chemical_caa").checked
      },
    }
    getEvents(fields, function(list) {
      for (i = 0; i < list.length; i++) {
        var facility = list[i].facility;
        var marker = new google.maps.Marker({
          position: { lat: facility.latitude, lng: facility.longitude },
          map: map
        });
        pins.push(marker);
        attachContent(marker, list[i]);
      }
    });
  }

  function initMap() {
    var mapCenter = new google.maps.LatLng(40,-89.5);
    defaultZoom = 7;
    window.map = new google.maps.Map(document.getElementById('map'), {
      zoom: defaultZoom,
      center: mapCenter
    });

    google.maps.event.addListener(map, "bounds_changed", dropPins);
    dropPins();
  }