import funkin.game.shaders.DropShadowShader;

var i = boyfriend;

function onLoad() {
	if (ClientPrefs.inDevMode)
		initScript('data/scripts/bf');

	i.color = getColor(Paths.sanitize(PlayState.SONG.song));

	if (ClientPrefs.lowQuality)
		return;

	i.animateAtlas.useRenderTexture = true;

	var rim = new DropShadowShader();
	rim.color = 0x90707358;
	rim.distance = getDistance(Paths.sanitize(PlayState.SONG.song));
	rim.attachedSprite = stage.members[0];
	rim.angle = getAngle(Paths.sanitize(PlayState.SONG.song));
	rim.uFrameBounds.value = [-0.2, -1.5, 2, 2];

	i.shader = rim;
}

function getColor(thing) {
	var c = 0xff7266c1;

	switch (thing) {
		case 'blammed':
			c = 0xffb5ade9;
		default:
			c = 0xff7266c1;
	}

	return c;
}

function getDistance(thing) {
	var d = 0;

	switch (thing) {
		case 'blammed':
			d = 12;
		default:
			d = 15;
	}

	return d;
}

function getAngle(thing) {
	var a = 0;

	switch (thing) {
		case 'blammed':
			a = 200;
		default:
			a = 135;
	}

	return a;
}
