  window.pins = [];

  function clearPins() {
    for (i = 0; i < pins.length; i++) {
      pins[i].setMap(null);
    }
    pins = [];
  }

  function formatReleaseEventString(facility) {
    var ret = ""
    ret += "Facility: " + facility.name + "<br>";
    ret += "Location: " + facility.address + ", " + facility.city +
       ", " + facility.state + "<br>";
    ret += "[<a href='/facilities/" + facility.id + "/edit'>Edit Facility</a>]&nbsp;";
    ret += "[<a data-confirm='Are you sure?' rel='nofollow' data-method='delete' href='/facilities/" + facility.id + "'>Delete Facility</a>]&nbsp;";
    return ret;
  }

  function attachContent(marker, facility) {
      var infowindow = new google.maps.InfoWindow({
        content: formatReleaseEventString(facility),
        isOpen: false
      });

      marker.addListener('mouseover', function() {
        infowindow.open(marker.get('map'), marker);
        infowindow.isOpen = false;
      });
      marker.addListener('mouseout', function() {
        if (!infowindow.isOpen) {
          infowindow.close(marker.get('map'), marker);
        }

      });
      marker.addListener('click', function() {
        if(infowindow.isOpen == false){
          infowindow.open(marker.get('map'), marker);
          infowindow.isOpen = true;
        }else{
          infowindow.close(marker.get('map'), marker);
          infowindow.isOpen = false;
        }

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
      window.releases = list;
      var facilities = {};
      for (i = 0; i < list.length; i++) {
        var f_id = "" + list[i].facility.id;
        if (!facilities[f_id]) {
          facilities[f_id] = Object.assign({}, list[i].facility);
          facilities[f_id].release_count = 0;
        }
        facilities[f_id].release_count++;
      }
      for (f_id in facilities) {
        var facility = facilities[f_id];
        console.log(facility);
        var marker = new google.maps.Marker({
          position: { lat: facility.latitude, lng: facility.longitude },
          label: "" + facility.release_count,
          map: map
        });
        pins.push(marker);
        attachContent(marker, facility);
      }
      generateTabel(list);
    });

  }

  function initMap() {
    var mapCenter = new google.maps.LatLng(40,-89.5);
    defaultZoom = 7;
    window.map = new google.maps.Map(document.getElementById('map'), {
      zoom: defaultZoom,
      center: mapCenter
    });

    google.maps.event.addListener(map, "idle", dropPins);
    dropPins();
  }

  function generateTabel(list){
      // get the reference for the body
    var new_tabel_body = document.createElement("tbody");
    new_tabel_body.id = "new_table_body";

    // creating all cells
    for (var i = 0; i < list.length; i++) {
      //console.log(list[i])
      // creates a table row
      var row = document.createElement("tr");
        // Create a <td> element and a text node, make the text
        // node the contents of the <td>, and put the <td> at
        // the end of the table row
        var cell = document.createElement("td");
        var cellText = document.createTextNode(list[i].chemical.name);
        cell.appendChild(cellText);
        row.appendChild(cell);

        var cell = document.createElement("td");
        var cellText = document.createTextNode(list[i].facility.name);
        cell.appendChild(cellText);
        row.appendChild(cell);

        var cell = document.createElement("td");
        var cellText = document.createTextNode(list[i].year);
        cell.appendChild(cellText);
        row.appendChild(cell);

        var cell = document.createElement("td");
        var cellText = document.createTextNode(list[i].quantity);
        cell.appendChild(cellText);
        row.appendChild(cell);

        var cell = document.createElement("td");
        var cellText = document.createTextNode(list[i].units);
        cell.appendChild(cellText);
        row.appendChild(cell);


      // add the row to the end of the table body
      new_tabel_body.appendChild(row);


    }
    old_tbody = document.getElementById("tabel_body");
    old_tbody.parentNode.replaceChild(new_tabel_body,old_tbody);
    new_tabel_body.id = "tabel_body";

    //$('#tabel').DataTable();
  }


  $(document).ready(function() {
    var eventFieldsForm = document.getElementById("event_fields");
    eventFieldsForm.onsubmit = function(e) {
      e.preventDefault();
      dropPins();
    };

    getTreeEvents(function(list) {
      // Load the graph below the map if it has been initialized
      if(typeof populateTidyTree !==  'undefined') {
        populateTidyTree(list);
      }
    });
  });
