//=================================//
        Shifter for Deus Ex
	    Version 1.8
//=================================//

INTRODUCTION:

	Shifter is my little attempt at "removing the suck" from Deux Ex.  Not
to say that Deux Ex sucks by any means, but that there were certain aspects of
the game which could have been changed for the better, mostly in the areas of
weapons/items.  One of the things that drives me batty with any game is when you
are given weapons or items that are useless for one reason or another.  In Deus
Ex there were several instances of items that were never useful or were useful
only for short periods of time. (As well as a few which were very nice but you
rarely came across, e.g. throwing knives)  Therefore, being the (relatively)
competent coder that I am I took it upon myself to remedy these problems.

	I have been told that my mod is part of a so-called "Holy Trinity of
Deus Ex upgrade goodness," namely the part that improves the gameplay.  I feel I
should mention the other two parts of the trinity, namely Project HDTP (found at
http://offtopicproductions.com/hdtp/) and Chris Dohnal's enhanced OpenGL and
Direct3D8 rendering engines for Deus Ex.  (found at
http://cwdohnal.home.mindspring.com/utglr/)  HDTP will make the game look
absolutely stunning, while the new rendering engines will keep the game's
visuals free of the kind of aliasing and intersection artifacts that usually
plague older games when run on newer hardware.


INSTALLATION:

	The most basic installation procedure -- the only one I'll cover -- is
to go to your DeusEx\System directory and replace your existing DeusEx.u and
DeusEx.int files with the ones in the Zip file.  I highly recommend you make
backup copies of each file just in case you want to switch back for some reason.
(e.g. multiplayer)  Doing this will ensure that Shifter runs *with* other mods,
meaning that any other new singleplayer maps/levels/plots you play will use
Shifter rules, with some few exceptions. (Hotel Carone will not use the new
skill system, for example)

	If you want to install Shifter so that you are still able to play
unmodified Deus Ex without having to swap files, please read the file
"Advanced.txt" for detailed instructions.

	**PLEASE NOTE** You MUST have the v1112fm patch installed to run Shifter
(The Game of the Year edition comes prepatched, usually)  PLEASE NOTE THE "M" AT
THE END OF THE PATCH TITLE.  You MUST install the MULTIPLAYER patch.  If, after
installation, you get an error mentioning "FloatProperty Streak" when you try to
run Deus Ex then you do *not* have v1112fm installed.

	**PLEASE ALSO NOTE** The second file you need to replace is DeusEx.inT.
The "T" at the end is not a typo.  If you replace DeusEx.inI the game will not
run! 

	**HDTP RELEASE #1 USERS** You need to move or copy the HDTPanim.utx file
into your C:\DeusEx\Textures folder for Shifter to work properly with HDTP.
This file is installed to C:\DeusEx\HDTP\Textures by default.


A BRIEF FAQ-TYPE THING:

	No readme would be complete without a FAQ, and believe me, I do hear a
lot of the same questions over and over and over again.  So, in no particular
order whatsoever:

	 - I CAN'T FIND THE ALT-FIRE BUTTON: Look up two paragraphs.  You need
	to make sure you've replaced the DeusEx.inT file in your
	C:\DeusEx\System folder with the one I've included in the zip file.
	Alt-Fire is the third button down in the button list, but if you're
	using the default DeusEx.inT file it will list it as "Drop Weapon".  The
	real "Drop Weapon" key is located just below it, in what used to be "Put
	Away Item".  "Put Away Item" is now at the very bottom of the list.

	 - CAN I USE YOUR MOD AS PART OF MY MOD, OR USE PARTS OF YOUR CODE: Yes,
	as a matter of fact you can.  I'm very much an open-source kind of guy.
	The only requirement I have is that you 1) have a readme, and 2) note in
	it that you used my code as part of your mod.  You don't have to go into
	incredible detail about what specific sections you used or anything, but
	do at least try to mention how much of my code you used.

	 - WHY DON'T YOU HAVE AN INSTALLER: Because I don't know where to find a
	free one and I'm too lazy to write my own.  I can't just use a self-
	extracting installer either; I need something that will copy existing
	files, move them, and modify them in addition to extracting my stuff.
	(Basically, something to do the Advanced Install automatically)	

	 - OMG MY GAME CRASHED WHY: Umm... "crashed" how?  Did it just close?
	What was the error message?  What were you doing in the game at the
	time?  If you can't answer two out of three of these I probably won't be
	able to help you.  If you can then I should be able to figure it out.

	 - MY GAME CRASHED, SOMETHING ABOUT FLOATING STREAKERS OR SOMETHING: You
	mean "FloatProperty Streak"?  That invariably means that you don't have
	v1112fm installed properly.  No, this doesn't mean you did it wrong, just
	that sometimes the patch doesn't, well, patch all the way.  This is
	surprisingly common with the Game of the Year edition, which supposedly
	comes pre-patched.  Just go get the v1112fm patch -- NOT v1112f -- off
	of FilePlanet and install it, then reinstall Shifter.

	 - I SAVED MY GAME IN SHIFTER AND NOW IT WON'T OPEN IN NORMAL DEUS EX:
	This is unavoidable, unfortunately.  Shifter has a number of items in it
	that normal Deus Ex does not.  Regardless of whether or not you pick up
	any of these items one or two will get saved into your savegame.  Deus
	EX will try to load the items, find it can't and stop trying to load the
	savegame.

	 - HOW CAN I MAKE YOUR MOD WORK WITH "X" MOD: This really depends on the
	mod in question.  As I mentioned, Shifter works "out of the box" with
	most "mission" mods, e.g. those which add new missions, such as Zodiac.
	However, I do get occasional requests for instructions on making my mod
	work with mods like Smoke's Mod, i.e. those which don't add new missions
	but simply change the rules of the game.  The problem is that my mod and
	mods like Smoke's modify the *same* file (DeusEx.u) in order to work.
	The only way to run the two together would be for someone (e.g. myself
	or Smoke) to "merge" the two mods, which would take time.

	 - DOES YOUR MOD WORK WITH HDTP: Yes, it does!  HDTP is the exception to
	the above answer, because I have gone out of my way to make Shifter
	compatible with HDTP. I have spent a good amount of time adding code to
	Shifter so that it will automatically load up the HDTP textures and
	models if it finds them, but will default to the normal Deus Ex ones if
	it can't. This only happens the FIRST time you load each map, so if you
	install HDTP in the middle of a play-through the current level won't get
	the HDTP facelift.

	 - DOES YOUR MOD WORK WITH THE STEAM VERSION OF DEUS EX: From what I've
	been told by various folks, apparently Shifter is 100% compatible with
	the version of Deus Ex you can purchase via Valve's Steam program.  I'm
	still in the process of testing it fully myself, but all indicators are
	that the functional enhancements of Shifter cause no problems with Steam
	and are not impeded by the program at all.  However, certain other mods
	(like HDTP) may require some extra configuration to get working.

	 - WHERE IS THE SHIFTER HOMEPAGE: You can find the Shifter homepage at
	http://yukichigai.googlepages.com/shifter.  I also have an account over
	at ModDB (http://mods.moddb.com/8002/shifter/) which is where I usually
	post news items, ramblings, and other such things. There's always the
	SaveFile project page for it, where you can get the latest version.
	(http://tinyurl.com/2b5k82)  I upload to FilePlanet semi-regularly,
	though not as often as to SaveFile.  I also update a thread in the Eidos
	Forums about Shifter.  (http://tinyurl.com/zxehg)


SPECIFICS:

	Weapon Modifications:

	 - Assault Rifle: Increased the amount of 7.62 ammo you pick up from
	corpses. (8-12 rounds, up from 1-4)

	 - Baton: Does a tiny bit more damage. (one point)

	 - Combat Knife: You can now carry 6 Combat Knives at once.  This is
	important since you can throw them using Alt-Fire.

	 - Crowbar: Increased the damage to make it worth two item slots.

	 - Explosive Rounds: I have placed a few boxes of explosive 10mm ammo in
	a few places throughout the game.  This ammo is somewhat scarce, as the
	amount of damage it allows a basic pistol to do is quite remarkable.

	 - Grenades: You can now switch between the various grenade types
	by pressing "Change Ammo" when holding a grenade.

	 - Hand to Hand Weapons: You can also cycle between hand to hand
	weapons (e.g. Knives, Swords) similar to how you can with grenades. In
	addition, most Hand to Hand weapons have an Alt-Fire mode, which simply
	throws the weapon.

	 - Laser Sight Mod: A weapon equipped with a Laser Sight will come up
	with the laser automatically activated.  The laser "dot" will now wander
	about within the range of your accuracy.  When you fire the weapon, the
	bullet will go EXACTLY where the laser is pointing.  You can still turn
	the laser on/off if you have a key bound to it, though why you would
	want to is beyond me.

	 - Mini-Crossbow: Flare Darts will now set NPCs on fire.  The length of
	this burn is half of what you would get from the Flamethrower.

	 - Pepper Spray: Increased the live time of the pepper spray cloud.  (Up
	to about 3 seconds from < 0.1 seconds)  This means you can actually stun
	people without having to practically stand on them.  As an interesting
	and as yet unexplained side-effect, Greasels now shoot Tear Gas in
	addition to their poisonous spit.

	 - PS20: Increased the damage and the explosion radius of the projectile
	it fires.  Worth using even late in the game now. 

	 - Scope: You no longer have to wait between shots to zoom in/out.  Much
	less annoying, much more realistic.

	 - Stealth Pistol: Increased the rate of fire and damage by a slight
	amount.

	 - Throwing Knives: Reduced the spread and increased the damage.

	 - Unique Weapons: Taking a page from Invisible War, I have added in a
	number of Unique weapons.  Some have been added as separate pickups,
	some were added in via other means.  You'll have to keep your eyes
	peeled and your curiosity high to find them.


	Augmentation Modifications:

	 - Augmentation Cannisters: Cannisters for augmentations you have
	already	installed will now allow you to upgrade that augmentation once.
	You must use a Medical Bot to do it though.  You may also choose to
	"overwrite" an existing augmentation with a new one if no slots are
	available, though the new augmentation will be installed at level 1,
	with no upgrades. Cannisters with no augmentations specified for them
	will contain a pair of randomly determined augs.  In the future such
	Cannisters may be incorporated into NPC Random Inventory.

	 - Environmental Resistance: Enviro Resist will now decrease the length
	of time you will experience "drunk" effects when it is active by an
	amount based on the level of the augmentation.

	 - Power Recirculator: Power Recirculator will now automatically
	activate whenever using it would decrease overall power use, and
	similarly will automatically deactivate whenever it is using up more
	power than it is conserving.

	 - Combat Strength: The Combat Strength and Muscle augmentations have
	been consolidated into the Muscle augmentation, a la Invisible War.  The
	Combat Strength augmentation has been replaced with the Electrostatic
	Discharge augmentation, also a la Invisible War.

	 - Regeneration: The Regeneration augmentation can be activated at any
	time, and will stay active until you turn it off, instead of when you
	are fully healed.  It will drain a low amount of power when you are
	healed -- i.e. when it is in the "idle" state -- and will use the
	normal, high amount of power only when it is actively healing you.

	 - Synthetic Heart:  Using the Synthetic Heart augmentation will now
	allow you to boost most augmentations past their maximum level.

	 - Skull Gun: Perhaps the most amusing running joke in the Deus Ex
	series is now an actual augmentation.  Augmentation Cannisters
	containing the Skull Gun aug have been placed in two locations within
	the game; one relatively early in the game and one which is somewhat
	late in the game.

	 - Targeting: The Targeting augmentation will now allow you to zoom in
	with any weapon, regardless of whether or not it has a scope.  The
	magnification of the zoom will depend on the level of the augmentation.
	It also has two "modes" of use: one with the zoomed sub-window, and one
	without.  To disable the window simply hit the activation key assigned
	to it a second time.


	General Modifications:	

	 - Alt-Fire: There is now a separate keybind for Alternate Fire.
	Several weapons have Alt-Fire modes, including the Plasma Rifle and
	Combat Knife.  Pressing Alt-Fire while using weapons without an Alt-Fire
	mode will simply turn on/off the scope on that weapon, if it has one.
	(Or if the targeting aug is currently active)

	 - Charged Items: Items like Ballistic Armor, Hazmat Suits, etc. no
	longer are one-use items.  You can turn them on and off as need be. To
	go with this some item functionality has been changed.  For example, the
	Rebreather now slowly refills your oxygen meter, rather than keeping it
	at maximum level constantly.

	 - Kills: You will now be given skill points for each kill/KO you make.
	The amount of points is calculated based on the max health of the victim,
	along with their affiliation and the method used to kill/KO them.

	 - Kills (again): Dying NPCs can now be affected by bullets and the like,
	which means that if you shoot them with something powerful enough -- say
	a Boomstick at point-blank range -- they just might be propelled a rather
	considerable distance by the force of the bullets.

	 - NPC Inventory: NPCs will randomly carry extra items, chosen from a
	set list.  These items will include some items not commonly found in the
	game, (Throwing Knives, Pepper Spray) as well as some generic items and
	certain "special" items.

	 - Office Storage: Someone pointed out how it's odd that any items you
	leave in JC's office at UNATCO will disappear between missions.  While
	this does make sense from a technical standpoint, from a plot standpoint
	it's as though Walton Simons keeps swinging by during off-hours and
	stealing your stuff.  You can now leave items in your office and find
	them there upon your return, complete with any Weapon Mods and so forth
	that have been installed on them.

	 - Stealth: Due to complaints about the skill points for kills/KO system
	slanted gameplay towards killing everyone (a valid point) there is also
	a system for granting skill points based on how stealthy you are.  The
	determination is based on how close you get to an NPC without being
	detected.  "Minor" detections, where the NPC saw you but "wasn't sure,"
	reduce the potential bonus by a fraction.  Being fully detected removes
	the stealth bonus for that NPC.  Yes, killing them counts as being
	detected for the purposes of the system.

	 - Vases, Plants, etc.: Throwing an item at an NPC will do "knock out"
	damage to them, provided the speed the object is thrown at is high
	enough and that you have the Muscle nhancement augmentation on. (Though
	if the speed is REALLY high the Muscle aug is not checked for) This will
	also damage the item thrown; in general one or two throws will shatter
	the item if it is breakable.

	 - Weapon Accuracy: Originally, Deus Ex was somewhat inconsistent in how
	it displayed and calculated the accuracy of a weapon.  Firstly, the
	crosshair's range in no way reflected the spread of the weapon.
	Secondly, the spread of two bullet-based weapons with the same accuracy
	could be wildly different depending on their maximum range.  Shifter
	addresses both of these issues.  While it may appear, based on the
	crosshair, that all weapons are now more accurate, weapon accuracy is in
	fact (mostly) the same.  (Slightly better for some weapons, slightly
	worse for others, depending on the range of the weapon)

	 - Zyme: Since Zyme was pretty much useless in the original game, I have
	modified it so it provides a temporary speed and skill boost.  It also
	initiates "bullet time" effects while it is active.  Be wary though; once
	the effects wear off there is a long period of "drunk-vision".


	Things I did because I could:

	 - Seagulls explode on death, similar to the way MiBs do but will less
	damage and a smaller blast radius.


	Multiplayer Modifications:

	   Shifter also includes a modified version of the Deux Ex MP code.
	The key change in Shifter MP is the way weapons are carried.  In 
	normal Deux Ex MP you are given three belt slots for weapons, the 
	others being reserved for Medkits, BioE Cells, various Grenades, 
	Multitools, and Lockpicks.  Unfortunately this made MP gameplay somewhat
	stifled and unvaried.  Shifter MP instead allocates 6 belt slots for
	weapons, but with a catch: the bigger the weapon is, the more belt slots
	it will take up.  For example, say you're carrying with you a Combat
	Knife, a Pistol, a Mini-Crossbow and a Gep Gun. The Knife, Pistol and
	Mini-C would take up your first 3 slots, and the Gep Gun would take up
	your last 3.  You could drop the Gep Gun and pick up a two-slot item --
	say an Assault Rifle or the Dragon's Tooth Sword -- and another 1 slot
	weapon.  And so on and so forth.

	   The next 2 slots are devoted to categories of items: Grenade,
	Recovery. (Grenades, Health Kits and BioE Cells)  The contents of each
	of these 3 slots can be changed	by pressing the Change Ammo button,
	allowing you to cycle through the available category items. The last two
	slots, as in normal Deus Ex MP, are devoted to Lockpicks and Multitools.

	   I have also added in numerous new player models to choose from when
	playing MP.  In general any NPC model seen in the game is a selectable
	player model.  This does make cycling through them all a somewhat long
	process (93 models in all) but remember that you can go backwards through
	the list by clicking with the right mouse button.


	Unique Weapons and other new items:

		The following is a complete listing of all Unique Weapons in
	Shifter, complete with a brief weapon description and the actual object
	name, should you decide to cheat and use the Summon command to bring one
	or two into play.

	 - Blackjack (WeaponBlackjack): A standard Baton, modified by Paul to
	be a formidable weapon while still meeting his non-lethal weapon needs.
	The interior has been filled with a heavy material, possibly lead shot
	or even iron rebar for authenticity.

	 - Boomstick (WeaponBoomstick): Jock's Sawed-Off Shotgun, with improved
	damage, less recoil and a quicker reload time.  

	 - ILAW (WeaponMiniRocket): The Internal Light Anti-Personnel Weapon is
	the official name of the cybernetic rocket-based weapon that Majestic-12
	Commandos are outfitted with.  Several prototypes were fitted for
	external use, for demonstration purposes.

	 - JackHammer (WeaponJackHammer): An Assault Shotgun modified by
	Smuggler, who just didn't quite know the meaning of the word "overkill".
	It has dramatically reduced recoil, which is vital in a gun capable of
	firing 12 shells in under a second.

	 - Lo Bruto (WeaponLoBruto): JoJo Fine's specially modified Stealth
	Pistol.  It has improved damage, but JoJo wasn't the best gunsmith in
	the world.

	 - Magnum (WeaponMagnum): A modified pistol with improved accuracy and
	damage.  It's a bit louder than the standard pistol, however.

	 - Precision Rifle (WeaponPrecisionRifle): A rifle developed with two
	goals in mind: long-range sniping and mid-range assault.  The so-called
	"Precision" Rifle mixes high accuracy with quick-chambering technology,
	allowing the user to fire multiple rounds in quick succession, while
	still retaining the high stopping power of the 30.06 round.  Comes
	equipped with a vision-enhancing scope.

	 - Prototype NanoSword (Mk I) (WeaponPrototypeSwordA): The first attempt
	at creating what would become the Dragon's Tooth Sword used a 
	dramatically different approach, generating a ultrathin stasis field 
	around the blade to effectively amplify momentum and force.  However, 
	the inherent instabilities of the stasis technology caused the approach 
	to be abandoned.

	 - Prototype NanoSword (Mk II) (WeaponPrototypeSwordB): The second 
	prototype of the NanoSword technology combined early-gen nanoscale 
	whetting devices with a significantly weaker stasis field, the hope 
	being that the instabilities in the stasis technology could be 
	eliminated by reducing the power of the field.  This proved untrue, and 
	the stasis technology was abandoned completely.

	 - Prototype NanoSword (Mk III) (WeaponPrototypeSwordC): The third 
	prototype of what would eventually become the Dragon's Tooth Sword 
	relied on a traditional blade to do the cutting, kept incredibly sharp 
	by nanoscale whetting devices.  Later revisions of these same whetting 
	devices can be found in the current Dragon's Tooth Sword.

	 - Railgun (WeaponRailgun): Created by an as yet unknown manufacturer,
	the Railgun is technically a heavy modification of the Plasma Rifle, but
	far more deadly.  A heavily compacted set of four plasma charges is
	magnetically accelerated to near-light speeds, making the resulting
	projectile easily capable of penetrating multiple solid objects in
	succession.  It has also been equipped with a thermal scope.

	 - Toxin Blade (WeaponToxinBlade): On the surface it appears to be no
	more than a standard Combat Knife, but the Toxin Blade is coated with a
	brutally effective paralytic toxin.  Deceptively high-tech, the coating
	is maintained by a swarm of nanobots which replenish it and ensure that
	the blade is always at its sharpest.

	 - Rate of Fire Weapon Mod (WeaponModAuto): Not a weapon in itself, but
	a way to decrease the time between shots on most weapons you can carry.
	Apply it just like any other weapon mod.

		There also exists another, super-secret unique weapon that is by
	no means intended for serious play.  It is not placed anywhere in the
	game.  Yet, anyway.


KNOWN GLITCHES:

	   Even though this mod is no loger in beta stages there are still some
	lingering glitches. With some of these I am unsure if these are due to
	my modifications or if they are simply pre-existing glitches that I have
	only noticed recently, but regardless they are still present.


	Single Player:

	 - If you have your resolution higher than about 1280x1024 then your
	savegames may not have screenshots to go with them.  This usually only
	happens with the OpenGL rendering settings, and is a limitation in the
	Deus Ex engine.  There's nothing I can really do about it, other than
	to warn you.  The enhanced Direct3D8 renderer (available from the same
	site as the enhanced OpenGL renderere) does not suffer from this
	limitation, however.

	 - An odd side-effect of the "Office Storage" feature may rarely cause
	random weapons to appear in JC's UNATCO office upon returning from a
	mission.  Sometimes these weapons come with a mod or mods installed;
	apparently silenced Sniper Rifles are the most common.

	 - The new Zyme effects do not completely work in at least one map in
	the game: the Hong Kong Canal area.  While you will receive the skill
	and speed boost, for unknown reasons the game's speed will not drop.
	As soon as you move to another map in the area, however, all normal
	Zyme effects will return.

	Multiplayer:

	 - Clients connecting to a server running ShifterMP may witness some
	bizarre behavior from the item belt, specifically an odd "scrolling"
	effect when using multi-slot weapons.  This is definitely some kind of
	issue with the Unreal engine's "replication" functionality, which
	unfortunately is one of the hardest Unreal "features" to deal with.  I'm
	working on fixing it, but in the meantime try to ignore the weird scroll
	thing; it may take a while for me to get it sorted out.

	 - Some of the new player models may "freeze" when attempting to perform
	a certain animation, since that player model doesn't have it.  If this
	occurs please let me know which models are doing it.


	   If you notice any other glitches or errors please e-mail me.


THINGS TO EXPECT IN THE FUTURE:

	 - Okay, scratch that whole "run bar" idea mentioned in earlier ReadMe
	versions.  I am, however, fully committed to converting the Swimming
	skill to a larger, more encompassing Athletics skill.

	 - The Skull Gun aug will be changed to a lower-damage, lower-drain aug
	that automatically fires at enemy targets when active.

	 - You will be able to pet cats.  Yes, I'm serious, I'm going to make a
	system for petting cats.

	 - Dragging a Weapon Mod over a belt slot will not replace the item in
	the slot.  It will instead upgrade the item if applicable.

	 - If I get bored enough I may make dead animals cookable, wherin they
	will subsequently become edible.  I warn you, I'm bored a lot.

	 - I fully intend for there to be a Unique Weapon to compliment every
	existing non-one-use weapon in the game.  (By "compliment" I mean like
	how the Magnum compliments the Pistol)


OTHER NOTES OF DEADLY DOOM:

	The name "Shifter" is a tribute to a popular mod for Starsiege: Tribes.
Shifter was created by emo1313.  Check out his current version of Shifter for
Tribes 2 at www.shiftermod.com.  Or check out mine, Shifter Classic, which can
be found (when I get around to distributing new versions) at
www.tribeshifter.com.

	As always, if you notice anything amiss or something I haven't covered
don't hesitate to fill my inbox with your witty and thought-out e-mails.

	For those of you who don't know, "NPC" means "Non-Player Character",
i.e. any person who you aren't playing as.

CONTACTING ME:

	Send gripes, suggestions, enthusiasms, Swiss Bank account numbers, 
free garden gnomes and anything that can be classified as a symptom of
progressed insanity to yukichigai@hotmail.com. You can also MSN me using
this e-mail address.


WHO THE HELL ARE YOU AGAIN?

	Y|yukichigai.  That's "you-key-chee-guy" for those of you who don't
habla Japañol.  Or whatever.


TESTIMONIALS:

	Here's what some satisfied (I think) players have had to say about my
mod and how it has affected their everyday lives (in Deus Ex, anyway):

	"A UNATCO agent trained in melee weapons can hurl a crowbar with 
	sufficient force and precision to crack the skull of a ten-year-old 
	homeless boy in a single shot while rendering the candy bar he carries 
	still edible." - Sb27441X


UPDATES:

	v1.8:

	 - Mostly fixed the exploits that allowed you to open any lock with one
	lockpick/multitool by pausing the game while you were picking.  I was
	unable to prevent lockpicks and multitools from working while paused, but
	the fix stops them from working past their determined efficiency, e.g. no
	matter how long you pause the game, if a door says it takes 4 lockpicks
	then you will have to use 4 lockpicks.

	 - Prevented the friendly bots in Vandenberg from deciding to kill the
	X51 scientists should some friendly fire occur.  This is rare, but given
	that a few of them carry shotguns it's a lot more common than I'd like.

	 - Added some code to the skillpoint award trigger class which should fix
	most of the "infinite skillpoint loop" glitches found in the game.  The
	new code will make sure that the "bTriggerOnceOnly" variable is actually
	paid attention to for all methods of activation; in the past it would
	disable the trigger if it was activated by touch, but not if it was
	activated by an action like entering the correct code on a keypad.

	 - Along the same lines, added in code to deactivate the UC self-destruct
	keypad in Hong Kong after you use it.  Before you could stop most of the
	navigation hazards (e.g. the electricity arcs) from showing up if you
	quickly re-entered the code before the core could fully extend.  Now the
	keypad will be set with an un-enterable code and will become unhackable,
	and should someone find a way around that triggering it won't do anything
	anyway.

	 - Related to the above, any keypads with zero-length codes will
	automatically give you an "ACCESS DENIED" message when you attempt to
	access them.  This should only affect the keypad mentioned above.

	 - Fixed the "Pistol Downgrade" trick, which allowed you to downgrade
	your pistol skill on the new game screen, yet still have it be at Trained
	when you finally started the game.  I'm not sure if the method I've used
	is going to cause problems with other mods like Zodiac or Hotel Carone,
	so let me know if your pistol skill behaves oddly or doesn't come up
	set to Trained by default on the new game screen in other mods.

	 - Fixed the issue that could cause two augmentations to be bound to the
	same hotkey after overwriting an existing augmentation.  This only came
	up when you overwrote augs in the Torso or Subdermal slots.

	 - A Russian fan of Shifter offered to create a Russian translation file
	for Shifter.  The easiest way to do that, unfortunately, was to create a
	new DeusEx.int file for Russian players to use.  So that all my textual
	changes carry over, I have gone through and redone how much of the new
	text is stored, specifically so it is stored in variables that a new
	DeusEx.int file can modify if need be.  This will in no way affect
	gameplay, other than the way things are done behind the scenes.

	 - Recoded the way the Precision Rifle's vision-enhancing scope works.
	Now it will actually enhance the visibility of NPCs like it was intended
	to in the first place.

	 - Added a new method to add items to corpses, or fake it anyway.  This
	means that instead of having to drop items near corpses, they can now be
	added to their inventory via script.  Or to rephrase, a few unique
	weapons you find near corpses will instead show up on them when you frob
	them.

	 - Noticed that I'd accidentally placed one of the unique weapons (one
	of the nanoswords) in two places.  To be more specific, I placed it in
	the new location without getting rid of the old placement.  The weapon
	will now only appear in the new location.

	 - Made the method of bullet spread calculation consistent between when
	a weapon is using a laser sight and when it is not.  With this last
	little change there is no functional difference between a weapon using
	a laser sight and not using a laser sight, other than being able to tell
	in advance where the shots are going to go.  This will make most weapons
	more inaccurate at long distances, but to be fair, the old method was
	horrid and unrealistic; the liklihood of you hitting a target was the
	same at 10 feet as it was at 200.

	 - Found a problem relating to NPC Random Inventory.  I accidentally
	screwed up and effectively disabled most of it, at least the part of it
	that randomly doled out anything but food and other consumables.  Now
	fixed.

	 - Slightly reworked NPC Random Inventory in a few places.  One change
	will make all kinds of non-alcoholic food (soda, candy, and soy food)
	items that can show up randomly.  Another change stops some of my code
	from checking an NPC for weapons once it has definitively determined
	what they are carrying in terms of weaponry, regardless of whether or
	not the loop has made it through all of their items.  This will save a
	tiny bit of time under certain circumstances.

	 - Reworked the check I put in place that excludes the Triad members in
	the Wanchai Tunnels from receiving NPC Random Inventory items.  The
	check will now only remove any additional weapons they are given, but
	will still let them carry any non-weapon items such as food, Zyme, some
	kinds of exotic ammo, and even weapon mods.

	 - Because I'm nice, and more to the point to prove that I can actually
	do it, I have modified the general conversation code so that it will not
	completely fail whenever a conversation is initiated but the
	corresponding sound file does not get loaded properly. Or to paraphrase,
	"OMG I CAN GAT ON TEH BOTE NOW!!1!!1! LOL"

	 - Per a suggestion on the GameFAQs message board I have added a minor
	perk to maxing out your Computer skill.  At Master level JC will be able
	to hack vending machines automatically, setting the cost of items from
	said vending machine to 0.  This does not apply to one specific vending
	machine early in the game however, though it is highly unlikely that you
	will have maxed out your computer skill by that time anyway.  Not
	impossible as such, but unlikely all the same.

	 - Finally made Ray (and a number of other NPCs) neutral.  This will
	stop those annoying deductions for killing said NPCs.  If you find any
	more NPCs that should be neutral, for point deduction reasons or just
	for thematic reasons, let me know.

	 - Buttons now light up a bit more obviously.  Trivial, I know, but I
	was really rather annoyed with how some buttons in dark corners would
	remain all but invisible even when they were activated.

	 - Added an upper limit to the amount of skillpoints you can have, based
	on a crash issue that supposedly exists according to it-he.org. The site
	claims that once you have enough skillpoints to max out 7 of your skills
	the game will crash the next time you save or change areas.  I have
	never encountered this personally, even with all mastered skills, but
	I've included a limit just to be safe anyway.  The upper limit is,
	coincidentally, the exact amount of skillpoints you get from the 
	"allskillpoints" cheat, more than enough to max out all your skills.

	 - Reworked the way accuracy is displayed and calculated.  The spread is
	now closer to what it was, just without the weird "the longer the range
	the tighter the spread is" thing.  I've also changed the crosshair
	and surrounding reticle to accurately reflect the true accuracy of any
	weapon, as in the past the spread only went to (roughly) the inside
	two-thirds of what the crosshair showed.

	 - Added reload sounds to the ILAW, and gave it scope capability.  I'm
	not sure if there's much point to adding a scope to the thing, but I
	figured that since the GEP Gun could have it the ILAW should be able to
	as well.

	 - Spruced up the Shotgun alt-fire.  When you load an extra round into
	the chamber it will now tell you what it's doing, and when you fire a
	shotgun with extra rounds in it there will be a small, slight delay
	between each burst; it's faster than you can fire the weapon, but still
	a wee bit slower than the Jackhammer's normal rate of fire.  At the very
	least it looks pretty darn cool, if you ask me anyway.

	 - Fixed an idiotic screwup in my code that would turn flagpoles
	invisible if you ran the game without HDTP installed.  Well, only the
	Chinese and USA flagpoles.

	 - Re-jiggered the new code that checks whether or not Paul Denton is
	dead after the 'Ton raid.  Before it was possible for Paul to be counted
	as dead even after he tells you he'll be fine and to meet up with him
	later, after which point he disappears.  In order to trigger this odd
	effect you had to leave via the window with at least one hostile still
	active within the 'Ton.  Rare, but it happens.  Now if Paul is no longer
	in the building he will be immediately counted as safe.

	 - Fixed a glitch with the new Office Storage system that would cause
	Augmentation Cannisters left in the room to wind up containing two
	randomly determined augs, rather than whatever they contained when you
	left them there.

	 - Made Fish, Birds, Rats, and Flies neutral by default.  This won't
	really have an effect on gameplay, other than all the aforementioned
	pest-type things showing up neutral in your crosshair.  However, it will
	provide "double protection" against getting dinged for skillpoints if
	you wind up killing some on accident.

	 - Remember that thing I supposedly added to v1.4 where Cigarette Smoke
	could randomly wind up doing a tear gas type effect?  No?  Well, I said
	I did, and apparently I lied about it.  Now smoke from Cigarettes will
	randomly (50-50 chance) inflict a tear gas effect on anybody it hits.

	 - Spruced up the Railgun a bit.  It will now hit whatever you point it
	at, though the method it uses to do this can be a bit, how shall we say,
	hacky.  The calculation is actually slightly faster than the old method,
	but those of you using older equipment (like stuff just barely meeting
	the recommended specs listed on the Deus Ex box) may want to brace for
	some slight lag when firing the Railgun.  Headshots aren't guaranteed
	yet either, so in the meantime it's an effective one-hit kill for most
	types of fleshy targets.  Oh yeah, while I was in there I restored the
	firing noise, which had been accidentally eliminated while I was fixing
	the "missing silenced Assault Rifle effects" issue.

	 - Coded in a manual override of the default scrambled bot behavior.
	The new code directly links the bot's alliances to those of whomever
	scrambled the bot. (The alliance checks are literally run through the
	scrambler now, rather than the bot)  This should at least get the AI to
	target and fire on potential enemies properly.

	 - Also cleaned up some code related to the above scrambled bot issue.
	The new code takes out some additional safeguards and checks rendered
	unnecessary by the new "alliance proxy" method described above.
	(Especially because they were causing problems with the way scramble
	grenades behave, or are supposed to anyway.)

	 - Did some minor work on Unrealistic, upgrading all NPCs to use the
	pre-specified "BRAINS_Human" intelligence template.  This does include
	animals.  The brief tests I have run show that NPCs are damn quick to
	react now, though you still have to get within normal range/etc.  I've
	also unlocked the template's ability to cause NPCs to trigger certain
	types of environmental effects if the AI is aware of them, though I have
	no idea yet what, if anything, this will cause them to do.

	 - Quickly coded in a temporary fix to stop Nicolette (and others) from
	running through path blocking obstacles like tanks.  The fix only
	applies to NPCs not actively carrying a weapon at the moment, so the
	MJ12 Commandos in the Lucky Money will still bust through the windows,
	for example.  This should, however, stop the Triad members from absently
	wandering back through unbroken windows after the carnage stops in the
	same level.

	 - Gave fishes corpses.  Previously you'd shoot them and they would just
	sort of freeze and then disappear.  This looked crappy, in my opinion.
	Now they'll turn upside-down and float to the surface.

	 - Brought back an oldie but goodie in a new form: killing Pigeons,
	commonly known as the Winged Rat, will occasionally produce an Un-
	Winged Rat rather than a Pigeon corpse.

	 - Started switching over the HDTP texture loading code to its own
	separate function in each of the relevant classes.  Once this is done I
	will be able to add code that will both allow the HDTP "facelift" to be
	applied at any time, as well as code that will temporarily switch all
	object skins and meshes back to the "base" DX versions when saving.
	This will allow for greater compatibility with saved games.

	 - Prevented carried decorations (trophies, boxes, etc.) from being
	forcibly thrown automatically when entering a conversation.  This could
	cause very odd results, such as key NPCs getting pissed at you because
	you just "attacked" them, to getting in an early, extra shot with a TNT
	crate when confonting Anna, Gunther, etc.

	 - Added optional support for new textures for the magnum, light rocket
	ammo and 10mm explosive ammo, created by Sergeant Kelly.  The textures
	will be included in an optional download, ShifterTextures.utx.  If you
	don't have the file the mod will work fine, it just won't load up the
	new textures. (Akin to how HDTP support works)

	 - Fixed a slight functional "oversight" with giving Gilbert Renton a
	weapon, one that's always driven me nuts.  While I couldn't expand the
	conversation menu so that it gives you multiple options of what to give
	him, rather giving you a choice between your best weapon and nothing, I
	was able to make it so that if you decide NOT to arm him you can change
	your mind later and give him a weapon by using the new "give weapon"
	feature used for Miguel.  The appropriate flags will be set just as if
	you'd given him a weapon in the conversation proper.  As a limitation
	of the method I used and an optional bonus, you gave give Mr. Renton
	just about any weapon you want, not just a pre-selected set of weapons
	like the conversation limits you to.  I recommend you give him a
	flamethrower so he can barbecue that f%$#head JoJo good.

	 - Related to the above, I did some advanced and careful tweaking of
	the conversation play code so that I can now start conversations at any
	point within the conversation, not just at the beginning.  I've used
	this to have Gilbert Renton thank you for giving him a weapon if you
	use the above optional weapon give method.

	 - Also related to the above, specifically my suggestion to give Mr.
	Renton a flamethrower, I added a function to his NPC class that will
	make sure he doesn't display a null animation when he holds any two-
	handed weapons, since the model used for Gilbert doesn't have an
	animation specifically for holding a two-handed weapon.

	 - Added a tiny bit of code to cats so they will attack rats, which
	coupled with the code I added to make them eat rat carcasses turns
	them into very effective rat-eliminating machines.

	 - It always bugged me that there was no real visual or auditory clue
	when the UNATCO troops at NSFHQ started to consider you an enemy.  Thus
	I've added in a bit of code so that when the alliance switch happens
	all the troops will reload their weapons quite audibly.  I'm working on
	having them stop for a moment as well, but I don't want to screw up any
	patrol routes they're on.

	 - Moved the body of the mechanic Ray (the Odd Mechanic) kills so that
	you don't damn near trip over it.  If you're observant it's still not
	very well hidden, but at least this way it looks like Ray put in SOME
	amount of effort.

	 - Added spark effects to melee hits that occur when the Electrostatic
	Discharge aug is on.  I have also used said spark to calculate whether
	or not a player has effectively hit a laser emitter with a melee hit,
	meaning that you can now actually use melee weapons to disable laser
	triggers a la Invisible War, albeit temporarily.

	 - Per a suggestion on the GameFAQs message board, (sorry, forgot who
	suggested it) I have adjusted the countdown sequence on wall-mounted
	grenades so that the higher the game's difficulty level, the less time
	you have to disarm the grenade.  On easy the time is the same, but on
	Realistic... well, the times range from just under eight seconds at
	Master Demolitions skill (a two second drop) to a quarter of a second
	at Untrained. (a three-quarter second drop)  Investing a few skill
	points in your Demolition skill is now advisable, to say the least.

	 - Did a little work on how the AI interacts with the various types of
	cloaking in the game.  Due to the somewhat rudimentary nature of the AI
	routines I am unable to get a realistic-feeling system in at this time,
	but I've included a fix so that NPCs won't follow you around with
	precise knowledge of your exact location while you're cloaked, though
	they will shoot at you just fine until the usual period of time has
	elapsed.  After that point they will have officially "lost" you.

	 - Adjusted the variables used in MissionScripts to add in custom email
	so that localization files (inTs) can override the contents.  This way
	the translation that Russian fan is working on will be able to affect
	said emails.

	 - Added in a new means to add custom text to any variety of so-called
	"Information Devices", including Data Cubes, Newspapers, and Books.
	This doesn't cover Public Info terminals, which I'll have to handle
	separately.  I have no idea what I'll do with this new power, but it's
	nice to know I can do something all the same.

	 - Added a location restriction on my "Paul won't converse with you in
	the 'Ton" fix.  The fix now limits it so that the conversation won't be
	started until you're actually inside the main room where you can see
	him, eliminiating the possibility of the conversation not starting
	because it was triggered while you were in his bedroom.

	 - Added an additional perk to having a higher Medicine skill level,
	along the lines of the existing bonus for Water Coolers and Water
	Fountains.  For each additional level of the Medicine skill, all food
	items will heal one addtional point of health.  You're welcome.

	 - While I was screwing around with food I thought I'd add a little
	code to Soda so that the new names don't show up in your inventory,
	since the four types of Soda are counted as one single type.  When you
	try to pick up any type of Soda it will simply be renamed "Soda" if
	you're successful, though you will still receive the brand-specific
	"you found some whatever" message.

	 - Placed some new code in the first mission so that you can now give
	Gunther a weapon later if you opt not to when you initially rescue him.
	Doing so will initiate the last part of the conversation in the same
	way that giving a weapon to Mr. Renton will.  Unlike the Renton
	situation though Gunther will ALWAYS be able to accept a weapon once
	you rescue him, should you decide to spoil him with a Sniper Rifle or
	PS20 or something.  (I'll work on making that worthwhile)

	 - Created a new method for adding custom bulletins to news terminals.
	Again, I have no idea what I'm going to do with this, but I figure
	there's no harm in futureproofing.

	 - Added in some beam visuals for the Railgun, specifically a green
	laser "trail" when you fire the weapon.  The effect doesn't behave
	precisely like I want it to, particularly in that it REFUSES to travel
	through walls and such.  I suspect this may be another annoying
	limitation of the Unreal 1 engine.  If it isn't though I will add the
	through-walls functionality for the visuals in the future.

	 - Added a check to the NPC weapon pick-up feature so that NPCs won't
	go after a weapon WHILE someone is holding it.  It typically only
	showed up when an NPC was equipped only with a low-damage hand-to-hand
	weapon, but the possibility existed for other situations.

	 - Finished moving all of the individual HDTP model/skin swap stuff in
	to separate functions, and created a "master" function which invokes
	them all.  This means that Shifter can now switch between normal and
	HDTP resources mid-game.  The function which does this is called
	GlobalFacelift, and can be run from the console. (e.g. "GlobalFacelift
	True" will load all HDTP resources, "GlobalFacelift False" will go back
	to the basic DeusEx stuff)

	 - Related to the above, I have included code so that whenever you save
	your game all HDTP resources will be temporarily unloaded while the
	game is saved, which (in theory) means that you can save a game on a
	computer with HDTP installed and load it on another one without HDTP.

	 - Also related, whenever you load a game the HDTP "Facelift" will be
	applied as soon as the map loads, meaning that if you have a game which
	was saved pre-Shifter or pre-HDTP you can now load it up and enjoy the
	HDTP goodness without having to wait until the next level change.

	 - Added code to the various Prototype Nanoswords which ensures that
	the "stasis field instability" effect doesn't occur when the weapon has
	been dropped.

	 - Prevented the "JC Office Storage" feature from tracking items you
	(or anybody else) currently have in inventory.  This should cut down on
	seemingly random items showing up as part of the office storage
	feature.

	 - Increased the probability of an NPC being given a better melee
	weapon in Unrealistic, and also added some ultra-powerful items to the
	Random Inventory list in Unrealistic.

	 - Per an observation by Kyle, I have made Juan Lebedev neutral.  While
	he can provide useful information, he is nonetheless technically a non-
	ally, non-enemy at that point.

	 - Fixed an issue where using Cigarettes while Zyming could make bullet
	time last forever.

	 - Ensured that Grays will actually gain health from being around
	sources of radiation.  (I was assuming they used a health system based
	on specific body parts, but they use an overall health total) Note that
	this fix does NOT apply to "Greys" from Zodiac, as they are actually a
	separate and new NPC class due to the necessary interaction from the
	E-Rifle.

	 - Okay, nevermind about that above bit that the Zodiac "Greys" won't
	heal from radiation, as I've added a custom function to the larger base
	class (Animal) which does specific checks for "Greys". (And Blues) I'll
	admit it's technically bad coding practice to do something like that,
	but given that I can't really mod Zodiac itself I had little choice.

	 - Changed Air Bubbles so that they can be assigned to spawn a specific
	something-or-other when they break the surface.  I promptly used said
	ability to make Air Bubbles created by Flares spawn smoke once they
	break the surface of water.

	 - Finalized code which will allow NPCs searching for weapons to frob
	corpses to get said weapons.  There's a limit in place to prevent them
	from picking up Unique weapons, just in case.

	 - Added some simple code to make Grays (non-Zodiac) try to search out
	Radiation areas when they are fleeing.  There's a lot missing from the
	AI flee routines as it is so it's not perfect right now, but in theory
	you may see a Gray or two run towards an area of Radiation once you've
	shot them enough to make 'em flee.

	 - Started breaking up what I call the "HK Unique Weapon Clusterfuck".
	In v1.7.2 there were 5 Uniques in the HK area, nearly half of the total
	Unique Weapons available in the game.  I'll admit that HK is a large
	and lengthy section of the game, but it's not THAT long and lengthy.
	For reference, I'm moving the Toxin Blade and one of the Prototype
	Nanoswords.  I'd considered moving the ILAW, but since that location is
	so difficult to reach (and the ILAW is available later) I saw no harm
	in leaving it there.

	 - Reworked the way the Railgun and Precision Rifle's custom scope
	effects are implemented.  Rather than piggybacking on the existing
	Vision augmentation system, the new method performs a few fancy moves
	inside the existing scope code.  This new method is far simpler than
	the old method, and as such I've removed the unnecessary extra windows
	which the old method would draw. (e.g. the outer IR amp window)  As a
	side effect this does somewhat limit the visible FOV of the through-
	walls view on the Railgun's scope, but to be fair the old method didn't
	really simulate a thermal scope very well.

	 - Redid how the scope function checks whether or not the Targeting aug
	is responsible for zooming the weapon.  If the zoom level available
	from the Targeting aug is equal to that of the weapon in use the scope
	function will assume that the Targeting aug is responsible, and thus
	will not draw the "blinders" around the screen.

	 - Changed the Targeting aug a tiny bit so that when you press the F8
	key to disable the target window it won't play the "aug off" sound.
	That was a bit confusing.

	 - Also updated the Targeting aug to use the Familiar Names of people
	it targets, rather than the "BindName", a lovely run-on name used
	mostly for internal conversation purposes and little else.

	 - Fixed the issue where picking up unconscious folks and then dropping
	them elsewhere would cause their display name to revert to the basic
	"Unconscious", rather than the more specific names I've set them up to
	display.

	 - Added in some code for any NPCs that are part of the Animal class
	which will check that the model used by the NPC has an animation before
	it attempts to play it in a conversation.  This will dramatically cut
	down on the number of script errors which show up in the log for mods
	that use Animals as conversing NPCs. (Which, as I've discovered, also
	improves overall stability)

	 - Rejiggered my "OMG I CAN GAT ON TEH BOTE NOW!!1! LOL" fix so that it
	only works on non-interactive conversations, e.g those you cannot use
	the mouse to click through quickly.  Combined with the above fix, which
	as I mentioned greatly improves stability, this means you can actually
	listen to the entire "Manderley raps" section of the Malkavian mod
	without the game crashing on you.  Well... sometimes, anyway.

	 - Included a fix to prevent NPCs marked as Invincible from dropping
	their weapons or taking any sort of damage.  The old code merely would
	prevent their main health from dropping, but would allow damage to be
	done to specific areas such as the arms and legs, which in turn could
	cause the NPC to drop their weapon and start running.

	 - Created a new "Cycling" option for consumables; just like for
	Lockpicks, Multitools, etc. it's activated by pressing the Change Ammo
	key.  This new cycling ability will go through the following items:
	Candy Bars, Forties, Liquor, Soda, Soy Food, Wine, and Zyme.

	 - While I was messing with cycling I adjusted the existing routine for
	Lockpicks/etc. so that it won't cycle to items already in a belt slot.
	Previously you could, say, cycle between lockpicks and multitools while
	both were in your item belt and wind up with one of the items taking up
	two full slots.

	- Also in there, I've moved the text notifications of the switches from
	hardcoded strings to localized variables stored in the DeusExPickup
	class.  This means that the Russian fan who is translating Shifter via
	the DeusEx.inT file will have one more thing to translate.

	 - Started making the various different-skinned consumables such that
	when you pick them up it keeps track of the type and order of them.
	This means that when you use or drop them the one left in your hand
	or inventory will change to whatever color/skin/etc. the NEXT one is.
	So far this applies to Soda and Forties.  I may do it to Candy Bars as
	well, though I'm not sure.

	 - As part of the aforementioned upgrade to consumables Forties will
	not always display the HDTP skin, since there's only one HDTP skin vs.
	four standard Deus Ex skins for Forties.  People using HDTP will still
	see the HDTP model/skin for the most common type of Forty, but may come
	across a few others using the old-school alternate textures from time
	to time.  (Depends on the map, actually)

	 - And since I was spending so much pointless effort screwing around
	with Soda I figured I might as well spruce it up EVEN MORE.  Therefore,
	the name displayed in the item belt will changed based on which soda
	you have.  This is useful, because each different soda type will heal a
	different amount.  Nuke heals at 2, Zap (as per Zodiac) heals at 3, and
	so on.

	 - And while we're on the subject of Zap, it occured to me that just	
	because I started screwing around with DynamicLoadObject just so I
	could make Shifter HDTP compatible doesn't mean I have to limit myself
	to that end.  Therefore if you have Zodiac installed Zap! soda will use
	the special Zap! icons.  Thanks to the recent HDTP-related upgrades
	I've made this won't even pose a problem with savegames/etc.

	- And also related to Zap! soda, all instances of Zap! soda within
	Zodiac will be automagically replaced with the Shifter version of Zap,
	which is only different in that it stacks with your normal soda, plus
	the fact that it will heal more based on your medicine skill.

	 - Since I'm on a Zodiac/Shifter crossover kick I thought I'd make sure
	the E-Rifle has the same 1-in-10 chance of setting normal Grays on fire
	that it does when used on Zodiac "Greys".  Sure, you can't get the
	E-Rifle into a Shifter game without cheating, but I figure eh, what the
	hell, why not?

	- Made sure that the Alien Spy in Zodiac gets counted in that whole
	"Radiation heals aliens" bit I described before.  I think that's the
	last of the Zodiac compatibility crap left to do.

	 - Nope, not the last bit of Zodiac compatibility.  I've added code so
	that C4 is now included in the cycling feature of grenades.  Enjoy.

	 - Added a little code so that when you use up one type of grenade it
	will automatically switch to the next grenade type and fill the old
	grenade's belt slot if any other grenades are available.

	 - Changed the Article variable on the Blackjack so that when you pick
	it up it says you found "Paul's Blackjack", not "a Blackjack".

	 - Did a little bit of behind-the-scenes work with the various items
	that I've made to benefit from having a higher Medicine skill level.
	The code should work exactly the same, but is far more efficient.

	 - Enabled Dodging (double-tap a direction key) in Unrealistic.  It
	might not be particularly useful yet, but it probably will be once I
	start making NPCs able to dodge as well.

	 - If an NPC who is afraid of bodies gets hit by some chunks o' flesh
	they will now get very afraid.  Not that gibbing someone just a few
	feet from 'em shouldn't already make them afraid, but y'know.

	 - NPCs who are fleeing merely due to not having a weapon but otherwise
	are capable and willing to fight will now seek out weapons, even from
	corpses so long as they aren't afraid of 'em.  You probably won't see
	this in action very much since it takes something special to disarm an
	NPC without getting them to the point where they should flee.

	 - Fixed a glitch with the new "grenade replacement" stuff which would
	cause them to switch every time you used one, not just if it was out of
	ammo like I intended.

	 - Added Cigarettes to the "Consumables" cycling ability. Not including
	them the first time around was an oversight.

	 - Added a check into the multiplayer component to prevent people from
	modifying their ini files to spawn with an invalid player class.  It's
	not really a big problem since the most you would wind up with is an
	unusable player model, but there should still be a check there.

	 - Finally managed to get the new HDTP model and skin for Valves
	working.  Turns out there was a new mesh, something that was not noted
	in the installer or even present in HDTP code.

	 - Due do a bout of coding overload mixed with boredom mixed with being
	re-acquainted with a particularly funny image on FARK, I've added a new
	skin for the "Caution Wet Floor" signs that will show up randomly, so
	long as you have the optional ShifterTextures package.  To give you an
	idea of what kind of image it is, the variable which tracks whether or
	not it's enabled is called "bSmartass".

	 - Prevented firing animations from being played when activating a
	weapon's scope via the Alt-Fire button.

	 - Restored an unused (well, mostly unused) sound for Rats.  Turns out
	that three separate squeak sounds are included in the game, but two of
	them are supposedly only for when they're hurt.  One does indeed sound
	like a cry of pain, but the other one is just another generic-sounding
	rat noise. (Bruxing, I think)

	 - Set the "bHasAltFire" variable for a few weapons like the Crowbar,
	Baton, and various shotguns.  I didn't have to set these in the past
	because the "throw" method for hand-to-hand weapons and alt-fire for
	shotguns involved overriding the AltFire function directly.  Due to the
	new code I've put in place to stop fire animations from being played on
	weapons without alt-fire, however, those overridden functions never get
	called unless the variable is set.

	 - Incorporated the "custom transfers" fix for mod conversations into
	the Shifter conversation class.  This means that any mods that use
	Shifter as a "base" will not need to create a package with their own
	special player class and conversation class in order to have convos
	where the player is given items that are part of the mod.

	 - Removed some old code which could theoretically prevent any weapon
	with an alt-fire AND alternate ammo from using the "Change Ammo" key.
	I say theoretically because a number of shotguns fall into that very
	category and work just fine.  Still, there's no reason for the code to
	be there anymore.

	 - Added in support for Sgt. Kelly's new skins and icons for the Magnum
	and Rate of Fire mod, which truth be told are pretty damn neat looking.
	The new textures are switched out in the same way that HDTP stuff is
	handled, so saving won't be an issue.

	 - ACTUALLY fixed the "invisible alarm panel" glitch.  It looks like it
	was due to a problem with my implementation of the new HDTP stuff,
	mostly owing to the fact that the new HDTP mesh for the alarm panel did
	not specify any skins.

	 - Changed the DrugEffectTimer in the player class to be a "travel"
	variable.  This means that when you change maps while drunk you won't
	suddenly lose or gain your zyme abilities or drunk status.

	 - Related to the above, added in some code to maintain game speed from
	map to map.  There's a tiny bit of lag after level load before the new
	speed is set, but it's still better than nothing.

	 - Fixed an issue with the code I added to allow me to add new email to
	computer terminals, which was preventing me from adding in another bit
	of additional flavor to the game.

	 - Reworked Office Storage a little to ensure that heavy weapons are
	placed on the ground properly.

	 - Moved support for searching sounds/etc. from the Robot class to the
	more generic ScriptedPawn class.  This means that for NPCs I can have
	them emit certain sounds rather than specified barks when certain
	things happen, e.g. when they spot someone.

	 - Fixed some issues I didn't even know I had with giving NPCs weapons
	and the ammo for said weapons in various functions.  While I was giving
	them ammo, I wasn't setting the variable in their weapons which tracked
	what ammo went to the gun.

	 - Changed the article on a number of Unique weapons to "the", so when
	you pick them up it will say (for example) "the Boomstick", rather than
	"a Boomstick".

	 - Slightly reworked how the script-given email is processed by my new
	method.  Before it would simply stop once it got to an entry that was
	blank; now it'll actually check the entire list of new email, just in
	case there's email, say, at the end of the list or something.

	 - Reworked JC Office Storage a little so it positions the items right
	and also works from mission 4 to mission 5.  Well, sort of on the last
	bit.  It works, but differently.  See below.

	 - Added in a new grouping of content I call "The Downward Spiral of
	Daniel Matsuma: an Interactive Drama in Three Acts."  It's related to
	the Office Storage feature, and will be most obvious during the escape
	from UNATCO in mission 5.

	 - Fixed the music in Hell's Kitchen the last time you make it back, or
	rather fixed the lack OF music.  The new method allows me to specify a
	"backup" music name in missionscript, which so far is only used for the
	final Hell's Kitchen map.

	 - Related to the music fix, changed the Play Music cheat window so
	that it won't stop the music if there's no music to go back to.  This
	will only be relevant on the aforementioned NYC Streets map (only for
	Game Of The Year users) plus any mod maps which have no music set.

	 - Fixed a problem in my code which could show up when a hand-to-hand
	weapon with ammo ran out of ammo.  (An infinite loop actually)  All
	a-ok now.

	v1.7.2: (BUGFIX RELEASE, PART DEUX)

	 - Cleaned up some issues relating to NPCs picking up weapons, in
	particular a few odd issues with "ghost" weapons floating around
	connected to them.

	 - Fixed a minor visual issue with the new water splash effects, pointed
	out to me by a German fan of Shifter.  (Yup, we've gone international)
	X Mulder/Lucius DeBeers pointed out that hand-to-hand weapons were
	creating water rings when the weapon didn't appear to break the surface
	of the water.  Hand-to-hand weapons will no longer produce water rings,
	unless they are thrown via alt-fire.

	 - Did a little more fixing on the "give weapons to NPCs" functionality.
	There was a minor issue with giving the NPC an ammo object it already
	had, which could cause a serious headache and some potential screw ups.
	Also, I added something that makes absolutely sure that when the NPC is
	given ammo they are given a generous amount, lest they be unable to fire
	the weapon.

	 - May have fixed the "locking weapons"/"locking baton" issue, or at
	least one version of it.  It appears to occur when, by some fluke, some
	of the items that a corpse supposedly holds are actually the items in
	the player's inventory.  The Frob function now will skip over any items
	that are "owned" by the player; depending on which item the corpse and
	the player "share" you may or may not get all (or any) of the items that
	the corpse should have.  Thanks to Radical R for providing me with a
	gamesave that allowed me to test this repeatedly.


	v1.7.1: (BUGFIX RELEASE)

	 - Fixed a scripting issue inside the NYC helibase area which could
	cause a ghost Tracer Tong and Juan Lebedev to show up unexpectedly
	above the helicopter.  This occasionally would lead to one or both of
	them winding up dead.  Also cleaned up the code so it does a few
	maintenance-type things when the conversation is finally done.

	 - Fixed some problems with the new "give weapons to NPCs" feature,
	specifically the problems with inventory carrying over and ammo
	sometimes disappearing when you give NPCs a weapon.

	 - Disabled the new HDTP textures for valves, as they don't seem to show
	up properly.  I assume this is because they are just unfinished, so this
	is only temporary until HDTP is fully released.

	 - Fixed a problem where zooming an unscoped weapon with the Targeting
	aug and then turning the aug off could leave you stuck in the zoomed
	view.  Disabling the aug while zoomed with an unscoped weapon will first
	drop you out of zoomed mode.  Just in case that doesn't cut it I have
	made absolutely sure that you can hit the Scope Toggle or Alt Fire
	buttons to unzoom, no matter what the circumstances.

	 - While I was at it I put in a quick fix to stop the MJ12 Troops hiding
	in Maggie Chow's apartment from randomly saying things that prematurely
	alert you to their presence.  Not that anybody playing Shifter is likely
	to NOT know they're there anyway, but still....

	 - Cleaned up a few script warning spam issues about "so and so accessed
	none" and blabbity blah blah blah.


	v1.7:

	 - Made it so Grays are healed by Radiation damage.  In the past they
	just ignored it, but it made me ask the question, "then why do they all
	hang out near radioactive waste?"  Made more sense this way.  I doubt
	it'll have a huge impact on the game, but flavor-wise it's dead on.

	 - Fixed a problem which has driven me nuts, NUTS I say since I got my
	21" monitor o' doom: the game only recognizes 16 resolutions, starting
	with 640x480.  That's great and all for 7 years ago, but my monitor can
	do up to 1920x1440, and I LIKE it at 1920x1440.  I don't like having to
	hack my DeusEx.ini file to get it there.  On the Deus Ex side it won't
	be an issue, as the game can now register up to 48 resolutions.
	However, there are some limitations with the Direct3D implementation
	used by the game, so if you use Direct3D render mode you will still
	only be able to select 1280x1024 in-game.  I highly suggest you use the
	"updated" OpenGL library instead, as it works better, looks better and
	does not have any of these limitations.

	 - Added simple splash effects for projectiles when then enter and leave
	water.  You will see a ring where the projectile entered as well as a
	water spout, though the latter will only be created if you have your
	world detail level set to "high".  I doubt any of you are still running
	Deus Ex on legacy equipment, but if you are you won't have to suffer
	through slowdown from all the neat effects I put in.

	 - Started creating an "Unrealistic" difficulty level, because some of
	us need a better challenge.  How challenging?  The first step I've done
	is to make all NPC bullet weapons shoot explosive rounds.

	 - Changed the way NPCs burn a bit more so that the "transition" between
	dying NPC on fire and dead NPC on fire is seamless.  Instead of creating
	new Fire objects it will simply move the existing ones smoothly.  Also
	resolved the occasional issue where corpses would spawn on TOP of the
	fire and float in mid-air.  Well, mostly.  There are some inadequacies
	in the Unreal engine that I can't fix.

	 - Related to splash effects, I discovered that air bubbles don't "pop"
	when they hit the surface, they just disappear.  I've changed it so they
	make a little ripple in the surface when they hit and disappear.  They
	will also now fade out if they're around for too long, rather than just
	vanishing underwater.

	 - Related to Unrealistic, did some diddling with explosive rounds.  It
	turns out that the built-in function that handles explosion damage/etc.,
	well, sucks.  I've modified it so at the very least if you shoot an NPC
	with an explosive round they will take the full 5x damage. (3x for bots)
	Whether anything in the area will take damage is not guaranteed.

	 - Started fixing up Flares.  Yeah, you heard me, Flares.  You thought I
	was joking when I said I would, didn't you?  Anyway, I've lengthened the
	burn time, up to 6 minutes from the usual 30 seconds.  It's still a lot
	less than a real Flare would burn for, but it's a lot more believable
	than 30 seconds.  I also made it so they continue to burn under water
	(also like real Flares) and will let off bubbles as they do so, rather
	than big puffs of smoke.  (which just looks silly under water)

	 - Fixed up some stuff on animals, particularly certain animals (like
	cats) and why they don't eat certain other dead animals (like rats).
	Also tweaked the scripts so you can now knock out animals.  I mean,
	y'know, 'cause I'm SURE those rats you killed kept you up at night.

	 - Redid the way dead bodies are named, or at least the way the names
	show up.  The itemName field is still the same, as I discovered while
	I was rooting around in some missionscripts that other mods rely on the
	name being "Unconscious" *exactly* to count someone as unconscious. I've
	used another variable to store the new display name, with the previous
	variable still using the old display name and being kept for both the
	purposes of missionscripts in other mods, as well as a fallback in case
	the new-format display name is somehow not set.

	 - And while I was in Mission 2's missionscript I completely recoded the
	Castle Clinton slaughter check.  As it was if any of the corpses or
	unconscious folks were somehow destroyed it would count you as having
	slaughtered them.  On top of that the check would keep going even after
	all the terrorists were unconscious or dead.  Bad bad coding.  Fixed
	now, much more logical.

	 - Fixed something with my customizeable vending machines which could
	overwrite the name of the product if you set it prior to the start of
	the mission. (e.g. built a map with it in there)

	 - After a rather serious flaw with the new laser mod system was pointed
	out to me by jetsetlemming I've "tooled up" the laser sight a bit more.
	Now it will "jump" with each shot, as realistically your aim would be
	jarred a bit.  The "jump" will only be within your current accuracy.

	 - Fixed the Aggresive Defense System, as it was able to "detonate"
	things like fire from the Flamethrower, Throwing Knives, and Darts.
	Obviously this was, well, unrealistic.  It is now limited to detonating
	all variety of Rockets and Plasma Bolts.

	 - Added a pretty fire effect to flare darts, and made them generate air
	bubbles when under water.  This is purely aesthetic and has no effect on
	gameplay.

	 - Removed an erroneous description on the Assault Rifle which said it
	could take 10mm ammo, left over from the days when I was having problems
	with the ammo amounts for the weapon.

	 - Fixed up the Shotguns slightly and stopped the alt-fire from allowing
	you to load up more than one clip into the shotgun for simul-fire.  Once
	you reload you will clear any packed shells in the weapon.

	 - I was going to add in a new shotgun ammo type, as suggested by
	Gdog4ever, but I got distracted by HDTP. (And the fact that I couldn't
	make the visual effect not look like crap)  The ammo type is there, but
	it doesn't really work yet.  I'll finish it in v1.8.

	 - Restored a conversation you can overhear between Lebedev and someone
	else which was left out of the original game for some unknown reason.
	It isn't impossible to miss like it was in the v1.7 WIP build, but it's
	pretty convenient all the same.

	 - Added in full HDTP compatibility for the new HDTP Release #1.
	Shifter will use the HDTP models and textures when available, and
	default to the original Deus Ex ones when not.  This may cause some
	issues for multiplayer between clients using/not using HDTP, so I may
	later disable HDTP textures for multiplayer matches.

	 - Added in another case that ensures mission scripts are spawned for
	every mission, even in mods.  The existing code defaulted to base DX
	missions, which caused a problem when running mods like Zodiac/etc.,
	which in turn caused a number of complaints about weapons and items not
	working in certain levels.  Now fixed.  Hooray!

	 - Fixed an infrequent problem you can run into in Hong Kong if you
	don't leave the Luminous Path compound via the door.  Once you get
	inside the compound properly (i.e. Gordon Quick lets you in) the Triad
	members won't turn against you if you then jump over the wall/etc.

	 - Restored another unused conversation, or more of an overheard bit of
	speech really.  Actually, it's a voice mail.  That should be a fairly
	good clue as to what you might have to do to find it.

	 - Be on the lookout for a new skillpoint opportunity: the Public
	Hygene Awareness Bonus.  You'll laugh when you find it.  Really.

	 - In traipsing (did I spell that right?) through the various Deus Ex
	texture packages in the course of my HDTP compatibility updates I came
	across some oddly unused textures.  If any of you have played Zodiac you
	may remember the soda "Zap!"  I thought it was a new texture in the
	Zodiac mod, but apparently it's an unused texture in normal Deus Ex.
	I've now added functionality to Soda cans so they will somewhat randomly
	use the new textures, excepting those that are "clustered". (e.g. the
	shelves full of "Nuke!" in the HK underground market.)

	 - Also while I was poking around in there I found an unused texture for
	candy bars, which I've added in much the same manner as above.

	 - Did some work on the AI combat routines.  If an NPC is attacking and
	either a) is only using melee weapons, or b) randomly decides to find a
	better weapon, they will go to the nearest better weapon and pick it up,
	at least within a certain range.

	 - While I was modifying NPCs I made sure that any flesh chunks you get
	from an exploded NPC will have the appropriate velocity, rather than
	just dropping straight down.  I think this looks better, or at least
	more realistic, than the old method.

	 - I decided to go for something a bit more direct with Miguel, and have
	now added in a new method to allow you to give items to certain NPCs.
	All you have to do is press "Drop Item" when you get close enough to
	certain NPCs. (So far only Miguel)  You'll get some text on the screen
	telling you what to do when you're close enough.  This only works for
	weapons.

	 - The questionable physics engine in Deus Ex has always driven me a bit
	batty at times, particularly the way certain items behave when they are
	falling.  Carts were one such item, especially how you could roll them
	when they were on the ground, but throwing them in one direction would
	only result in them stopping abruptly when they landed.  Carts will now
	roll after they land, in a way that at least vaguely approximates actual
	physics.

	 - Did a little bit of code cleanup to prevent some of those random "so
	and so tried to access None" messages in the log from showing up.  Some
	of it was due to my additions, but a surprising amount was from what was
	already present in Deus Ex to begin with.

	 - Finally made it so you get points for disabling a robot with EMP.
	Also, you will no longer get points for hacking a disabled robot to
	pieces.  It only seemed fair.

	 - Long ago someone joked about how Walton Simons must swing by JC's
	office every time he leaves to steal all the things he leaves behind.
	"I mean, what does he think it is, a storage locker?"  Yeah, well I was
	a little bored and decide to make it so you can store things in your
	office between missions.  It'll even keep track of what mods you've
	added to weapons and so forth.  Go hog wild.

	 - Discovered that there's a datacube in the MJ12 HQ in UNATCO that
	invariably falls through the walls of the level and is thusly destroyed
	before you can read it.  I've now placed a copy of it in roughly the
	same place as it starts out, only on top of the table, rather than
	inside it.  Worst case scenario: you'll find two of the same datacube
	stacked on top of one another.

	 - Another purely aesthetic change, I've now made it so that your item
	belt is cleared out BEFORE you are sent to the MJ12 HQ, rather than as
	the game is removing all your items.  The items will still be in your
	inventory for that split second, so all of you folks who like to cheat
	and drop your items real quick can still do it.

	 - Added a limit to how many shells you can "pack" into the shotguns,
	based on your associated skill level.  At Untrained you can pack in one
	shell, but at Master you can pack in four.  This will both prevent some
	serious possible abuse of the weapon as well as keeping the Jackhammer
	worth picking up.

	 - One of the other illogical things about the game that has always
	bugged me is why, when the MJ12 folks disarm you, do they not take your
	Credits and your NanoKey Ring as well?  The NanoKey Ring isn't something
	I can exactly address easily, particularly because you kind of need it
	to get through some parts of the level, but the credits were easy enough
	to handle.  You'll now wake up in the cell with no credits, as they will
	have been confiscated and taken to the Armory along with the rest of
	your goodies.

	 - Changed the way the Combat Knife code is written so that any items
	which are based off of it (child classes) will not have the Alt-Fire
	functionality by default.  This used to be a specific exclusion for the
	Toxin Blade, but I thought I'd make it generic, lest some other mod have
	a really cool knife that winds up getting borked due to my alt-fire
	throwing code.


	v1.6:

	 - Modified NPC Random Inventory a little more.  The recursive check
	which tracks NPCs that might get a weapon now will stop if all NPCs have
	been given random inventory.  This means slightly less CPU usage, which
	is a good thing.

	 - I was reading some posts on DXEditing.com's forums and came across a
	post which pointed out that the "random" option for the spawn and patrol
	point functions in the MissionScript.uc file does nothing due to badly
	written code.  I've changed it so it now works.  I'm not sure what
	effect this will have on the game, but if you notice any NPCs that seem
	to change locations or patrol areas every time you go into a map (except
	for the Goth in the Hong Kong market) do let me know.

	 - Also in the same post it was mentioned that you can shoot at the Bob
	Page hologram in the Vandenberg base and he'll jump off of the holo
	projector and start running around.  While I find this terribly amusing
	I thought I should fix it.  No more fleeing ghost-Page.

	 - In yet another post there was mention of how you could get Paul to
	follow you around in the first mission and kill everyone, yet still have
	him compliment you on your restraint.  This too has been fixed.  Paul
	will now only use non-lethal weapons in the first mission.  You can
	still get him to follow you around, but he'll only knock out Terrorists.

	 - Slowed down all sounds when using Zyme.  I hope you'll find that the
	"bullet time" atmosphere is improved by this change.

 	 - Changed the way the DeusEx.u file is compiled so that it doesn't
	include the UBrowser and UWindow classes in it.  This means the average
	filesize should be around 5.4 MB, versus 6.1 MB.

	 - Added in an actual Alt-Fire button and fire method, heavily borrowed
	from the Hardcore mod.  For weapons without Alt-Fire modes this will
	simply toggle the scope if the weapon has one.  The only weapon this
	will prove problematic for is the Plasma Rifle, which has both an
	Alt-Fire mode and Scope capability.

	 - Related to Alt-Fire, the Combat Knife now has an "Alt-Fire Mode":
	throwing the knife at whatever.  To compliment this you can now carry
	six (6) combat knives at once, a la Solider of Fortune.  The damage from
	a thrown Combat Knife is fairly impressive, but not much higher than a
	Throwing Knife.

	 - Still yet even MORE related to Alt-Fire, most Hand-to-Hand weapons
	are now throwable like the Combat Knife, though you can only carry one
	of each on all but the Combat Knife.

	 - Also inspired by Hardcore, the crosshair will now turn blue when you
	look at neutral NPCs, rather than green.  Friendly NPCs will still show
	up green.

	 - Added a "lethality" check, at the moment only used for the Toxin
	Blade.  The means if you stab someone with the Toxin Blade and they pass
	out from the poison later they'll be unconscious, but if you stab 'em to
	death they will be, in fact, dead.

	 - Modified the new skillpoint system so it tracks whether or not you
	killed someone with a hand to hand weapon.  This means the skillpoint
	bonuses for bonking NPCs on the head with the Baton, etc., have gone
	away.  I still recommend you bonk 'em on the head though, since it does
	8x damage when you do. (That's from Deus Ex, not Shifter)

	 - In a surprising show of aesthetics I have modified the Vision aug so
	that when you look at a hologram with the Vision aug on (level 3+) it
	will be rendered a la The Matrix.  The same is true for the Railgun's
	scope.  You'll probably only get a chance to see this in the Vandenberg
	lab, when Bob Page shows up to heckle you.

	 - FINALLY included a working "stealth bonus" skillpoint system.  At the
	moment you need to get within a certain range of the NPC for the bonus
	to accumulate, and it will be reduced by doing things like making a
	noise, being spotted briefly/completely, etc.  If you kill/KO the NPC
	you won't get any stealth points.  Points accumulate during the course
	of a mission and are awarded during mission changes.  This does mean
	that the final mission's stealth bonuses will not be awarded.  The new
	system should work with any other mod, as per usual.

	 - Changed the number of slugs the Boomstick and Jackhammer put out, up
	to 15 from 12.  The Boomstick's damage per shot is back down to 30, but
	the Jackhammer's damage per shot is up to 15.

	 - "Fixed" the interaction between the Laser Sight and Scope mods.  If
	you have a Laser Sight on a weapon with a Scope you will no longer take
	an accuracy penalty if you don't zoom in using the Scope.

	 - Added in the other half of my modifications to the Augmentation
	installation/upgrade system.  Now if you want to replace an existing aug
	with a new one you just picked up you can.  You will also get all the
	upgrades the previous augmentation had.  As with the upgrades, this can
	only be done at a medbot.  In the process of doing this I also fixed an
	error in the new system which allowed you to use Aug Canisters to
	upgrade an aug past its maximum level.

	 - Related to this, fixed a glitch -- pointed out to me by des223 on the
	GameFAQs message boards -- which made it impossible to upgrade an
	augmentation using an aug canister when you had more than one of them in
	your inventory.

	 - Reworked the "Assault Rifle Sound Fix" a little so that the sounds
	from the Flamethrower and Pepper Spray sound normal again, as the fix
	had made them a bit stuttered.

	 - Also on the Flamethrower, gave it an Alt-Fire which jettisons a half
	tank of napalm, then ignites it.  The resulting incendiary death bomb
	will set anything on fire it doesn't outright kill.

	 - Modified NPC Random Inventory again, this time removing the exemption
	on Triad members.  In the past allowing the Triads to carry random items
	had made the fight in the HK tunnel a little surreal.  I've since added
	a check into the mission script which removes any random items from
	those Triad members and those only.  All other Triad members are fair
	game.

	 - Rebreather no longer instantly refills your oxygen meter.  It now
	provides a gradual refill.  This should remove the exploit provided by
	making "charged" items toggleable.

	 - Added in a new method to create email in the game.  This means I can
	add in textual clues for the extra stuff I make.  Whoopee!  Oh yes, so
	that the implication is completely obvious: hint hint, I already have.

	 - Tech Goggles will now work like a less-powerful Level 4 Vision aug.
	The range of the through-walls vision is limited, so as not to make
	the Vision aug useless.  Hopefully this will make Tech Goggles worth
	picking up early in the game.

	 - Fixed the longstanding Deus Ex problem where starting a new game
	while playing an existing game would cause many items to carry over to
	the new game.  You should now start with a clean, default inventory
	whenever you decide to start a new game.

	 - Created the Blackjack, another Unique Weapon, on a whim.  The
	Blackjack is a suped-up Baton, carrying some extra weight and thusly
	some extra punch.  Paul carries this weapon in the first mission.  No,
	you cannot kill him to get it.

	 - Removed skillpoint deductions for fish.  Yeah, fish.  I forgot that
	they're able to be killed.  On the plus side, if you happen to find a
	particularly hostile trout you'll get points for killing it.

	 - Changed the placement of the Magnum to somewhere a bit more logical.
	It's still in the same area, just not quite the same place.

	 - Fixed the exclusion in the MJ12 capture sequence where your grenade
	counts are reset after your items are "confiscated".  The LAMs, Gas
	Grenades, EMP Grenades, and Scramble Grenades you pick up in the armory
	should now reflect your actual ammo amounts.

	 - Also in the MJ12 capture sequence, removed the exploit that allowed
	you to open the inventory screen really quick and drop all your stuff
	before it was confiscated from you.  The fix is only present if cheats
	are disabled, similar to the Inventory Overlap fix.

	 - Fixed a glitch pointed out by Zak X on the GameFAQs message board
	which would put the player into infinite bullet time whenever they were
	shot with a Poison Dart, or (highly uncommon) if they were able to drink
	enough alcohol to make them drunk while Zyme-ing.

	 - Taking another suggestion from ASG on the GameFAQs Message Boards, I
	have added in the Prototype NanoSword, a Unique Weapon.  This is an
	early version of the Dragon's Tooth, taking less inventory space but
	also packing less of a punch.  Due to widely ranging opinions on which
	of three colors the weapon should be there are three separate versions
	of the sword, each with its own unique stats.

	 - For convenience, Vending Machines will now display the credit cost in
	their display name.  The credit cost will be replaced by "empty" if the
	machine is empty.  They will also display the product they sell.

	 - Finally added in the range reading for the Laser Sight mod.  The
	reading is color-coded: green means you're within the gun's accurate
	range, yellow means you're outside the accurate range, and red means the
	distance is greater than the gun's maximum range.

	 - Changed the Alt-Fire for the Plasma Rifle.  It will now shoot several
	low damage Plasma bolts which will bounce a number of times before they
	expire.  At each bounce they will do damage.

	 - Placed Explosive 10mm ammo in a few places in the game.  The ammo is
	also a part of NPC Random Inventory; once you pick up an actual box of
	the ammo you should be able to get it from any NPCs who are given it via
	NPC Random Inventory.

	 - Actually fixed the "ghost laser sight" problem in the MJ12 "capture"
	sequence.

	 - Modified the check in the Castle Clinton area so that it won't give
	you a bloodthirsty reputation if Anna or the UNATCO troops kill some of
	the NSF.

	 - Fixed a problem with the ILAW which wouldn't leave ammo on the MJ12
	Commandos when they died.

	 - Removed skillpoint bonuses for killing neutral NPCs, because there's
	really no skill in doing that.

	 - Modified the Recoil and Reload display in the inventory screen to
	calculate the changes due to weapon skill in addition to those from
	weapon mods.  Gracias to des223 for pointing out that the display lacked
	that information.

	 - Fixed a last-minute glitch pointed out to me by jellyfish007 which
	prevented the JackHammer from doing damage when using Sabot shells.

	 - Fixed another last-minute glitch pointed out by ASG where you could
	use the Skull Gun augmentation by pressing the Activate All Augs key,
	even if you didn't have the aug installed.

	 - Changed the version info at the bottom of the Main Menu so that it
	displays Shifter's version info instead of Deus Ex's.

	 - Changed the door display so that it will let you know the minimum
	amount of damage required to damage a breakable door.

	 - Related to this, changed the damage readout on multi-projectile
	weapons so that it displays the base damage and how many projectiles
	it shoots as a multiplier before displaying the total damage.  This
	should clear up any confusion over what weapons can or cannot damage
	what doors.

	 - Removed a velocity reducing function from the Dying state of NPCs.
	This means when you boomstick someone in the face they'll REALLY fly.

	 - Added an Alt-Fire mode to the Shotguns which allows you to pack extra
	shells into the chamber before firing.  Think of it as being able to
	fire the entire clip at once, provided you have the time to prime it.

	 - In response to an error pointed out by des223 I coded a default case
	which will ensure that MissionScripts are at least attempted to be
	spawned for each level.  The Vandenberg Tunnels level has no script
	specified, and therefore doesn't clear a number of flags/settings which
	indicate that the player is between levels.  Or did before the fix
	anyway.

	 - Changed the way explosive projectiles may explode, currently only
	used by the projectile fired by the ILAW.  This allows it to bust open
	safes and other goodies without having the damage usually required to
	open safes: 250. (explosives explode in a strange manner)

	 - Also related to the ILAW, while it can now bust open safes, it can
	only do so if your Heavy Weapon skill is at Advanced or above.  It can
	still bust open most doors and the like.

	 - Modified the way firing animations are played so that the Shot Time
	Weapon Mod can always speed up a weapon.  The speed of the animation
	will now increase to match the shot time when needed.

	 - Modified the Targeting Augmentation so it will allow you to zoom in
	with weapons that don't have scopes.

	 - Added in the Precision Rifle, a Unique Weapon.  Fans of Red Faction
	should have a general idea of what this weapon is and what it does.

	 - Tucked away somewhere in the wide expanse of Deus Ex is a vending
	machine which sells Beer.  I'm not going to say where it is, but it's
	there.  Alas, you don't realy get any prize for finding it, except the
	opportunity to buy Beer.  Then again, Beer is its own reward.  Beer.

	 - Fixed a glitch posted on the Gamespot message boards where you can
	kill Bob Page just after his conversation with Maggie Chow by shooting
	through a near-imperceptable break in the bulletproof windowing in the
	VersaLife labs.  You can still kill him if you really want to, but it
	won't remove him from the later levels and force you to spawn him to
	continue during the Vandenberg mission, for example.  In short, Bob
	Page is undead.  THE DEAD WALK AMONG US!!!  RUN FOR YOUR LIVES!!!

	 - Changed the weapon ammo display in the Inventory screen to only show
	ammo that you've already picked up before when viewing a weapon's
	details.  This means that weapons could theoretically be capable of
	using a certain kind of ammo, but won't tell you that until after you
	have picked up some of it somewhere.  Hrrm, now what possible reason
	could I have to do something like that?

	 - Sped up bullet tracers so they move somewhere remotely near the
	speed the actual damage moves. (Instantly, that is)

	 - Added another check to ensure Ford Schick isn't considered
	un-rescued even after you rescue him.

	 - Traditionally, leaving Paul's apartment through the window during
	the raid on the 'Ton would automatically kill Paul.  I found this
	remarkably stupid if you, say, saved Paul and cleared out the 'Ton
	completely, watched him walk off, then left through the window only to
	find out he mysteriously died in the raid you just stopped.  Well, no
	more.  If you clear out the 'Ton and Paul is still alive he STAYS
	alive.  Period.

	 - Attempted to fix an old Deus Ex glitch where Paul sometimes will not
	show up in his apartment after you've sent the signal to the NSF.  I'm
	not sure if this will fix the problem or not, but in my tests I've yet
	to see it happen.  As it is, if the raid on the 'Ton hasn't happened
	yet, then Paul will be in his apartment during that mission.

	 - Remember that "wandering laser sight" thing I said I was only going
	to be able to do in time for v1.7.  Yeah... turns out it was a lot
	easier than I thought it would be.  The laser sight will now wander
	around within your current accuracy, but the bullet will always wind up
	EXACTLY where the laser is pointing.

	 - Related to this, you may notice that "scoped" weapons seem to
	suddenly be less accurate when not zoomed than they were in the past.
	This is not true; the HUD now merely reflects the true accuracy of the
	weapon, as it did not in the past.  Scoped weapons will still be as
	accurate as ever, more so in fact since I slightly changed the accuracy
	penalty calculation to give smaller penalties. (This is, of course, not
	including the old laser sight behavior, which gave 100% accuracy)

	 - Fixed a fix I made to the ever-so-glitchy 'Ton map during the UNATCO
	Raid.  I'd inadvertantly set it so it attempted to start the
	conversation with Paul a little early if you accidentally got to close
	to him.  That is no longer the case.

	 - FINALLY resolved all Save/Load issues.  Music no longer restarts
	when you load a game or save a game, and the info that appears next to
	each save game should be correct.  This appears to be because of the,
	how shall we say, pickiness of the Deus Ex engine, which expects only
	a certain number of variables attributed to the DeusExPlayer class.  As
	I had added one to create a new "too much ammo" message this had thrown
	off the engine's calculations, which made game saves skip a bunch of
	important info. (like what music was playing, how long you'd played...)

	 - To combat how many of my mod's additions make the game significantly
	easier, I have modified NPC aim stats.  In the past NPCs were not given
	the "standing bonus" received by the player, whereby aim gets better
	the longer they stand still.  This has been changed so that NPCs will
	have better aim the longer they stand still, though how fast their aim
	improves depends on the game difficulty.  On Easy their aim improves
	at roughly 1/4th the speed the player's does, whereas on Realistic NPC
	aim improves just as fast as the player's.

	 - As per a suggestion from someone on the Gamespot/FAQs message board
	(I've forgotten who) NPC AI can now use the Railgun properly, e.g. an
	NPC will shoot through walls with the Railgun.  Unfortunately this is
	done based on the assumption that the Railgun actually fires through
	walls properly, which at the moment it does not.  They also cannot use
	the thermal scope on the Railgun, though that may be a good thing.  I
	have given the Railgun to one in-game NPC at the moment as a sort of
	test, though whether or not they will use it remains to be seen.


	v1.5.1: (BUGFIX VERSION.  I F%$#ED UP BAD)

	 - Changed the array size of the Augmentation list back to the original
	value.  This seemed to cause a number of General Protection Fault
	Crashes during missions loads, which is bad.  Definitely bad.  Very...
	very bad.  Unfortunately this means that there is a cap on how many new
	augmentations I can add to the game.  As it is there are 22 augs in the
	game; the array has room for 25.

	 - Compressed the mod using a standard format compatible with Windows
	XP's built-in Zip viewing capabilities.  I promise I'll never use the
	proprietary Winzip format again.  Ever.  Ever ever ever.


	v1.5:

	 - Finally added in a working skillpoint bonus for headshots.

	 - Fixed the firing sound problem with silenced Assault Rifles.  You
	would only hear one silenced firing sound for every three or four
	bullets fired.  The firing noise is now tied to projectile generation
	on every weapon, with the exception of the UN-silenced Assault Rifle,
	as the firing noise is actually four-in-one.

	 - Added in the much-reffered-to Skull Gun augmentation.  It installs
	to the Cranial aug slot and can be found in two places in the regular
	game.  I would have liked to provide textual clues within the game as
	to the locations, but that has proven to be massively difficult.  Just
	remember: it's all about Gunther.  This was suggested to me by ASG on
	the GameFAQs Deus Ex Message Board.

	 - As a side effect of my placement of the Skull Gun aug, Augmentation
	Cannisters will now contain random augmentations if none are specified
	for them.  This will only matter for the aforementioned Skull Gun pickup
	and for Augmentation Cannisters you bring into the game using Summon.  I
	may use this for NPC Random Inventory later, however.

	 - Added in the Internal Light Anti-Personel Weapon (ILAW), a Unique
	Weapon.  This fires the same missiles the MJ12 Commandos fire at you,
	and therefore runs on the same ammo.  Because ammo for this weapon will
	be quite abundant, the placement of the weapon is somewhat obscure and
	difficult to find.  Suggested by ASG.

	 - Added in the JackHammer, another Unique Weapon.  This is based
	heavily on the same-named weapon found in Max Payne.  For those of you
	who have never played the game before, the JackHammer is a late-game
	weapon which is, in essence, a fully-auto rapid Shotgun, capable of
	expending a 12-round clip in under a second.  It also puts out 12
	slugs instead of the normal 5, but with only 1 damage per slug.  And
	you will *definitely* have to work to get this one.  As a hint: the
	weapon was made by Smuggler.

	 - And yet *another* Unique Weapon: Lo Bruto.  This is JoJo Fine's
	specially modified Stealth Pistol.  I don't think I need to tell you
	where to find it.  Also thanks to a suggestion by ASG.

	 - Placed the Rate of Fire Weapon Mod in a few places in the game.  They
	may or may not be in the some of the same places that ASG suggested on
	the GameFAQs Deus Ex Message Board.

	 - Found an interesting code screwup centering around Ford Schick. (The
	guy you optionally rescue from the underground lab in NYC)  Sometimes he
	won't show up in the last Smuggler map due to the way the code is 
	structured. (If you rescue him) I've added a failsafe or two.

	 - Also related to Ford Schick in the last map, after your conversation
	with him he's supposed to give you something, but you never get it.  It
	turns out there's a typo in the convo code; I've fixed it so you get the
	item.

	 - When possible, I've gone back and changed Unique Weapon and other
	item placement to be absolute -- as in XYZ coordinates -- in the script
	which places them.  Since the placement is absolute, I've been able to
	move the code which places it to the initial mission load script.  To
	summarize: GRR, CODE MORE EFFICIENT!

	 - The Boomstick now pumps out 12 slugs instead of 5.  The damage is
	roughly the same, total.

	 - Added in the Majestic-12 Commando as a playable character in DXMP.
	It wasn't in previously because I was having trouble with the model
	trying to execute animations it didn't have, thereby freezing it.
	From what I can tell now this should no longer be a problem.

	 - Changed Cigarettes a little so they give out a puff of smoke which
	does some minor damage.  There's a random chance that it will also cause
	the damaged NPC to be "Tear Gassed" for a short period.

	 - I may have fixed a glitch where you would generate a "ghost" laser
	dot if you had a weapon with the laser mod out prior to being captured
	at the end of mission 4.

	 - Gave all Shotgun-based weapons extra kick, and allowed NPCs that are
	dying to be affected by momentum.  This means you can theoretically
	Boomstick someone in the face and watch 'em fly.

	 - Set up a method to differentiate between Flamethrower fire damage and
	Flare Dart fire damage.  The only noticable difference is that NPCs will
	burn for half as long when hit with a Flare Dart, compared to the
	Flamethrower.

	 - Alarm Panels deactivated via EMP will now be deactivated for a period
	of time relative to the EMP damage dealt to them.  This is also true for
	Laser Tripwires, but I somehow neglected to document this previously.
	This seems to work for all sources of EMP, including the Electrostatic
	Discharge mod, though it has proven very difficult to hit the Laser
	Emitters with hand to hand weapons.

	 - Coded a workaround to a limitation in the Unreal engine where one of
	the functions that is called when an NPC dies -- WaitForLanding() --
	doesn't count water as a landing surface.  The function will therefore
	wait indefinitely.  It's very rare that this will ever be seen, as the
	problem only happens when an NPC is killed *above* water, *not* in it.

	 - Reintroduced Explosive 10mm ammo.  This turns your basic pistol into
	a true hand cannon.  It hasn't been placed in the game yet, but you can
	spawn a few ammo boxes if you'd like.  The name is Ammo10mmEX.

	 - Instead of the typical "NPCs magically stop burning when they die"
	crap, NPCs will now continue to burn after they die.  The length of the
	burn will be no longer than they would have burned had they not died.


	v1.4:

	 - Regeneration mod will no longer turn off when you are fully healed.
	Instead it will go to an "idle" state, where it uses a minimal amount
	of energy, and will re-activate and heal once you are no longer at full
	health.

	 - Added a direct modifier to the damage done by throwing plants/etc.
	into an NPC, based on the level of the Muscle augmentation.

	 - Fixed the problem with improper sounds for certain player models in
	MP, for the most part.  I was unable to replace sounds that had no
	female compliments obviously.

	 - Changed the Combat Strength aug into the Electrostatic Discharge
	aug, taken pretty much identically from Invisible War.  As such, the
	Microfibral Muscle augmentation now has the Combat Strength ability
	in addition to its normal ability, also like Invisible War.

	 - Fixed a minor coding problem that spammed the DeusEx.log file every
	time a player switched weapons.

	 - Changed where the Toxin Blade is found to a location that is much
	more appropriate for the weapon.

	 - Added in a temporary "fix" for the new skillpoint system, allowing
	players to disable it if they choose.

	 - Added in the Railgun.  As with various incarnations of Railguns,
	this particular one WILL shoot through walls.  And boxes.  And people.
	At the moment it may not hit something even if you think it should,
	but headshots are guaranteed to be lethal.  However, it will suck
	down ammo like none other. And no, I won't tell you where it is. :P


	v1.3:

	 - Upgraded the mod from Beta stage to final, as there are no major
	glitches left in the mod.

	 - Changed the Power Recirculator Aug so it activates and deactivates
	automatically.

	 - Modified pickups like crates, vases, and so on such that when you
	throw them into an NPC at high speed it does stun/"knock-out" damage
	to them, as well as to the object if it is not indestructable.

	 - Added in another unique weapon: the Toxin Blade.  The only clue
	I'll offer is that it can be found similar to how the Toxin Blade was
	found in Invisible War.

	 - Modified some generic weapon code so that weapons can stun NPCs
	without doing the special "Stun" damage type.  At the moment this is
	only used for the Toxin Blade.

	 - Added in slow-motion "bullet time" effects while using Zyme.  Don't
	get thrown when it appears as though you're going slower; so is
	everyone and everything else. Because of this I've reduced the time
	for which the Zyme effect lasts, down to 30 seconds from 60.

	 - Fixed a problem with the Enviromental Resistance augmentation and
	one of my additions which made lower levels of the aug reduce "drunk"
	time more quickly than high levels of the aug.

	 - Changed the Scope feature so that it won't force you to wait until
	the gun is in the "idle" state before allowing you to zoom in/out.

	 - Added in several new player models for Multiplayer.  Unfortunately
	I haven't been able to find a way to get the sounds to come out right
	yet, but at least you don't have a whopping 4 choices of who to play as.

	 - Fixed the "highlight" issue in MP, where the highlight border would
	appear around the right-most slot of a multi-slot weapon, yet the game
	would switch based on the left-most slot of the item.  The highlight
	will now appear on the left-most slot of the item.

	 - Removed one of the "section separators" from the Toolbelt in MP,
	since the section it was marking has been expanded.

	 - Moved the UPDATES section to the bottom of the Readme file.

	 - Fixed the "overlap" trick, but only when cheats are disabled. If you
	still want to stack all three heavy weapons atop each other in your
	inventory screen you'll have to enable cheats to do it.

	 - Split the difference between the chance of NPCs getting random
	inventory in v1.1b and v1.2b.  It's now higher than v1.2b, but still
	lower than in v1.1b

	 - Added in another Unique weapon: the Boomstick.  You probably won't
	miss this one, but do keep an eye out.


	v1.2b:

	 - Lowered the chance of NPCs getting random inventory slightly.

	 - Modified the way NPC random inventory is given.  It now determines
	whether or not an NPC can have random inventory when they are intially
	spawned, but only initially gives non-weapon items.  It also sets up a
	recursive check which monitors whether or not the NPC is later given a
	weapon, in which case NPC random inventory will give that NPC a
	randomly determined upper-tier item, should they have not already been
	given a lower-tier item.  This makes it so you can't keep reloading
	and re-killing NPCs in order to get the items of your choice.

	 - Borrowed a little from the new Deus Ex game (Invisible War) and
	started adding in unique weapons.  Thus far I have only added in a
	Magnum; I'm not going to tell you where it is though, except that it's
	not a separate item pickup.


	v1.1b:

	 - Fixed something in NPC random inventory which was not tracking the
	weapons the NPC possessed properly, something which is factored in
	when granting random inventory.

	 - Fixed a problem where you would be unable to remove Lockpicks or
	Multitools from your belt without the other replacing it, unless you
	dropped the items completely.

	 - When you examine a corpse now any items you cannot pick up (or that
	you discard, i.e. Combat Knife) will be removed from the corpse and
	dropped on the ground as actual pickups.

	 - Did some more tweaking to skill points for kills/KOs.  Bonuses for
	stunning vs. killing are now only given for certain NPCs. (NSF, some
	others)  Added in small bonuses for one-hit kills and hands-on kills.

	 - Finally added in the strength/accuracy/speed bonus for Zyme use.
	You will experience roughly 30 seconds of enhanced abilities followed
	by an equal or greater period of drunkeness.  Zyme use will also remove
	any existing drunk effects when first activated.

	 - Modified some minor "consumeables" stuff. 40s will heal more and
	don't make you quite as drunk as before.  Liquor heals a tiny bit more
	but makes you drunk twice as long. Candy Bars heal one more point as
	well, and Soda will actually reduce the time you are drunk. (Must be
	all that Caffiene) Cigarettes will now make you immediately sober.
	(They still hurt you though)

	 - Added in Weapon Mod (Rate of Fire).  This will increase the Rate of
	Fire on a variety of weapons, though unfortunately I have found the
	rounds per second listing exhibits gross innacuracies as far as rate
	calculations go.  This mod will be found randomly on people you kill/KO.

	 - If you come across an Augmentation Cannister for an Aug you already
	have you will be able to upgrade the existing Aug through the use of a
	Medical Bot.

	 - Increased the base accuracy of Throwing Knives, as the current level
	was roughly the same spread as the shotgun.

	 - Kills made by bots affected by a Scramble Grenade will grant you
	skill points as though you had made the kills, excepting any bonuses
	for distance, etc.  (Unfortunately they tend to kill EVERYTHING, as
	I have pointed out above, so be wary)

	 - Extended the time a Fire Extinguisher will spray for to 5 seconds.

	 - The Environmental Resistance Augmentation will now decrease the
	length of time you will experience "drunk" effects, when active.


	v1.0b:

	 - Added in code so that you don't pick up the f%$#ing Combat Knife
	from corpses if you have a better Hand to Hand weapon in your invo.

	 - NPCs that would normally carry the combat knife may randomly be
	given a better melee weapon instead. (Fairly rare chance though)

	 - Fixed the problem with Throwing Knives not showing up on the
	Inventory Added screen.

	 - Changed some minor nuances in skill points for kills/KOs.

	 - Fixed a problem with Dart Ammo on corpses where you could get between
	9 and 14 clips (36 - 56 rounds) of regular darts from one corpse.

	 - Took out a special case which had effectively nullified the change
	I made to the Pepper Spray cloud's live time.

	 - Added in weapon switching for Hand to Hand weapons.  If you press
	Change Ammo with a hand to hand weapon out -- e.g. Dragon's Tooth --
	it will switch to the next available hand-to-hand weapon you have.
	If you have a second hand to hand weapon in another belt slot it will
	skip over it.


	v0.9b:

	 - Fixed a problem where you could get docked skill points for killing
	flies. (Yeah, like the things that buzz around bodies.  Those flies)

	 - Fixed the problem in Shifter MP where the item labels didn't reflect
	what was in the belt slot.

	 - Began implimentation of item cycling in the three right-most belt
	slots in MP.  As an added bonus you can now cycle through all available
	grenade types in Single Player by pressing the "Change Ammo" button, as
	well as between Lockpicks and Multitools, Medkits and BioE Cells.

	 - Finally played normal Deus Ex MP in god knows how long and realized
	that you don't actually have a Keyring in MP, meaning the last slot was
	available.  As of now Lockpicks and Multitools each have their own slots.
	The cycling option from Multitool <=> Lockpick will only work in Single
	Player mode.

	 - Took out Weapon Mod Auto, because it was a stupid idea. :P In order 
	to prevent load errors from occuring with saves made with the weapon mod
	in inventory/in level/etc. you can still pick it up, but it does nothing
	(Don't worry though, I have a much better idea on what to replace it
	with) To get the mod out of your inventory simply drag it over any weapon
	and it will disappear.

	 - Modified skill points on kill/KO.  Lowered the bonus you get for
	stuns or KOs, and added in a bonus for distance.

	 - Halved the live time on Pepper Spray clouds.  The weapon was more
	like a micro-Gas Grenade and less like a hand weapon.

	 - Increased the amount of damage the PS20 does. (again)  Now it should
	be capable of taking out most enemies in one hit, short of MIBs/WIBs.
	(Hell, if it's a straight head shot it can take out an MiB as well)

	 - Upgraded the mod's status to Beta stage, since as far as I can tell
	I have fixed most problems in Multiplayer.


	v0.8a:

	 - Added Riot Prod to both the initial random list as well as the "KO
	or killed" list.  Also modified the initial random list so that the
	liklihood of getting an item is the same as the other random list,
	and decreased the liklihood of a low-level NPC "jumping" levels to
	the next inventory list.

	 - Fixed a problem in Random NPC Inventory which prevented any NPC from
	receiving credits as a result of random inventory.

	 - Modified some skill point for kill/KO stuff.


	v0.7a:

	 - Added in skill points for kills/knock-outs.  The general amount may
	be changed in the future as evidence presents itself. At the moment
	you will receive about 1/10th of the victim's health in skill points.
	(NSF Terrorists have 75 so 7 pts, MIBs 350 so 35 pts, etc.)  This amount
	can be modified based on how you killed them (e.g. Riot Prod vs LAW)
	or their alliance. (Hint: killing friendlies = bad)

	 - Modified NPC random inventory so that only certain items go to NPCs
	in a certain health range. (e.g. no more 20mm ammo showing up on NSF
	Terrorists... mostly) There will still be a random chance that a NPC
	will "jump" a rank and receive an item from a higher list.

	 - Fixed a glitch with the Mini Crossbow where you could pick up both
	ammo from the crossbow and the Tranq Darts carried by an NPC, in effect
	doubling the amount of ammo you could receive from a downed NPC.

	 - Also related to Ammo and Random NPC Inventory, there was a glitch
	where you could see a screen showing you as having received some kind of
	ammo, but it would not actually be added to your ammo count unless you
	already possessed ammo of that type.  I initally attempted to fix this
	problem so that you would always receive the ammo, but upon further
	consideration it occured to me this would serve as an excellent means to
	prevent Shifter from advancing the progress of your game prematurely.
	Therefore as of now you cannot receive ammo from random NPC Inventory
	unless you have picked up an actual ammo pickup for it previously.


	v0.6a:

	 - Changed NPC random inventory to be initiated when the NPC dies for
	certain items. (mostly weapons)  This will allow for more NPCs to
	qualify for the "weapon list" of items where applicable. (e.g. the
	hostile sailors, as sailors do not normally carry weapons and are in
	fact classified as civilians in the game)

	 - Fixed a glitch related to random inventory which prevented you from
	getting ammo from corpses which was not loaded into a weapon.  You are
	now able to pick up ammo from corpses provided it is non-standard ammo.
	(e.g. 20mm Ammo, Flare Darts, Standard Darts, Sabot Shells...)


	v0.5a:

	 - Removed a glitch in NPC random inventory code where an NPC could be
	given a credit chit with no credits on it.  Also prevented a randomly
	given credit chit from overwriting a credit chit already held by the
	NPC.

	 - Modified the effect of Skill: Medicine on Water Coolers and Water
	Fountains.  The range is now from 1 to 4 points of damage healed.

	 - Changed the description of the "Change Ammo" key to reflect the fact
	that it also can change weapon modes.

	 - Added in Weapon Mod (Automatic).

	v0.4a:

	 - Changed some items in the NPC random inventory list.  Removed Gas
	Grenades and Stealth Pistol in favor of 20mm Ammo and Riot Prod. Also
	removed Multitools and Lockpicks from the list, since you get enough of
	those in-game, and added in Zyme. (It's not just for junkies anymore!)

	 - Increased the liklihood of an NPC getting random inventory ever so
	slightly. (4 in 11 chance instead of 3 in 10... sort of)

	 - Fixed a glitch in the random inventory code that could lead to an
	NPC having no ammo for a weapon they were given.

	 - Changed the minimum spread on Plasma Rifle in Spread Fire mode.

	 - Added a whopping one point of damage to the Baton.

	 - Water Coolers and Water Fountains will heal points of damage based
	on your Medicine skill. (from 1 to 3 points of damage)

	v0.3a:

	 - Removed 10mm ammo from Assault Rifle. (Originally there to offset
	a now-fixed problem with getting 7.62 ammo)

	 - NPCs will carry certain items based on random chance.  MiBs and WiBs
	get a special set of random items. (Really good ones)

	 - Changed the Alt-Fire on Plasma Rifle from Roswell Burst (Grey Spit)
	to Spread Fire. (Shotgun-style fire w/lower damage per hit but more
	projectiles)

	 - Added more uses (drinks) to the water fountains found in levels.
	Also decreased the wait time between uses. (1 second down from 2)

	 - Moved some things around in the Readme.


	v0.2a:

	 - Initial public release.
