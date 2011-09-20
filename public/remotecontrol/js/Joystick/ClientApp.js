
(function(){
	JoystickDemo.ClientApp = function() {
        this.setup();
	};

	JoystickDemo.ClientApp.prototype = {

		gameClockReal  			: 0,											// Actual time via "new Date().getTime();"
		gameClock				: 0,											// Seconds since start
		gameTick				: 0,											// Ticks/frames since start

		speedFactor				: 1,											// Used to create Framerate Independent Motion (FRIM) - 1.0 means running at exactly the correct speed, 0.5 means half-framerate. (otherwise faster machines which can update themselves more accurately will have an advantage)
		targetFramerate			: 60,											// Try to call our tick function this often, intervalFramerate, is used to determin how often to call settimeout - we can set to lower numbers for slower computers

		netChannel				: null,											// ClientNetChannel instance
		cmdMap					: {},											// Map some custom functions if wnated

        _thumbStickControllerLeft   : null,
		_mousePosition			: {},		// Actual mouse position
		_mousePositionNormalized: {},		// Mouse position 0-1
        _accelX                 : 0,
        _accelY                 : 0,

        setup: function() {
            this.gameClockReal = new Date().getTime();

            this.cmdMap = {};
            this.cmdMap[RealtimeMultiplayerGame.Constants.CMDS.LEVEL_COMPLETE] = this.onLevelComplete;

		    this.netChannel = new RealtimeMultiplayerGame.ClientNetChannel( this, RealtimeMultiplayerGame.Constants.SERVER_SETTING.SOCKET_ADDRESS, RealtimeMultiplayerGame.Constants.SERVER_SETTING.SOCKET_PORT, ['websocket', 'xhr-polling', 'json-polling'], false);

            this._thumbStickControllerLeft = new JoystickDemo.controls.ThumbStickController("left");

            if( document.getElementById('dpad_button_right') )
			    this._button = new JoystickDemo.controls.ButtonController( document.getElementById('dpad_button_right'), true );


            

            // Cancel
            document.addEventListener("touchstart", function(e) { e.preventDefault()}, true);
            document.addEventListener("touchmove", function(e) { e.preventDefault()}, true);
            document.addEventListener("touchend", function(e) { e.preventDefault()}, true);
            document.addEventListener("touchcancel", function(e) { e.preventDefault()}, true);

            //var acceleration.y
            var kFilter = 0.5;
            var that = this;
            window.ondevicemotion = function(event) {
                var rawX = event.accelerationIncludingGravity.x;
                var rawY = event.accelerationIncludingGravity.y;
                that._accelX = rawX * kFilter + that._accelX * (1.0 - kFilter);
                that._accelY = rawY * kFilter + that._accelY * (1.0 - kFilter);
            }
        },

        /**
         * Level complete, return to index
         */
        onLevelComplete: function(){
            window.location ="./win.html";
        },

		update_count: 0,
		update: function() {
			this.updateClock();

            this.netChannel.addMessageToQueue( false, RealtimeMultiplayerGame.Constants.CMDS.JOYSTICK_UPDATE, {
                analog: this._thumbStickControllerLeft.getAngle360(),
                accelX: this._accelX,
                accelY: this._accelY,
				button: (this._button) ? this._button.getIsDown() : 'null',
                level: this.level_id
            } );
			this.netChannel.tick();
		},

        netChannelDidConnect: function() {
			this.joinGame( "user" + this.netChannel.getClientid() );
		},

		netChannelDidReceiveMessage: function( aMessage ) {
			this.log("RecievedMessage", aMessage);
		},
		netChannelDidDisconnect: function() {
			this.log("netChannelDidDisconnect", arguments);
		},

		/**
		 * Updates the gameclock and sets the current
		 */
		updateClock: function() {
			//
			// Store previous time and update current
			var oldTime = this.gameClockReal;
			this.gameClockReal = new Date().getTime();

			// Our clock is zero based, so if for example it says 10,000 - that means the game started 10 seconds ago
			var delta = this.gameClockReal - oldTime;
			this.gameClock += delta;
			this.gameTick++;

			// Framerate Independent Motion -
			// 1.0 means running at exactly the correct speed, 0.5 means half-framerate. (otherwise faster machines which can update themselves more accurately will have an advantage)
			this.speedFactor = delta / ( 1000/this.targetFramerate );
			if (this.speedFactor <= 0) this.speedFactor = 1;
		},

		/**
		 * Called by the ClientNetChannel, it sends us an array containing tightly packed values and expects us to return a meaningful object
		 * It is left up to each game to implement this function because only the game knows what it needs to send.
		 * However the 4 example projects in RealtimeMultiplayerNodeJS offer should be used ans examples
		 *
		 * @param {Array} entityDescAsArray An array of tightly packed values
		 * @return {Object} An object which will be returned to you later on tied to a specific entity
		 */
		parseEntityDescriptionArray: function(entityDescAsArray) {
			var entityDescription = {};

			// It is left upto each game to implement this function because only the game knows what it needs to send.
			// However the 4 example projects in RealtimeMultiplayerNodeJS offer this an example
			entityDescription.entityid = +entityDescAsArray[0];
			entityDescription.clientid = +entityDescAsArray[1];
			entityDescription.entityType = +entityDescAsArray[2];
			entityDescription.x = +entityDescAsArray[3];
			entityDescription.y = +entityDescAsArray[4];

			return entityDescription;
		},

		getGameClock: function() {
		   return this.gameClock;
		},

		/**
		 * Called when the user has entered a name, and wants to join the match
		 * @param aNickname
		 */
		joinGame: function(aNickname) {
		
		// Load a level if one is provided via query string
            if( window.location.href.indexOf("?id=") != -1 ) {
                var needle = "?id=";
                var needleIndex = window.location.href.indexOf(needle);
                var level_id = window.location.href.substring( needleIndex + needle.length )

                this.netChannel.addMessageToQueue( true, RealtimeMultiplayerGame.Constants.CMDS.JOYSTICK_SELECT_LEVEL, {
                    level_id: level_id
                } );
            }

            this.level_id = level_id;
			// Create a 'join' message and queue it in ClientNetChannel
			this.netChannel.addMessageToQueue( true, RealtimeMultiplayerGame.Constants.CMDS.PLAYER_JOINED, { nickname: aNickname, type: "joystick" } );
		},

        log: function() { console.log.apply(console, arguments); }
	};
}());