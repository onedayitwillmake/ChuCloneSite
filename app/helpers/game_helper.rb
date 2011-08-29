module GameHelper
	$output = "java -jar compiler.jar --compilation_level WHITESPACE_ONLY "
	#This file simply contains all the imports needed to run the game, in depencency order, in one place
	def embed(src)
		#	puts "\t<script type='torext/javascript' src='#{src}')\n";
		$output << " --js #{src}"
	end

	def embed_all()
			embed('/game/js/lib/DAT.GUI.js')
	embed('/game/js/lib/Stats.js')
	embed('/game/js/lib/three.js/build/custom/ThreeDebug.js')
	embed('/game/js/lib/three.js/examples/js/RequestAnimationFrame.js')
	embed('/game/js/lib/three.js/examples/js/Stats.js')
	embed('/game/js/lib/Tween.js')

	embed('/game/assets/geometry/Bird.js')

	embed('/game/js/lib/Box2DWeb.js')
	embed('/game/js/lib/EventEmitter.js')

	embed('/game/js/ChuClone/namespace.js')
	embed('/game/js/ChuClone/model/Constants.js')
	embed('/game/js/ChuClone/model/AchievementTracker.js')

	embed('/game/js/ChuClone/Utils.js')
	embed('/game/js/ChuClone/utils/TextureUtils.js')
	embed('/game/js/ChuClone/utils/StyleMemoizer.js')

	embed('/game/js/ChuClone/gui/LevelListing.js')
	embed('/game/js/ChuClone/gui/HUDController.js')
	embed('/game/js/ChuClone/gui/LevelRecap.js')
	embed('/game/js/ChuClone/gui/TutorialNoteDisplay.js')

	embed('/game/js/ChuClone/components/BaseComponent.js')
	embed('/game/js/ChuClone/components/JumpPadComponent.js')
	embed('/game/js/ChuClone/components/FrictionPadComponent.js')
	embed('/game/js/ChuClone/components/MovingPlatformComponent.js')
	embed('/game/js/ChuClone/components/RespawnPointComponent.js')
	embed('/game/js/ChuClone/components/GoalPadComponent.js')
	embed('/game/js/ChuClone/components/DeathPadComponent.js')
	embed('/game/js/ChuClone/components/AutoRotationComponent.js')

	embed('/game/js/ChuClone/components/effect/ParticleEmitterComponent.js')
	embed('/game/js/ChuClone/components/effect/BirdEmitterComponent.js')

	embed('/game/js/ChuClone/components/player/CharacterControllerComponent.js')
	embed('/game/js/ChuClone/components/player/CheckIsJumpingComponent.js')
	embed('/game/js/ChuClone/components/player/KeyboardInputComponent.js')
	embed('/game/js/ChuClone/components/player/PlayerRecordComponent.js')
	embed('/game/js/ChuClone/components/player/PlayerPlaybackComponent.js')
	embed('/game/js/ChuClone/components/player/RemoteJoystickInputComponent.js')

	embed('/game/js/ChuClone/components/PhysicsVelocityLimitComponent.js')
	embed('/game/js/ChuClone/components/BoundsYCheckComponent.js')

	embed('/game/js/ChuClone/components/camera/CameraFocusRadiusComponent.js')
	embed('/game/js/ChuClone/components/camera/CameraFollowEditorComponent.js')
	embed('/game/js/ChuClone/components/camera/CameraFollowPlayerComponent.js')
	embed('/game/js/ChuClone/components/camera/CameraOrbitRadiusComponent.js')

	embed('/game/js/ChuClone/components/misc/TutorialNoteComponent.js')

	embed('/game/js/ChuClone/components/ComponentFactory.js')

	embed('/game/js/ChuClone/model/FSM/State.js')
	embed('/game/js/ChuClone/model/FSM/StateMachine.js')

	embed('/game/js/ChuClone/Dispatcher.js')

	embed('/game/js/ChuClone/editor/LevelModel.js')
	embed('/game/js/ChuClone/editor/LevelManager.js')
	embed('/game/js/ChuClone/editor/CameraGUI.js')
	embed('/game/js/ChuClone/editor/PlayerGUI.js')
	embed('/game/js/ChuClone/editor/ShiftDragHelper.js')
	embed('/game/js/ChuClone/editor/WorldEditor.js')
	embed('/game/js/ChuClone/editor/ComponentGUI.js')

	embed('/game/js/ChuClone/physics/ContactListener.js')
	embed('/game/js/ChuClone/physics/DestructionListener.js')
	embed('/game/js/ChuClone/physics/WorldController.js')

	embed('/game/js/ChuClone/GameViewController.js')
	embed('/game/js/ChuClone/GameEntity.js')

	embed('/game/js/ChuClone/states/ChuCloneBaseState.js')
	embed('/game/js/ChuClone/states/EditState.js')
	embed('/game/js/ChuClone/states/EndLevelState.js')
	embed('/game/js/ChuClone/states/PlayLevelState.js')
	embed('/game/js/ChuClone/states/TitleScreenState.js')

	embed('/game/js/ChuClone/ChuCloneGame.js')

    puts $output;
	end

	def has_highscore highscores, level_id
		return false if highscores == nil
		highscores.each do |score|
			return true if score.level_id == level_id
		end

		false
	end
end
