
/**
 * [CreditsVideo.hx]
 * State that credits all users who helped with the mod in a special video fashion
 */
import funkin.scripting.ScriptedState;
import funkin.scripting.PluginsManager;
import funkin.utils.CoolUtil;
import flixel.text.FlxText;
import funkin.FunkinAssets;
import funkin.api.DiscordClient;
import funkin.game.shaders.ColorSwap;

var video:FunkinVideoSprite;
var funny = FlxG.save.data.unlockedHim;

// {name: "", description: ""},

// Array of all headers & users
var credits= [
    {name: "Stay Funky", description: "By squishyzumorizu ft. Wrathstetic, Team Deez"},

    {name: "TEAM DEEZ"},
    {name: "DastardlyDeacon", description: "Creator of D-Sides, Lead director, Concept artist, Character designer"},
    {name: "FifLeo", description: "Lead Artist & Animator/Concept Artist/Character Designer"},
    {name: "EllisBros", description: "Lead Redux Style Artist, Main BG & Icon Artist, Character Designer"},
    {name: "DuskieWhy", description: "Lead Programmer, Lead Developer of NightmareVision, Charter, Promotional Video Editor"},
    {name: "theuseraqua", description: "Programmer"},
    {name: "Marco Antonio", description: "Sprite Artist & Animator, Character Designer, Coder, Composer"},
    {name: "squishyzumorizu", description: "Composer, Concept/Sprite Artist & Animator, Charter"},
    {name: "yoisabo", description: "Sprite/Menu/UI Artist"},
    {name: "TGG", description: "Freeplay Icon Artist, Artist"},
    {name: "Dieg", description: "Sprite Artist & Animator, Concept Artist"},
    {name: "Stonesteve", description: "Sprite Artist & Animator"},
    {name: "Offbi", description: "Sprite Artist & Animator, Character Designer"},
	{name: "Weedeet", description: "Accelerant Assets"},
    {name: "Philiplol", description: "Composer, Voice Actor, Singer"},
    {name: "Selora789", description: "Composer"},
    {name: "lexxiemow", description: "Composer"},
    {name: "xyy", description: "Composer"},
    {name: "RedTv53", description: "Composer, Voice Actor, Singer"},
    {name: "Wrathstetic", description: "Composer, Voice Actor, Singer, Writer"},
    {name: "EthanTheDoodler", description: "Composer, Sound Designer"},
    {name: "TheWAHBox", description: "Composer"},
    {name: "Cloverderus", description: "Composer, Charter"},
    {name: "Biddle3", description: "Composer"},
    {name: "Clappers46", description: "Guest Composer"},
	{name: "Gojira Darko", description: "Guest Composer"},
    {name: "qodax", description: "Legacy Composer"},
    {name: "gc", description: "Legacy Composer"},
    {name: "scrumbo_", description: "Composer"},
    {name: "Antinarious", description: "Composer"},
    {name: "angelfaise", description: "Artist, Character Designer, Voice Actor"},
    {name: "JimboGames", description: "Concept Artist, Character Designer, Voice Actor"},
    {name: "KloogyBaboogy", description: "Concept Artist, Character Designer, Voice Actor"},
    {name: "flyplague", description: "Character Designer, Voice Actor"},
    {name: "SKL", description: "Voice Actor, Character Designer, Sprite Artist & Animator"},
    {name: "Funkybunny", description: "3D Model"},

    {name: "CONTRIBUTORS"},
    {name: "Data5", description: "Programming Help"},
	{name: "MaybeMaru", description: "Texture Atlas Help"},
    {name: "Peakjuggler, NebulaZorua & AshStat", description: "Programming Help (pre-redux)"},
    {name: "FredrickFunny", description: "Tutorial, Bopeebo, Blammed Charts & general chart touchups, Camera events"},
    {name: "Srife5", description: "Pico Chart"},
    {name: "lemonaid_", description: "??? Chart"},
    {name: "moxxie", description: "Newgrounds Logo"},
    {name: "Blackberri, Rareblin", description: "Composers (pre-redux)"},
	{name: "Winter", description: "And Assets"},
	{name: "lossarquo", description: "Phone Dude Assets"},
    {name: "LacExists, BenzBt, Greenstranger", description: "Miscellaneous Menu/Character Art"},
	{name: "Komica", description: "Voice Actor (Dusk)"},
    {name: "SrPelo", description: "Voice Actor (Spooky Kids)"},
    {name: "Beethovenus, RecD", description: "Voice Actors (pre-redux)"},
    {name: "JcJack", description: "Menu Design Help"},
    {name: "CorvenCarrion", description: "Writing Help & Character Design"},
    

    {name: "Playtesters", description: "Special thanks to Data5, Niffirg, shelby, FredrickFunny, Decoy, ashstat, Clowfoe, Lethrial, Dawn, loggo, Halographic, CorvenCarrion, Ito Saihara, __far0__, Paige, PurpleKav, Iceptual, Srife5, lemlem_mew, ari_the_when, vortexgottaken, CommandoDev, Kreagato, FazieFunbear, Snoot & TheGrandestGoon for helping play test and find bugs!"},
    {name: "Loading Screen Artists", description: "Thank you to gojira_darko, fredrickfunny, lemlem_mew, purplekav, funkybunny, sssprite, smoothmars, scopsilk, benzbt, novasaur, __far0__, marco antonio, valeriousval, jamlikesgranola, morathefox, thatgoofyguy, lexxiemeow, smoothdedede, ito saihara, abysmalcha0s, biviuure, brickztyler, mat_doesstuff, samulakz, xyy, molten_prod, moonlight2095, funbletoken, d4rkz1a, Leafohyeah, FidgetyAttic, DDP_2007, SeanicGames, g-wave, Ashz, Agente R, XHam, StrPointless, DusterBuster, LeoThM, Roquefort, EL_BRUNO_27, Meep, Marron_er, SonicSalvy, Robotist, JeffriesArtz, SosoM4966342951, MrFazdude, Ch1ckenfr, the_osacat, SkiddyBobard & NefariousPrisma for drawing the various loading screens seen throughout the mod!"},
    {name: "Special Thanks", description: "Thank you to Goop Troop, Purples Hub World, Studio Hopscotch, Marios Madness, Funkin at Freddys, Popeyes Discord Server, Funhouse Discord Server, Inverted Fate, Penkaru, Nowhereman, Clappers46, Ratto, TheWinterReaper, Nitr0cyti, and any/all friends of the D-Sides team! Thank you for supporting us through development through all these years!"}
];

// array of all the icons that appear to dance on screen
var icons = ['bf', 'gf', 'shuckydad', 'bf-old', 'dad', 'spooky', 'bfhair', 'monster', 'pico', 'darnell', 'bfgrunt', 'tricky', 'whitty', 'zardy', 'dusk', 'spoinky', 'guyy', 'mack', 'chica', 'foxy', 'fakemighty', 'zeph', 'tenma', 'milkeggman', 'sunky', 'mitee', 'exec'];
var iconGrp = [];


/**
 * [onCreate()]
 * Runs on creation of the state.
 * 
 * In this script:
 *  Creates and plays the custom video
 *  Creates all graphics shown in the menu.
 *  Changes the discord status. 
 *  If the player hasn't seen this, marks this sequence as completed in the save data.
*/
function onCreate()
{
	PluginsManager.callPluginFunc('Utils', 'saveFix', []);

    var save = FlxG.save.data.completedMenuShit.get('funky');
    if(save == false || save == null){
        FlxG.save.data.completedMenuShit.set('funky', true);
        FlxG.save.flush();
    }

    FlxG.mouse.visible = false;
    FlxG.sound.music.stop();
	DiscordClient.changePresence("Gettin' Funky, bitch.", "(they're watching the stay funky credits sequence)");

    banner = new FlxSprite().loadGraphic(Paths.image("menus/credits/credBanner"));
    banner.scale.set(0.66667, 0.66667);
    banner.updateHitbox();
    banner.alpha = 0;
    add(banner);

    doodles = new FlxSprite().loadGraphic(Paths.image('menus/doodles'));
    doodles.scale.set(0.625, 0.625);
    doodles.updateHitbox();
    doodles.screenCenter();
    doodles.alpha = 0;
    add(doodles);

    video = new FunkinVideoSprite();
    video.onFormat(()->{
        video.screenCenter();
        video.antialiasing = true;
    });
    video.load(Paths.video('CreditsIntro'));
    video.onStart(()->{
        FlxTimer.wait(1, ()->{
            banner.alpha = 1;
        });
    });
    add(video);

    var color = new ColorSwap();
    color.saturation = -0.5;

    if(funny){
        credits.push({
            name: "OAT Gang",
            description: "Thank you to Marketplier, Salesman999, Icey131, JoggingScout (LECTROA) & Gary Gilbenson for helping make SORETRO possible! Its really funny ok."
        });

        icons.push('dario');
    }

    credits.push({name: "Thank YOU for playing! Make sure to check out freeplay for some extras :)"});

    var poop = 1;
    var id = 0;
    for(i in icons)
    {
        poop *= -1;

        for(j in 0...2){
        	var col = [255, 255, 255];

            var shad = newShader('color-replace');
            shad.setFloat('uBlackMin', 0.0);
            shad.setFloat('uBlackMax', 0.5);
	    	shad.data.uReplaceColor.value = [col[0] / 255, col[1] / 255, col[2] / 255, 1]; 

            var icon = new HealthIcon(i);
            icon.scale.set(0.5, 0.5);
            icon.updateHitbox();
            icon.ID = id;
            icon.angle = 15 * poop;
            icon.flipX = true;
            // icon.blend = BlendMode.ADD;
            icon.shader = shad;
            add(icon);
            iconGrp.push(icon);
            icon.setPosition(1280, j == 0 ? 0 : FlxG.height - icon.height * 2);
        }
        id += 1;
    }

    black = new FlxSprite().makeGraphic(1000, 720, FlxColor.BLACK);
    black.screenCenter();
    black.alpha = 0;
    add(black);

    credTxt = new FlxText();
	credTxt.setFormat(Paths.font('Pixim.otf'), 45, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    credTxt.borderSize = 2;
    credTxt.fieldWidth = 1000;
    credTxt.screenCenter(FlxAxes.X);
    credTxt.y = FlxG.height;
    add(credTxt);

    var time = 5;
    for(i in 0...credits.length){
        var cred = credits[i];
        var text = cred.name;

        if(i != 0)
            text = '\n' + cred.name;

        if(cred.description != null)
            text += '\n' + cred.description + '\n';
        else
            text = '\n' + text + '\n\n';

        credTxt.text = credTxt.text + text;

        time += 2.5;
    }


    video.onEnd(()->{
        FlxTween.tween(banner, {alpha: 0, y: -banner.height}, 7, {ease: FlxEase.circIn, onComplete: ()->{
            for(icon in iconGrp)
                FlxTween.tween(icon, {x: -icon.width * 2}, 62.5, {startDelay: icon.ID * 4});

            FlxTween.tween(doodles, {alpha: 0.4}, 10);
        }});

        FlxTween.tween(credTxt, {y: -credTxt.height}, time, {onComplete: end});
        FlxTween.tween(black, {alpha: 0.4}, 4);
    });

    Conductor.bpm = 88;

    FlxTimer.wait(1, ()->{
        video.play();
        FunkinSound.playMusic(FunkinAssets.getVorbisSound(Paths.findFileWithExts('music/dstayfunky', ['ogg'], null, true)));
        // FlxG.sound.music.play();
    });

}

/**
 * [end]
 * Custom end function that destroys the video & switches the state to the normal Credits state.
 */
function end()
{
    FlxG.switchState(new ScriptedState('Credits'));
    video.destroy();
}


/**
 * [onUpdate(elapsed)]
 * Run on every frame update.
 
 * @param elapsed
 * Floating-point value that holds the second-value between the last frame update of the game.
 * Also known as a frame-delta.
  
 * In this script
 *  sets Conductor's songPosition variable.
 */
function onUpdate(elapsed)
{
	if (FlxG.sound.music != null)
		Conductor.songPosition = FlxG.sound.music.time;
}

/**
 * [onBeatHit()]
 * Run every time a beat passes in the menu's current song.
 * 
 * In this script
 *  multiplies all icons angle by -1
 */
function onBeatHit()
{
    for(icon in iconGrp)
        icon.angle *= -1;
        // icon.angle += 15;
}