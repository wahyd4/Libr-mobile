// Wait for device API libraries to load
//
document.addEventListener("deviceready", onDeviceReady, false);

// device APIs are available
//
function onDeviceReady() {
    navigator.geolocation.getCurrentPosition(onSuccess, onError);
}

// onSuccess Geolocation
//
function onSuccess(position) {
//    var element = document.getElementById('geolocation');
//    element.innerHTML = 'Latitude: ' + position.coords.latitude + '<br />' +
//        'Longitude: ' + position.coords.longitude + '<br />' +
//        'Altitude: ' + position.coords.altitude + '<br />' +
//        'Accuracy: ' + position.coords.accuracy + '<br />' +
//        'Altitude Accuracy: ' + position.coords.altitudeAccuracy + '<br />' +
//        'Heading: ' + position.coords.heading + '<br />' +
//        'Speed: ' + position.coords.speed + '<br />' +
//        'Timestamp: ' + position.timestamp + '<br />';
    alert('sss');
    alert('Latitude: ' + position.coords.latitude + '<br />' +
        'Longitude: ' + position.coords.longitude + '<br />');
}

// onError Callback receives a PositionError object
//
function onError(error) {
    alert('code: ' + error.code + '\n' +
        'message: ' + error.message + '\n');
}


function scan() {
    alert('into scan');
    cordova.plugins.barcodeScanner.scan(
        function (result) {
            alert("We got a barcode\n" +
                "Result: " + result.text + "\n" +
                "Format: " + result.format + "\n" +
                "Cancelled: " + result.cancelled);
        },
        function (error) {
            alert("Scanning failed: " + error);
        }
    );
}