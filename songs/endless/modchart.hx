function numericForInterval(start, end, interval, func) {
	var index = start;
	while (index < end) {
		func(index);
		index += interval;
	}
}

function tr(deg) {
	return deg * (3.141592653595 / 180);
}

function onLoad() {
	holdSubdivisions = ClientPrefs.lowQuality ? 1 : 4;
}

function onCreatePost() {
	if (ClientPrefs.modcharts)
		loadModchart();
}

function loadModchart() {
	for (i in 0...4) {
		modManager.setValue("transform" + i + "Y", -200, 0);
		modManager.setValue("alpha" + i, 1, 0);
		modManager.setValue("confusion" + i, 180, 0);
	}

	modManager.queueSet(16, "squish", 0.5);
	modManager.queueEase(16, 20, "squish", 0, 'circOut');

	for (i in 0...4) {
		modManager.queueEase(72 + i, 80 + i, "transform" + i + "Y", 0, 'quartOut');
		modManager.queueEase(72 + i, 80 + i, "alpha" + i, 0, 'quadOut');
		modManager.queueEase(72 + i, 80 + i, "confusion" + i, 0, 'quartOut');
	}

	// modManager.queueSet(16, "localrotateY", tr(360));
	// modManager.queueEase(16, 24, "localrotateY", 0, 'quadOut');

	numericForInterval(16, 135, 16, (s) -> {
		modManager.queueSet(s, "drunk", .45);
		modManager.queueEase(s, s + 4, "drunk", 0, 'expoOut');

		modManager.queueSet(s + 6, "tipsy", -.45);
		modManager.queueEase(s + 6, s + 8, "tipsy", 0, 'quadOut');

		modManager.queueSet(s + 8, "drunk", .85);
		modManager.queueEase(s + 8, s + 14, "drunk", 0, 'expoOut');
		modManager.queueSet(s + 8, "tipsy", .85);
		modManager.queueEase(s + 8, s + 14, "tipsy", 0, 'expoOut');
	});

	// modManager.queueEase(144, 148, "wave", 1);

	modManager.queueSet(144, "localrotateY", tr(360 * 3));
	modManager.queueEase(144, 148, "localrotateY", 0, 'circOut');

	var f = 1;
	numericForInterval(144, 400, 8, (s) -> {
		f *= -1;
		modManager.queueSet(s, 'transformX', -85 * f);
		modManager.queueSetP(s, 'mini', -50);
		modManager.queueEase(s, s + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(s, s + 4, "mini", 0, "quadOut");

		modManager.queueSet(s, "drunk", 1 * f);
		modManager.queueEase(s, s + 4, "drunk", 0, 'cubeOut');

		modManager.queueSet(s, "localrotateZ", tr(15) * -f, 0);
		modManager.queueSet(s, "localrotateZ", tr(15) * f, 1);
		modManager.queueEase(s, s + 4, "localrotateZ", 0, 'circOut');
		modManager.queueSet(s, "confusion", 15 * -f, 0);
		modManager.queueSet(s, "confusion", 15 * f, 1);
		modManager.queueEase(s, s + 4, "confusion", 0, 'circOut');

		var step = s + 4;

		modManager.queueSetP(step, 'tipsy', 125);
		modManager.queueSetP(step, 'tipsyOffset', 25);
		modManager.queueSet(step, 'transformX', -75);
		modManager.queueSetP(step, 'mini', -50);
		modManager.queueEase(step, step + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsy', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsyOffset', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, "mini", 0, "quadOut");

		modManager.queueSet(step, "tipsy", 1 * f);
		modManager.queueEase(step, step + 4, "tipsy", 0, 'cubeOut');

		// modManager.queueEase(step, step+4, "localrotateY", tr(-10), 'circOut');
	});

	var y = ClientPrefs.downScroll ? 200 : -200;
	for (i in 0...2) {
		modManager.queueEase(302, 302 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(302 + 3, 'reverse' + i, 1);
		modManager.queueSet(302 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(302 + 3, 302 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(302, 302 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(302 + 3, 'reverse' + i, 1);
		modManager.queueSet(302 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(302 + 3, 302 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(365, 365 + 3, "transform" + i + "Y", -y, 'backIn');
		modManager.queueSet(365 + 3, 'reverse' + i, 1);
		modManager.queueSet(365 + 3, "transform" + i + "Y", y);
		modManager.queueEase(365 + 3, 365 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(365, 365 + 3, "transform" + i + "Y", -y, 'backIn');
		modManager.queueSet(365 + 3, 'reverse' + i, 1);
		modManager.queueSet(365 + 3, "transform" + i + "Y", y);
		modManager.queueEase(365 + 3, 365 + 6, "transform" + i + "Y", 0, 'backOut');
	}
	for (i in 2...4) {
		modManager.queueEase(318, 318 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(318 + 3, 'reverse' + i, 1);
		modManager.queueSet(318 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(318 + 3, 318 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(380, 380 + 3, "transform" + i + "Y", -y, 'backIn');
		modManager.queueSet(380 + 3, 'reverse' + i, 1);
		modManager.queueSet(380 + 3, "transform" + i + "Y", y);
		modManager.queueEase(380 + 3, 380 + 6, "transform" + i + "Y", 0, 'backOut');
	}

	modManager.queueEase(368, 369, "reverse0", 0, 'cubeInOut');
	modManager.queueEase(368, 369, "reverse1", 0, 'cubeInOut');
	modManager.queueEase(383, 386, "reverse2", 0, 'cubeInOut');
	modManager.queueEase(383, 386, "reverse3", 0, 'cubeInOut');

	var f = 1;
	numericForInterval(400, 650, 8, (s) -> {
		f *= -1;
		modManager.queueSet(s, 'transformX', -30 * f);
		modManager.queueSetP(s, 'mini', -25);
		modManager.queueEase(s, s + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(s, s + 4, "mini", 0, "quadOut");

		modManager.queueSet(s, "drunk", 0.5 * f);
		modManager.queueEase(s, s + 4, "drunk", 0, 'cubeOut');
		var step = s + 4;

		modManager.queueSetP(step, 'tipsy', 125);
		modManager.queueSetP(step, 'tipsyOffset', 25);
		modManager.queueSet(step, 'transformX', -75);
		modManager.queueSetP(step, 'mini', -25);
		modManager.queueEase(step, step + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsy', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsyOffset', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, "mini", 0, "quadOut");

		modManager.queueSet(step, "tipsy", 0.5 * f);
		modManager.queueEase(step, step + 4, "tipsy", 0, 'cubeOut');

		// modManager.queueEase(step, step+4, "localrotateY", tr(-10), 'circOut');
	});

	modManager.queueEase(400, 408, "opponentSwap", 0.5, 'quartOut');
	modManager.queueEase(400, 408, "alpha", 0.5, 'quartOut', 1);
	modManager.queueEase(400, 408, "stealth", 0.125, 'quartOut', 1);
	modManager.queueEase(400, 408, "transform0X", -112 * 3.25, 'quartOut', 0);
	modManager.queueEase(400, 408, "transform1X", -112 * 3, 'quartOut', 0);
	modManager.queueEase(400, 408, "transform2X", 112 * 3, 'quartOut', 0);
	modManager.queueEase(400, 408, "transform3X", 112 * 3.25, 'quartOut', 0);

	for (i in 0...4)
		modManager.queueEase(456, 464, "transform" + i + "X", 0, 'quartInOut', 0);

	modManager.queueEase(456, 464, "transform0X", -112 * 3.25, 'quartOut', 1);
	modManager.queueEase(456, 464, "transform1X", -112 * 3, 'quartOut', 1);
	modManager.queueEase(456, 464, "transform2X", 112 * 3, 'quartOut', 1);
	modManager.queueEase(456, 464, "transform3X", 112 * 3.25, 'quartOut', 1);

	modManager.queueEase(526, 528, "transformY", y, 'backIn');
	modManager.queueSet(528, "opponentSwap", 0);
	modManager.queueSet(528, "reverse", 1);
	modManager.queueSet(528, "alpha", 0, 1);
	modManager.queueSet(528, "stealth", 0, 1);
	modManager.queueSet(528, "transformY", -y);
	for (i in 0...4)
		modManager.queueSet(528, "transform" + i + "X", 0, 1);
	modManager.queueEase(528, 530, "transformY", 0, 'backOut');

	modManager.queueSet(550, "localrotateX", tr(360));
	modManager.queueEase(550, 555, "localrotateX", 0, 'backInOut');
	modManager.queueEase(550, 555, "reverse", 0, 'backInOut');

	modManager.queueEase(592, 594, "opponentSwap", -0.125, 'quartOut');
	modManager.queueEase(592, 594, "stretch", 0.325, 'quintOut');
	modManager.queueEase(592, 594, "confusion", 20, 'quintOut');
	modManager.queueEase(596, 598, "opponentSwap", 0, 'bounceOut');
	modManager.queueEase(596, 598, "stretch", 0, 'bounceOut');
	modManager.queueEase(596, 598, "confusion", 0, 'bounceOut');

	modManager.queueEase(616, 618, "opponentSwap", 0.125, 'quartOut');
	modManager.queueEase(616, 618, "stretch", 0.25, 'quintOut');
	modManager.queueEase(616, 618, "flip", 0.125, 'quintOut');
	modManager.queueEase(616, 618, "confusion", -20, 'quintOut');

	modManager.queueEase(622, 626, "opponentSwap", -0.125, 'quintOut');
	modManager.queueEase(622, 626, "confusion", 20, 'quintOut');

	modManager.queueEase(626, 628, "flip", 0, 'bounceOut');
	modManager.queueEase(626, 628, "stretch", 0, 'bounceOut');
	modManager.queueEase(626, 628, "opponentSwap", 0, 'bounceOut');
	modManager.queueEase(626, 628, "confusion", 0, 'bounceOut');

	modManager.queueEase(654, 656, "alpha", 0.5, 'quartInOut', 1);
	modManager.queueEase(654, 656, "stealth", 0.25, 'quartInOut', 1);
	modManager.queueEase(654, 656, "transformX", -50, 'quartInOut');
	modManager.queueSet(656, "transformX", 0);

	modManager.queueFunc(656, 788, function(event:CallbackEvent, cDS:Float) {
		var pos = (cDS - 656) / 4;

		for (pn in 1...3) {
			for (col in 0...4) {
				var cPos = col * -112;
				if (pn == 2)
					cPos = cPos - 620;
				var c = (pn - 1) * 4 + col;
				var mn = pn == 2 ? 0 : 1;

				var cSpacing = 112;
				var newPos = (((col * cSpacing + (pn - 1) * 640 + pos * cSpacing) % (1280))) - 176;
				modManager.setValue("transform" + col + "X", cPos + newPos, mn);
			}
		}
	});

	var poop = 1;
	numericForInterval(656, 904, 4, (step) -> {
		poop *= -1;
		modManager.queueSet(step, "confusion", 10 * poop);
		modManager.queueEase(step, step + 4, "confusion", 0);

		modManager.queueSet(step, "squish", 0.2);
		modManager.queueEase(step, step + 4, 'squish', 0, 'quintOut');
	});

	modManager.queueEase(717, 720, "transformY", y, 'backIn');
	modManager.queueSet(720, "reverse", 1);
	modManager.queueSet(720, "transformY", -y);
	modManager.queueEase(720, 723, "transformY", 0, 'backOut');

	modManager.queueEase(782, 790, "reverse", 0, 'backInOut');
	modManager.queueEase(782, 790, "receptorScroll", 1, 'backInOut');
	modManager.queueEase(782, 790, "sudden", 0.85, 'backInOut');
	modManager.queueEase(782, 790, "suddenOffset", 0.85, 'backInOut');

	for (i in 0...4)
		modManager.queueEase(894, 906, "transform" + i + "X", 0, 'backInOut');
	modManager.queueEase(900, 904, "receptorScroll", 0, 'backInOut');

	modManager.queueEase(912, 916, "beat", 0.25, 'backInOut');
	modManager.queueEase(912, 916, "alpha", 0.85, 'backInOut', 1);
	modManager.queueEase(912, 916, "opponentSwap", 0.5, 'backInOut');

	modManager.queueSet(912, "localrotateY", (360 * 2) * (3.14159265359 / 180));
	modManager.queueEase(912, 920, "localrotateY", 0, 'quartOut');

	var poop = 1;
	numericForInterval(912, 1168, 4, (step) -> {
		poop *= -1;
		modManager.queueSet(step, "confusion", 10 * poop);
		modManager.queueEase(step, step + 4, "confusion", 0);

		modManager.queueSet(step, "squish", 0.2);
		modManager.queueEase(step, step + 4, 'squish', 0, 'quintOut');
	});

	var counter = -1;
	var counter2 = -1;
	numericForInterval(912, 1168, 8, (step) -> {
		counter *= -1;
		counter2 += 1;
		if (counter2 >= 8)
			counter2 = 0;

		modManager.queueSet(step, "mini", -0.625);
		modManager.queueEase(step, step + 4, "mini", 0, "quartOut");
		modManager.queueSet(step, "drunk", -1.25 * counter);
		modManager.queueEase(step, step + 4, "drunk", 0, "quartOut");

		modManager.queueSet(step + 4, "mini", -0.625);
		modManager.queueEase(step + 4, step + 8, "mini", 0, "quartOut");
		modManager.queueSet(step + 4, "tipsy", 0.75 * counter);
		modManager.queueEase(step + 4, step + 8, "tipsy", 0, "quartOut");
		modManager.queueSet(step + 4, "drunk", 1.25 * counter);
		modManager.queueEase(step + 4, step + 8, "drunk", 0, "quartOut");
	});

	modManager.queueSet(1040, "localrotateX", tr(360));
	modManager.queueEase(1040, 1048, "localrotateX", 0, 'backInOut');
	modManager.queueEase(1040, 1048, "reverse", 1, 'backInOut');

	// too lazy to do the math. JARVIS DO THE MATH FOR ME
	modManager.queueEase(1168, 1168 + 16, "reverse", 0, 'quadOut');
	modManager.queueEase(1168, 1168 + 16, "opponentSwap", 0, 'quadOut');
	modManager.queueEase(1168, 1200, "beat", 0, 'quadInOut');
	modManager.queueEase(1168, 1200, "alpha", 0, 'quadInOut');
	modManager.queueEase(1168, 1200, "stealth", 0, 'quadInOut');

	modManager.queueSet(1296, "localrotateY", (360 * 2) * (3.14159265359 / 180));
	modManager.queueEase(1296, 1304, "localrotateY", 0, 'quartOut');

	var f = 1;
	numericForInterval(1296, 1550, 8, (s) -> {
		f *= -1;
		modManager.queueSet(s, 'transformX', -85 * f);
		modManager.queueSetP(s, 'mini', -50);
		modManager.queueEase(s, s + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(s, s + 4, "mini", 0, "quadOut");

		modManager.queueSet(s, "drunk", 1 * f);
		modManager.queueEase(s, s + 4, "drunk", 0, 'cubeOut');

		modManager.queueSet(s, "localrotateZ", tr(15) * -f, 0);
		modManager.queueSet(s, "localrotateZ", tr(15) * f, 1);
		modManager.queueEase(s, s + 4, "localrotateZ", 0, 'circOut');
		modManager.queueSet(s, "confusion", 15 * -f, 0);
		modManager.queueSet(s, "confusion", 15 * f, 1);
		modManager.queueEase(s, s + 4, "confusion", 0, 'circOut');

		var step = s + 4;

		modManager.queueSetP(step, 'tipsy', 125);
		modManager.queueSetP(step, 'tipsyOffset', 25);
		modManager.queueSet(step, 'transformX', -75);
		modManager.queueSetP(step, 'mini', -50);
		modManager.queueEase(step, step + 4, 'transformX', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsy', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, 'tipsyOffset', 0, 'cubeOut');
		modManager.queueEaseP(step, step + 4, "mini", 0, "quadOut");

		modManager.queueSet(step, "tipsy", 1 * f);
		modManager.queueEase(step, step + 4, "tipsy", 0, 'cubeOut');
	});

	for (i in 0...2) {
		modManager.queueEase(1455, 1455 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(1455 + 3, 'reverse' + i, 1);
		modManager.queueSet(1455 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(1455 + 3, 1455 + 6, "transform" + i + "Y", 0, 'backOut');

		modManager.queueEase(1455, 1455 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(1455 + 3, 'reverse' + i, 1);
		modManager.queueSet(1455 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(1455 + 3, 1455 + 6, "transform" + i + "Y", 0, 'backOut');
	}
	for (i in 2...4) {
		modManager.queueEase(1471, 1471 + 3, "transform" + i + "Y", y, 'backIn');
		modManager.queueSet(1471 + 3, 'reverse' + i, 1);
		modManager.queueSet(1471 + 3, "transform" + i + "Y", -y);
		modManager.queueEase(1471 + 3, 1471 + 6, "transform" + i + "Y", 0, 'backOut');
	}

	for (i in 0...4) {
		modManager.queueEase(1515, 1515 + 3, "transform" + i + "Y", y, "backIn");
		modManager.queueSet(1513 + 3, "transform" + i + "Y", -y);
		modManager.queueSet(1513 + 3, "reverse" + i, 0);
		modManager.queueEase(1513 + 3, 1513 + 6, "transform" + i + "Y", 0, 'backOut');
	}

	modManager.queueEase(1550, 1584, "alpha", 1);
	modManager.queueEase(1550, 1584, "confusion", 360);
	modManager.queueEase(1550, 1584, "centerrotateY", tr(360 * 1.5));
}
