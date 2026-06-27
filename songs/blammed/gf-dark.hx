import funkin.game.shaders.DropShadowShader;

var i = gf;
var distance;

function onCreatePost()
{
    i.color = 0xff7266c1;

    if(ClientPrefs.lowQuality)
        return;

    i.animateAtlas.useRenderTexture = true;

	var rim = new DropShadowShader();
	rim.color = 0x90707358;
	rim.distance = getDistance(Paths.sanitize(PlayState.SONG.song));
	rim.attachedSprite = stage.members[0];
    rim.uFrameBounds.value = [-1, -0.9, 4, 2];
    rim.angle = getAngle(Paths.sanitize(PlayState.SONG.song));

    i.shader = rim;
}

function getDistance(thing)
{
    var d = 0;

    switch(thing)
    {
        case 'blammed':
            d = 22;
        default:
            d = 15;
    }

    return d;
}

function getAngle(thing)
{
    var a = 0;

    switch(thing)
    {
        case 'blammed':
            a = 180;
        default:
            a = 90;
    }

    return a;
}