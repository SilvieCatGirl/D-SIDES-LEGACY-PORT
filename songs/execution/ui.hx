// import funkin.data.NoteSkinHelper;
import flixel.text.FlxText;
// import funkin.RatingInfo;
import funkin.utils.MathUtil;
import funkin.backend.Difficulty;
import flixel.math.FlxMath;

var kadeEngineWatermark:FlxText;
var scoreText:FlxText;
var originalX:Float;
var diff = ['easy', 'normal', 'hard'];
var displacementx:Float;
var displacementy:Float;
var displacementcam:Float;
var bro:Float;
var totalElapsed:Float = 0;
var fucked_up:Bool = true;
var fucked_up_icons:Bool = true;

// var illegal:FlxSprite;
var cameraState:Int = 0;

function onLoad() {
	fucked_up = true;
	fucked_up_icons = true;

	songStartCallback = () -> {
		new FlxTimer().start(1.2, (t:FlxTimer) -> {
			startCountdown();
			getFieldFromID(1).playAnims = false;
			modManager.setValue("transformX", -50);
		});
	}

	illegal = new FlxSprite(0, 0).makeGraphic(4980, 4020, FlxColor.BLUE);
	illegal.alpha = 0.001;
	illegal.zIndex = 998;
	illegal.blend = BlendMode.MULTIPLY;
	illegal.cameras = [camHUD];
	// illegal.visible = false;
	add(illegal);

	if (ClientPrefs.lowQuality)
		return;

	illegaltext = new FlxSprite(700, 600);
	illegaltext.loadGraphic(Paths.image("backgrounds/exe/execution/illegalinstruction"));
	illegaltext.setGraphicSize(Std.int(illegaltext.width * 1.5));
	illegaltext.cameras = [camOther];
	illegaltext.zIndex = 999;
	illegaltext.antialiasing = false;
	illegaltext.alpha = 0.001;
	illegaltext.blend = BlendMode.ADD;
	// illegaltext.visible = false;
	add(illegaltext);
}

function onCreatePost() {
	skipCountdown = true;

	cameraSpeed = 1;
	camZoomingDecay = 2;

	playHUD.showRating = false;
	playHUD.showRatingNum = false;

	var poop = [playHUD.scoreTxt];
	if (ClientPrefs.timeBarType != 'Disabled') {
		poop.push(playHUD.timeTxt);
		poop.push(playHUD.timeBar);
	}
	for (m in poop)
		m.visible = false;

	playHUD.healthBar.setColors(FlxColor.fromRGB(255, 0, 0), FlxColor.fromRGB(101, 255, 49));

	kadeEngineWatermark = new FlxText(4, playHUD.healthBar.y
		+ 60, 0,
		PlayState.SONG.song
		+ " - "
		+ CoolUtil.capitalize(Difficulty.getCurrentDifficultyString())
		+ " | KE 1.5.4", 16);
	kadeEngineWatermark.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, FlxTextAlign.RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	kadeEngineWatermark.cameras = [camHUD];
	kadeEngineWatermark.scrollFactor.set();
	add(kadeEngineWatermark);

	if (ClientPrefs.downScroll)
		kadeEngineWatermark.y = FlxG.height * 0.9 + 45;

	scoreText = new FlxText(FlxG.width / 2 - 235, playHUD.healthBar.y + 50, 0, "", 20);
	scoreText.screenCenter(FlxAxes.X);
	originalX = scoreText.x;
	scoreText.scrollFactor.set();
	scoreText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	scoreText.cameras = [camHUD];
	add(scoreText);

	for (m in [boyfriendGroup, dadGroup]) {
		for (f in m.members)
			f.camDisplacement = 0;
	}

	// for (i in 0...4) {}
	// script_SUSTAINENDOffsets[i].y += 50;

	boyfriendGroup.addToList('mobian_bf', 0);
	dadGroup.addToList('LordX', 1);
	gfGroup.addToList('mobian_gf', 2);

	if (ClientPrefs.lowQuality)
		return;

	executionBG = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
	executionBG.cameras = [camOther];
	add(executionBG);

	executionCircle = new FlxSprite(1280, 0).loadGraphic(Paths.image('UI/game/exe/CircleExecution'));
	executionCircle.cameras = [camOther];
	add(executionCircle);

	executionTxt = new FlxSprite(-1280, 0).loadGraphic(Paths.image('UI/game/exe/TextExectution'));
	executionTxt.cameras = [camOther];
	add(executionTxt);

	modManager.queueFuncOnce(0, (s, s2) -> {
		FlxTween.tween(executionCircle, {x: 0}, 1);
		FlxTween.tween(executionTxt, {x: 0}, 1);
	});

	modManager.queueFuncOnce(16, (s, s2) -> {
		for (item in [executionBG, executionCircle, executionTxt])
			FlxTween.tween(item, {alpha: 0}, 1.25);
	});

	for(field in playFields.members)
	{
		for(i in 0...4)
			field._skin.susEndOffsets[i].y += 40;
	}
}

function onDestroy() {
	ClientPrefs.load();
}

function onSpawnNotePost(note) {
	if (!fucked_up)
		return;

	note.alpha = 1;
}

function onEvent(eventName, value1, value2) {
	if (eventName == 'Change Character') {
		playHUD.healthBar.setColors(FlxColor.fromRGB(255, 0, 0), FlxColor.fromRGB(101, 255, 49));
	}

	switch (eventName) {
		case 'Execution Events':
			switch (value1.toLowerCase()) {
				case 'aura':
					cameraState = 2;
					bro = 4;
					defaultCamZoom = 0.55;

				case 'aura loss':
					cameraState = 0;
					bro = 0;

				case 'bg':
					modManager.setValue("transformX", 0);
					getFieldFromID(1).playAnims = true;

					for (m in [playHUD.timeBar, playHUD.timeTxt, playHUD.scoreTxt])
						m.visible = true;

					health = 1;
					playHUD.healthBar.setColors(dad.healthColour, boyfriend.healthColour);

					cameraSpeed = 1.2;
					camZoomingDecay = 1.2;

					playHUD.showRating = true;
					playHUD.showRatingNum = true;

					kadeEngineWatermark.visible = false;
					scoreText.visible = false;

				// resetHUD();

				case 'lord x transforms':
					bro = 5;
					cameraState = 2;
					defaultCamZoom = 0.66;
					camZoomingMult = 0;
					cameraSpeed = 1.4;

				case 'error':
					for (i in [dad, gf, boyfriend]) {
						i.canDance = false;
						i.pauseAnim();
					}
					// snapCamToPos(326, 375, true);

					illegal.alpha = 1;
					if (!ClientPrefs.lowQuality) illegaltext.alpha = 1;

				case 'real intro':
					fucked_up_icons = false;
					bro = 2;
					cameraState = 2;

					illegal.color = FlxColor.BLACK;
					if (!ClientPrefs.lowQuality) illegaltext.visible = false;

				case 'real intro fade':
					camZooming = true;
					defaultCamZoom = 2.4;
					FlxTween.tween(game, {defaultCamZoom: 0.6}, 12.5, {ease: FlxEase.quadOut});

					FlxTween.color(illegal, 8, illegal.color, FlxColor.BLUE);
					FlxTween.tween(illegal, {alpha: 0}, 16, {ease: FlxEase.quintInOut});

				case 'real start':
					FlxTween.cancelTweensOf(game);
					bro = 1;
					cameraState = 1;
					camZoomingMult = 1;

				case 'epic thing':
					cameraState = 2;
					defaultCamZoom = 0.6;
					FlxTween.tween(game, {defaultCamZoom: 0.57}, 5, {ease: FlxEase.quadInOut});
					bro = 3;

				case 'end':
					camHUD.fade(FlxColor.BLACK, 5);
			}
	}
}

var iconScale:Float = 1;

function onUpdate(elapsed) {
	if (!fucked_up) {
		return;
	}

	if (fucked_up_icons) {
		for (icon in [playHUD.iconP1, playHUD.iconP2]) {
			icon.setGraphicSize(Std.int(FlxMath.lerp(150, icon.width, 0.50)));
			icon.updateHitbox();
		}
	}

	if (scoreText != null) {
		scoreText.text = calcR(songScore, songMisses);
		scoreText.screenCenter(FlxAxes.X);
	}

	totalElapsed += elapsed * -1;

	var displacementx = ((2.5 * Math.sin(totalElapsed * 0.45)) + (FlxG.random.float(-5, 5) * 0.07)) * (elapsed * 60);
	var displacementy = ((2.5 * Math.sin(totalElapsed * 0.25)) + (FlxG.random.float(-5, 5) * 0.07)) * (elapsed * 60);
	var displacementcam = (0.4 * Math.sin(totalElapsed * 0.55)) * (elapsed * 60);

	switch (bro) {
		case 0:
			// nothing ever happens
			isCameraOnForcedPos = false;

		case 1:
			// real part
			camGame.scroll.x = camGame.scroll.x + displacementx;
			camGame.scroll.y = camGame.scroll.y - displacementy;
			camGame.angle = displacementcam;
			isCameraOnForcedPos = false;

		case 2:
			// real part intro
			isCameraOnForcedPos = true;
			camFollow.x = 830;
			camFollow.y = 475;

		case 3:
			// real part ending
			camGame.scroll.x = camGame.scroll.x + displacementx * 0.1;
			camGame.scroll.y = camGame.scroll.y - displacementy * 0.1;
			camGame.angle = displacementcam;
			isCameraOnForcedPos = true;
			camFollow.x = 830;
			camFollow.y = 475;

		case 4:
			// aura
			isCameraOnForcedPos = true;
			camFollow.x = 626;
			camFollow.y = 375;

		case 5:
			// pibby
			isCameraOnForcedPos = true;
			camFollow.x = 326;
			camFollow.y = 375;
	}
}

var cam_focussing_on:String = '';

function onMoveCamera(focus) {
	switch (cameraState) {
		case 0:
			defaultCamZoom = focus == 'dad' ? 0.6 : 0.75;
		case 1:
			defaultCamZoom = focus == 'dad' ? 0.58 : 0.65;
		default:
	}
}

function onBeatHit() {
	if (!fucked_up)
		return;

	for (icon in [playHUD.iconP1, playHUD.iconP2]) {
		icon.setGraphicSize(Std.int(icon.width + 30));
		icon.updateHitbox();
	}
}

function weirdLetterRating(misses, bads, shits, goods) {
	var ranking:String = '';

	// THIS CODE IS DIRECTLY COPIED FROM KADE ENGINE -- PLEASE DONT KILL ME FOR THIS STAIRCASE
	// Signed, Campbell

	if (misses == 0 && bads == 0 && shits == 0 && goods == 0) // Marvelous (SICK) Full Combo
		ranking = "(MFC)";
	else if (misses == 0 && bads == 0 && shits == 0 && goods >= 1) // Good Full Combo (Nothing but Goods & Sicks)
		ranking = "(GFC)";
	else if (misses == 0) // Regular FC
		ranking = "(FC)";
	else if (misses < 10) // Single Digit Combo Breaks
		ranking = "(SDCB)";
	else
		ranking = "(Clear)";

	ranking += ' ';

	if (songScore == 0)
		ranking = '';

	return ranking;
}

function otherLetterRating(acc) {
	// this staircase is also ripped right from kade engine. There's GOTTA be a better way to do this but for the soul of kade engine ill leave it like this :P
	// Signed, Campbell
	var rating = 'N/A';

	if (acc >= 99.9935)
		rating = 'AAAAA'
	else if (acc >= 99.97)
		rating = 'AAAA';
	else if (acc >= 99.7)
		rating = 'AAA';
	else if (acc >= 93)
		rating = 'AA';
	else if (acc >= 85)
		rating = 'A';
	else if (acc >= 70)
		rating = 'B';
	else if (acc >= 60)
		rating = 'C';
	else if (acc < 60 && acc > 0)
		rating = 'D';
	else if (acc == 0)
		rating = 'N/A';

	return rating;
}

var rating = 'N/A';

function calcR(score, misses) {
	var acc = MathUtil.floorDecimal(ratingPercent * 100, 2);
	var rating = otherLetterRating(acc);

	return "Score: " + score + " | Combo Breaks: " + misses + " | Accuracy: " + acc + " %" + " | " + weirdLetterRating(songMisses, bads, shits, goods) + rating;
}
