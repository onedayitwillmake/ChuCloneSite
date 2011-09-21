(function(){
    JoystickDemo.namespace("JoystickDemo.controls");

	/**
	 * Creates a new ButtonController, if shouldCatchOwnEvents it can handle its own touch events
	 * @param anHTMLElement
	 * @param shouldCatchOwnEvents
	 */
    JoystickDemo.controls.ButtonController = function( anHTMLElement, shouldCatchOwnEvents ){
        JoystickDemo.controls.ButtonController.superclass.constructor.call(this);
		if(!anHTMLElement) {
			throw new Error("anHTMLElement cannot be null!");
		}

        this._touchAreaHtmlElement = this._htmlElement = anHTMLElement;
        this._hitAreaBuffer = 10;
		this._catchOwnEvents = shouldCatchOwnEvents;
        this.setup();
        this.id == 1;
    };

    JoystickDemo.controls.ButtonController.prototype = {
        /**
         * @type {Boolean}
         */
        _isDown         : false,
        id:1,

        /**
         * @type {HTMLElement}
         */
        _htmlElement    : null,

        /**
         * @type {HTMLElement}
         */
        _touchAreaHtmlElement    : null,

        /**
         * Setup event listeners and etc
         */
        setup: function( ) {
			if(!this._catchOwnEvents) return;

			var that = this;
            //this.addListener( this._touchAreaHtmlElement, 'mousedown', function(e){ that.onMouseDown(e);} );
            this.addListener( document, 'touchstart', function(e){ that.ontouchstart(e);} );
            this.addListener( document, 'touchmove', function(e){ that.ontouchmove(e);} );
            this.addListener( document, 'touchend', function(e){ that.ontouchend(e);} );
            //setInterval(function(){
            //    that.ontou
            //}, 30)
        },

		onMouseDown: function(e) {
			this.ontouchstart(e);


            if(this._)

			var that = this;
			this.addListener( document, 'mouseup', function(e){ that.ontouchend(e);} );

		},

        /**
         * Mousedown callback
         * @param {MouseEvent} e
         */
        ontouchstart: function(e) {

            if( this._touchIdentifier != 0 ) {
                //console.log("TouchStart: Ignore");
                return;
            }
            var validTouches  = this.getValidTouches(e.touches, false);

            if(validTouches.length == 0) {
                //console.log("TouchStart: NoTouches");
                return;
            }




            this._touchIdentifier = validTouches[0].identifier;

            //console.log("TouchStart:" + validTouches.length + " " + this._touchIdentifier);
            this._isDown = validTouches.length != 0;
            this._htmlElement.style.opacity = (this._isDown) ? 1 : 0.25;
        },

        /**
         * Set angle based on nub location
         * @param {MouseEvent} e
         */
        ontouchmove: function(e) {
            var touchOfInterest  = this.getTouchOfInterest(e.changedTouches);
            if(!touchOfInterest) return;

            //console.log("TouchMove:" + touchOfInterest );
            
            this._isDown = this.hitTest(touchOfInterest);

            if(!this._isDown) {
                this._touchIdentifier = 0;
            }

            this._htmlElement.style.opacity = (this._isDown) ? 1 : 0.25;
        },

        /**
         * Reset the nub
         * @param {MouseEvent} e
         */
        ontouchend: function(e) {
            var touchOfInterest  = this.getTouchOfInterest(e.changedTouches);
            this._isDown = touchOfInterest == null;
            this._htmlElement.style.opacity = (this._isDown) ? 1 : 0.25;
            this._touchIdentifier = 0;
            //console.log("TouchEnd:" + touchOfInterest);
            return;
            var validTouches  = this.getValidTouches(e.changedTouches);
            //console.log("TouchEnd:" + validTouches.length)
            
            this._isDown = !(validTouches.length != 0);
            this._htmlElement.style.opacity = (this._isDown) ? 1 : 0.25;
            
            //// If catching own events - verify that this touch was ours
            //if( this._catchOwnEvents && !this.getTouchOfInterest(e.changedTouches)) {
             //   console.log("ButtonController::ontouchend - Touch ignored" + String(this.getTouchOfInterest(e.changedTouches)));
             //   return;
            //}
            //
            //this._isDown = false;
            //this._htmlElement.style.opacity = 0.25;
            //
			//if(this._catchOwnEvents) {
			//	this.removeListener( document, 'mouseup' );
			//	this.removeListener( document, 'touchend' );
			//}

			//console.log("touchup")
        },

        ///// ACCESSORS
        getIsDown: function() {
            return this._isDown;
        }
    };

    JoystickDemo.extend( JoystickDemo.controls.ButtonController, JoystickDemo.controls.Controller )

})();