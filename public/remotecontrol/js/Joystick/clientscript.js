/**
 * Created by IntelliJ IDEA.
 * User: onedayitwillmake
 * Date: 5/20/11
 * Time: 9:37 PM
 * To change this template use File | Settings | File Templates.
 */
(function(){
	var onLoad = function( event ) {

        var ua = navigator.userAgent.toLowerCase();
        var isAndroid = ua.indexOf("android") > -1; //&& ua.indexOf("mobile");
        isAndroid = true;
        if(isAndroid) {
          // Do something!
          // Redirect to Android-site?
          //window.location = 'http://android.davidwalsh.name';
            var button = document.getElementById('dpad_button_right');
            button.parentNode.removeChild(button);

            var thumbstick = document.getElementById('thumb_stick_left');
            thumbstick.style.left = thumbstick.parentNode.clientWidth/2 - thumbstick.clientWidth/2 + "px";
            //button.parentNode.removeChild(button);
        }
		var app = new JoystickDemo.ClientApp();
		// Loop
		(function loop() {
			app.update();
			window.requestAnimationFrame( loop, null );
		})();
	};



	if (!window.requestAnimationFrame) {
		window.requestAnimationFrame = ( function() {
			return window.webkitRequestAnimationFrame ||
					window.mozRequestAnimationFrame ||
					window.oRequestAnimationFrame ||
					window.msRequestAnimationFrame ||
					function(/* function FrameRequestCallback */ callback, /* DOMElement Element */ element) {
						window.setTimeout(callback, 1000 / 60);
					};
		})();
	}
	window.addEventListener('DOMContentLoaded', onLoad, true);
}());