import funkin.audio.visualize.PolygonSpectogram;
import funkin.audio.visualize.PolygonSpectogram.VISTYPE;
import funkin.audio.visualize.SpectogramSprite.SPECDIRECTION;

function onLoad(){
    abot = new FlxSpriteGroup(gfGroup.x + gf.positionArray[0], gfGroup.y + gf.positionArray[1]);
    stage.add(abot);

    a_bot_screen = new FlxSprite(40, 300).loadGraphic(Paths.image('characters/PicoSchool/Nene/ABotScreenFill'));
    abot.add(a_bot_screen);


    a_bot = new FlxSprite();
    a_bot.frames = Paths.getSparrowAtlas('characters/PicoSchool/Nene/ABotIdle');
    a_bot.animation.addByPrefix('idle', 'ABot', 24, false);
    a_bot.animation.play('idle');
    abot.add(a_bot);

    abot.x -= 180;
    abot.y += a_bot.height / 2;

    a_bot_dark = new FlxSprite();
    a_bot_dark.frames = Paths.getSparrowAtlas('characters/PicoSchool/Nene/ABotIdle_Tunnel');
    a_bot_dark.animation.addByPrefix('idle', 'ABotSpeaker', 24, false);
    a_bot_dark.animation.play('idle');
    abot.add(a_bot_dark);
}

function onCreatePost(){
    dadGroup.zIndex += 1;
    gfGroup.zIndex += 1;
    boyfriendGroup.zIndex += 1;
    
    abot.zIndex = gfGroup.zIndex - 1;
    refreshZ(stage);

    if(ClientPrefs.lowQuality || ClientPrefs.streamedMusic) return;

    viz = new PolygonSpectogram(PlayState.instance.audio.inst, 0xFF00FF00, a_bot_screen.width - 35, 1, SPECDIRECTION.HORIZONTAL);
    viz.thickness = 2;
    viz.alpha = 0.4;
    viz.waveAmplitude *= 0.75;
    viz.setPosition(55, 380);

    green = new FlxSprite(55, 380).makeGraphic(a_bot_screen.width - 35, 1, 0xFF00FF00);

    abot.insert(1, viz);
    abot.insert(1, green);

        var vizDarnell = new PolygonSpectogram(vocals.opponentVocals.members[0], dad.healthColour, a_bot_screen.height, 2, SPECDIRECTION.HORIZONTAL);
        vizDarnell.setPosition(55, 345);
        vizDarnell.alpha = 0.8;
        abot.insert(1, vizDarnell);

        purp = new FlxSprite(55, 345).makeGraphic(a_bot_screen.width, 1, dad.healthColour);
        abot.insert(1, purp);

        var vizPico = new PolygonSpectogram(vocals.playerVocals.members[0], boyfriend.healthColour, a_bot_screen.height, 2, SPECDIRECTION.HORIZONTAL);
        vizPico.setPosition(55, 417);
        vizPico.alpha = 0.8;
        abot.insert(1, vizPico);

        pink = new FlxSprite(55, 417).makeGraphic(a_bot_screen.width, 1, boyfriend.healthColour);
        abot.insert(1, pink);
}

function onSongStart(){
    if(ClientPrefs.lowQuality || ClientPrefs.streamedMusic) return;

    green.visible = false;
    pink.visible = false;
    purp.visible = false;
}

var inTunnel = false;

function onUpdate(elapsed){
    inTunnel = dad.curCharacter == 'darnell-tunnel';
    
    a_bot_dark.visible = inTunnel;
    a_bot.visible = !inTunnel;
    a_bot_screen.color = (inTunnel) ? 0xFF414141 : FlxColor.WHITE; 
}
