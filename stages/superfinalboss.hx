import funkin.backend.assets.Paths;

import flixel.FlxSprite;

PlayState.instance.skipCountdown = true;
function onCreatePost()
{
	dad.visible = false;
	boyfriend.visible = false;
	
	spr = new FlxSprite();
	spr.frames = Paths.getAtlas('superfinalboss');
	spr.animation.addByPrefix('anim', 'anim', 24);
	spr.animation.play('anim');
	spr.screenCenter();
	spr.scrollFactor.set();
	add(spr);
	
	spr.visible = false;
	
	hud.visible = false;
}

function onEvent(ev, v1, v2, time)
{
	if (ev == '' && v1 == 'show') spr.visible = true;
}
