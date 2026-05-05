function onCreate()
{
	var spr = new FlxSprite(-500, 0, Paths.image('henr'));
	addBehindGF(spr);
	spr.scale.set(1.5, 1.5);
	spr.updateHitbox();
}
