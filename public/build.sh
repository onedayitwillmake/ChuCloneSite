# See http://www.robotstxt.org/wc/norobots.html for documentation on how to use the robots.txt file
#
# To ban all spiders from the entire site uncomment the next two lines:
# User-Agent: *
# Disallow: /

java -jar compiler.jar --compilation_level WHITESPACE_ONLY  --js ./game/js/lib/DAT.GUI.js --js ./game/js/lib/Stats.js --js ./game/js/lib/three.js/build/custom/ThreeDebug.js --js ./game/js/lib/three.js/examples/js/RequestAnimationFrame.js --js ./game/js/lib/three.js/examples/js/Stats.js --js ./game/js/lib/Tween.js --js ./game/assets/geometry/Bird.js --js ./game/js/lib/Box2DWeb.js --js ./game/js/lib/EventEmitter.js --js ./game/js/ChuClone/namespace.js --js ./game/js/ChuClone/model/Constants.js --js ./game/js/ChuClone/model/AchievementTracker.js --js ./game/js/ChuClone/Utils.js --js ./game/js/ChuClone/utils/TextureUtils.js --js ./game/js/ChuClone/utils/StyleMemoizer.js --js ./game/js/ChuClone/gui/LevelListing.js --js ./game/js/ChuClone/gui/HUDController.js --js ./game/js/ChuClone/gui/LevelRecap.js --js ./game/js/ChuClone/gui/TutorialNoteDisplay.js --js ./game/js/ChuClone/components/BaseComponent.js --js ./game/js/ChuClone/components/JumpPadComponent.js --js ./game/js/ChuClone/components/FrictionPadComponent.js --js ./game/js/ChuClone/components/MovingPlatformComponent.js --js ./game/js/ChuClone/components/RespawnPointComponent.js --js ./game/js/ChuClone/components/GoalPadComponent.js --js ./game/js/ChuClone/components/DeathPadComponent.js --js ./game/js/ChuClone/components/AutoRotationComponent.js --js ./game/js/ChuClone/components/effect/ParticleEmitterComponent.js --js ./game/js/ChuClone/components/effect/BirdEmitterComponent.js --js ./game/js/ChuClone/components/player/CharacterControllerComponent.js --js ./game/js/ChuClone/components/player/CheckIsJumpingComponent.js --js ./game/js/ChuClone/components/player/KeyboardInputComponent.js --js ./game/js/ChuClone/components/player/PlayerRecordComponent.js --js ./game/js/ChuClone/components/player/PlayerPlaybackComponent.js --js ./game/js/ChuClone/components/player/RemoteJoystickInputComponent.js --js ./game/js/ChuClone/components/PhysicsVelocityLimitComponent.js --js ./game/js/ChuClone/components/BoundsYCheckComponent.js --js ./game/js/ChuClone/components/camera/CameraFocusRadiusComponent.js --js ./game/js/ChuClone/components/camera/CameraFollowEditorComponent.js --js ./game/js/ChuClone/components/camera/CameraFollowPlayerComponent.js --js ./game/js/ChuClone/components/camera/CameraOrbitRadiusComponent.js --js ./game/js/ChuClone/components/misc/TutorialNoteComponent.js --js ./game/js/ChuClone/components/ComponentFactory.js --js ./game/js/ChuClone/model/FSM/State.js --js ./game/js/ChuClone/model/FSM/StateMachine.js --js ./game/js/ChuClone/Dispatcher.js --js ./game/js/ChuClone/editor/LevelModel.js --js ./game/js/ChuClone/editor/LevelManager.js --js ./game/js/ChuClone/editor/CameraGUI.js --js ./game/js/ChuClone/editor/PlayerGUI.js --js ./game/js/ChuClone/editor/ShiftDragHelper.js --js ./game/js/ChuClone/editor/WorldEditor.js --js ./game/js/ChuClone/editor/ComponentGUI.js --js ./game/js/ChuClone/physics/ContactListener.js --js ./game/js/ChuClone/physics/DestructionListener.js --js ./game/js/ChuClone/physics/WorldController.js --js ./game/js/ChuClone/GameViewController.js --js ./game/js/ChuClone/GameEntity.js --js ./game/js/ChuClone/states/ChuCloneBaseState.js --js ./game/js/ChuClone/states/EditState.js --js ./game/js/ChuClone/states/EndLevelState.js --js ./game/js/ChuClone/states/PlayLevelState.js --js ./game/js/ChuClone/states/TitleScreenState.js --js ./game/js/ChuClone/ChuCloneGame.js --js_output_file chuclone_min.js