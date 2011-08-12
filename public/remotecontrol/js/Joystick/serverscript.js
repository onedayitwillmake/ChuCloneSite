/**
File:
	serverside.js
Created By:
	Mario Gonzalez
Project:
	NoBarrierOSC
Abstract:
	Server starting point
Basic Usage:
 	node server.js
Version:
	1.0
*/
require("../../../game/js/lib/NoBarrierOSC/SortedLookupTable.js");
require("../../../game/js/lib/NoBarrierOSC/RealtimeMutliplayerGame.js");
require("../../../game/js/lib/NoBarrierOSC/Point.js");
require("../../../game/js/lib/NoBarrierOSC/Constants.js");
require("../../../game/js/lib/NoBarrierOSC/NetChannelMessage.js");
require("../../../game/js/lib/NoBarrierOSC/EntityController.js");
require("../../../game/js/lib/NoBarrierOSC/Client.js");
require("../../../game/js/lib/NoBarrierOSC/ServerNetChannel.js");
require("../../../game/js/lib/NoBarrierOSC/GameEntity.js");

require("./JoystickNamespace.js");
require("./JoystickGameEntity.js");
require("./JoystickWorldEntityDescription.js");
require("./ServerApp.js");

var serverApp = new JoystickDemo.ServerApp();
serverApp.startGameClock();
