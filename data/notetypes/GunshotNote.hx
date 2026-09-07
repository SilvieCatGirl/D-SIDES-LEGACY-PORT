import funkin.backend.Conductor;

var sSize = Conductor.stepCrotchet / 1000;

function setupNote(note) {
	if (ClientPrefs.mechanics) {
		note.hitCausesMiss = false;
		note.noAnimation = true;
	}
	note.rgbEnabled = false;
	note.setCustomColor([0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF]);
	note.reloadNote('bullet/');
}

function postSpawnNote(note) {
	note.rgbEnabled = false;
}

var game = PlayState.instance;

function noteMiss(note) {
	if (note.noteType == 'GunshotNote' && ClientPrefs.mechanics)
		game.health -= 0.25;
}

var dodge_notes:Array<String> = ['sing_dodgeLEFT', 'sing_dodgeDOWN', 'sing_dodgeUP', 'sing_dodgeRIGHT'];
var anidodge_notes:Array<String> = ['singLEFT-dodge', 'singRIGHT-dodge'];

function goodNoteHit(note) {
	if (note.noteType == 'GunshotNote') {
		if (ClientPrefs.bfSkin == 'default'){
			boyfriend.playAnim(anidodge_notes[note.noteData], true);
			boyfriend.holdTimer = 0;
		}
		if (boyfriend.curCharacter == 'animaniabf'){
			boyfriend.playAnim(anidodge_notes[FlxG.random.int(0, anidodge_notes.length-1)], true);
			boyfriend.specialAnim = true;
		}
		else{
			boyfriend.playAnim('dodge', true);
			boyfriend.holdTimer = 0;
		}
	}
}

function opponentNoteHit(note) {
	if (note.noteType == 'GunshotNote') {
		shoot();

		if (!ClientPrefs.mechanics) {
			boyfriend.playAnim(dodge_notes[note.noteData], true);
			boyfriend.holdTimer = 0;
		}
	}
}

var poop = 1;

function shoot() {
	FlxTween.cancelTweensOf(camGame, ['scrollAngle']);
	camGame.zoom += 0.0625 / 4;
	camGame.scrollAngle = 4 * poop;
	poop *= -1;
	FlxTween.tween(camGame, {scrollAngle: 0}, sSize * 2, {ease: FlxEase.quartOut});
}
