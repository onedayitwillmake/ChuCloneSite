module GameHelper
	$output = ""
	#This file simply contains all the imports needed to run the game, in depencency order, in one place
	def embed(src)
		#	puts "\t<script type='text/javascript' src='#{src}'></script>\n";
		$output << "\t<script type='text/javascript' src='#{root_url}game/#{src}'></script>\n";
	end

	def embed_all()
		embed("js/lib/DAT.GUI.js");
		embed("js/lib/Stats.js");
		embed("js/lib/three.js/build/custom/ThreeDebug.js");
		embed("js/lib/three.js/examples/js/RequestAnimationFrame.js");
		embed("js/lib/three.js/examples/js/Stats.js");
		embed("js/lib/Tween.js");

		embed("assets/geometry/Bird.js");

		embed("js/lib/Box2DWeb.js");
		embed("js/lib/EventEmitter.js");


		embed("js/ChuClone/namespace.js");
		embed("js/ChuClone/model/Constants.js");
		embed("js/ChuClone/model/AchievementTracker.js");

		embed("js/ChuClone/Utils.js");
		embed("js/ChuClone/utils/TextureUtils.js");
		embed("js/ChuClone/utils/StyleMemoizer.js");

		embed("js/ChuClone/gui/LevelListing.js");
		embed("js/ChuClone/gui/HUDController.js");
		embed("js/ChuClone/gui/LevelRecap.js");

		embed("js/ChuClone/components/BaseComponent.js");
		embed("js/ChuClone/components/JumpPadComponent.js");
		embed("js/ChuClone/components/FrictionPadComponent.js");
		embed("js/ChuClone/components/MovingPlatformComponent.js");
		embed("js/ChuClone/components/RespawnPointComponent.js");
		embed("js/ChuClone/components/GoalPadComponent.js");
		embed("js/ChuClone/components/DeathPadComponent.js");
		embed("js/ChuClone/components/AutoRotationComponent.js");

		embed("js/ChuClone/components/effect/ParticleEmitterComponent.js");
		embed("js/ChuClone/components/effect/BirdEmitterComponent.js");

		embed("js/ChuClone/components/player/CharacterControllerComponent.js");
		embed("js/ChuClone/components/player/CheckIsJumpingComponent.js");
		embed("js/ChuClone/components/player/KeyboardInputComponent.js");
		embed("js/ChuClone/components/player/PlayerRecordComponent.js");
		embed("js/ChuClone/components/player/PlayerPlaybackComponent.js");
		embed("js/ChuClone/components/player/RemoteJoystickInputComponent.js");

		embed("js/ChuClone/components/PhysicsVelocityLimitComponent.js");
		embed("js/ChuClone/components/BoundsYCheckComponent.js");
		embed("js/ChuClone/components/camera/CameraFocusRadiusComponent.js");
		embed("js/ChuClone/components/camera/CameraFollowEditorComponent.js");
		embed("js/ChuClone/components/camera/CameraFollowPlayerComponent.js");
		embed("js/ChuClone/components/camera/CameraOrbitRadiusComponent.js");
		embed("js/ChuClone/components/ComponentFactory.js");

		embed("js/ChuClone/model/FSM/State.js");
		embed("js/ChuClone/model/FSM/StateMachine.js");

		embed("js/ChuClone/Dispatcher.js");
		embed("js/ChuClone/editor/LevelModel.js");
		embed("js/ChuClone/editor/LevelManager.js");
		embed("js/ChuClone/editor/CameraGUI.js");
		embed("js/ChuClone/editor/PlayerGUI.js");
		embed("js/ChuClone/editor/WorldEditor.js");
		embed("js/ChuClone/editor/ComponentGUI.js");
		embed("js/ChuClone/physics/ContactListener.js");
		embed("js/ChuClone/physics/DestructionListener.js");
		embed("js/ChuClone/physics/WorldController.js");
		embed("js/ChuClone/GameViewController.js");
		embed("js/ChuClone/GameEntity.js");

		embed("js/ChuClone/states/ChuCloneBaseState.js");
		embed("js/ChuClone/states/EditState.js");
		embed("js/ChuClone/states/EndLevelState.js");
		embed("js/ChuClone/states/PlayLevelState.js");
		embed("js/ChuClone/states/TitleScreenState.js");
		embed("js/ChuClone/ChuCloneGame.js");
	end
end
