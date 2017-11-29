function getEvents(callback) {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", "/events.json");
  xhr.send();
  xhr.onreadystatechange = function() {
    if (xhr.readyState < 4) return;
    else callback(JSON.parse(xhr.responseText));
  }
}
