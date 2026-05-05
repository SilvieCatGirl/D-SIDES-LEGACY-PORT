import funkin.game.shaders.HSLColorSwap;
import openfl.filters.ShaderFilter;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.text.FlxTypeText;

var camTenma:FlxCamera;
var camChar:FlxCamera;
var dadReflection:FlxSprite;
var boyfriendReflection:FlxSprite;
var bg_string:String = 'backgrounds/exe/endless';
var lilGuy1:BGSprite;
var lilGuy2:BGSprite;
var lilGuy3:BGSprite;
var lilGuy45:BGSprite;
var audience:BGSprite;
var purp_a:Float = 0;
var purple = newShader('blue');
var purpleHUD = newShader('blue');
var sat = new HSLColorSwap();

function numericForInterval(start, end, interval, func) {
	var index = start;
	while (index < end) {
		func(index);
		index += interval;
	}
}

function tr(deg) {
	return deg * (3.141592653595 / 180);
}

function makeSpr(x,y,anim,factor)
{
	var spr = new FlxSprite(x,y).setFrames(Paths.getSparrowAtlas('backgrounds/exe/endless/city'));
	spr.animation.addByPrefix('idle', anim, 24, false);
	spr.animation.play('idle');
	spr.scrollFactor.set(factor[0], factor[1]);
	spr.updateHitbox();

	return spr;
}

function onLoad() {
	initScript('data/scripts/exe_hud');
	if(!ClientPrefs.lowQuality){
		if (ClientPrefs.shaders) {
			sat.saturation = -0.2;

			purple.setFloat('hue', 1.575);
			purple.setFloat('hueBlend', 0.5);
			purple.setFloat('pix', 0.000001);

			purpleHUD.setFloat('hue', 1.575);
			purpleHUD.setFloat('hueBlend', 0.0);
			purpleHUD.setFloat('pix', 0.000001);

			camGame.filters = [new ShaderFilter(sat.shader)];
			camHUD.filters = [new ShaderFilter(purpleHUD)];
		}

		camTenma = new FlxCamera(-465, 0, 2209, 124 * 8);
		camTenma.bgColor = 0x0;
		camChar = new FlxCamera();
		camChar.bgColor = 0x0;
		insertFlxCamera(FlxG.cameras.list.indexOf(camGame), camTenma, false);
		insertFlxCamera(FlxG.cameras.list.indexOf(camGame), camChar, false);

	}

	var bg = makeSpr(-700,-740, 'endlesssky', [0.15, 0.15]);
	add(bg);
	var city = makeSpr(-700,-550, 'endlesscity', [0.25, 0.25]);
	add(city);

	var cd = makeSpr(430, 1100, 'endlesscd', [1.0, 1.0]);

	if(!ClientPrefs.lowQuality){
		var thingyLeft = makeSpr(-380, 0, 'endlesstower1', [0.75, 1.0]);
		add(thingyLeft);

		barLeft = makeSpr(-150, -200, 'endlessbuild2', [0.8, 1.0]);

		lilGuy3 = new BGSprite(bg_string + '/tenmas', barLeft.x + 1070, barLeft.y + 310, 0.65, 1, ['Tenma3'], false);
		lilGuy3.antialiasing = true;

		add(lilGuy3);
		add(barLeft);

		lilGuy2 = new BGSprite(bg_string + '/tenmas', barLeft.x + 670, barLeft.y + 370, 0.8, 1, ['Tenma2'], false);
		lilGuy2.antialiasing = true;
		add(lilGuy2);

		lilGuy1 = new BGSprite(bg_string + '/tenmas', barLeft.x + 270, barLeft.y + 530, 0.8, 1, ['Tenma1'], false);
		lilGuy1.antialiasing = true;
		add(lilGuy1);

		barRight = makeSpr(1300,-200, 'endlessbuild1', [0.85, 1.0]);
		add(barRight);

		lilGuy45 = new BGSprite(bg_string + '/tenmas', barRight.x + 200, barRight.y + 410, 0.85, 1, ['Tenma4and5'], false);
		lilGuy45.antialiasing = true;
		add(lilGuy45);

		thingyRight = makeSpr(2300,0,'endlesstower', [1.2, 1.0]);
		thingyRight.zIndex = 2;
		add(thingyRight);

		audience = new BGSprite(bg_string + '/tenmas', 0, 1200, 1.3, 1, ['AudienceTenmas'], false);
		audience.antialiasing = true;
		audience.zIndex = 3;
		add(audience);

		tenmalinebg = new FlxSprite(-300, 0).makeGraphic(2700, 2000, FlxColor.BLACK);
		tenmalinebg.alpha = 0;
		add(tenmalinebg);

		tenmaline1 = new FlxBackdrop(null, FlxAxes.XY, 0, Std.int(134));
		tenmaline1.frames = Paths.getSparrowAtlas(bg_string + '/tenmas');
		tenmaline1.animation.addByPrefix('idle', 'tenmadance', 12, true);
		tenmaline1.animation.play('idle');
		tenmaline1.scale.set(2, 2);
		tenmaline1.updateHitbox();
		tenmaline1.alpha = 0;
		add(tenmaline1);

		tenmaline2 = new FlxBackdrop(null, FlxAxes.XY, 0, Std.int(134));
		tenmaline2.frames = Paths.getSparrowAtlas(bg_string + '/tenmas');
		tenmaline2.animation.addByPrefix('idle', 'tenmadance', 12, true);
		tenmaline2.animation.play('idle');
		tenmaline2.scale.set(2, 2);
		tenmaline2.updateHitbox();
		tenmaline2.y += 134 * 2;
		tenmaline2.alpha = 0;
		add(tenmaline2);

		introTenma = new FlxSprite();
		introTenma.frames = Paths.getSparrowAtlas(bg_string + '/tenmas');
		introTenma.animation.addByPrefix('idle', 'tenmadance', 12, true);
		introTenma.animation.play('idle');
		introTenma.blend = BlendMode.ADD;
		introTenma.updateHitbox();
		introTenma.screenCenter();
		introTenma.camera = camOther;
		introTenma.visible = false;
		add(introTenma);

		introText = new FlxTypeText(0, 450, 500, 'YOU NEVER STOOD A CHANCE');
		introText.setFormat(Paths.font("rge.ttf"), 50, 0xFFda75ff, FlxTextAlign.CENTER);
		introText.screenCenter(FlxAxes.X);
		introText.camera = camOther;
		add(introText);

		add(cd);

		blend_bg = makeSpr(100,100,'endless_gradient', [0.15, 0.15]);
		blend_bg.antialiasing = ClientPrefs.globalAntialiasing;
		blend_bg.blend = BlendMode.ADD;
		blend_bg.scale.set(2.5, 2.5);
		blend_bg.zIndex = 9;
		blend_bg.alpha = 0.4;
		add(blend_bg);

		for (i in [barLeft, barRight, lilGuy1, lilGuy2, lilGuy3, lilGuy45])
			i.y -= 750;
		audience.y += 500;
	} else{
		add(cd);
		defaultCamZoom = 1;
		camGame.zoom = 1;
	}

	skipCountdown = true;
	countdownDelay = 1;
	holdSubdivisions = ClientPrefs.lowQuality ? 1 : 4;
}

var dropped:Bool = false;

var tenmaline_amt:Int = ClientPrefs.flashing ? 10 : 5;
function onUpdate(elapsed) {
	if(ClientPrefs.lowQuality) return;

	tenmaline1.x -= tenmaline_amt * (60 * elapsed);
	tenmaline2.x += tenmaline_amt * (60 * elapsed);

	blend_bg.alpha = purp_a;
	if (!dropped && ClientPrefs.shaders)
		purple.setFloat('hueBlend', 0.5 + (purp_a * 0.5));

	purp_a = FlxMath.lerp(purp_a, 0.1, FlxMath.bound(0, 1, elapsed * 4));
}

var purpTimer = 99999;
var purpLvl = 0;

function onCreatePost() {
	if(ClientPrefs.lowQuality) return;

	if (ClientPrefs.shaders) {
		boyfriend.shader = purple;
		gf.shader = purple;
		dad.shader = purple;
	}

	camGame.visible = false;
	camHUD.visible = false;

	modManager.queueFuncOnce(2, (s, s2) -> {
		introTenma.visible = true;
		introText.start();
	});

	modManager.queueFuncOnce(16, (s, s2) -> {
		camOther.bgColor = 0x0;
		introTenma.visible = false;
		introText.visible = false;
		if (ClientPrefs.flashing)
			camHUD.flash(FlxColor.WHITE, 1);
		else
			camHUD.flash(FlxColor.BLACK, 2);
		camHUD.visible = true;
		camGame.visible = true;
	});

	modManager.queueFuncOnce(143, (s, s2) -> {
		purpLvl = 0.325;
		purpTimer = 2;
		FlxTween.tween(sat, {saturation: 0}, 1);

		for (i in [barRight, lilGuy45])
			FlxTween.tween(i, {y: i.y + 750}, 3, {startDelay: 0.5, ease: FlxEase.circOut});

		for (i in [barLeft, lilGuy1, lilGuy2])
			FlxTween.tween(i, {y: i.y + 750}, 2.75, {ease: FlxEase.circOut});

		FlxTween.tween(lilGuy3, {y: lilGuy3.y + 750}, 2, {ease: FlxEase.circOut, startDelay: 1.5});
		FlxTween.tween(audience, {y: audience.y - 500}, 1, {ease: FlxEase.circOut, startDelay: 0.75});
	});
	modManager.queueFuncOnce(911, (s, s2) -> {
		drop(true);
	});
	modManager.queueFuncOnce(1167, (s, s2) -> {
		drop(false);
	});
	loadModchart();
}

var blendbgtween:FlxTween;

function onBeatHit() {
	if(ClientPrefs.lowQuality) return;

	tenmas_dance();
	if (curBeat % purpTimer == 0)
		purp_a = (ClientPrefs.flashing ? purpLvl : purpLvl * 0.5);
}

function onCountdownTick() {
	tenmas_dance();
}

function tenmas_dance() {
	lilGuy1.animation.play('Tenma1', true);
	lilGuy2.animation.play('Tenma2', true);
	lilGuy3.animation.play('Tenma3', true);
	lilGuy45.animation.play('Tenma4and5', true);
	audience.animation.play('AudienceTenmas', true);

	if (blendbgtween != null) {
		blendbgtween.cancel();
	}
}

function drop(dropping) {
	var time = dropping ? 2 : 3;
	dropped = dropping;
	purpLvl = dropping ? 0.625 : 0.325;
	purpTimer = dropping ? 1 : 4;

	if (ClientPrefs.shaders) {
		FlxTween.tween(sat, {saturation: dropping ? 0.5 : 0}, time);
		FlxTween.num(dropping ? 0 : 0.75, dropping ? 0.75 : 0, time, {
			onUpdate: (t) -> {
				purpleHUD.setFloat('hueBlend', t.value);
			}
		});

		FlxTween.num(dropping ? 0.5 : 1, dropping ? 1 : 0.5, time, {
			onUpdate: (t) -> {
				purple.setFloat('hueBlend', t.value);
			}
		});
	}

	for (i in [tenmaline1, tenmaline2, tenmalinebg])
		FlxTween.tween(i, {alpha: dropping ? 1 : 0}, time);
	for (i in [audience, thingyRight])
		FlxTween.tween(i, {alpha: dropping ? 0 : 1}, time);

	var y = ClientPrefs.downScroll ? -200 : 200;
	for (i in [playHUD.timeBar, playHUD.timeTxt])
		FlxTween.tween(i, {y: dropping ? i.y - y : i.y + y}, time * 0.75, {ease: dropping ? FlxEase.expoIn : FlxEase.expoOut});

	for (i in [playHUD.healthBar, playHUD.iconP1, playHUD.iconP2])
		FlxTween.tween(i, {y: dropping ? i.y + y : i.y - y}, time * 0.75, {ease: dropping ? FlxEase.expoIn : FlxEase.expoOut});
}

function insertFlxCamera(idx:Int, camera:FlxCamera, defDraw:Bool = false) {
	var cameras = [
		for (i in FlxG.cameras.list)
			{
				cam: i,
				defaultDraw: FlxG.cameras.defaults.contains(i)
			}
	];

	for (i in cameras)
		FlxG.cameras.remove(i.cam, false);

	cameras.insert(idx, {cam: camera, defaultDraw: defDraw});

	for (i in cameras)
		FlxG.cameras.add(i.cam, i.defaultDraw);
}

function loadModchart() {
	for (i in 0...4) {
		modManager.setValue("transform" + i + "Y", -200, 0);
		modManager.setValue("alpha" + i, 1, 0);
		modManager.setValue("confusion" + i, 180, 0);
	}

	modManager.queueSet(16, "squish", 0.5);
	modManager.queueEase(16, 20, "squish", 0, 'circOut');

	for (i in 0...4) {
		modManager.queueEase(72 + i, 80 + i, "transform" + i + "Y", 0, 'quartOut');
		modManager.queueEase(72 + i, 80 + i, "alpha" + i, 0, 'quadOut');
		modManager.queueEase(72 + i, 80 + i, "confusion" + i, 0, 'quartOut');
	}

	modManager.queueSet(16, "localrotateY", tr(360));
	modManager.queueEase(16, 24, "localrotateY", 0, 'quadOut');

	numericForInterval(16, 135, 16, (s) -> {
		modManager.queueSet(s, "drunk", .45);
		modManager.queueEase(s, s + 4, "drunk", 0, 'expoOut');

		modManager.queueSet(s + 6, "tipsy", -.45);
		modManager.queueEase(s + 6, s + 8, "tipsy", 0, 'quadOut');

		modManager.queueSet(s + 8, "drunk", .85);
		modManager.queueEase(s + 8, s + 14, "drunk", 0, 'expoOut');
		modManager.queueSet(s + 8, "tipsy", .85);
		modManager.queueEase(s + 8, s + 14, "tipsy", 0, 'expoOut');
	});

	// modManager.queueEase(144, 148, "wave", 1);

	modManager.queueSet(144, "localrotateY", tr(360 * 3));
	modManager.queueEase(144, 148, "localrotateY", 0, 'circOut');

	var f = 1;
	numericForInterval(144, 400, 8, (s) -> {
		f *= -1;
		modManager.queueSet(s, 'transformX', -85 * f);
		modManager.queueSetP(s, 'mini', -50);
		modManager.queueEase(s, s + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(s, s + 4, "mini", 0, "quadOut");

		modManager.queueSet(s, "drunk", 1 * f);
		modManager.queueEase(s, s + 4, "drunk", 0, 'cubeOut');

		modManager.queueSet(s, "localrotateZ", tr(15) * -f, 0);
		modManager.queueSet(s, "localrotateZ", tr(15) * f, 1);
		modManager.queueEase(s, s + 4, "localrotateZ", 0, 'circOut');
		modManager.queueSet(s, "confusion", 15 * -f, 0);
		modManager.queueSet(s, "confusion", 15 * f, 1);
		modManager.queueEase(s, s + 4, "confusion", 0, 'circOut');

		var step = s + 4;

		modManager.queueSetP(step, 'tipsy', 125);
		modManager.queueSetP(step, 'tipsyOffset', 25);
		modManager.queueSet(step, 'transformX', -75);
		modManager.queueSetP(step, 'mini', -50);
		modManager.queueEase(step, step + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsy', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsyOffset', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, "mini", 0, "quadOut");

		modManager.queueSet(step, "tipsy", 1 * f);
		modManager.queueEase(step, step + 4, "tipsy", 0, 'cubeOut');

		// modManager.queueEase(step, step+4, "localrotateY", tr(-10), 'circOut');
	});

	var y = ClientPrefs.downScroll ? 200 : -200;
	for (i in 0...2) {
		modManager.queueEase(302, 302 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(302 + 3, 'reverse' + i, 1);
		modManager.queueSet(302 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(302 + 3, 302 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(302, 302 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(302 + 3, 'reverse' + i, 1);
		modManager.queueSet(302 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(302 + 3, 302 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(365, 365 + 3, "transform" + i + "Y", -y, 'backIn');
		modManager.queueSet(365 + 3, 'reverse' + i, 1);
		modManager.queueSet(365 + 3, "transform" + i + "Y", y);
		modManager.queueEase(365 + 3, 365 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(365, 365 + 3, "transform" + i + "Y", -y, 'backIn');
		modManager.queueSet(365 + 3, 'reverse' + i, 1);
		modManager.queueSet(365 + 3, "transform" + i + "Y", y);
		modManager.queueEase(365 + 3, 365 + 6, "transform" + i + "Y", 0, 'backOut');
	}
	for (i in 2...4) {
		modManager.queueEase(318, 318 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(318 + 3, 'reverse' + i, 1);
		modManager.queueSet(318 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(318 + 3, 318 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(380, 380 + 3, "transform" + i + "Y", -y, 'backIn');
		modManager.queueSet(380 + 3, 'reverse' + i, 1);
		modManager.queueSet(380 + 3, "transform" + i + "Y", y);
		modManager.queueEase(380 + 3, 380 + 6, "transform" + i + "Y", 0, 'backOut');
	}

	modManager.queueEase(368, 369, "reverse0", 0, 'cubeInOut');
	modManager.queueEase(368, 369, "reverse1", 0, 'cubeInOut');
	modManager.queueEase(383, 386, "reverse2", 0, 'cubeInOut');
	modManager.queueEase(383, 386, "reverse3", 0, 'cubeInOut');

	var f = 1;
	numericForInterval(400, 650, 8, (s) -> {
		f *= -1;
		modManager.queueSet(s, 'transformX', -30 * f);
		modManager.queueSetP(s, 'mini', -25);
		modManager.queueEase(s, s + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(s, s + 4, "mini", 0, "quadOut");

		modManager.queueSet(s, "drunk", 0.5 * f);
		modManager.queueEase(s, s + 4, "drunk", 0, 'cubeOut');
		var step = s + 4;

		modManager.queueSetP(step, 'tipsy', 125);
		modManager.queueSetP(step, 'tipsyOffset', 25);
		modManager.queueSet(step, 'transformX', -75);
		modManager.queueSetP(step, 'mini', -25);
		modManager.queueEase(step, step + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsy', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsyOffset', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, "mini", 0, "quadOut");

		modManager.queueSet(step, "tipsy", 0.5 * f);
		modManager.queueEase(step, step + 4, "tipsy", 0, 'cubeOut');

		modManager.queueEase(step, step+4, "localrotateY", tr(-10), 'circOut');
	});

	modManager.queueEase(400, 408, "opponentSwap", 0.5, 'quartOut');
	modManager.queueEase(400, 408, "alpha", 0.5, 'quartOut', 1);
	modManager.queueEase(400, 408, "stealth", 0.125, 'quartOut', 1);
	modManager.queueEase(400, 408, "transform0X", -112 * 3.25, 'quartOut', 0);
	modManager.queueEase(400, 408, "transform1X", -112 * 3, 'quartOut', 0);
	modManager.queueEase(400, 408, "transform2X", 112 * 3, 'quartOut', 0);
	modManager.queueEase(400, 408, "transform3X", 112 * 3.25, 'quartOut', 0);

	for (i in 0...4)
		modManager.queueEase(456, 464, "transform" + i + "X", 0, 'quartInOut', 0);

	modManager.queueEase(456, 464, "transform0X", -112 * 3.25, 'quartOut', 1);
	modManager.queueEase(456, 464, "transform1X", -112 * 3, 'quartOut', 1);
	modManager.queueEase(456, 464, "transform2X", 112 * 3, 'quartOut', 1);
	modManager.queueEase(456, 464, "transform3X", 112 * 3.25, 'quartOut', 1);

	modManager.queueEase(526, 528, "transformY", y, 'backIn');
	modManager.queueSet(528, "opponentSwap", 0);
	modManager.queueSet(528, "reverse", 1);
	modManager.queueSet(528, "alpha", 0, 1);
	modManager.queueSet(528, "stealth", 0, 1);
	modManager.queueSet(528, "transformY", -y);
	for (i in 0...4)
		modManager.queueSet(528, "transform" + i + "X", 0, 1);
	modManager.queueEase(528, 530, "transformY", 0, 'backOut');

	modManager.queueSet(550, "localrotateX", tr(360));
	modManager.queueEase(550, 555, "localrotateX", 0, 'backInOut');
	modManager.queueEase(550, 555, "reverse", 0, 'backInOut');

	modManager.queueEase(592, 594, "opponentSwap", -0.125, 'quartOut');
	modManager.queueEase(592, 594, "stretch", 0.325, 'quintOut');
	modManager.queueEase(592, 594, "confusion", 20, 'quintOut');
	modManager.queueEase(596, 598, "opponentSwap", 0, 'bounceOut');
	modManager.queueEase(596, 598, "stretch", 0, 'bounceOut');
	modManager.queueEase(596, 598, "confusion", 0, 'bounceOut');

	modManager.queueEase(616, 618, "opponentSwap", 0.125, 'quartOut');
	modManager.queueEase(616, 618, "stretch", 0.25, 'quintOut');
	modManager.queueEase(616, 618, "flip", 0.125, 'quintOut');
	modManager.queueEase(616, 618, "confusion", -20, 'quintOut');

	modManager.queueEase(622, 626, "opponentSwap", -0.125, 'quintOut');
	modManager.queueEase(622, 626, "confusion", 20, 'quintOut');

	modManager.queueEase(626, 628, "flip", 0, 'bounceOut');
	modManager.queueEase(626, 628, "stretch", 0, 'bounceOut');
	modManager.queueEase(626, 628, "opponentSwap", 0, 'bounceOut');
	modManager.queueEase(626, 628, "confusion", 0, 'bounceOut');

	modManager.queueEase(654, 656, "alpha", 0.5, 'quartInOut', 1);
	modManager.queueEase(654, 656, "stealth", 0.25, 'quartInOut', 1);
	modManager.queueEase(654, 656, "transformX", -50, 'quartInOut');
	modManager.queueSet(656, "transformX", 0);

	modManager.queueFunc(656, 788, function(event:CallbackEvent, cDS:Float) {
		var pos = (cDS - 656) / 4;

		for (pn in 1...3) {
			for (col in 0...4) {
				var cPos = col * -112;
				if (pn == 2)
					cPos = cPos - 620;
				var c = (pn - 1) * 4 + col;
				var mn = pn == 2 ? 0 : 1;

				var cSpacing = 112;
				var newPos = (((col * cSpacing + (pn - 1) * 640 + pos * cSpacing) % (1280))) - 176;
				modManager.setValue("transform" + col + "X", cPos + newPos, mn);
			}
		}
	});

	var poop = 1;
	numericForInterval(656, 904, 4, (step) -> {
		poop *= -1;
		modManager.queueSet(step, "confusion", 10 * poop);
		modManager.queueEase(step, step + 4, "confusion", 0);

		modManager.queueSet(step, "squish", 0.2);
		modManager.queueEase(step, step + 4, 'squish', 0, 'quintOut');
	});

	modManager.queueEase(717, 720, "transformY", y, 'backIn');
	modManager.queueSet(720, "reverse", 1);
	modManager.queueSet(720, "transformY", -y);
	modManager.queueEase(720, 723, "transformY", 0, 'backOut');

	modManager.queueEase(782, 790, "reverse", 0, 'backInOut');
	modManager.queueEase(782, 790, "receptorScroll", 1, 'backInOut');
	modManager.queueEase(782, 790, "sudden", 0.85, 'backInOut');
	modManager.queueEase(782, 790, "suddenOffset", 0.85, 'backInOut');

	for (i in 0...4)
		modManager.queueEase(894, 906, "transform" + i + "X", 0, 'backInOut');
	modManager.queueEase(900, 904, "receptorScroll", 0, 'backInOut');

	modManager.queueEase(912, 916, "beat", 0.25, 'backInOut');
	modManager.queueEase(912, 916, "alpha", 0.85, 'backInOut', 1);
	modManager.queueEase(912, 916, "opponentSwap", 0.5, 'backInOut');

	modManager.queueSet(912, "localrotateY", (360 * 2) * (3.14159265359 / 180));
	modManager.queueEase(912, 920, "localrotateY", 0, 'quartOut');

	var poop = 1;
	numericForInterval(912, 1168, 4, (step) -> {
		poop *= -1;
		modManager.queueSet(step, "confusion", 10 * poop);
		modManager.queueEase(step, step + 4, "confusion", 0);

		modManager.queueSet(step, "squish", 0.2);
		modManager.queueEase(step, step + 4, 'squish', 0, 'quintOut');
	});

	var counter = -1;
	var counter2 = -1;
	numericForInterval(912, 1168, 8, (step) -> {
		counter *= -1;
		counter2 += 1;
		if (counter2 >= 8)
			counter2 = 0;

		modManager.queueSet(step, "mini", -0.625);
		modManager.queueEase(step, step + 4, "mini", 0, "quartOut");
		modManager.queueSet(step, "drunk", -1.25 * counter);
		modManager.queueEase(step, step + 4, "drunk", 0, "quartOut");

		modManager.queueSet(step + 4, "mini", -0.625);
		modManager.queueEase(step + 4, step + 8, "mini", 0, "quartOut");
		modManager.queueSet(step + 4, "tipsy", 0.75 * counter);
		modManager.queueEase(step + 4, step + 8, "tipsy", 0, "quartOut");
		modManager.queueSet(step + 4, "drunk", 1.25 * counter);
		modManager.queueEase(step + 4, step + 8, "drunk", 0, "quartOut");
	});

	modManager.queueSet(1040, "localrotateX", tr(360));
	modManager.queueEase(1040, 1048, "localrotateX", 0, 'backInOut');
	modManager.queueEase(1040, 1048, "reverse", 1, 'backInOut');

	// too lazy to do the math. JARVIS DO THE MATH FOR ME
	modManager.queueEase(1168, 1168 + 16, "reverse", 0, 'quadOut');
	modManager.queueEase(1168, 1168 + 16, "opponentSwap", 0, 'quadOut');
	modManager.queueEase(1168, 1200, "beat", 0, 'quadInOut');
	modManager.queueEase(1168, 1200, "alpha", 0, 'quadInOut');
	modManager.queueEase(1168, 1200, "stealth", 0, 'quadInOut');

	modManager.queueSet(1296, "localrotateY", (360 * 2) * (3.14159265359 / 180));
	modManager.queueEase(1296, 1304, "localrotateY", 0, 'quartOut');

	var f = 1;
	numericForInterval(1296, 1550, 8, (s) -> {
		f *= -1;
		modManager.queueSet(s, 'transformX', -85 * f);
		modManager.queueSetP(s, 'mini', -50);
		modManager.queueEase(s, s + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(s, s + 4, "mini", 0, "quadOut");

		modManager.queueSet(s, "drunk", 1 * f);
		modManager.queueEase(s, s + 4, "drunk", 0, 'cubeOut');

		modManager.queueSet(s, "localrotateZ", tr(15) * -f, 0);
		modManager.queueSet(s, "localrotateZ", tr(15) * f, 1);
		modManager.queueEase(s, s + 4, "localrotateZ", 0, 'circOut');
		modManager.queueSet(s, "confusion", 15 * -f, 0);
		modManager.queueSet(s, "confusion", 15 * f, 1);
		modManager.queueEase(s, s + 4, "confusion", 0, 'circOut');

		var step = s + 4;

		modManager.queueSetP(step, 'tipsy', 125);
		modManager.queueSetP(step, 'tipsyOffset', 25);
		modManager.queueSet(step, 'transformX', -75);
		modManager.queueSetP(step, 'mini', -50);
		modManager.queueEase(step, step + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsy', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsyOffset', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, "mini", 0, "quadOut");

		modManager.queueSet(step, "tipsy", 1 * f);
		modManager.queueEase(step, step + 4, "tipsy", 0, 'cubeOut');
	});

	for (i in 0...2) {
		modManager.queueEase(1455, 1455 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(1455 + 3, 'reverse' + i, 1);
		modManager.queueSet(1455 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(1455 + 3, 1455 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(1455, 1455 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(1455 + 3, 'reverse' + i, 1);
		modManager.queueSet(1455 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(1455 + 3, 1455 + 6, "transform" + i + "Y", 0, 'backOut');
	}
	for (i in 2...4) {
		modManager.queueEase(1471, 1471 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(1471 + 3, 'reverse' + i, 1);
		modManager.queueSet(1471 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(1471 + 3, 1471 + 6, "transform" + i + "Y", 0, 'backOut');
	}

	for (i in 0...4) {
		modManager.queueEase(1515, 1515 + 3, "transform" + i + "Y", y, "backIn");
		modManager.queueSet(1513 + 3, "transform" + i + "Y", -y);
		modManager.queueSet(1513 + 3, "reverse" + i, 0);
		modManager.queueEase(1513 + 3, 1513 + 6, "transform" + i + "Y", 0, 'backOut');
	}

	modManager.queueEase(1550, 1584, "alpha", 1);
	modManager.queueEase(1550, 1584, "confusion", 360);
	modManager.queueEase(1550, 1584, "centerrotateY", tr(360 * 1.5));
}

