function queryString(obj) {
  var ret = "";
  for (attr in obj) {
    if ((typeof obj[attr]) == "object") {
      for (nested_attr in obj[attr]) {	
        ret += (attr + "[" + nested_attr + "]=" + obj[attr][nested_attr] + "&");
      }
    } else {
      ret += (attr + "=" + obj[attr] + "&");
    }
  }
  return ret;
}

function getEvents(query, callback) {
  var xhr = new XMLHttpRequest();
  console.log("Requesting: " + "/events.json?" + queryString(query));
  xhr.open("GET", "/events.json?" + queryString(query));
  xhr.send();
  xhr.onreadystatechange = function() {
    if (xhr.readyState < 4) return;
    else callback(JSON.parse(xhr.responseText));
  }
}
