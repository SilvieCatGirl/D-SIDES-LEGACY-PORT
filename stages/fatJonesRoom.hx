package export.debug.windows.bin.mods.stages;

function onLoad()
{
	FlxG.camera.pixelPerfectRender = false;
	
	var bg = new FlxSprite().loadGraphic(Paths.image('blubber/blubber_bg'));
	bg.scale.set(1.5, 1.5);
	bg.updateHitbox();
	add(bg);
	
	camOffset = 20;
}

function onEvent(ev, v1, v2, time)
{
	if (ev == '')
	{
		switch (v1)
		{
			case 'crowd':
				if (crowd.alive) crowd.kill();
				else crowd.revive();
			case 'endtween':
				FlxTween.tween(FlxG.camera.scroll, {x: -200}, 1.5, {ease: FlxEase.cubeIn});
				FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.4}, 1.5, {ease: FlxEase.cubeIn});
		}
	}
}

function opponentNoteHit(note)
{
	var isAlt = note.noteType == 'Alt Animation' || PlayState.SONG.notes[curSection].altAnim;
	
	if (!note.isSustainNote && note.noteData == 3 && !isAlt)
	{
		boyfriend.playAnim('hit', true);
		boyfriend.specialAnim = true;
		
		FlxG.sound.play(Paths.sound('blubberPunch'), 0.35);
		
		if (health > 0.1) health -= 0.1;
	}
}