//=================================//
        Shifter for Deus Ex
	   Version 1.8.2
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
Shifter rules, with some few exceptions.

	If you want to install Shifter so that you are still able to play
unmodified Deus Ex without having to swap files, please read the file
"Advanced.txt" for detailed instructions.

	In case you don't know, by default Deus Ex is installed to the
"C:\DeusEx" folder.  For people with the Steam version of the game, the default
path is "C:\Program Files\Steam\steamapps\common\deusex".  The basic install
works with both versions.

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
This file is installed to C:\DeusEx\HDTP\Textures by default.  You must also use
the NORMAL Deus Ex/Shifter exe file.  Do NOT run HDTP.exe or Shifter will not be
running when you do!


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
	it can't. This change happens whenever you enter a map OR whenever you
	load a savegame, so if you install HDTP and then load an existing save
	you should notice the new textures and models immediately.

	 - DOES YOUR MOD WORK WITH THE STEAM VERSION OF DEUS EX: From what I've
	been told by various folks, apparently Shifter is 100% compatible with
	the version of Deus Ex you can purchase via Valve's Steam program.  I'm
	still in the process of testing it fully myself, but all indicators are
	that the functional enhancements of Shifter cause no problems with Steam
	and are not impeded by the program at all.  However, certain other mods
	(like HDTP) may require some extra configuration to get working.

	 - DOES YOUR MOD WORK WITH THE GAMETAP VERSION OF DEUS EX: I am pleased
	to say that yes, Shifter does work with the GameTap version of Deus Ex
	though it takes some additional configuration and the install procedure
	is VERY different.  Complete installation instructions can be found in 
	the file "GameTap Info.txt".  Please note that while Shifter's gameplay
	modifications will be passed along to the GameTap version, some of the
	associated text changes (some item descriptions and one button label in
	the keyboard config menu) will NOT come through.

	 - DOES YOUR MOD WORK WITH THE DEMO: It can, but some extra work is
	required.  The Demo versions (the 1-, 2- and 5-mission varieties) do
	not have the most up-to-date versions of some files which Shifter needs
	to work (i.e. the Demo isn't patched to v1112fm).  You can add these
	files by downloading the v1112fm patch, opening it with WinZip/etc.
	(NOT running it) and then extracting the contents into the Deus Ex
	Demo's installation folder (e.g. C:\DeusExDemo\).  This will overwrite
	the old, incompatible files; from there you can install Shifter.  In
	order to start a new game in the 1- or 2-mission versions of the game
	you will need to right-click the "OK" button when starting a new game.
	(This skips the intro, which these demo versions do not have)

	 - WHERE IS THE SHIFTER HOMEPAGE: You can find the Shifter homepage at
	http://yukichigai.googlepages.com/shifter.  I also have an account over
	at ModDB (http://mods.moddb.com/8002/shifter/) which is where I usually
	post news items, ramblings, and other such things. There's always the
	SaveFile project page for it, where you can get the latest version.
	(http://tinyurl.com/2b5k82)  I upload to FilePlanet semi-regularly,
	though not as often as to SaveFile.  I also update a thread in the Eidos
	Forums about Shifter.  (http://tinyurl.com/zxehg)  Finally, if you want
	the bleeding-edge latest version you can get my most current source
	files from Google Code, under the account "shifterdx".


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
	it fires.  Worth using even late in the game now.  You can also carry
	multiple PS20s in your inventory, should you feel the need.

	 - Scope: You no longer have to wait between shots to zoom in/out.  Much
	less annoying, much more realistic.

	 - Stealth Pistol: Increased the rate of fire and damage by a slight
	amount.

	 - Throwing Knives: Reduced the spread and increased the damage.

	 - Unique Weapons: Taking a page from Invisible War, I have added in a
	number of Unique weapons.  Some have been added as separate pickups,
	some were added in via other means.  You'll have to keep your eyes
	peeled and your curiosity high to find them.

	 - Weapon Accuracy: Originally, Deus Ex was somewhat inconsistent in how
	it displayed and calculated the accuracy of a weapon.  Firstly, the
	crosshair's range in no way reflected the spread of the weapon.
	Secondly, the spread of two bullet-based weapons with the same accuracy
	could be wildly different depending on their maximum range.  Shifter
	addresses both of these issues.  While it may appear, based on the
	crosshair, that all weapons are now more accurate, weapon accuracy is in
	fact (mostly) the same.  (Slightly better for some weapons, slightly
	worse for others, depending on the range of the weapon)


	Augmentation Modifications:

	 - "AugAdd" cheat: Using the "AugAdd" cheat for an augmentation you
	already have will upgrade that augmentation, rather than simply failing
	as was the case in normal Deus Ex.

	 - Augmentation Cannisters: Cannisters for augmentations you have
	already	installed will now allow you to upgrade that augmentation once.
	You must use a Medical Bot to do it though.  You may also choose to
	"overwrite" an existing augmentation with a new one if no slots are
	available, though the new augmentation will be installed at level 1,
	with no upgrades. Cannisters with no augmentations specified for them
	will contain a pair of randomly determined augs.  (Meaning that if you
	use the cheat "summon AugmentationCannister" you'll actually get
	something useful)

	 - Environmental Resistance: Enviro Resist will now decrease the length
	of time you will experience "drunk" effects when it is active by an
	amount based on the level of the augmentation.

	 - Light: The light augmentation is also upgradeable, similar to how it
	is in Hardcore.  However, unlike Hardcore the distance the flashlight
	effect can travel also increases with each level, and the boost of
	"radiant" light around you increases at higher levels, but is actually
	LOWER than normal at the aug's lowest level.

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
	certain "special" items.  (NOTE: To stop people from just neutralizing
	everyone in each mission all willy-nilly to take their stuff you will
	LOSE skill points for killing/KOing friendly NPCs)

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

	 - Zyme: Since Zyme was pretty much useless in the original game, I have
	modified it so it provides a temporary speed and skill boost.  It also
	initiates "bullet time" effects while it is active.  Be wary though; once
	the effects wear off there is a long period of "drunk-vision".


	Unrealistic Mode:

	   Unrealistic Mode is a new difficulty level I've added to Shifter for
	the benefit of players looking for either more of a challenge, or more
	of a departure from traditional Deus Ex (and Shifter) gameplay.  Though
	it isn't finished yet, Unrealistic contains a number of modifications
	which make it a unique experience, somewhat akin to the Hardcore mod.
	These are, in no particular order:

	 - Player Model: Rather than being stuck with the single choice of JC
	Denton, Unrealistic will use whatever model you have selected for use
	in Multiplayer.  I hear using the Child model is particularly amusing.

	 - NPC Weapons: All bullet-based NPC weapons fire explosive rounds now.
	The damage is not as extreme as a weapon loaded with 10mm EX ammo, but
	it isn't anything you can easily shrug off either.

	 - NPC Random Inventory: Gives weapons out more often and applies to
	everyone, including non-armed NPCs, Robots, and Animals.  I hear that
	the Greasels in the Paris Catacombs often carry GEP Guns.

	 - Corpse looting: You can now check the bodies of Animals and Robots
	for loot in Unrealistic, which works well with the expanded capability
	of NPC Random Inventory.

	 - Smarter everything: Every NPC, be it Animal, Human, or Robot, uses
	the highest Intelligence preset available in the game.  This means that
	Karkians can open doors and Spider Bots know how to call an elevator.
	Both can also pick up new weapons in the middle of combat.


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
	site as the enhanced OpenGL renderer) does not suffer from this
	limitation, however.

	 - An odd side-effect of the "Office Storage" feature may rarely cause
	random weapons to appear in JC's UNATCO office upon returning from a
	mission.  Sometimes these weapons come with a mod or mods installed;
	apparently silenced Sniper Rifles are the most common.

	 - The new Zyme effects do not completely work in at least one map in
	the game: the Hong Kong Canal area.  While you will receive the skill
	and speed boost, for unknown reasons the game's speed will not drop.
	As soon as you move to another map in the area, however, all normal
	Zyme speed effects will return.

	 - If you carry a datacube from one area to another such that you
	encounter a load screen the datacube will be "wiped".  Fixing this will
	require some fancy code that I haven't quite implemented yet, but it
	will be done eventually.

	Multiplayer:

	 - Clients connecting to a server running ShifterMP may witness some
	bizarre behavior from the item belt, specifically an odd "scrolling"
	effect when using multi-slot weapons.  Theoretically this is now fixed,
	but if you notice this odd behavior showing up again please let me know.

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

	 - If I get bored enough I may make dead animals cookable, wherin they
	will subsequently become edible.  I warn you, I'm bored a lot.

	 - I fully intend for there to be a Unique Weapon to compliment every
	existing non-one-use weapon in the game.  (By "compliment" I mean like
	how the Magnum compliments the Pistol)


OTHER NOTES OF DEADLY DOOM:

	The name "Shifter" is a tribute to a popular mod for Starsiege: Tribes.
Shifter was created by emo1313.  Check out his current version of Shifter for
Tribes 2 at www.shiftermod.com.  Or check out mine, Shifter Classic, which can
be found... actually, nobody hosts it anymore, but if you really care you can
email me and I'll be happy to send you the mod.  (Once I find it)

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

	v1.8.4:

	 - Shifter-TNM: Made sure that when Shifter replaces TNM's MedBots with
	the Shifter ones it only removes the old TNM bots after its sure the
	new ones are in place.  If a replacement MedBot isn't spawned then the
	old TNM one will still be around, which means it augmentation
	replacement may not always be available in TNM + Shifter.

	 - HDTP no longer loads/unloads when you do a QuickSave, which will
	make these saves actually quick, but not fully compatible if swapping
	save files between computers.  Of course, if you're going to swap a
	save file then you can just make a separate, non-quick save file.

	 - Added a built-in way to skip the intro when starting a new game:
	right-clicking the "OK" button.  This is probably only going to be
	useful for people trying to run Shifter with the Demo version, and the
	horribly impatient.

	 - Moved around part of the fix for the UC destruction event in HK so
	it's more efficient.

	 - Also moved around where Ray gets set to being neutral.  While I was
	there I also removed some old, out-of-date code that was doing nothing
	but taking up resources.

	 - Added a routine to part of NPC Random Inventory which should help
	ensure that items given to NPCs, particularly ones in TNM, don't just
	wind up at their feet.  Also adjusted NPC Random Inventory to not
	factor in inventory belonging to another NPC that has somehow been
	linked to the wrong inventory list.

	 - Fixed a subtle Deus Ex glitch with couches.  Did you know they're
	supposed to come in five different colors?  I didn't.  Thanks to Jonas
	of TNM for pointing that out.

	 - Re-worked the Pistol Downgrade fix so that it is more compatible
	with other mods like TNM/etc. which use a custom New Game Menu class.

	 - Changed the code for putting random augmentations in summoned Aug
	Cans.  The code was set up so that if it picked one of the "default"
	augmentations then it would simply pick the next aug in the list, which
	skewed results towards those "next" augs.  Now it will just start the
	random selection process over.

	 - Restored the Crossbow's original firing sound, which was never heard
	due to a code oversight.  Thanks to Lork on the OTP forums for pointing
	this out.

	 - Also adjusted the Targeting aug so it will use the display name of a
	weapon it spots being carried by an NPC, if available.  Also thanks to
	that wacky Lork guy.

	 - Holy crap more Lork-reported fixes. This time he discovered that if
	you are using a Charged Pickup (thermoptic camo, etc.) when you are
	captured by UNATCO it will leave the HUD in place and cause some other
	weirdness after the item is confiscated.

	 - And someone ELSE pointed out that while the description on the
	HazMat Suit says it protects against fire, electricity, and EMP damage,
	it actually doesn't. Now it does.

	 - Ballistic Armor will now protect against explosive gunfire.

	 - A "because I can" fix, If you boost the EMP aug past Tech Four using
	the Synthetic Heart aug you will actually GAIN health and energy from
	sources of EMP.

	 - Finished work on one of the more odd-ball DXMP models I decided to
	add.  I'm not going to say who or what it is, except that if you've
	played through one of the more bizarre Deus Ex mods you'll get the joke

	 - Any consumable items (soda, etc) which show up in DXMP will act as
	instant-effect items when you click them, e.g. if there's a bottle of
	booze when you click it you'll immediately gain some health and get a
	teeny tiny bit drunk.  This has something to do with the new DXMP model
	I mentioned above.

	 - Changed the ammo pickup count from bodies.  Again.  In normal DX it
	was anywhere from 1 to 4, which I changed to 1 to <Weapon Clip Size>.
	Now it's a bit more complicated: 1 to (half the clip size or four,
	whatever is greater).

	 - Moved another MissionScript fix to a lower-lag location, this time
	the fix that stops the x51 scientists from making their own bots turn
	on them.


	v1.8.3:

	 - Removed the Demo version compatibility, which was falsely detecting
	some installs as being the Demo version.  I may re-add it later if I
	can figure out the cause of the issue.

	v1.8.2:

	 - Fixed a problem that could cause Multitools or Lockpicks to appear
	in multiple belt slots if you run out of one while both are occupying
	belt slots.  In certain instances this could cause whichever was
	"doubled up" to disappear completely from your inventory.

	 - Added a little code so that mods or maps which rely on the WiB, MiB,
	GuntherHermann, or AnnaNavarre classes SPECIFICALLY having an "Explode"
	function will still work with Shifter.  I'd forgotten that UnrealScript
	doesn't always pass function calls from one class to the parent class.

	 - Stopped bots from playing the "passed out" sound when they've been
	felled by some sort of stun weapon. (e.g. Baton, Prod, etc.)

	 - Added code which will ensure you see the actual amount of ammo you
	receive from conversations if you're given more than you can hold.
	(e.g. if you receive 3 LAMs but can only hold 1 more it'll say you only
	received 1) Most of the time, anyway.

	 - In a slightly embarassing twist I discovered that I had not adjusted
	the description on the IFF Aug to reflect the new "Blue = neutral" part
	of it.  The description (and the DeusEx.int file) have been updated.

	 - Added another layer to the "Paul disappears in the 'Ton" fix.  If
	Paul has somehow been removed from the map (typically if he is marked
	as dead due to that damn trigger placed outside the window) the game
	will now spawn another copy of him and un-mark him as dead, at least
	before the subsequent raid has been initiated.

	 - Adjusted the scripts for a few of the new item placements so that
	they are done in a different, non-recurring part of the mission script.
	As it was Paul's answering machine, for example, was placed only once,
	but the script checked to make sure it was placed every second.  The
	only possible side-effect this will have is that players who start a
	game in normal Deus Ex and then add Shifter partway through their play
	through may not see certain new additions in levels they've already
	visited.  At the very least they'll have to leave the area and return.

	 - Fixed an existing Deus Ex bug which could cause two JoJo Fines to
	appear in the lobby of the 'Ton.  This only happened when the JoJo
	descending the stairs was unhidden, then one of the Rentons died, and
	finally the player left and returned to the 'Ton WITHOUT killing JoJo.

	 - Updated the DeusEx.int file to include some text that CAN be added
	to a datacube in Mission 2.

	 - Changed skill point awards for Kills/KOs so that you aren't given a
	sound/text cue if the NPC hasn't been rendered within a second (i.e.
	you can't see them) unless they're a significant character.

	 - Redid the way the super-secret access to Unrealistic is done so that
	it works for people using a localization (int) file.  Before it was
	examining the button names without considering the different ways that
	"Realistic" is said in other languages.  (Oo, a hint!)

	 - Re-enabled some functions I took out of various NPC states so that
	TNM can work with Shifter.  More accurately, I renamed the functions
	and made sure that in every state they returned the same type.  Had,
	anyway.  Apparently NPCs in TNM rely on some of those functions, so
	it's back to the ever-so-dicey practice of having states containing
	functions with the same name but different return types.

	 - Changed the way the "Facelift" function is defined so that it won't
	(I think) be overridden for the parent class by the first child
	function, which (I think) is what was causing some odd issues with HDTP
	models randomly appearing in other mods like Zodiac and TNM.

	 - Burning corpses will no longer continue burning if for some reason
	they have no visible fire effects associated with them.  Apparently
	random gibbing is no fun.

	 - Moved where one of the log messages is placed in relation to the "no
	music in the last NYC mission" fix, as it was causing problems in mods
	where certain maps are supposed to have no music.  (Giant log files of
	doom.) The lack of music will only be noted if it's being fixed now.

	 - Added some COA (cover our asses) code to ATMs, Repair Bots, Medical
	Bots, and a few other classes which will make sure that one of the
	classes some of my new code accesses is actually there.  This was
	causing a few mods to spam the log file with "accessed None" messages.
	You shouldn't notice any change in gameplay, though the fact that I
	needed to add this code tells me that my "pause-then-hack" exploit fix
	may not work in ALL situations, just most.

	 - Reworked the way the "skills-for-kills" system is done.  It is now
	handled by a separate function which is initiated elsewhere in the game
	code, which will allow it to work with mods like TNM, Hotel Carone, and
	so forth.

	 - Made sure the HDTP facelift is only applied to the actual objects
	they are meant to and NOT child classes in other mods, e.g. the subway
	ticket machine in TNM.

	 - Discovered that two items weren't having their HDTP facelift applied
	until save/load: Beam Triggers and thrown Crowbars.  Now fixed.

	 - Added every TNM melee weapon to the weapon cycling function, which
	includes their version of the Combat Knife/etc.

	 - Modified the Augmentation Replacement method in the Medbot menu so
	that it SPECIFICALLY reminds you that you need to select an aug that is
	installed in the proper slot.

	 - Adjusted the item received display so that it will try to display
	the amount of ammo you were given whenever possible.  This MAY fix some
	of the issues in TNM and other mods where it lists you as having
	received only one unit of ammo, rather than X bullets/etc.

	 - Changed the Dead Body search functions so that they will ALWAYS set
	the amount of ammo in the ammo pickup you find equal to whatever you
	are given.  This has no real effect other than working better with the
	change I made above.

	 - Moved part of NPC Random Inventory so that it is only done in the
	Timer event for each NPC, not for the entire missionscript.  This will
	use less system resources since the missionscript version was checking
	every second and was checking EVERY NPC.

	 - Adjusted NPC Random Inventory to give out appropriate TNM items when
	the game is being run with TNM.  Generally this just means that the TNM
	-specific version of the Assault Rifle/etc. will be given out, but
	there are a few substitutions that have been made, e.g. instead of Soy
	Food NPCs will be given Beans.

	 - The TNM Medical Bots will now be replaced by Shifter's Medical Bots.
	This will allow you to replace existing augmentations as well as
	upgrading them using an existing augmentation cannister and a medbot;
	the latter feature was already present in TNM and was the reason for a
	specialized Medbot for the mod.

	 - Added a special case to make sure that TNM weapons will play firing
	sounds.

	 - Re-tweaked the HDTP Facelift function so it REALLY only applies to
	Deus Ex/Shifter-specific items and NOT mod-specific ones.

	 - Because I care entirely too much I added a some code to the level
	change function so that it will check to see if the next map is there.
	If it isn't the game will show you the "This is a Demo" splash screen,
	which will tell you how awesome the game is and then throw you back to
	the start menu when you click something.  What this means is that
	Shifter now works correctly and error-free with the 1-level Demo,
	2-level expanded Demo, and the 5-level "Limited Edition" (after you
	patch any of those versions to v1112fm, anyway). I'm sure a total of 5
	people (max) will care about this.

	 - Moved the changelog for prior versions to a separate file called
	Changelog.txt.

	 - Made sure you can start a new game with Shifter running in the Demo
	(1- or 2-level) version.  Both versions do not contain the Introduction
	cinematic map, so Shifter will bypass the "level" if it isn't present.

	 - Dialed down the insanely high skillpoint awards which were possible
	for destroying bots with melee weapons.  By "dialed down" I mean 
	"removed completely".

	 - Added some code that will check and see whether or not HDTP is even
	installed before performing the series of time-consuming model/texture
	swaps whenever you enter a level or load/save a game.  This should make
	it so that people running the game on era-appropirate hardware (e.g.
	stuff that is only doubly overpowered for the game) won't have to sit
	through 20 second save times, at least when they aren't using HDTP.

	 - Took out the "KO" exception from the "friendly fire" skillpoint
	penalty.  Several people pointed out that making friendly kills a no-no
	was enforcing a morality in the game, and they're right.  However, back
	when I first added the penalty it was more to prevent people from 
	killing everyone in a level, friend, foe, or otherwise, in order to
	snag goodies handed out with NPC Random Inventory.  Removing the
	exception brings it more in line with that intent.

	 - Tweaked NPC Random Inventory a bit more to take into account the new
	"category" classes used by TNM, as well as the TNM-specific classes for
	MiBs, WiBs, and most Deus Ex weapons like the Assault Rifle, etc.

	 - Added a second entry for Alternate Fire to the keyboard config menu.
	The entry is at the very bottom and will ALWAYS show as Alternate Fire
	regardless of whether or not you have removed/replaced DeusEx.int.
	You can change the Alternate Fire keybinding(s) on either entry, but
	the change will not be accurately reflected in the entry you DIDN'T use
	until you exit the config screen and open it again.

	 - Pressing "Fire" in TNM while you are unarmed will now bring up your
	fists.  Incredibly useful and convenient.

	 - Moved some code around so that Crystal Melk in TNM will actually
	wear off.  As a side-benefit your "Zyme time" will not count down
	during conversations.

	 - Fixed the teleporting aliens in TNM, who were not able to do so.
	Turns out it was a side-effect of some of my "optimizations".  Oops.

	 - Also relating to aliens, adjusted some code so that ANYTHING that is
	Gray-shaped or Gray-esque (Zodiac's Greys and Blues, TNM's Phasers and
	Aliens, etc. etc.) is healed by Radiation, and set on fire (most of the
	time) by Zodiac's E-Rifle.  Y'know, because so many people are likely
	to bring the E-Rifle into a TNM game.

	- Tweaked the "firing sounds" fix, which was causing some problems with
	TNM.  The new version does the same thing, but more effectively, and in
	a way that keeps TNM weapons playing firing sounds.  Even without
	wanting to change it to make TNM play nice, I should have done it this
	way in the first place.

	 - Renamed the TraceFire function to DoTraceFire so that TNM won't
	override it, thereby undoing aim fixes, splash effects, and so on and
	so forth.  The TraceFire function still exists, but just calls the new,
	renamed function, so other mods will work just fine.

	 - Adjusted the "make sure we have a mission script" fix (and changed
	the MissionScript class) so that if no Mission Script can be found for
	a particular level then the bare-bones "MissionScript" class will be
	spawned, rather than Mission11 (the old default).  There are new log
	messages to go with this change.

	 - Added in Grenade cycling for TNM, and in the process redid the way
	that all weapon cycling is performed.  Not sure if it's more efficient,
	but it's more easily inclusive of mod weapons, whatever they may be.  I
	still have to add them in first though.

	 - Redid a portion of the Robot AI routines so that when you scramble
	them they don't simply switch alliances, they use YOUR alliances to the
	letter.  Among other things, this means that the weird "Spider-Bot +
	Repair Bot" dilemma in the first level of TNM isn't much of a dilemma
	owing to the fact that both bots will simply become friendly.



	v1.8.1 - v0.2:

	 - See Changelog.txt for a list of changes.