import funkin.game.shaders.DropShadowShader;

var i = dad;

function onLoad()
{
    i.color = 0xffb5ade9;

    if(ClientPrefs.lowQuality)
        return;

    i.animateAtlas.useRenderTexture = true;

	var rim = new DropShadowShader();
	rim.color = 0x903D3E31;
	rim.distance = 15;
	rim.attachedSprite = stage.members[0];
    rim.angle = 135;
    rim.uFrameBounds.value = [-0.2, -0.9, 2, 2];

    i.shader = rim;
}