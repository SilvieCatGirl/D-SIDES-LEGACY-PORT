import funkin.game.shaders.DropShadowShader;

var i = dad;

function onLoad()
{
    i.color = 0xff7266c1;
    
    if(ClientPrefs.lowQuality)
        return;

    i.animateAtlas.useRenderTexture = true;

	var rim = new DropShadowShader();
	rim.color = 0x90707358;
	rim.distance = 15;
	rim.attachedSprite = stage.members[0];
    rim.angle = 45;
    rim.uFrameBounds.value = [-0.2, -0.9, 2, 2];

    i.shader = rim;
}