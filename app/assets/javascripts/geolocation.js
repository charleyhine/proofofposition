function getGeoLocation() {
  navigator.geolocation.getCurrentPosition(setGeoCookie);
}

function setGeoCookie(position) {
  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
  
  if (document.cookie.indexOf("lat_lng") >= 0) {
	  document.cookie = "lat_lng=" + escape(cookie_val);
  } else { 
	  document.cookie = "lat_lng=" + escape(cookie_val);
	  location.reload();
  }
}