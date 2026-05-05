import funkin.game.shaders.DropShadowShader;

var i = boyfriend;

function onLoad() {

	i.color = getColor();

	if (ClientPrefs.lowQuality)
		return;	

	var rim = new DropShadowShader();
	rim.color = 0x90707358;
	rim.distance = getDistance();
	rim.attachedSprite = stage.members[0];
	rim.angle = getAngle();
	rim.uFrameBounds.value = [-0.2, -1.5, 2, 2];

	i.shader = rim;
}

function getColor(thing) {
	var c = 0xff7266c1;

	return c;
}

function getDistance(thing) {
	var d = 15;

	return d;
}

function getAngle(thing) {
	var a = 135;

	return a;
}
