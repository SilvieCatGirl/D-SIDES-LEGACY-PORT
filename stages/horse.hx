import flixel.FlxG;
import flixel.tweens.FlxTween;

import funkin.objects.HealthIcon;
import funkin.objects.AttachedSprite;
import funkin.shaders.ColorSwap;

import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;

var penis:Array<FlxBackdrop> = [];
var henryHorse;
var prangeHorse;
var ourpleHorse;
var impact;
var bars:Array<FlxSprite> = [];

function onCreate()
{
	var sky = new FlxSprite().loadGraphic(Paths.image('horse/L7'));
	addBehindGF(sky);
	sky.scrollFactor.set(0.3, 0.3);
	
	var sun = new FlxSprite().loadGraphic(Paths.image('horse/L6'));
	addBehindGF(sun);
	sun.scrollFactor.set(0.3, 0.3);
	
	var clouds = new FlxSprite().loadGraphic(Paths.image('horse/L5'));
	addBehindGF(clouds);
	clouds.scrollFactor.set(0.4, 0.4);
	
	for (i in 1...5)
	{
		var backdrop = new FlxBackdrop(Paths.image('horse/L' + Std.string(5 - i)), FlxAxes.X);
		addBehindGF(backdrop);
		penis.push(backdrop);
		backdrop.scrollFactor.x = 1 - (5 - i) * 0.1;
	}
	
	henryHorse = new AttachedSprite('horse/horseguy', 'horseWALK', null, true);
	henryHorse.animation.curAnim.frameRate = 96;
	henryHorse.flipX = true;
	henryHorse.scale.set(1.25, 1.25);
	henryHorse.updateHitbox();
	addBehindGF(henryHorse);
	henryHorse.scrollFactor.set(1, 1);
	
	var shader = new ColorSwap();
	shader.mix = 0;
	shader.brightness = -0.5;
	shader.saturation = -1;
	henryHorse.shader = shader.shader;
	
	prangeHorse = new AttachedSprite('horse/horseguy', 'horseWALK', null, true);
	prangeHorse.scrollFactor.set(1, 1);
	prangeHorse.animation.curAnim.frameRate = 96;
	prangeHorse.flipX = true;
	addBehindDad(prangeHorse);
	prangeHorse.scale.set(1.25, 1.25);
	prangeHorse.updateHitbox();
	
	var colorShader = new ColorSwap();
	colorShader.mix = 0;
	colorShader.hue = 0.35;
	prangeHorse.shader = colorShader.shader;
	
	ourpleHorse = new AttachedSprite('horse/horseguy', 'horseWALK', null, true);
	ourpleHorse.scrollFactor.set(1, 1);
	ourpleHorse.animation.curAnim.frameRate = 96;
	ourpleHorse.flipX = true;
	ourpleHorse.scale.set(1.25, 1.25);
	ourpleHorse.updateHitbox();
	addBehindBF(ourpleHorse);
	
	impact = new FlxSprite().loadFrames('horse/hit');
	impact.animation.addByPrefix('i', 'hit', 30, false);
	impact.scale.set(3, 3);
	impact.updateHitbox();
	add(impact);
	impact.visible = false;
	impact.animation.onFinish.add((anim) -> impact.visible = false);
	
	var barTop:FlxSprite = new FlxSprite(0, -110).makeGraphic(1, 1, 0xFF000000);
	var barBot:FlxSprite = new FlxSprite(0, FlxG.height).makeGraphic(1, 1, 0xFF000000);
	for (bar in [barTop, barBot])
	{
		bar.scale.set(FlxG.width, 110);
		bar.updateHitbox();
		bar.cameras = [camHUD];
		bar.scrollFactor.set();
		insert(0, bar);
		bars.push(bar);
	}
}

var additionalIcon:HealthIcon;

function onCreatePost()
{
	// TEST JHUST A TEST
	
	additionalIcon = new HealthIcon("henre");
	hud.add(additionalIcon);
	additionalIcon.sprTracker = hud.iconP2;
	additionalIcon.xAdd = -250;
	additionalIcon.yAdd = ClientPrefs.data.downScroll ? -900 : 1000;
	
	hud.updateIconsScale = (elapsed) -> {
		var mult:Float = FlxMath.lerp(hud.iconP1.defScale, hud.iconP1.scale.x, Math.exp(-elapsed * 9 * game.playbackRate));
		hud.iconP1.scale.set(mult, mult);
		
		var mult:Float = FlxMath.lerp(hud.iconP2.defScale, hud.iconP2.scale.x, Math.exp(-elapsed * 9 * game.playbackRate));
		hud.iconP2.scale.set(mult, mult);
		additionalIcon.scale.set(mult, mult);
	}
	
	henryHorse.sprTracker = gf;
	henryHorse.xAdd = -140;
	henryHorse.yAdd = 90;
	
	gf.scrollFactor.x = 0.8;
	gf.x += 1000;
	
	prangeHorse.sprTracker = dad;
	prangeHorse.xAdd = -110;
	prangeHorse.yAdd = 70;
	
	ourpleHorse.sprTracker = boyfriend;
	ourpleHorse.xAdd = -100;
	ourpleHorse.yAdd = 90;
	
	startSlideTween(dad);
	startSlideTween(boyfriend);
	
	camZooming = true;
	
	game.triggerEvent("Camera Follow Pos", "1100", "300", 0);
	
	FlxG.camera.fade(0xFF000000, 0, false);
	
	dad.x += 2000;
	boyfriend.x += 2000;
	
	FlxTimer.wait(3, () -> FlxTween.tween(dad, {x: dad.x - 2000}, 7, {ease: FlxEase.cubeInOut, onComplete: () -> startSlideTween(dad)}));
	FlxTimer.wait(3, () -> FlxTween.tween(boyfriend, {x: boyfriend.x - 2000}, 7, {ease: FlxEase.cubeInOut, onComplete: () -> startSlideTween(boyfriend)}));
	FlxTimer.wait(5, () -> FlxTween.tween(FlxG.camera.scroll, {x: FlxG.camera.scroll.x - 400}, 3, {ease: FlxEase.cubeIn}));
}

function onSongStart()
{
	FlxG.camera.zoom += 2;
	FlxG.camera.fade(0xFF000000, 5, true);
}

function startSlideTween(char)
{
	FlxTween.cancelTweensOf(char);
	
	FlxTimer.wait(0, () -> FlxTween.tween(char, {x: char.x + ((char == gf) ? -50 : 50)}, 2, {ease: FlxEase.sineInOut, type: 4}));
}

function bfSpecialAnim(anime, num, idx)
{
	boyfriend.specialAnim = true;
}

function onEvent(ev, v1, v2, st)
{
	if (ev == '')
	{
		switch (v1)
		{
			case 'hudFade':
				FlxTween.tween(camHUD, {alpha: 0}, 1);
				
			case 'horseBump':
				if (v2 == 'prange')
				{
					FlxTween.cancelTweensOf(boyfriend);
					FlxTween.cancelTweensOf(dad);
					
					FlxTween.tween(dad, {x: dad.x + 100}, 1.6, {ease: FlxEase.circIn});
					FlxTween.tween(additionalIcon, {xAdd: -200, yAdd: 25}, 1.6,
						{
							ease: FlxEase.backIn,
							onComplete: Void -> {
								hud.iconP2.visible = true;
								hud.iconP2.changeIcon('henre');
								additionalIcon.changeIcon('prang');
								hud.healthBar.leftBar.color = 0xFF383838;
								
								hitIcon = true;
								additionalIcon.sprTracker = null;
								FlxTween.tween(additionalIcon, {x: additionalIcon.x + 300, angle: 270}, 0.4);
								FlxTween.tween(additionalIcon, {y: additionalIcon.y - 100 * (ClientPrefs.data.downScroll ? -1 : 1)}, 0.15,
									{
										ease: FlxEase.sineOut,
										onComplete: Void -> {
											FlxTween.tween(additionalIcon, {y: additionalIcon.y + 300 * (ClientPrefs.data.downScroll ? -1 : 1)}, 0.2, {ease: FlxEase.sineIn});
										}
									});
								camHUD.shake(0.005, 0.2);
							}
						});
					FlxTween.tween(boyfriend, {x: boyfriend.x - 400}, 1.6,
						{
							ease: FlxEase.circIn,
							onComplete: Void -> {
								impact.visible = true;
								impact.animation.play('i');
								impact.x = ourpleHorse.x - 50 - 200;
								impact.y = ourpleHorse.y - 100 - 100;
								
								FlxG.sound.play(Paths.sound('horse/bump'));
								
								FlxG.camera.shake(0.01, 0.1);
								
								FlxTween.tween(gf, {x: gf.x - 100}, 1.6, {ease: FlxEase.circOut});
								FlxTween.tween(boyfriend, {x: boyfriend.x + 400}, 1.6, {ease: FlxEase.circOut, onComplete: (f) -> startSlideTween(boyfriend)});
								
								onEvent('', 'fallPrange', '', 0);
								onEvent('', 'laugh', '', 0);
							}
						});
				}
				else
				{
					FlxTween.cancelTweensOf(gf);
					FlxTween.cancelTweensOf(boyfriend);
					
					FlxTween.tween(gf, {x: gf.x + 300}, 1.6, {ease: FlxEase.circIn});
					FlxTween.tween(boyfriend, {x: boyfriend.x - 100}, 1.6,
						{
							ease: FlxEase.circIn,
							onComplete: Void -> {
								impact.visible = true;
								impact.animation.play('i');
								impact.x = ourpleHorse.x - 75;
								impact.y = ourpleHorse.y - 100 - 50;
								
								FlxG.sound.play(Paths.sound('horse/bump'));
								FlxG.camera.shake(0.01, 0.1);
								
								onEvent('', 'ourpleFall', '', 0);
								onEvent('', 'henryFall', '', 0);
								
								FlxTween.tween(henryHorse, {x: henryHorse.x - 300}, 1.6, {ease: FlxEase.circOut});
								FlxTween.tween(ourpleHorse, {x: ourpleHorse.x + 100}, 1.6, {ease: FlxEase.circOut});
							}
						});
				}
				
			case 'henryMoveUp':
				FlxTween.cancelTweensOf(gf);
				
				FlxTween.num(girlfriendCameraOffset[0], girlfriendCameraOffset[0] + 200, 2, {ease: FlxEase.cubeInOut}, (f) -> girlfriendCameraOffset[0] = f);
				
				FlxTween.tween(gf, {x: gf.x - 200}, 2, {ease: FlxEase.cubeInOut, onComplete: (f) -> startSlideTween(gf)});
				
			case 'henryAppear':
				FlxTween.tween(gf, {x: gf.x - 1000}, 4, {ease: FlxEase.cubeInOut, onComplete: (f) -> startSlideTween(gf)});
				FlxTween.tween(additionalIcon, {yAdd: -25}, 3, {ease: FlxEase.cubeInOut});
				
			case 'centerCamera':
				game.isCameraOnForcedPos = true;
				
				FlxTween.tween(camFollow, {x: getCharBasePos(gf).x + 150 + 350}, 1, {ease: FlxEase.cubeInOut});
				
			case 'revertLaugh':
				boyfriend.specialAnim = true;
				boyfriend.playAnim('laugh-toIdle');
				boyfriend.animation.onFinish.addOnce((anim) -> {
					if (anim == 'laugh-toIdle')
					{
						boyfriend.animation.onFrameChange.remove(bfSpecialAnim);
					}
				});
				
			case 'laugh':
				boyfriend.animation.onFrameChange.add(bfSpecialAnim);
				
				boyfriend.animation.onFinish.addOnce((anim) -> {
					if (anim == 'laugh-start')
					{
						boyfriend.playAnim('laugh-loop');
					}
				});
				
				boyfriend.playAnim('laugh-start');
				FlxG.sound.play(Paths.sound('horse/AHHH'));
				
			case 'ourpleFall':
				ourpleHorse.sprTracker = null;
				FlxTween.cancelTweensOf(boyfriend);
				
				boyfriend.animation.onFrameChange.add((anime, num, idx) -> {
					if (anime == 'fall')
					{
						var fpsTime = 1 / 12;
						if (num == 1)
						{
							FlxTween.tween(boyfriend, {y: boyfriend.y - 150}, fpsTime * 3,
								{
									ease: FlxEase.sineOut,
									onComplete: Void -> {
										FlxTween.tween(boyfriend, {y: boyfriend.y + 350}, fpsTime * 4,
											{
												ease: FlxEase.sineIn,
												startDelay: fpsTime,
												onComplete: Void -> {
													FlxTween.tween(boyfriend, {y: boyfriend.y - 100}, 0.2, {ease: FlxEase.circOut});
												}
											});
									}
								});
								
							FlxTween.tween(boyfriend, {x: boyfriend.x + 1000}, fpsTime * 6,
								{
									startDelay: fpsTime * 5,
									ease: FlxEase.quartIn,
									onComplete: Void -> {
										FlxTween.tween(ourpleHorse, {x: ourpleHorse.x + 1500}, 4, {ease: FlxEase.cubeIn, startDelay: 0.7});
									}
								});
						}
					}
					boyfriend.specialAnim = true;
				});
				
				boyfriend.animation.onFinish.addOnce((anim) -> {
					if (anim == 'fall')
					{
						boyfriend.playAnim('fall-loop');
					}
				});
				boyfriend.playAnim('fall');
				
			case 'fallPrange':
				prangeHorse.sprTracker = null;
				FlxTween.cancelTweensOf(dad);
				
				dad.animation.onFrameChange.add((anime, num, idx) -> {
					dad.specialAnim = true;
				});
				
				dad.playAnim('fall');
				
				var rate = 0.8;
				FlxTween.tween(dad, {x: dad.x + 1100}, 0.8 / rate, {ease: FlxEase.sineIn});
				FlxTween.tween(dad, {y: dad.y - 100}, 0.2 / rate,
					{
						ease: FlxEase.sineOut,
						onComplete: Void -> {
							FlxTween.tween(dad, {y: dad.y + 450}, 0.4 / rate,
								{
									ease: FlxEase.sineIn,
									onComplete: Void -> {
										FlxTween.tween(prangeHorse, {x: prangeHorse.x + 1500}, 4, {ease: FlxEase.cubeIn, startDelay: 0.7});
									}
								});
						}
					});
					
			case 'henryFall':
				henryHorse.sprTracker = null;
				FlxTween.cancelTweensOf(gf);
				
				for (i in notes)
				{
					i.noAnimation = true;
				}
				
				gf.animation.onFrameChange.add((anime, num, idx) -> {
					gf.specialAnim = true;
				});
				
				gf.playAnim('crashout');
				
				var rate = 0.8;
				FlxTween.tween(gf, {x: gf.x + 1000}, 0.8 / rate, {ease: FlxEase.sineIn});
				FlxTween.tween(gf, {y: gf.y - 100}, 0.2 / rate,
					{
						ease: FlxEase.sineOut,
						onComplete: Void -> {
							FlxTween.tween(gf, {y: gf.y + 400}, 0.4 / rate,
								{
									ease: FlxEase.sineIn,
									onComplete: Void -> {
										FlxTween.tween(henryHorse, {x: henryHorse.x - 800}, 1.4, {ease: FlxEase.cubeIn, startDelay: 0.7});
									}
								});
						}
					});
					
			case 'horsesLeave':
				FlxG.camera._fxFadeColor = FlxColor.BLACK;
				
				FlxTween.tween(FlxG.camera, {_fxFadeAlpha: 1}, 2, {startDelay: 0.5});
				
			case 'bars in':
				bars[0].cameras = v2 == 'yeah' ? [camOther] : [camHUD];
				bars[1].cameras = v2 == 'yeah' ? [camOther] : [camHUD];
				
				FlxTween.cancelTweensOf(bars[0]);
				FlxTween.tween(bars[0], {y: 0}, 1, {ease: FlxEase.quintOut});
				FlxTween.cancelTweensOf(bars[1]);
				FlxTween.tween(bars[1], {y: FlxG.height - bars[1].scale.y}, 1, {ease: FlxEase.quintOut});
			case 'bars out':
				FlxTween.cancelTweensOf(bars[0]);
				FlxTween.tween(bars[0], {y: -bars[0].scale.y}, 1, {ease: FlxEase.quintIn});
				FlxTween.cancelTweensOf(bars[1]);
				FlxTween.tween(bars[1], {y: FlxG.height}, 1, {ease: FlxEase.quintIn});
		}
	}
}

var timer = 0;
var baseSpeed = 2;

function onUpdate(elapsed)
{
	timer += elapsed;
	
	while (timer >= 1 / 24)
	{
		timer -= 1 / 24;
		penis[0].x += 0.5 * baseSpeed;
		penis[1].x += 5 * baseSpeed;
		penis[2].x += 10 * baseSpeed;
		penis[3].x += 15 * baseSpeed;
	}
}

function onBeatHit()
{
	additionalIcon.scale.set(additionalIcon.defScale + 0.2, additionalIcon.defScale + 0.2);
}
