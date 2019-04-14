        
"BAD for
			       BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"The BAD scenario..."

<GLOBAL CLOCK-TBL-3 <TABLE I-TOWER 32767
			   I-FUSE 32767
			   I-ASSASSINATION 1080
			   I-FESTIVITIES 60
			   I-TOPAZ 32767
			   I-ELEVATOR-ARRIVES 32767>>
<CONSTANT CLOCK-INTS-3 6>

<CONSTANT I-ASSASSINATION-OFF 5>
<CONSTANT I-TOPAZ-OFF 9>
<CONSTANT I-ELEVATOR-OFF 11>

<ROUTINE TOPAZ-THOUGHT ("OPTIONAL" (CR <>))
	 <COND (,TOPAZ-THOUGHT-STR
		<COND (<EQUAL? .CR 1> <CRLF>)
		      (<NOT .CR> <TELL " ">)>
		<TELL ,TOPAZ-THOUGHT-STR>
		<SETG TOPAZ-THOUGHT-STR <>>
		<RTRUE>)>>

;<ROUTINE BACKTRACKING? (OLD-HERE "AUX" (L <LOC ,TOPAZ>))
	 <REPEAT ()
		 <COND (<EQUAL? .L ,HERE> <RTRUE>)
		       (<EQUAL? .L .OLD-HERE 0> <RFALSE>)>
		 <SET L <GETP .L ,P?PATH>>>>

<GLOBAL TOPAZ-THOUGHT-STR
"You consider telling Topaz who and what you are, but it is too
dangerous; your own men are probably swarming the area, and any
contact with Topaz would blow your cover wide open.">

<OBJECT BAD-GUN
	(DESC "Gurthark Mark VI revolver")
	(SYNONYM PISTOL GUN REVOLVER GURTHARK)
	(ADJECTIVE GURTHARK AUTOMATIC MARK VI)
	(FLAGS TAKEBIT)
	(ACTION BAD-GUN-F)>

<ROUTINE BAD-GUN-F ()
	 <COND (<VERB? POINT>
		<GUN-POINT>)
	       (<VERB? DROP THROW PUT>
		<TELL
"You might need it later. Better keep it around." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It's your Russian-made Gurthark Mark VI 45-caliber revolver. Not
exactly standard issue, but clearly a Soviet product." CR>)>>  

<OBJECT BAD-WATCH
	(DESC "wristwatch")
	(SYNONYM CLOCK WATCH WRISTWATCH)
	(ADJECTIVE WRIST)
	(FLAGS WEARBIT WORNBIT READBIT)
	(ACTION BAD-WATCH-F)>

<ROUTINE BAD-WATCH-F ()
	 <COND (<VERB? DROP TAKE-OFF>
		<TELL
"Time is critical - it would be foolish to be without your watch." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It's a Frotzni, a brand almost as popular in Frobnia as the Urbak." CR>)
	       (<VERB? READ>
		<TELL
"You can read the time on your status line." CR>)>>

<ROUTINE I-ASSASSINATION ()
	 <HLIGHT ,H-BOLD>
	 <CRLF>
	 <COND (<EQUAL? ,HERE ,SNIPER-ROOM>
		<JIGS-UP
"The sniper squeezes the trigger twice, and the sound echoes through
the room. Your agents have chosen well - Huttinger is dead, and you have
failed in your mission.">)
	       (<SQUARE-VIEW?>
		<JIGS-UP
"A shot rings out, then another. The sound echoes through the square,
followed by a different one, the sound of screams, then sirens. Police
run onto the dais, as the body of the American ambassador is carried off
on a stretcher. By instinct, you know he is already dead.">)
	       (T
		<JIGS-UP
"In the direction of the square, you hear the sound of shots being
fired. You needn't be told what has happened - your agents are quite
thorough - the ambassador is dead.">)>>

<ROUTINE I-FESTIVITIES ("AUX" STR FC)
	 <SET FC <+ </ ,CLOCK-TIME 60> 1>>
	 <COND (,FIGHT-IN-PROGRESS
		<SET STR <GET ,FESTIVITIES-F .FC>>)
	       (<OR <SQUARE-VIEW?>
		    <EQUAL? <SET STR <GET ,FESTIVITIES .FC>> -1>>
		<SET STR <GET ,FESTIVITIES-SQ .FC>>)>
	 <COND (.STR <BOLDTELL .STR>)>>
	       
<GLOBAL FESTIVITIES-SQ <PLTABLE
<>
<>
<>
<>
<>
<>
<>
<>
<>
<>
<>
<>
"The town's fifteenth century clock strikes the hour, indicating that the
ceremonies are shortly to commence."
"You watch as the mayor of Ostnitz comes to the podium at the front of the
dais. He motions for the crowd to be silent for the playing of the national
anthem."
"The anthem finished, the mayor calls upon the head of the church of
Litzenburg to give a benediction."
"The priest departs, and the mayor announces the \"kickoff\" speaker,
William Henry Huttinger, the American ambassador. Amidst
the roaring approval of the crowd, Huttinger approaches the rostrum.|
|
It may seem strange for an unaligned country to show such feeling for a
former member of the American military, but it was Huttinger
who led the Allied forces during the liberation of Litzenburg in 1945,
and the people have not forgotten.|
|
How ironic that the Kremlin chose this time, this place for the death
of one of Litzenburg's only heroes. Even more ironic is that the irony is
almost certainly lost on them."
"Having calmed down the crowd, Huttinger begins to speak. The words seem
to careen through your head but make little impact - there are only
moments now in which to act."
"">>

<GLOBAL FESTIVITIES-F <PLTABLE
<>
<>
<>
<>
<>
<>
<>
<>
<>
<>
<>
<>
"The town's fifteenth century clock strikes the hour."
"You notice that the crowd has become quiet. After a moment, the national
anthem begins to play."
"The anthem is now finished, and after a few moments, a benediction is
read."
"The mayor announces the \"kickoff\" speaker, William Henry Huttinger, the
American ambassador. The crowd roars its approval; you've got only moments
before it will be too late to save him!"
"Huttinger begins to speak. The words seem to careen through your head but
make little impact - you have only moments in which to act."
"Huttinger continues to speak, and the crowd responds with enthusiasm,
interrupting him frequently.">>

<GLOBAL FESTIVITIES <PLTABLE
<>
<>
<>
<>
<>
<>
<>
<>
<>
<>
<>
<>
-1
"The crowd noise subsides and the national anthem is begun."
-1
-1
-1
-1>>

<ROUTINE SQUARE-VIEW? ()
	 <INTBL? ,HERE <REST ,SQUARE-VIEWS 2> <GET ,SQUARE-VIEWS 0>>>

<GLOBAL SQUARE-VIEWS
	<PLTABLE BLDG-6 BLDG-5 SQUARE-NW BLDG-1 ALLEY-1 BLDG-2
		 SQUARE-SW BLDG-3 BLDG-4 TOWN-SQUARE>> 

<OBJECT MATCHES
	(DESC "matchbook")
	(SYNONYM MATCH MATCHES MATCHBOOK BOOK)
	(FLAGS TAKEBIT)
	(SIZE 2)
	(ACTION MATCHES-F)>

<ROUTINE MATCHES-F ()
	 <COND (<VERB? ON KILL REMOVE>
		<TELL
"You've tried this before on the train - the matches don't work; perhaps
that's why they're given out for free. The mystery is why you're still
holding on to them." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"The matchbook has no cover; anyone concerned about safety wouldn't be
riding the Frobnian National Railroad anyway." CR>)
	       (<VERB? READ EXAMINE>
		<TELL
"The matchbook bears the logo of the Frobnian National Railway with
its motto, \"You will ride with us.\"" CR>)>>

<OBJECT CIGARETTE
	(DESC "cigarette")
	(SYNONYM CIGARETTE)
	(FLAGS TAKEBIT)
	(SIZE 2)
	(ACTION CIGARETTE-F)>

<ROUTINE CIGARETTE-F ()
	 <COND (<VERB? ON>
		<TELL
"You haven't a lighter and the matches you're carrying have proven themselves
useless; there'll be more time for a smoke after
you finish your mission." CR>)
	       (<VERB? EXAMINE>
		<TELL
"This cigarette is your last; you haven't had enough time to buy another
pack since the fiasco on the train." CR>)>>
	 

<ROOM EDGE-NW
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Street Corner")
      (FDESC "the corner or Brzni and Fremzi")
      (LDESC
"You are at the corner of Brzni, running east-west, and Besnap, running
north and south. The town square can be reached east along Brzni.")
      (NORTH SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")
      (WEST SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")
      (SOUTH PER BB1-MOVE)
      (EAST TO BLDG-7 IF FALSE-FLAG ELSE
"You continue along Brzni Street, arriving in front of a closed hardware
store. The street continues east.")>

<ROOM BEHIND-BLDG-1
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Behind Apartments")
      (FDESC "back side of the apartment building")
      (LDESC
"You are behind the apartment building; there is no access to the inside from
this street. Fremzi continues north and south here; a vacant lot lies to the
west.")
      (NORTH TO EDGE-NW IF FALSE-FLAG ELSE
"You continue down Fremzi Street, coming to the intersection with Brzni
Street, which runs east toward the square.")
      (SOUTH TO EDGE-W IF FALSE-FLAG ELSE
"You are now moving down Fremzi Street, just between Brzni Street to the
north and Besnap Street to the south. The apartment building and office
building lie to your northeast and southeast respectively, but there is
no access here to either. A vacant lot lies to the west.")
      (WEST SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")
      (EAST SORRY
"There's no way into the apartment building from here.")>

<ROUTINE BB2-MOVE ()
	 <BB1-MOVE ,BEHIND-BLDG-2>>

<ROUTINE BB1-MOVE ("OPTIONAL" (RM ,BEHIND-BLDG-1))
	 <TELL
"You continue down Fremzi street, stopping behind the ">
	 <COND (<EQUAL? .RM ,BEHIND-BLDG-1>
		<TELL "apartment">)
	       (T
		<TELL "office">)>
	 <TELL " building
whose entrance would be on Ostnitz Street. There is no entrance here. Across
the street, to the west, lies a vacant lot." CR>
	 <SETG DONT-DESCRIBE-ROOM T>
	 .RM> 

<ROOM EDGE-W
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Near Empty Lot")
      (FDESC "spot directly across from the vacant lot")
      (LDESC
"You are on Fremzi Stret, halfway between Brzni to the north and Besnap
to the south. A vacant lot sits to the west; two buildings rise to the
northeast and southeast, but access to the inside is on Ostnitz Street.")
      (NORTH PER BB1-MOVE)
      (SOUTH PER BB2-MOVE)
      (WEST SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")
      (NE SORRY "You can't enter the apartment building from here.")
      (SE SORRY "You can't enter the office building from here.")
      (EAST SORRY
"There's just a wall there, papered with various uninteresting posters.")>

<ROOM BEHIND-BLDG-2
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Behind Offices")
      (FDESC "back side of the office building")
      (LDESC
"You are behind the office building; there is no access to the inside from
this street. Fremzi continues north and south here; a vacant lot lies to the
west.")
      (NORTH TO EDGE-W IF FALSE-FLAG ELSE
"You are now moving down Fremzi Street, just between Brzni Street to the
north and Besnap Street to the south. The apartment building and office
building lie to your northeast and southeast respectively, but there is
no access here to either. A vacant lot lies to the west.")
      (SOUTH TO EDGE-SW IF FALSE-FLAG ELSE
"You continue along the street to the corner of Besnap and Fremzi;
crowds of people are now heading east through this intersection on
their way to the square.")
      (EAST SORRY
"There's no way into the office building from here.")
      (WEST SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")>

<ROOM EDGE-SW
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Street Corner")
      (FDESC "corner of Besnap and Fremzi")
      (LDESC
"You stand at the corner of Besnap and Fremzi, away from the throngs that
have gathered in Ostnitz Square to the east. Fremzi can be followed to the
north and, for a short ways, to the south, while Besnap is cordoned
off to the west. A large vacant lot lies to the northwest.")
      (NORTH PER BB2-MOVE)
      (SOUTH TO ANTIQUE-SIDE IF FALSE-FLAG ELSE
"You move down Fremzi Street, stopping just short of a police barricade.
Some uniformed police watch you casually; these are probably crowd control
officers, restricting access to the site of the festivities. A closed
metal door lies to the east.")
      (WEST SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")
      (EAST TO BLDG-8 IF FALSE-FLAG ELSE
"You continue along Besnap Street until you come to the front of an
antique shop. The sign outside says:|
|
   Riznik's Antiques|
 Rare Books and Curios|
|
The gathering crowd which surrounds you continues its relentless push toward
Ostnitz Square to the east.")
      (GLOBAL BARRICADE POLICE)>

<ROOM BLDG-8
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Outside Antique Shop")
      (FDESC "antique shop")
      (LDESC
"You're standing on Besnap Street, just outside the entrance to Riznik's
Antique Shop. The crowd here continues to push eastward toward Ostnitz
Square, but you can continue westward to a less congested spot.")
      (NORTH SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")
      (IN-DIR P?SOUTH)
      (SOUTH PER ANTIQUE-ENTER)
      (EAST TO SQUARE-SW IF FALSE-FLAG ELSE
"You continue along the street, jostled every few moments by the surging
crowd, and stop at the intersection of Besnap Street (going east-west) and
Ostnitz Street (going north-south), at the southwest corner of Ostnitz
Square. The Square itself is packed with people awaiting the start of
the Constitution Day festivities.")
      (WEST TO EDGE-SW IF FALSE-FLAG ELSE
"You continue along the street to the corner of Besnap and Fremzi;
crowds of people are now heading east through this intersection on
their way to the square.")>

<OBJECT BUILDING
	(LOC GLOBAL-OBJECTS)
	(DESC "building")
	(SYNONYM BUILDING SHOP STORE STOREFRONT BOOKSTORE)
	(ADJECTIVE APARTMENT OFFICE CHEMIST\'S BOOK TAILOR\'S
	 HARDWARE ANTIQUE)
	(ACTION BUILDING-F)>

<ROUTINE BUILDING-F ()
	 <COND (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,BLDG-8 ,BLDG-3 ,BLDG-4>
		       <DO-WALK ,P?SOUTH>)
		      (<EQUAL? ,HERE ,BLDG-7 ,BLDG-6 ,BLDG-5>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE ,BLDG-1 ,BLDG-2>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE ,BEHIND-BLDG-1 ,BEHIND-BLDG-2>
		       <DO-WALK ,P?EAST>)
		      (<FSET? ,HERE ,PENBIT>
		       <DO-WALK ,P?IN>)
		      (<EQUAL? ,HERE ,HALL-2 ,HALL-3 ,HALL-4>
		       <TELL
"There are apartments to the east and west; which one do you want to
enter?" CR>)
		      (T
		       <TELL "There's no ">
		       <COND (<NOT <EQUAL? ,HERE ,HALL-1>>
			      <TELL "building">)
			     (T
			      <TELL "apartment">)>
		       <TELL " to enter here." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,BLDG-8>
		       <TELL
"It's hard to tell much from here, though it appears that ">
		       <COND (,ANTIQUE-FLAG
			      <TELL "the shop is closed">)
			     (T
			      <TELL "Riznik is inside">
			      <COND (<IN? ,CUSTOMER ,ANTIQUE-SHOP>
				     <TELL ", talking to a customer">)>)>
		       <TELL ,PERIOD-CR>)
		      (T
		       <TELL
"You'll have to get closer, and perhaps even enter the building for
that." CR>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? <GET ,P-ADJW 0> ,W?APARTMENT>>
		<TELL
"You'd get the best view of the apartment building from the town
square." CR>)>>

<OBJECT ANTIQUE-SIGN
	(LOC BLDG-8)
	(DESC "sign")
	(SYNONYM SIGN)
	(FLAGS READBIT NDESCBIT)
	(ACTION ANTIQUE-SIGN-F)>

<ROUTINE ANTIQUE-SIGN-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"|
   Riznik's Antiques|
 Rare Books and Curios" CR>)>> 

<ROOM ANTIQUE-SHOP
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Antique Shop")
      (FDESC "inside of the antique shop")
      (OUT-DIR P?NORTH)
      (NORTH TO BLDG-8 IF FALSE-FLAG ELSE
"You leave the shop, and reenter the gathering crowd which surrounds you
in its relentless push toward Ostnitz Square to the east.")
      (IN-DIR P?SOUTH)
      (SOUTH PER COUNTER-ENTER)
      (GLOBAL CURIOS RARE-BOOKS)
      (ACTION ANTIQUE-SHOP-F)>

<ROUTINE ANTIQUE-SHOP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The shop appears disorganized, with assorted antiques and bric-a-brac
seemingly strewn haphazardly around the floor. What better cover for
Riznik, one of the most meticulous and methodical agents it has been
your pleasure to know. He stands at the counter now, ">
		<COND (<IN? ,CUSTOMER ,HERE>
		       <TELL "talking to a customer whose back
is to you; he averts his gaze - something's wrong!">)
		      (T
		       <TELL
"waving you toward him with a benevolent smile.">)>
		<CRLF>)>> 

<OBJECT CROWD
	(LOC GLOBAL-OBJECTS)
	(DESC "crowd of people")
	(SYNONYM PEOPLE CROWD MASSES SPECTATORS TOURIST TOURISTS)
	(SCENARIO 3)
	(ACTION CROWD-F)>

<ROUTINE CROWD-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,SNIPER-ROOM>
		       <TELL
"You look down at the square and nearby streets, which are practically
overflowing with people pressed up against the barricades." CR>)
		      (<NOT <IN-PUBLIC?>>
		       <TELL
"You can't see the crowd from here." CR>)
		      (T
		       <TELL
"The people are everywhere - tourists, businessmen, families - all
turned out to witness the days' festivities." CR>)>)>>

<ROOM ANTIQUE-STORAGE
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Storage Room")
      (FDESC "storage room")
      (WEST TO ANTIQUE-SIDE IF FALSE-FLAG ELSE
"You leave quietly through the side door, which closes behind you.
You're now on a
north-south street just around the corner from the store's entrance.
Just south of you stands a guarded police barricade.")
      (OUT-DIR P?WEST)
      (IN-DIR P?NORTH)
      (NORTH SORRY "You would only be detained by the police.")
      (GLOBAL CURIOS RARE-BOOKS)
      (ACTION ANTIQUE-STORAGE-F)>

<ROUTINE ANTIQUE-STORAGE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The room is small, dark, and cluttered. The door to the counter area is
slightly ajar, and through it you can hear the police questioning your
friend. He's doing his best, but they are persistent. A side door to the
street lies to the west." CR>)>>

<OBJECT CURIOS
	(LOC LOCAL-GLOBALS)
	(DESC "curio")
	(SYNONYM CURIO CURIOS ANTIQUES ANTIQUE)
	(ADJECTIVE RARE)
	(ACTION CURIOS-F)>

<ROUTINE CURIOS-F ("OPTIONAL" (FOO <>))
	 <COND (<VERB? EXAMINE>
		<TELL
"You don't know much about ">
		<COND (<NOT .FOO>
		       <TELL "antiques">)
		      (T
		       <TELL "rare books">)>
		<TELL ", but some of the pieces look quite rare and
valuable. Someday, you will have to come here under more pleasant
circumstances." CR>)>>

<OBJECT RARE-BOOKS
	(LOC LOCAL-GLOBALS)
	(DESC "rare book")
	(SYNONYM BOOK BOOKS MANUSCRIPT FOLIO FOLIOS)
	(ADJECTIVE RARE OLD)
	(ACTION RARE-BOOKS-F)>

<ROUTINE RARE-BOOKS-F ()
	 <CURIOS-F T>> 

<OBJECT ANTIQUE-SIDE-DOOR
	(LOC ANTIQUE-STORAGE)
	(DESC "side door")
	(SYNONYM DOOR)
	(ADJECTIVE SIDE)
	(FLAGS DOORBIT NDESCBIT)>

<OBJECT ANTIQUE-COUNTER-DOOR
	(LOC ANTIQUE-STORAGE)
	(DESC "counter door")
	(SYNONYM DOOR)
	(ADJECTIVE COUNTER)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION ANTIQUE-COUNTER-DOOR-F)>

<ROUTINE ANTIQUE-COUNTER-DOOR-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL
"The sound of the door ">
		<COND (<VERB? OPEN> <TELL "open">)
		      (T <TELL "clos">)>
		<TELL "ing alerts the police, who storm into
the back room and take you into custody." CR>
		<JIGS-UP ,EPILOGUE-BAD-FAILS>)>>

<OBJECT ANTIQUE-CONVERSATION
	(LOC ANTIQUE-STORAGE)
	(DESC "conversation")
	(SYNONYM CONVERSATION)
	(FLAGS NDESCBIT)
	(ACTION ANTIQUE-CONVERSATION-F)>

<ROUTINE ANTIQUE-CONVERSATION-F ()
	 <COND (<VERB? LISTEN FOLLOW EXAMINE>
		<TELL
"You can't make out every word, but the police are questioning your friend
about certain acquaintences, affiliations, and the like." CR>)
	       (T
		<TELL "Bizarre." CR>)>>

<ROOM ANTIQUE-SIDE
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Side Entrance")
      (LDESC
"This is as far as you can go on Fremzi Stret, before running into the
police cordons. A metal door, closed and locked, lies to the east.
On it, a sign reads \"Riznik's Antiques - Deliveries Only\"")
      (FDESC "side entrance of the antique store")
      (IN-DIR P?EAST)
      (EAST SORRY "The door is locked from the inside.")
      (SOUTH SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")
      (NORTH TO EDGE-SW IF FALSE-FLAG ELSE
"You continue along the street to the corner of Besnap and Fremzi;
crowds of people are now heading east through this intersection on
their way to the square.")
      (GLOBAL POLICE BARRICADE)>

<OBJECT POLICE
	(LOC LOCAL-GLOBALS)
	(DESC "police")
	(SYNONYM POLICE POLICEMAN)
	(ACTION POLICE-F)>

<ROUTINE POLICE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"They are ordinary policemen, here to provide extra security for the
day's events." CR>)
	       (<VERB? TELL CALL YELL HELLO>
		<TELL
"There is no reason to call attention to yourself; you're famous enough
that they might recognize you and take you in for questioning." CR>
		<COND (<VERB? TELL> <STOP>)>
		<RTRUE>)>>

<OBJECT BARRICADE
	(LOC LOCAL-GLOBALS)
	(DESC "barricade")
	(SYNONYM BARRICADE CORDON)>

<OBJECT ANTIQUE-STREET-DOOR
	(LOC ANTIQUE-SIDE)
	(DESC "metal door")
	(SYNONYM DOOR)
	(ADJECTIVE METAL)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION ANTIQUE-STREET-DOOR-F)>

<ROUTINE ANTIQUE-STREET-DOOR-F ()
	 <COND (<VERB? UNLOCK OPEN>
		<TELL
"You can't unlock or open the door from this side." CR>)
	       (<VERB? KNOCK>
		<TELL
"You bang on the door for a while and get no response; it occurs to
you that Riznik, the antique dealer, and your contact, is hard of
hearing." CR>)>>

<ROUTINE I-CUSTOMER-LEAVES ()
	 <DE-RT-QUEUE>
	 <COND (<EQUAL? ,HERE ,ANTIQUE-SHOP>
		<CRLF>
		<HLIGHT ,H-BOLD>
		<SETG P-WALK-DIR <>>
		<PERFORM ,V?TELL ,CUSTOMER>
		<RTRUE>)
	       (<EQUAL? ,HERE ,BLDG-8>
		<BOLDTELL
"You watch as a man walks out of the antique shop. A moment later,
still in motion, he takes a walkie-talkie out of his pocket and
starts speaking into it. Within seconds, he is lost in the crowd. You
try to think, but you're certain you've never seen him before.">)>
	 <REMOVE ,CUSTOMER>>

<ROUTINE COUNTER-ENTER ()
	 <TELL
"You approach the counter ">
	 <COND (<IN? ,CUSTOMER ,ANTIQUE-SHOP>
		<TELL "and the proprietor turns away anxiously." CR>
		<SETG P-WALK-DIR <>>
		<PERFORM ,V?TELL ,CUSTOMER>
		<RFALSE>)
	       (T
		<SETG ANTIQUE-FLAG T>
		<TELL "and the proprietor comes out from behind it
to greet you. \"Welcome, my friend! How may I assist you? A clock,
perhaps? A music box?\" He smiles warmly, but, sensing your urgency,
stops abruptly. \"You are right to look worried. I am being watched. We
must be very careful now.\" You talk
quickly, giving him a condensed version of what has happened, and
why you are in need of information. He nods grimly, and
draws closer. \"Then the businessman on the train must have smuggled
the document across the border. You've seen the extra security, no doubt - the
authorities must know about our plan! The 'event' is at noon, as the
ambassador is speaking to the
crowd. If you're going to get near our sniper, you'll need the password - \"">
		<TELL <GET ,SNIPER-PASSWORD-TBL ,SNIPER-CODE>>
		<TELL "\"; he is positioned in a window
on the...|
|
At just this moment, two uniformed policemen enter. \"You must go. Through
the back!\" He shoves you forcibly through the door to the back room as
the men approach.|
|
The back room itself is small, dark, and cluttered. It's hard to tell the
difference, in fact, between what lies out front and what lies in here. The
door to the counter area is slightly ajar, and through it you can hear the
police questioning your friend. He's doing his best, but they are persistent.
It is not safe here any longer; the door to the street lies to the west.">)>
	 <RT-QUEUE ,I-POLICE-ENTER 95>
	 <CRLF>
	 <SETG DONT-DESCRIBE-ROOM T>
	 <COND (,CHASE-FLAG
		<TELL CR
"A moment later, Topaz bursts into the shop and alerts the police
to your presence. Despite the protests of Riznik, they enter and take you
into custody." CR>
		<JIGS-UP ,EPILOGUE-BAD-FAILS>)>
	 ,ANTIQUE-STORAGE>

<ROUTINE I-POLICE-ENTER ()
	 <DE-RT-QUEUE>
	 <COND (<EQUAL? ,HERE ,ANTIQUE-STORAGE>
		<HLIGHT ,H-BOLD>
		<TELL CR
"The proprietor, unable to hold off the policemen any longer, reluctantly
lets them past the counter and into your hiding place. Finding you there,
they take you into custody." CR>
		<JIGS-UP ,EPILOGUE-BAD-FAILS>)>>

<GLOBAL ANTIQUE-FLAG <>>

<ROOM ANTIQUE-COUNTER
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Antique Shop, Counter")
      (OUT-DIR P?NORTH)
      (NORTH TO ANTIQUE-SHOP)>

<OBJECT PROPRIETOR
	(LOC ANTIQUE-SHOP)
	(DESC "proprietor")
	(SYNONYM PROPRIETOR AGENT CONTACT SPY MAN RIZNIK)
	(ADJECTIVE OLD)
	(FLAGS PERSON NDESCBIT)
	(ACTION PROPRIETOR-F)> 

<OBJECT COUNTER
	(LOC ANTIQUE-SHOP)
	(DESC "counter")
	(SYNONYM COUNTER)
	(FLAGS NDESCBIT)
	(ACTION COUNTER-F)>

<ROUTINE COUNTER-F ()
	 <COND (<VERB? WALK-TO>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The counter is clear of the odds-and-ends which are scattered around
the shop; the proprietor, your contact, is standing behind it." CR>)>>

<ROUTINE PROPRIETOR-F ()
	 <COND (<VERB? WALK-TO>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<VERB? TELL HELLO>
		<COND (<IN? ,CUSTOMER ,HERE>
		       <PERFORM ,V?TELL ,CUSTOMER>
		       <RTRUE>)
		      (T
		       <TELL
"It would be best to approach the man before talking." CR>
		       <STOP>)>)
	       (<VERB? EXAMINE>
		<TELL
"The proprietor is well-known to you; he has been the KGB's local contact
here for over a dozen years. On the surface a warm, though bookish man, he
is in fact hard as nails." CR>)>>

<OBJECT CUSTOMER
	(LOC ANTIQUE-SHOP)
	(DESC "customer")
	(SYNONYM CUSTOMER MAN)
	(FLAGS PERSON NDESCBIT)
	(ACTION CUSTOMER-F)>

<ROUTINE CUSTOMER-F ()
	 <COND (<VERB? WALK-TO>
		<DO-WALK ,P?SOUTH>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"From here, it's difficult to tell much. Medium height, medium build,
nothing special. Could be anyone." CR>)
	       (<VERB? TELL TELL-ABOUT HELLO>
		<TELL
"The customer turns around - his face doesn't register, but yours
apparently does. He reaches under his coat and pulls out a revolver.
\"You will come with me quietly,\" he begins. \"We do not wish any
trouble here today.\" With his free hand, he takes out his identification -
local police. Could they have been tipped off? Could Topaz have gotten
word across the border?" CR>
		<JIGS-UP ,EPILOGUE-BAD-FAILS>)>>  

<GLOBAL EPILOGUE-BAD-FAILS
"|
Epilogue|
|
You are taken to police headquarters, and it is there that you learn of
the successful assassination of the American ambassador. Back home, you are
commended for your work - drawing attention away from the assassins and
thereby helping assure the success of the mission. Sadly, you have failed
in your real mission, but perhaps there was really nothing you could have
done.|
"> 

<ROUTINE ANTIQUE-ENTER ()
	 <COND (,ANTIQUE-FLAG
		<TELL
"The shop has been closed up; Riznik must have gotten out in a hurry." CR>
		<RFALSE>)>
	 <TELL
"A jingling of bells announces your presence in the antique shop. You
close the door behind you, and find yourself in the midst of untold
thousands of antiques, curios, and just plain junk. Just south of your
position is the sales counter, behind which the proprietor is standing.
You recognize him at once; Riznik, your local contact in Ostnitz -
KGB through and through. He looks up at you">
	 <COND (<IN? ,CUSTOMER ,ANTIQUE-SHOP>
		<TELL " nervously, and then starts talking again with
a customer whose back is toward you">)
	       (T
		<TELL ", your face registering at once, and waves you
toward him with a smile">)>
	 <TELL ,PERIOD-CR>
	 <SETG DONT-DESCRIBE-ROOM T>
	 ,ANTIQUE-SHOP>

<ROOM SQUARE-SW
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Ostnitz Square, SW")
      (FDESC "southwest corner of Ostnitz square")
      (LDESC
"Here, at the southwest corner of Ostnitz Square, you can walk down either
Besnap Street to the east and west, or Ostnitz Street to the north and
south. In the Square, thousands of people have gathered for the
festivities which are to begin at noon.")
      (NORTH TO BLDG-2 IF FALSE-FLAG ELSE
"You continue through the crowds as you head down Ostnitz Street, stopping
finally in front of a sidewalk cafe. Waiters here in traditional red robes
cater to the mixed crowd of tourists and locals eager to watch the
festivities while sipping on a drink in the shade. Behind the cafe to
the west is the entrance to the building itself, which appears to be used as
office space. A pair of policemen guard the door - added security for the
occasion.")
      (SOUTH SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")
      (EAST TO BLDG-3 IF FALSE-FLAG ELSE
"You continue along Besnap Street until you come to the front of a closed
bookstore. The street continues east; the town square is just to the north.")
      (NE TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (WEST TO BLDG-8 IF FALSE-FLAG ELSE
"You continue along Besnap Street until you come to the front of an
antique shop. The sign outside says:|
|
   Riznik's Antiques|
 Rare Books and Curios|
|
The gathering crowd which surrounds you continues its relentless push toward
Ostnitz Square to the east.")>

<ROOM BLDG-3
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Bookstore")
      (FDESC "bookstore")
      (LDESC
"You are on Besnap Street in front of a closed bookstore. The street
continues east and west here; the town square lies to the north.")
      (NORTH TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (SOUTH SORRY
"The shop is closed and locked, presumably due to the holiday. With all
of the security in the area, it is unlikely you could force your way in
without being detected.")
      (IN-DIR P?SOUTH)
      (EAST TO BLDG-4 IF FALSE-FLAG ELSE
"You continue along Besnap Street until you come to the front of a closed
tailor's shop. Police barricades block the street to the east; the town
square is just to the north.")
      (WEST TO SQUARE-SW IF FALSE-FLAG ELSE
"You continue along the street, jostled every few moments by the surging
crowd, and stop at the intersection of Besnap Street (going east-west) and
Ostnitz Street (going north-south), at the southwest corner of Ostnitz
Square. The Square itself is packed with people awaiting the start of
the Constitution Day festivities.")>

<ROOM BLDG-4
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Tailor's Shop")
      (FDESC "tailor's shop")
      (LDESC
"You are on Besnap Street in front of a closed tailor's shop. Police
barricades block the street to the east, but you can continue west
easily enough. The square lies to the north.")
      (NORTH TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (NW TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (SOUTH SORRY
"The shop is closed and locked, presumably due to the holiday. With all
of the security in the area, it is unlikely you could force your way in
without being detected.")
      (IN-DIR P?SOUTH)
      (EAST SORRY
"You move toward the barricade, then think twice as you see the line
of policemen blocking your way.")
      (WEST TO BLDG-3 IF FALSE-FLAG ELSE
"You continue along Besnap Street until you come to the front of a closed
bookstore. The street continues west; the town square is just to the north.")
      (GLOBAL BARRICADE POLICE)>

<OBJECT GLOBAL-BLDGS
	(LOC GLOBAL-OBJECTS)
	(DESC "building")
	(SYNONYM BUILDINGS WINDOWS)
	(SCENARIO 3)
	(ACTION GLOBAL-BLDGS-F)>

<OBJECT GLOBAL-WINDOW
	(LOC GLOBAL-OBJECTS)
	(DESC "window")
	(SCENARIO 3)
	(ACTION GLOBAL-WINDOW-F)>

<ROUTINE GLOBAL-WINDOW-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<OR <EQUAL? ,HERE ,BLDG-8 ,BLDG-7 ,BLDG-6>
			   <EQUAL? ,HERE ,BLDG-5 ,BLDG-4 ,BLDG-3>
			   <EQUAL? ,HERE ,BLDG-2 ,BLDG-1>>
		       <PERFORM ,V?LOOK-INSIDE ,BUILDING>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?EXAMINE ,GLOBAL-BLDGS>
		       <RTRUE>)>)>>

<ROUTINE GLOBAL-BLDGS-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<IN-PUBLIC?>
		       <TELL
"You look around at the various buildings and windows, and see nothing
of interest. Perhaps the best spot to survey the entire area would be
from the town square." CR>)
		      (T
		       <TELL
"You can't see much from where you're standing." CR>)>)>>

<OBJECT SQUARE-BUILDINGS
	(LOC TOWN-SQUARE)
	(DESC "building")
	(SYNONYM BUILDING BUILDINGS WINDOW WINDOWS APARTMENT)
	(ADJECTIVE APARTMENT)
	(FLAGS NDESCBIT)
	(ACTION SQUARE-BUILDINGS-F)>

<ROUTINE SQUARE-BUILDINGS-F ()
	 <COND (<VERB? EXAMINE WATCH LOOK-UP>
		<TELL
"You scan the buildings, looking for something, anything, that might help
you locate the assassin. The only remarkable observation you can make is
that, despite the winter weather, the apartment building has three open
windows: ">
		<PRINT-OPEN-WINDOWS>
		<TELL ". It could be nothing - people watching the
ceremonies from their room, health fanatics in need of fresh air, or just
maybe a sniper lying in wait..." CR>)>> 

<GLOBAL SNIPER-FLOOR 0>

<ROOM TOWN-SQUARE
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Ostnitz Square")
      (FDESC "middle of Ostnitz Square")
      (LDESC
"You are amidst a huge crowd which has poured into the square to better
see and hear the afternoon's events. From here, you can move in any
direction, albeit slowly, except toward the barricades to the east.
Behind the barricades, a raised dais has been constructed, and the
dignitaries are already in place. A tall column here commemorates
those who died in the Litzenburger war for independence.")
      (EAST SORRY
"You move toward the barricade, then think twice as you see the line
of policemen blocking your way.")
      (NE TO BLDG-6 IF FALSE-FLAG ELSE
"You leave the square, arriving at Brzni Street in front of a chemist's
shop. The street is blocked by barricades to the east, but it does continue
to the west.")
      (NORTH TO BLDG-5 IF FALSE-FLAG ELSE
"You leave the square, arriving at Brzni Street in front of a vacant
storefront. The street continues east and west.")
      (NW TO SQUARE-NW IF FALSE-FLAG ELSE
"You press through the crowd to the corner of Ostnitz and Brzni Streets.
A police barricade to the north effectively closes off Ostnitz Street
in that direction, but movement in other directions is simple enough,
if slow due to the crowd congestion.")
      (WEST TO ALLEY-1 IF FALSE-FLAG ELSE
"You press through the crowd until you reach Ostnitz Street at a point
where a street vendor is busily peddling his wares - soda, pretzels,
and hot dogs. His cart is practically overflowing with food, but it's
a safe bet that it will all be gone before the afternoon is over. Behind
the cart, to the west, is a blind alley sandwiched between the apartment
building to your north and the office building to your south.")
      (SW TO SQUARE-SW IF FALSE-FLAG ELSE
"You move through the crowd and finally leave the Square at its southwest
corner, at the intersection of Besnap Street (going east-west) and
Ostnitz Street (going north-south).")
      (SOUTH TO BLDG-3 IF FALSE-FLAG ELSE
"You leave the square, arriving at Besnap Street in front of a closed
bookstore. The street continues east and west.")
      (SE TO BLDG-4 IF FALSE-FLAG ELSE
"You leave the square, arriving at Besnap Street in front of a closed
tailor's shop. Police barricades block the street to the east.")
      (GLOBAL BARRICADE POLICE)>

<OBJECT COLUMN
	(LOC TOWN-SQUARE)
	(DESC "tall column")
	(SYNONYM COLUMN)
	(ADJECTIVE TALL MEMORIAL)
	(FLAGS NDESCBIT)
	(ACTION COLUMN-F)>

<ROUTINE COLUMN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The column is tall and graceful, rising seventy feet into the air.
It stands here to commemorate the War of Independence in which tens of
thousands of Litzenburgers gave their lives in the cause of freedom." CR>)>>

<OBJECT DAIS
	(LOC TOWN-SQUARE)
	(DESC "dais")
	(SYNONYM DAIS PODIUM)
	(FLAGS NDESCBIT)
	(ACTION DAIS-F)>

<ROUTINE DAIS-F ()
	 <COND (<VERB? ENTER BOARD CLIMB-ON>
		<TELL
"With the barricades and the police, you can't get near enough." CR>)>>

<OBJECT HUTTINGER
	(LOC TOWN-SQUARE)
	(DESC "Huttinger")
	(SYNONYM HUTTINGER AMBASSADOR)
	(ADJECTIVE AMBASSADOR)
	(FLAGS NDESCBIT PERSON NOABIT NOTHEBIT)
	(ACTION HUTTINGER-F)>

<ROUTINE HUTTINGER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Huttinger is an imposing figure, tall and broad-shouldered, his white
mustache glistening in the sun. Everyone here reveres the man, and his
appearance, despite his advancing years, is as grand as his reputation." CR>)
	       (T
		<DIGNITARIES-F>)>>

<OBJECT MAYOR
	(LOC TOWN-SQUARE)
	(DESC "mayor")
	(SYNONYM MAYOR)
	(FLAGS NDESCBIT PERSON)
	(ACTION MAYOR-F)>

<ROUTINE MAYOR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"You don't recognize the mayor of Ostnitz, though he is obvious from his
ceremonial uniform." CR>)
	       (T
		<DIGNITARIES-F>)>>

<OBJECT DIGNITARIES
	(LOC TOWN-SQUARE)
	(DESC "dignitary")
	(SYNONYM DIGNITARIES DIGNITARY)
	(FLAGS NDESCBIT PERSON)
	(ACTION DIGNITARIES-F)>

<ROUTINE DIGNITARIES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"You don't recognize them, but many are in uniform, representing the
armed forces of Litzenburg. Others, no doubt, are foreigners who,
like Ambassador Huttinger, are taking part in the events of the day." CR>)
	       (<VERB? KILL HIT MUNG TELL HELLO>
		<TELL
"You'd never get close enough for that." CR>
		<COND (<VERB? TELL> <STOP>)>
		<RTRUE>)>>	

<ROOM BLDG-6
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Chemist's Shop")
      (FDESC "chemist's shop")
      (LDESC
"You are on Brzni Street, in front of a closed chemist's shop. Police
barricades block the street to the east, though it is easy, but slow,
going to the west. The town square lies to the south.")
      (NORTH SORRY
"The shop is closed and locked, presumably due to the holiday. With all
of the security in the area, it is unlikely you could force your way in
without being detected.")
      (IN-DIR P?NORTH)
      (SOUTH TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (EAST SORRY
"You move toward the barricade, then think twice as you see the line
of policemen blocking your way.")
      (WEST TO BLDG-5 IF FALSE-FLAG ELSE
"You continue down Brzni Street, arriving in front of a vacant
storefront. The street continues west.")
      (SW TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (GLOBAL BARRICADE POLICE)> 

<ROOM BLDG-5
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Empty Storefront")
      (FDESC "empty storefront")
      (LDESC
"You are on Brzni Street, in front of a vacant storefront. The street
continues east and west here; the town square lies to the south.")
      (NORTH SORRY
"The shop is closed and locked, presumably due to the holiday. With all
of the security in the area, it is unlikely you could force your way in
without being detected.")
      (IN-DIR P?NORTH)
      (SOUTH TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (EAST TO BLDG-6 IF FALSE-FLAG ELSE
"You continue along Brzni until you reach the front of a closed chemist's
shop. Barricades block the way to the east; the town square lies to the
south.")
      (WEST TO SQUARE-NW IF FALSE-FLAG ELSE
"You press through the crowd to the corner of Ostnitz and Brzni Streets.
A police barricade to the north effectively closes off Ostnitz Street
in that direction, but movement in other directions is simple enough,
if slow due to the crowd congestion.")>

<ROOM SQUARE-NW
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Ostnitz Square, NW")
      (FDESC "northwest corner of Ostnitz Square")
      (LDESC
"This is the corner of Brzni Street, running east and west, and Ostnitz
Street, running north and south along the western edge of Ostnitz Square.
Though congested, your way is clear in all directions, except to the
north, where police barricades block the street.")
      (NORTH SORRY
"You would be getting rather far from the action, and you've no time to
spare getting sidetracked.")
      (SOUTH TO BLDG-1 IF FALSE-FLAG ELSE
"You move down Ostnitz Street until you come to the entrance to an apartment
building. When you have seen this building before, it has been protected
by doormen; today, they have been replaced by police. Something is definitely
up here - even an occasion such as this would not normally require so much
extra security. Your mind races - could the plot have been uncovered?")
      (EAST TO BLDG-5 IF FALSE-FLAG ELSE
"You continue down Brzni Street, arriving in front of a vacant
storefront. The street continues east.")
      (WEST TO BLDG-7 IF FALSE-FLAG ELSE
"You continue along Brzni Street, arriving in front of a closed hardware
store. The street continues west.")
      (SE TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to those
who died in the War of Independence. Atop the column, a fifteenth century
clock tolls the hours. Surrounding the square on all sides are stately
buildings dating from the time of the War, most of which now have storefronts
at ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")>

<ROOM BLDG-7
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Hardware Store")
      (FDESC "hardware store")
      (LDESC
"You are on Brzni Street, in front of a closed hardware store. The street
runs east-west here.")
      (NORTH SORRY
"The shop is closed and locked, presumably due to the holiday. With all
of the security in the area, it is unlikely you could force your way in
without being detected.")
      (IN-DIR P?NORTH)
      (WEST TO EDGE-NW IF FALSE-FLAG ELSE
"You continue down Brzni Street, coming to the intersection with Fremzi
Street, which runs south alongside a vacant lot to the west.")
      (EAST TO SQUARE-NW IF FALSE-FLAG ELSE
"You press through the crowd to the corner of Ostnitz and Brzni Streets.
A police barricade to the north effectively closes off Ostnitz Street
in that direction, but movement in other directions is simple enough,
if slow due to the crowd congestion.")>

<ROOM BLDG-1
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Apartment Building")
      (FDESC "apartment building")
      (LDESC
"You're standing outside of a prestigious apartment building. Two
policemen guard the entrance as added security for the afternoon's
events. The street here continues north and south, and the square lies
directly to your east.")
      (NORTH TO SQUARE-NW IF FALSE-FLAG ELSE
"You press through the crowd to the corner of Ostnitz and Brzni Streets.
A police barricade to the north effectively closes off Ostnitz Street
in that direction, but movement in other directions is simple enough,
if slow due to the crowd congestion.")
      (SOUTH TO ALLEY-1 IF FALSE-FLAG ELSE
"You press through the crowd until you reach Ostnitz Street at a point
where a street vendor is busily peddling his wares - soda, pretzels,
and hot dogs. His cart is practically overflowing with food, but it's
a safe bet that it will all be gone before the afternoon is over. Behind
the cart, to the west, is a blind alley sandwiched between the apartment
building to your north and the office building to your south.")
      (EAST TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (WEST TO APARTMENT-LOBBY IF FALSE-FLAG ELSE
"You walk nonchalantly past the guards, nodding at them politely, and find
yourself in the lobby. An elevator lies to the north; its door is open and
the operator, an older woman, is standing inside. A directory, listing the
building's occupants, is standing here as well. You can leave the building
to the east.")
      (IN-DIR P?WEST)
      (SE TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")>

<OBJECT APARTMENT-GUARDS
	(LOC BLDG-1)
	(DESC "guard")
	(SYNONYM GUARD GUARDS POLICE POLICEMAN)
	(FLAGS PERSON NDESCBIT)
	(ACTION APARTMENT-GUARDS-F)>

<ROUTINE APARTMENT-GUARDS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"They are evidently part of the beefed-up security that the police
have put in place for today's events." CR>)
	       (<VERB? CALL WAVE-AT YELL>
		<TELL
"No sense calling attention to yourself." CR>)>>

<OBJECT DIRECTORY
	(LOC APARTMENT-LOBBY)
	(DESC "directory")
	(SYNONYM DIRECTORY LIST LISTING)
	(ADJECTIVE BUILDING APARTMENT)
	(FLAGS NDESCBIT READBIT)
	(ACTION DIRECTORY-F)>

<ROUTINE DIRECTORY-F ()
	 <COND (<VERB? EXAMINE READ>
		<PRINT-APT-DIR>)>>

<ROOM APARTMENT-LOBBY
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Apartment Lobby")
      (SDESC "lobby of the apartment building")
      (LDESC
"This is the lobby of the apartment building; there is little of note here,
except for the elevator, whose door stands open to the north. In front of
you, a directory lists the occupants of the building. You can
exit the building to the east.")
      (NORTH TO ELEVATOR-ROOM)
      (IN-DIR P?NORTH)
      (EAST TO BLDG-1 IF FALSE-FLAG ELSE
"You leave the apartment building, and return to Ostnitz Street, where
the crowd is packed in even tighter than before, especially east, in
the direction of the town square.")
      (OUT-DIR P?EAST)
      (GLOBAL ELEVATOR-DOOR ELEVATOR-OPERATOR ELEVATOR-BUTTON ELEVATOR POLICE)
      (ACTION APARTMENT-LOBBY-F)>

<ROUTINE APARTMENT-LOBBY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<SETG HALL-FLOOR 1>)>>

<OBJECT ELEVATOR
	(LOC LOCAL-GLOBALS)
	(DESC "elevator")
	(SYNONYM ELEVATOR LIFT)
	(ACTION ELEVATOR-F)>

<ROUTINE ELEVATOR-F ()
	 <COND (<VERB? CALL>
		<COND (<FSET? ,ELEVATOR-DOOR ,OPENBIT>
		       <TOO-LATE>)
		      (<EQUAL? ,HERE ,HALL-1 ,HALL-2 ,HALL-3>
		       <TELL
"You'll have to do that from the end of the hallway." CR>)
		      (T
		       <PERFORM ,V?PUSH ,ELEVATOR-BUTTON>
		       <RTRUE>)>)
	       (<VERB? ENTER WALK-TO BOARD>
		<DO-WALK ,P?NORTH>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<OR <FSET? ,ELEVATOR-DOOR ,OPENBIT>
			   <EQUAL? ,HERE ,APARTMENT-LOBBY>>
		       <TELL
"The elevator door is open; an older woman, the operator, is standing
inside." CR>)
		      (T
		       <TELL
"The elevator isn't here now; you might try calling it." CR>)>)>>

<OBJECT ELEVATOR-OPERATOR
	(LOC LOCAL-GLOBALS)
	(DESC "older woman")
	(SYNONYM WOMAN OPERATOR)
	(ADJECTIVE OLD OLDER)
	(FLAGS PERSON)
	(ACTION ELEVATOR-OPERATOR-F)>

<ROUTINE ELEVATOR-OPERATOR-F ()
	 <COND (<NOT <OR <EQUAL? ,HERE ,APARTMENT-LOBBY>
			 <FSET? ,ELEVATOR-DOOR ,OPENBIT>>>
		<TELL
"You can't see the elevator operator here. Perhaps if you called
the elevator you'd have better luck." CR>)
	       (<VERB? EXAMINE>
		<TELL
"She is an elderly woman, seventy years or more, wearing simple
clothes. She looks at you expectantly, waiting for you to enter." CR>)
	       (T
		<TELL
"No use doing that." CR>)>>

<ROOM BLDG-2
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Sidewalk Cafe")
      (FDESC "sidewalk in front of the cafe")
      (NORTH TO ALLEY-1 IF FALSE-FLAG ELSE
"You press through the crowd until you reach Ostnitz Street at a point
where a street vendor is busily peddling his wares - soda, pretzels,
and hot dogs. His cart is practically overflowing with food, but it's
a safe bet that it will all be gone before the afternoon is over. Behind
the cart, to the west, is a blind alley sandwiched between the apartment
building to your north and the office building to your south.")
      (SOUTH TO SQUARE-SW IF FALSE-FLAG ELSE
"You continue along the street, jostled every few moments by the surging
crowd, and stop at the intersection of Besnap Street (going east-west) and
Ostnitz Street (going north-south), at the southwest corner of Ostnitz
Square. The Square itself is packed with people awaiting the start of
the Constitution Day festivities.")
      (WEST SORRY
"You consider trying to force your way into the building, but decide against
it, realizing that anything that calls attention to yourself will jeopardize
either your plan or your cover.")
      (IN-DIR P?WEST)
      (EAST TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (NE TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (ACTION BLDG-2-F)> 

<OBJECT WAITERS
	(LOC BLDG-2)
	(DESC "waiter")
	(SYNONYM WAITER WAITRESS)
	(FLAGS NDESCBIT PERSON)
	(ACTION WAITER-F)>

<ROUTINE WAITER-F ()
	 <COND (<VERB? CALL TELL HELLO>
		<TELL
"The help is very busy here and there is a long line for service;
it would take a while to get their attention." CR>
		<COND (<VERB? TELL> <STOP>)>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The waiters, in ceremonial dress for the occasion, are quite busy and
are rushing to and fro trying to keep up with the customers." CR>)>>

<OBJECT CAFE-FOOD
	(LOC BLDG-2)
	(DESC "food")
	(SYNONYM FOOD LUNCH MEAL EATS)
	(FLAGS NDESCBIT)
	(ACTION CAFE-FOOD-F)>

<ROUTINE CAFE-FOOD-F ()
	 <COND (<VERB? TAKE EAT BUY>
		<TELL
"There is a long line for tables; it would take quite a while to
get a meal here." CR>)>>

<OBJECT CAFE-TABLE
	(LOC BLDG-2)
	(DESC "table")
	(SYNONYM TABLE CHAIR SEAT)
	(FLAGS NDESCBIT)
	(ACTION CAFE-TABLE-F)>

<ROUTINE CAFE-TABLE-F ()
	 <COND (<VERB? SIT CLIMB-ON>
		<TELL
"The tables are all full and there appears to be quite a wait." CR>)>>

<ROUTINE BLDG-2-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER-DESC>
		     <NOT ,TOPAZ-FIGHT>
		     <IN? ,TOPAZ ,HERE>>
		<RT-QUEUE ,I-TOPAZ-SPOTS 5 ,I-TOPAZ-OFF>
		<COND (<NOT <FSET? ,TOPAZ ,TOUCHBIT>>
		       <FSET ,TOPAZ ,TOUCHBIT>
		       <TELL CR
"As you scan the cafe scene, you are taken aback by the sight of Topaz,
sitting at a table not thirty feet from you, sipping on a tall drink and
carefully watching the crowd. His left arm is in a sling, but he appears
completely alert and, perhaps, dangerous. It seems he hasn't seen you
yet." CR>)
		      (T
		       <TELL CR
"You look around, noticing that Topaz is still watchfully waiting at his
table at the cafe." CR>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"A sidewalk cafe sits here on Ostnitz Street facing the square to the east.
Behind it, on office building is guarded by two policemen. Ostnitz Street
continues north and south along the western edge of the square. Waiters
scurry around, hopelessly trying to keep pace with the crowd that has
gathered here looking for a drink and some shade." CR>
		<COND (<AND <IN? ,TOPAZ ,HERE>
			    <FSET? ,TOPAZ ,NDESCBIT>>
		       <TELL CR
"Sitting at a table, not thirty feet away, is Topaz. His eyes take in the
crowd, but he hasn't spotted you yet." CR>)>
		)>>

<ROUTINE I-TOPAZ-SPOTS ()
	 <COND (<OR ,TOPAZ-FIGHT ,CHASE-FLAG>
		<RFALSE>)
	       (<G? <SETG TOPAZ-SPOT-COUNT <+ ,TOPAZ-SPOT-COUNT 1>> 6>
		<BOLDTELL
"Topaz has spotted you! He's started to move away from his table and
rushes in your direction.">
		<SETG I-FATAL T>
		<START-CHASE>
		<RTRUE>)
	       (T
		<RT-QUEUE ,I-TOPAZ-SPOTS 5 ,I-TOPAZ-OFF>)>>

<ROOM ALLEY-1
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Street Vendor")
      (FDESC "vendor's cart")
      (NORTH TO BLDG-1 IF FALSE-FLAG ELSE
"You move down Ostnitz Street until you come to the entrance to an apartment
building. When you have seen this building before, it has been protected
by doormen; today, they have been replaced by police. Something is definitely
up here - even an occasion such as this would not normally have so much in
the way of security. You wonder if perhaps the plot has been uncovered.")
      (SOUTH TO BLDG-2 IF FALSE-FLAG ELSE
"You continue through the crowds as you head down Ostnitz Street, stopping
finally in front of a sidewalk cafe. Waiters here in traditional red robes
cater to the mixed crowd of tourists and locals eager to watch the
festivities while sipping on a drink in the shade. Behind the cafe to
the west is the entrance to the building itself, which appears to be used as
office space. A pair of policemen guard the door - added security for the
occasion.")
      (EAST TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (WEST PER ALLEY-MOVE)
      (NE TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (SE TO TOWN-SQUARE IF FALSE-FLAG ELSE
"You push your way through the crowd, reaching a spot near the middle of
the square where a graceful column stands, dedicated to the Litzenburgers
who died in the War of Independence which is celebrated here today.
Surrounding the square on all sides are stately buildings dating from the 18th
century, most of which now have storefronts on ground level.|
|
Stretching from northeast through southeast, a series of barricades has been
erected to separate the crowd from the dignitaries attending the ceremonies.
Hundreds of uniformed police guard the barricades, and scores of plainclothes
police are milling around nearby, heads cocked toward their earphones to
enable them to hear over the ever louder crowd. The dais is raised about
ten feet, and the dignitaries are just starting to take their positions.")
      (ACTION ALLEY-1-F)
      (GLOBAL ALLEY SODA-CANS PRETZELS VENDOR-CART HOT-DOGS VENDOR)>

<ROUTINE ALLEY-MOVE ()
	 <TELL
"You move around the vendor's cart and enter the alley." CR CR>
	 ,ALLEY-2>

<ROUTINE ALLEY-1-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,CART-TOPPLED?
		       <TELL
"The vendor's cart lies on its side here; soda cans and pretzels lie
all over the ground. The street runs north-south here, with the square
directly to the east.">)
		      (T
		       <TELL
"A street vendor's cart stands here, piled high with his wares -
soda cans, mostly, but also hot dogs and pretzels. The street runs
from north to south here, and the town square lies directly to your
east. People are everywhere, pushing up toward the square and the dais
from which the speakers will deliver their addresses.">)>
		<CRLF>)>>  

<OBJECT BUSINESS-CARD
	(DESC "business card")
	(SYNONYM CARD)
	(ADJECTIVE BUSINESS)
	(SIZE 2)
	(FLAGS READBIT TAKEBIT)
	(ACTION BUSINESS-CARD-F)>

<ROUTINE BUSINESS-CARD-F ()
	 <COND (<VERB? EXAMINE READ>
		<CAN-BE-FOUND>)>>

<ROUTINE CAN-BE-FOUND ()
	 <TELL "The " D ,PRSO
	       " can be found in your BORDER ZONE package." CR>>

<OBJECT BAD-CLOTHES
	(DESC "your clothes")
	(SYNONYM CLOTHES SOCKS SHIRT PANTS CLOTHING CLOTH COAT)
	(ADJECTIVE TRENCH)
	(FLAGS NARTICLEBIT WORNBIT SEARCHBIT SURFACEBIT OPENBIT CONTBIT
	       NOTHEBIT NOABIT)
	(ACTION BYSTANDER-CLOTHES-F)>

<ROUTINE START-CHASE ()
	 <SETG CHASE-FLAG T>
	 <SETG TOPPLE-CHASE ,CART-TOPPLED?>
	 <MOVE ,TOPAZ ,TOPAZ-ROOM>
	 <RT-QUEUE ,I-TOPAZ 30 ,I-TOPAZ-OFF>>

<ROOM TOPAZ-ROOM
      (LOC ROOMS)
      (DESC "Topaz Start Point")
      (FDESC "table he was seated at")
      (PATH BLDG-2)
      (PATH-TIME 15)>

<ROUTINE I-TOPAZ-END ()
	 <HLIGHT ,H-BOLD>
	 <TELL CR
"Topaz, sensing your presence, swings around, and ">
	 <TOPAZ-KILLS>
	 <JIGS-UP " ">>

<ROUTINE TOPAZ-KILLS ()
	 <TELL
"fires twice, hitting you in the chest with both rounds. You fall backward
onto the floor, and Topaz approaches. \"That wasn't so awfully smart, you
know, leaving this " D <HALL-OBJECT? ,SNIPER-HALL> " for me to find.\" He chuckles.
He puts his gun to your head. \"For old times sake,\" he says, shrugging, and
fires.">>

<ROUTINE I-TOPAZ ("AUX" (L <LOC ,TOPAZ>) TIM NL)
	 <COND (<ZERO? .L> <RFALSE>)>
	 <MOVE ,TOPAZ <SET L <GETP .L ,P?PATH>>>
	 <COND (<AND <EQUAL? .L ,SNIPER-ROOM>
		     <HALL-OBJECT? ,SNIPER-HALL>>
		<HLIGHT ,H-BOLD>
		<TELL CR
"Without warning, Topaz bursts through the door, pistol raised, and
fires three rounds at the sniper, who slumps to the floor in a pool of
blood. ">
		<SETG I-FATAL T>
		<RT-QUEUE ,I-TOPAZ-END 20>
		<COND (,HIDING-BEHIND-DOOR
		       <TELL "He pauses, body tensed, and takes a
hesitant step toward the window. He stops again; he's not three
feet in front of you.">
		       <REMOVE ,SNIPER>
		       <MOVE ,SNIPER-CORPSE ,HERE>
		       <DE-QUEUE ,I-ASSASSINATION-OFF>
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)
		      (T
		       <TELL "In the same motion, he turns and ">
		       <TOPAZ-KILLS>
		       <JIGS-UP " ">)>)
	       (<EQUAL? .L ,SNIPER-ROOM>
		<REMOVE ,TOPAZ>
		<SETG TOPAZ-IN-HALL T>
		<DE-QUEUE ,I-TOPAZ-OFF>
		<DE-RT-QUEUE>
		<DE-SLOW-CLOCK-QUEUE>
		<BOLDTELL
"You try, but can hear nothing at all coming from the hallway. Topaz must
be close, but how close you can't determine.">) 
	       (<EQUAL? .L ,HERE>
		<HLIGHT ,H-BOLD>
		<TELL CR "Topaz grabs hold of you ">
		<COND (,ON-THE-CAN
		       <SETG ON-THE-CAN <>>
		       <TELL "by the pants and pulls you down off
the trash can.">)
		      (T
		       <TELL "and spins you around.">)>
		<COND (<IN? ,CUSTOMER ,HERE>
		       <TELL CR
"The customer, appearing to recognize Topaz, pulls out a gun and
comes to his aid. Within moments, you are subdued." CR>
		       <JIGS-UP ,EPILOGUE-BAD-FAILS>)>
		<TELL CR CR "Before you can react, he lands a quick
blow to your ribs, knocking you breathless. He's good, you think, though
he lacks experience. You smile fleetingly, knowing yourself to be a damn
good teacher.">
		<HLIGHT ,H-NORMAL>
		<CRLF>
		<DE-RT-QUEUE>
		<DE-QUEUE ,I-TOPAZ-OFF>
		<SETG TOPAZ-FIGHT T>
		<FSET ,TOPAZ ,OPENBIT>
		<SETG CHASE-FLAG <>>
		<REMOVE ,CUSTOMER>
		<FCLEAR ,TOPAZ ,NDESCBIT>
		;"No more chase..."
		<SETG FIGHT-IN-PROGRESS T>
		<I-CLOCKER 60>
		<BOLDTELL
"The next blow is yours, and the next, but Topaz manages a few good shots
of his own. Time, time. Not much time, you think.">
		<I-CLOCKER 60>
		<HLIGHT ,H-BOLD>
		<TELL CR
"You swing around, knocking Topaz to the ">
		<COND (<OR <FSET? ,HERE ,PENBIT> <FSET? ,HERE ,HUTBIT>>
		       <TELL "floor">)
		      (T
		       <TELL "ground">)>
		<TELL ", and then, a quick kick
to the head and he's out.">
		<SETG FIGHT-IN-PROGRESS <>>
		<COND (<IN-PUBLIC?>
		       <TELL
" You turn to leave, but a small crowd has formed around you. \"It's
alright. He tried to run off with my wallet, and I'm afraid I just got carried
away. Excuse me.\" You straighten yourself up and move away from the
onlookers.">)>
		<HLIGHT ,H-NORMAL>
		<CRLF>
		<STATUS-LINE>
		<I-CLOCKER 30>)
	       (T
	        <SET NL <GETP .L ,P?PATH>>
		<SET TIM <GETP .L ,P?PATH-TIME>>
		<COND (<AND <EQUAL? .NL ,HALL-1>
			    <EQUAL? ,HERE ,SNIPER-ROOM>>
		       <SETG I-FATAL T>
		       <HLIGHT ,H-BOLD>
		       <TELL CR
"You can hear Topaz's footsteps racing down the hall.">
		       <COND (<NOT <HALL-OBJECT? ,SNIPER-HALL>>
			      <TELL " His footsteps slow down, then
stop. He is being careful now, not knowing where to find his prey.">)>
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)
		      (<AND <FSET? .L ,HUTBIT>
			    <EQUAL? ,HERE ,SNIPER-ROOM>
			    <HALL-OBJECT? .L>
			    <NOT <EQUAL? .L ,SNIPER-HALL>>>
		       <REMOVE ,TOPAZ>
		       <DE-QUEUE ,I-TOPAZ-OFF>
		       <DE-RT-QUEUE>
		       <DE-SLOW-CLOCK-QUEUE>
		       <BOLDTELL
"From somewhere in the hallway, you can hear a muffled, cracking noise.
Perhaps Topaz has mistakenly broken into one of the apartments nearby,
hoping to find you inside. A few moments later, you hear feet racing
down the hall, then silence.">)
		      (<AND <EQUAL? .L ,ALLEY-1>
			    <EQUAL? .NL ,ALLEY-2>
			    ,CART-TOPPLED?
			    <NOT ,TOPPLE-CHASE>>
		       ;"** Critical timing"
		       <SETG I-FATAL T>
		       <BOLDTELL
"You look behind you and spot Topaz, down on the ground, having been
knocked over in the near-melee at the vendor's cart. It'll be a little
while before he catches up to you.">
		       <SET TIM 80>)
		      (<AND <EQUAL? .L ,ALLEY-3>
			    <EQUAL? .NL ,FIRE-1>>
		       ;"** Critical timing"
		       <COND (<TOPAZ-VISIBLE?>
			      <SETG I-FATAL T>
			      <BOLDTELL
"You look down; Topaz is on the ground below you, moving the trash
can into position under the ladder.">)>
		       <SET TIM 45>)
		      (<TOPAZ-VISIBLE?>
		       <SETG I-FATAL T>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <TELL
"You look behind you; Topaz has just reached the ">
		       <TELL <GETP .L ,P?FDESC> ".">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)>
		<RT-QUEUE ,I-TOPAZ .TIM ,I-TOPAZ-OFF>
		;<COND (,DEBUG
		       <TELL CR "[Topaz will arrive at " D .NL
			     " at " N .TIM "]" CR>)>
		<RFALSE>)>>

<ROUTINE REAL-HALL (RM)
	 <GETP .RM <GET ,FLOOR-PROPS ,SNIPER-FLOOR>>>

<ROUTINE HALL-OBJECT? (RM)
	 <FIRST? <REAL-HALL .RM>>>

<GLOBAL FIGHT-IN-PROGRESS <>>

<GLOBAL TOPPLE-CHASE 0>

<GLOBAL TOPPLED-CART-TRANSIENT <PLTABLE ALLEY-1 ALLEY-2>>

<ROUTINE IN-PUBLIC? ("OPTIONAL" OBJ "AUX" L)
	 <COND (<ZERO? .OBJ> <SET OBJ ,WINNER>)>
	 <SET L <LOC .OBJ>>
	 <AND <NOT <FSET? .L ,PENBIT>>
	      <NOT <FSET? .L ,HUTBIT>>
	      <NOT <EQUAL? .L ,ALLEY-2 ,ALLEY-3>>
	      <NOT <EQUAL? .L ,ANTIQUE-SHOP ,ANTIQUE-STORAGE>>>>

;<ROUTINE IN-BUILDING? ("OPTIONAL" OBJ "AUX" L)
	 <COND (<ZERO? .OBJ> <SET OBJ ,WINNER>)>
	 <SET L <LOC .OBJ>>
	 <OR <EQUAL? .L ,ANTIQUE-SHOP>
	     <FSET? .L ,HUTBIT>>>		   

<OBJECT VENDOR
	(LOC LOCAL-GLOBALS)
	(DESC "vendor")
	(SYNONYM PEDDLER VENDOR SALESMAN MAN)
	(ADJECTIVE STREET SODA PRETZEL ICE-CREAM)
	(FLAGS PERSON)
	(ACTION VENDOR-F)>

<OBJECT SODA
	(LOC TOPAZ-ROOM)
	(DESC "can of soda")
	(SYNONYM CAN SODA)
	(ADJECTIVE SODA)
	(FLAGS TAKEBIT)
	(ACTION FOOD-F)>

<ROUTINE FOOD-F ()
	 <COND (<VERB? BUY>
		<TELL "You already have one!" CR>)
	       (<AND <VERB? EXAMINE READ>
		     <EQUAL? ,PRSO ,SODA>>
		<PERFORM ,V?EXAMINE ,SODA-CANS>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<AND <NOT <IN? ,PRSO ,TOPAZ-ROOM>>
			    <NOT <IN? ,PRSO ,HERE>>>
		       <TELL
"You've taken one of those already; you've got more important things
on your mind." CR>)
		      (T
		       <MOVE ,PRSO ,WINNER>
		       <TELL
"You take the " D ,PRSO ". The vendor, in his confusion, will never be
the wiser." CR>)>)
	       (<VERB? OPEN>
		<TELL
"If you want to drink the soda, and waste precious time, just say so." CR>)
	       (<VERB? EAT DRINK>
		<MOVE ,PRSO ,TOPAZ-ROOM>
		<SETG CLOCK-MOVE 45>
		<TELL
"You take a moment to finish the " D ,PRSO>
		<COND (<EQUAL? ,PRSO ,SODA>
		       <TELL ", and you throw the can away">)>
		<TELL ,PERIOD-CR>)>>

<OBJECT SODA-CANS
	(LOC LOCAL-GLOBALS)
	(DESC "bunch of soda cans")
	(SYNONYM CANS BUNCH CAN DRINK SODA)
	(ADJECTIVE SODA SOFT)
	(ACROSS SODA)
	(ACTION VENDOR-STUFF-F)>

<ROUTINE VENDOR-STUFF-F ()
	 <COND (<VERB? TAKE>
		<COND (<NOT ,CART-TOPPLED?>
		       <TELL
"The vendor wouldn't be very happy about that. You'll just have to wait your
turn." CR>)
		      (<EQUAL? ,PRSO ,HOT-DOGS>
		       <TELL
"They were inside the cart, so there aren't any lying around." CR>)
		      (<NOT <LOC <GETP ,PRSO ,P?ACROSS>>>
		       <TELL
"Enough with the " D ,PRSO "! You've got more important things to do." CR>)
		      (T
		       <PERFORM ,V?TAKE <GETP ,PRSO ,P?ACROSS>>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,PRSO ,SODA-CANS>>
		<TELL
"It's a can of IC Cola; you frown, remembering the businessman on the train
and the role he has played in this affair." CR>)
	       (<VERB? BUY>
		<TELL
"There's quite a wait and you haven't much time." CR>)>> 

<OBJECT PRETZELS
	(LOC LOCAL-GLOBALS)
	(DESC "bunch of pretzels")
	(SYNONYM BUNCH PRETZELS PRETZEL FOOD)
	(ACROSS PRETZEL)
	(ACTION VENDOR-STUFF-F)>

<OBJECT PRETZEL
	(LOC TOPAZ-ROOM)
	(DESC "pretzel")
	(SYNONYM PRETZEL)
	(FLAGS TAKEBIT)
	(ACTION FOOD-F)>

<OBJECT HOT-DOGS
	(LOC LOCAL-GLOBALS)
	(DESC "hot dog")
	(SYNONYM DOG HOT-DOG HOTDOG FOOD)
	(ADJECTIVE HOT)
	(FLAGS TAKEBIT)
	(ACTION VENDOR-STUFF-F)>

<ROUTINE VENDOR-F ()
	 <COND (<VERB? HELLO TELL>
		<STOP>
		<TELL
"The vendor is quite busy, though he acknowledges you with a brief shake
of his ">
		<COND (,CART-TOPPLED?
		       <TELL "fist">)
		      (T
		       <TELL "head">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? GIVE SHOW>
		<TELL
"He's very busy at the moment, which is apparently more than can be said
about you." CR>)
	       (<VERB? EXAMINE>
		<TELL
"He's your typical European street vendor, specializing in pretzels,
soda, and hot dogs. He's got his hands full ">
		<COND (,CART-TOPPLED?
		       <TELL "dealing with the mess of soda cans and
pretzels from his toppled cart">)
		      (T
		       <TELL "with customers">)>
		<TELL ,PERIOD-CR>)>>

<OBJECT VENDOR-CART
	(LOC LOCAL-GLOBALS)
	(DESC "vendor's cart")
	(SYNONYM CART STAND)
	(ADJECTIVE VENDOR\'S)
	(FLAGS NDESCBIT)
	(ACTION VENDOR-CART-F)>

<GLOBAL TOPAZ-FIGHT <>>

<ROUTINE VENDOR-CART-F ()
	 <COND (<VERB? EXAMINE>
		<COND (,CART-TOPPLED?
		       <TELL
"The cart is on its side, and its contents are strewn all along the
sidewalk, blocking the entrance to the alley." CR>)
		      (T
		       <TELL
"The cart is quite large and piled high with cans of soft drinks and
boxes of pretzels. Inside the cart, the vendor keeps his supply of
hot dogs." CR>)>)
	       (<VERB? OPEN CLOSE>
		<TELL
"That's the vendor's job, presumably." CR>)
	       (<VERB? TOPPLE PUSH MOVE>
		<COND (,CART-TOPPLED?
		       <TOO-LATE>
		       <RTRUE>)>
		<PUTP ,CART-DEBRIS ,P?TRANSIENT ,TOPPLED-CART-TRANSIENT>
		<DYNAMIC-DESC ,BLDG-1 ,P?SOUTH ,ALLEY-OOPS>
		<DYNAMIC-DESC ,BLDG-2 ,P?NORTH ,ALLEY-OOPS>
		<DYNAMIC-DESC ,TOWN-SQUARE ,P?WEST ,ALLEY-OOPS>
		<DYNAMIC-DESC ,ALLEY-1 ,P?WEST
"You dodge not only the vendor's cart, but its strewn contents, and
finally manage to get through to the other side.">
		<DYNAMIC-DESC ,ALLEY-2 ,P?EAST
"You dodge not only the vendor's cart, but its strewn contents, and
finally manage to get through to the other side.">
		<TELL
"With a hefty push, you manage to topple the entire cart, sending hundreds
of cans of soda and dozens of pretzels flying. In the confusion, a few
people are knocked to the ground, causing a sort of chain reaction in
which dozens fall or are knocked down">
		<COND (<EQUAL? ,HERE ,ALLEY-2>
		       <COND (<IN? ,TOPAZ ,ALLEY-1>
			      <TELL ", including Topaz, who is struggling
to regain his footing">
			      <PUT ,CLOCK-TBL
				   ,I-TOPAZ-OFF
				   <+ <GET ,CLOCK-TBL ,I-TOPAZ-OFF>
				      30 ;"** CRITICAL TIMING">>)>
		       <TELL ,PERIOD-CR>)
		      (T
		       <TELL ". You manage to sidestep this
impending melee and ">
		       <COND (,CHASE-FLAG
			      <TELL "hurry">)
			     (T
			      <TELL "move">)>
		       <TELL " off into the safety of the alley." CR CR>
		       <GOTO ,ALLEY-2 <>>
		       <TELL
"You're running down the alley now, just a few steps beyond the
vendor's cart. The scene is somewhat comical, with dozens of people
trying to regain their footing on a carpet of soda cans, which are
acting like ball bearings." CR>)>
		<SETG CART-TOPPLED? T>
		<RTRUE>)
	       (<AND <VERB? CLEAN> ,CART-TOPPLED?>
		<TELL
"An amusing thought, though the vendor would probably kill you if
you approached again." CR>)>>

<GLOBAL ALLEY-OOPS
"You press through the crowd until you reach Ostnitz Street at a point
where a street vendor is busily cleaning up his overturned cart. Soda
cans and pretzels lie everywhere, making the congestion even worse than
it was before. Behind the cart, to the west, is a blind alley sandwiched
between the apartment building to your north and the office building to
your south. It might take a while to get there, though, with all the mess
in the way.">

<ROUTINE DYNAMIC-DESC (RM DIR STR)
	 <PUT <GETPT .RM .DIR> ,SEXITSTR .STR>>

<OBJECT CART-DEBRIS
	(LOC GLOBAL-OBJECTS)
	(DESC "debris")
	(SYNONYM DEBRIS)
	(SCENARIO 3)
	(TRANSIENT <LTABLE>)>	

<ROOM ALLEY-2
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Behind the Cart")
      (FDESC "alley just behind the vendor's cart")
      (EAST TO ALLEY-1 IF FALSE-FLAG ELSE
"You leave the alley at Ostnitz Street; the street vendor is still
here, though his stock is somewhat depleted. The square is before you,
still practically bursting with humanity. The street continues to the
north and south.")
      (WEST PER ALLEY-23)
      (GLOBAL ALLEY SODA-CANS PRETZELS HOT-DOGS VENDOR-CART VENDOR)
      (ACTION ALLEY-2-F)>

<ROUTINE ALLEY-23 ()
	 <COND (,CHASE-FLAG
		<TELL
"You run down the alley to the far end. Above you, out of reach, a
fire-escape ladder rises to the four stories of apartment building
above." CR>
		<SETG DONT-DESCRIBE-ROOM T>)
	       (T
		<TELL
"You move down the alley until you reach the end - a high concrete
wall." CR CR>)>
	 ,ALLEY-3>

<GLOBAL CART-TOPPLED? <>>

<ROUTINE ALLEY-2-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The alley is narrow and thus somewhat darkened; to the east, people
are walking along Ostnitz Street past the street vendor who">
		<COND (,CART-TOPPLED?
		       <TELL "se toppled cart and scattered wares
almost completely block">)
		      (T
		       <TELL" partially blocks">)>
		<TELL " the alley's entrance. The alley is bounded on the
north and south by buildings; the one to the south is an office building of
five stories; to the north lies an apartment building of the same
height." CR>)>> 

<ROOM ALLEY-3
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "End of Blind Alley")
      (FDESC "end of the alley")
      (WEST SORRY
"The wall climbs perhaps twenty feet; there's no way you could get over it.")
      (EAST TO ALLEY-2 IF FALSE-FLAG ELSE
"You head back toward Ostnitz street, stopping just behind the vendor's
cart.")
      (UP PER FIRE-LADDER-REACH)
      (ACTION ALLEY-3-F)
      (GLOBAL FIRE-LADDER FIRE-WINDOW ALLEY)>
      
<ROUTINE ALLEY-3-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? LEAP>>
		<COND (<EQUAL? <GET ,P-ITBL ,P-PREP1N> ,W?DOWN>
		       <COND (,ON-THE-CAN
			      <PERFORM ,V?DISEMBARK ,TRASH-CAN>
			      <RTRUE>)
			     (T
			      <TELL "That's nonsense." CR>
			      <RTRUE>)>)
		      (<NOT ,ON-THE-CAN>
		       <TELL
"Your best jump leaves you a few feet short of the ladder." CR>)
		      (T
		       <DO-WALK ,P?UP>
		       <RTRUE> )>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Here, at the end, the buildings on either side of you rise five stories
into the air; the one to the south is an office building, to the north
an apartment building. On the side of the apartment building, a fire-escape
ladder hangs about a dozen feet above the ground, climbing to windows on all
four above ground levels. There is no access at all here to the office
building." CR>)>>

<OBJECT TRASH-CAN
	(LOC ALLEY-3)
	(DESC "trash can")
	(SYNONYM CAN)
	(ADJECTIVE TRASH)
	(FDESC
"Leaning up against the office building, a foul-smelling trash can is
standing.")
	(LDESC
"An empty trash can is standing here.")
	(FLAGS TAKEBIT CONTBIT OPENBIT TRYTAKEBIT)
	(CAPACITY 40)
	(ACTION TRASH-CAN-F)>

<OBJECT BOXES
	(LOC ALLEY-3)
	(DESC "box")
	(SYNONYM BOXES BOX)
	(ADJECTIVE BROKEN)
	(LDESC
"A few dozen discarded boxes are strewn on the ground here.")
	(ACTION BOXES-F)>

<ROUTINE BOXES-F ()
	 <COND (<VERB? STACK>
		<TELL
"They're too flimsy to be stacked." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"They're typical discarded boxes of different sizes." CR>)
	       (<VERB? MOVE PUT>
		<TELL
"They're so flimsy, they'd probably fall apart if you moved them." CR>)
	       (<VERB? BOARD STAND-ON CLIMB-ON>
		<TELL
"They're only cardboard; you might try something sturdier." CR>)>>

<GLOBAL ON-THE-CAN <>>

<ROUTINE TRASH-CAN-F ()
	 <COND (<VERB? TAKE-OFF DISEMBARK LEAVE LEAP LEAP-OFF>
		<COND (,ON-THE-CAN
		       <SETG ON-THE-CAN <>>
		       <TELL
"You step off the can." CR>)
		      (T
		       <TOO-LATE>)>)
	       (<VERB? CLIMB-ON BOARD STAND-ON CLIMB-UP>
		<COND (,ON-THE-CAN <TOO-LATE>)
		      (<AND <VERB? BOARD>
			    <EQUAL? <GET ,P-ITBL ,P-PREP1N> ,W?IN ,W?INTO>>
		       <TELL
"Getting inside the trash can, while amusing, is not helpful." CR>)
		      (T
		       <SETG ON-THE-CAN T>
		       <TELL
"You're now standing on top of the trash can">
		       <FSET ,TRASH-CAN ,TOUCHBIT>
		       <COND (,CAN-UNDER-LADDER
			      <TELL
". From here, you can reach the bottom rungs of the ladder which
hangs above your head">)
			     (<EQUAL? ,HERE ,ALLEY-3>
			      <TELL
". You can't reach the ladder from here; you're high enough, but the
can is positioned too far away laterally">)>
		       <TELL ,PERIOD-CR>)>)
	       (,ON-THE-CAN
		<TELL "You're standing on it!" CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,TRASH-CAN>>
		<TELL
"No time for that now." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"The can seems to be missing its lid." CR>)
	       (<VERB? TAKE>
		<SETG CAN-UNDER-LADDER <>>
		<RFALSE>)>>

<GLOBAL FIRE-WINDOW-TBL <LTABLE 0 0 0 0 0>>

<OBJECT FIRE-WINDOW
	(LOC LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW)
	(ACTION FIRE-WINDOW-F)>

<GLOBAL CAN-UNDER-LADDER <>>

<ROUTINE FIRE-WINDOW-F ("AUX" FL)
	 <SET FL <GETP ,HERE ,P?SIZE>>
	 <COND (<EQUAL? ,HERE ,ALLEY-3>
		<TELL
"The windows are all above you." CR>)
	       (<VERB? ENTER BOARD>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (<VERB? OPEN RAISE>
		<COND (<ZERO? <GET ,FIRE-WINDOW-TBL .FL>>
		       <PUT ,FIRE-WINDOW-TBL .FL 1>
		       <TELL
"You raise the window just enough to get through." CR>)
		      (T
		       <TOO-LATE>)>)
	       (<VERB? CLOSE LOWER>
		<COND (<ZERO? <GET ,FIRE-WINDOW-TBL .FL>>
		       <TOO-LATE>)
		      (T
		       <PUT ,FIRE-WINDOW-TBL .FL 0>
		       <TELL
"You lower the window to the closed position." CR>)>)>>

<OBJECT ALLEY
	(LOC LOCAL-GLOBALS)
	(DESC "alley")
	(SYNONYM ALLEY)
	(ADJECTIVE BLIND)
	(FLAGS VOWELBIT)
	(ACTION ALLEY-F)>

<ROUTINE ALLEY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The alley runs east-west between the apartment building to the
north and the office building to the south. It is rather narrow and
somewhat dark. It ends at a concrete wall to the west and at the
street end it is ">
		<COND (,CART-TOPPLED?
		       <TELL "completely blocked by an overturned">)
		      (T
		       <TELL "partially blocked by a">)>
		<TELL " street vendor's cart." CR>
		<TOPAZ-DESC>
		<RTRUE>)>>

<OBJECT FIRE-LADDER
	(LOC LOCAL-GLOBALS)
	(DESC "ladder")
	(SYNONYM RUNG RUNGS LADDER FIRE-ESCAPE ESCAPE)
	(ADJECTIVE FIRE-ESCAPE FIRE)
	(ACTION FIRE-LADDER-F)>

<ROUTINE FIRE-LADDER-F ()
	 <COND (<AND <VERB? PUT-UNDER> <EQUAL? ,PRSO ,TRASH-CAN>>
		<COND (,CAN-UNDER-LADDER <TOO-LATE>)
		      (T
		       <SETG CAN-UNDER-LADDER T>
		       <TELL "You ">
		       <COND (<IN? ,TRASH-CAN ,WINNER>
			      <TELL "put down the can and position it">)
			     (T
			      <TELL "move the can until it's positioned">)>
		       <MOVE ,TRASH-CAN ,HERE>
		       <TELL " just underneath the fire-escape
ladder." CR>)>)
	       (<VERB? CLIMB CLIMB-UP>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<AND <VERB? TOUCH CLIMB-ON TAKE> <EQUAL? ,HERE ,ALLEY-3>>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The ladder is made of iron, and it has rusted pretty badly. It runs
along the outside of the apartment building, leading to windows on the
second through fifth floors.">
		<COND (<EQUAL? ,HERE ,ALLEY-3>
		       <TELL
" The bottom rungs are about twelve feet above ground level, making it all but
impossible to reach">
		       <COND (,ON-THE-CAN
			      <TELL
" unless, of course, you're standing on the trash can (which you are)">)>
		       <TELL ".">)>
		<CRLF>)>>

<ROUTINE FIRE-LADDER-REACH ()
	 <COND (<AND ,CAN-UNDER-LADDER ,ON-THE-CAN>
		<SETG ON-THE-CAN <>>
		<SETG CAN-UNDER-LADDER <>>
		<TELL
"You grab hold of the bottom rungs of the ladder and pull yourself
onto the ladder, knocking the can over in the process." CR CR>
		,FIRE-1)
	       (,ON-THE-CAN
		<TELL
"You're high enough, but the can is positioned too far away from
the ladder." CR>
		<RFALSE>)
	       (T
		<TELL
"You try jumping, but even then you can't reach the bottom rungs of
the ladder." CR>
		<RFALSE>)>>

<ROOM FIRE-1
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Fire Escape, 1st Floor")
      (FDESC "bottom of the fire escape")
      (LDESC
"You are at the bottom of the fire-escape ladder, about ten feet above
the ground. The ladder rises to each of the upper four levels and it's
just a short drop to the ground. A toppled trash can lies in the alley
beneath your feet.")
      (DOWN TO ALLEY-3 IF TRUE-FLAG ELSE
"You drop the last four feet to the ground.")
      (UP PER FIRE-2-MOVE)
      (SIZE 1)
      (FLAGS PENBIT)
      (GLOBAL FIRE-LADDER ALLEY)>

<ROOM FIRE-2
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Fire Escape, 2nd Floor")
      (FDESC "fire escape at the second floor")
      (DOWN PER FIRE-1-MOVE)
      (UP PER FIRE-3-MOVE)
      (NORTH TO HALL-1 IF FALSE-FLAG ELSE
"You pull yourself through the window, and find yourself staring at a long
hallway leading north.")
      (IN-DIR P?NORTH)
      (GLOBAL FIRE-LADDER ALLEY FIRE-WINDOW)
      (SIZE 2)
      (FLAGS PENBIT)
      (ACTION FIRE-ROOM-F)>

<ROOM FIRE-3
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Fire Escape, 3rd Floor")
      (FDESC "fire escape at the third floor")
      (DOWN PER FIRE-2-MOVE)
      (UP PER FIRE-4-MOVE)
      (NORTH TO HALL-1 IF FALSE-FLAG ELSE
"You pull yourself through the window, and find yourself staring at a long
hallway leading north.")
      (IN-DIR P?NORTH)
      (GLOBAL FIRE-LADDER ALLEY FIRE-WINDOW)
      (SIZE 3)
      (FLAGS PENBIT)
      (ACTION FIRE-ROOM-F)>

<ROOM FIRE-4
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Fire Escape, 4th Floor")
      (FDESC "fire escape at the fourth floor")
      (DOWN PER FIRE-3-MOVE)
      (UP PER FIRE-5-MOVE)
      (NORTH TO HALL-1 IF FALSE-FLAG ELSE
"You pull yourself through the window, and find yourself staring at a long
hallway leading north.")
      (IN-DIR P?NORTH)
      (GLOBAL FIRE-LADDER ALLEY FIRE-WINDOW)
      (SIZE 4)
      (FLAGS PENBIT)
      (ACTION FIRE-ROOM-F)>

<ROOM FIRE-5
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Fire Escape, 5th Floor")
      (FDESC "fire escape at the fifth floor")
      (DOWN PER FIRE-4-MOVE)
      (UP SORRY "The ladder ends here; there is no access to the roof.")
      (NORTH TO HALL-1 IF FALSE-FLAG ELSE
"You pull yourself through the window, and find yourself staring at a long
hallway leading north.")
      (IN-DIR P?NORTH)
      (GLOBAL FIRE-LADDER ALLEY FIRE-WINDOW)
      (SIZE 5)
      (FLAGS PENBIT)
      (ACTION FIRE-ROOM-F)>

<GLOBAL FIRE-TBL <PLTABLE FIRE-1 FIRE-2 FIRE-3 FIRE-4 FIRE-5>>

<ROUTINE FIRE-1-MOVE ()
	 <FIRE-MOVE ,FIRE-1 "level just above the ground">>

<ROUTINE FIRE-2-MOVE ()
	 <FIRE-MOVE ,FIRE-2 "second">>

<ROUTINE FIRE-3-MOVE ()
	 <FIRE-MOVE ,FIRE-3 "third">>

<ROUTINE FIRE-4-MOVE ()
	 <FIRE-MOVE ,FIRE-4 "fourth">>

<ROUTINE FIRE-5-MOVE ()
	 <FIRE-MOVE ,FIRE-5 "fifth">>

<ROUTINE FIRE-MOVE (RM STR)
	 <TELL "You ">
	 <COND (,CHASE-FLAG
		<TELL "scramble">)
	       (T
		<TELL "move">)>
	 <TELL " ">
	 <COND (<EQUAL? ,PRSO ,P?UP>
		<TELL "up">)
	       (T
		<TELL "down">)>
	 <TELL " the fire-escape ladder until reaching the landing
at the ">
	 <TELL .STR>
	 <TELL " floor.">
	 <COND (<EQUAL? .RM ,FIRE-5>
		<TELL
" The ladder ends here; there is no access to the roof.">)>
	 <COND (<NOT <EQUAL? .RM ,FIRE-1>>
		<TELL
" A window here leads to a hallway along which apartments are
arranged on either side.">)>
	 <CRLF>
	 <SETG DONT-DESCRIBE-ROOM T>
	 .RM>

<GLOBAL HALL-FLOOR 0>

<ROOM HALL-1
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Hallway, Fire Escape")
      (FDESC "hallway near the fire escape")
      (LDESC
"You're at the end of a north-south hallway. There are no doors right here;
they are farther down the hall. The window leading to the fire-escape is
open.")
      (NORTH TO HALL-2 IF FALSE-FLAG ELSE
"You continue down the hall to the next set of doorways, one to the east
and one to the west. You're now about a third of the way toward the end
of the hall.")
      (SOUTH PER LEAVE-HALL)
      (OUT-DIR P?SOUTH)
      (EAST SORRY "There is no door to the east.")
      (WEST SORRY "There is no door to the west.")
      (SIZE 4)
      (FLAGS HUTBIT)
      (2ND-FLOOR HALL-21)
      (3RD-FLOOR HALL-31)
      (4TH-FLOOR HALL-41)
      (5TH-FLOOR HALL-51)
      (GLOBAL FIRE-WINDOW ELEVATOR ELEVATOR-OPERATOR)>

<ROUTINE LEAVE-HALL ()
	 <TELL
"You crawl through the window and to the fire-escape ladder." CR CR>
	 <GET ,HALL-EXIT-TBL ,HALL-FLOOR>>

<GLOBAL HALL-EXIT-TBL <LTABLE 0 FIRE-2 FIRE-3 FIRE-4 FIRE-5>>

<ROOM HALL-2
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Hallway, South")
      (FDESC "southern part of the hallway")
      (LDESC
"You are about one-third of the way betwween the southern and northern
ends of the hallway. Doors are on both sides of you, east and west.")
      (NORTH TO HALL-3 IF FALSE-FLAG ELSE
"You continue down the hall to the next set of doorways, one to the east
and one to the west. You're now about halfway down the hall.")
      (SOUTH TO HALL-1 IF FALSE-FLAG ELSE
"You continue to the end of hall, where a window leads to a fire-escape
ladder connecting the various floors of the building.")
      (EAST SORRY "The door is locked.")
      (WEST SORRY "The door is locked.")
      (FLAGS HUTBIT)
      (2ND-FLOOR HALL-22)
      (3RD-FLOOR HALL-32)
      (4TH-FLOOR HALL-42)
      (5TH-FLOOR HALL-52)
      (SIZE 3)
      (GLOBAL HALL-DOOR-E HALL-DOOR-W ELEVATOR ELEVATOR-OPERATOR)>

<ROOM HALL-3
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Hallway, Middle")
      (FDESC "middle of the hallway")
      (LDESC
"You are halfway between the northern and southern ends of the hallway; closed
doors lie on either side of you.")
      (NORTH TO HALL-4 IF FALSE-FLAG ELSE
"You continue down the hall to the last set of doorways, one to the east
and one to the west. Before you, to the north is an elevator with a white
call button.")
      (SOUTH TO HALL-2 IF FALSE-FLAG ELSE
"You continue down the hall to the next set of doorways, one to the east
and one to the west. You're now about two-thirds of the way toward the end
of the hall.")
      (EAST SORRY "The door is locked.")
      (WEST SORRY "The door is locked.")
      (FLAGS HUTBIT)
      (2ND-FLOOR HALL-23)
      (3RD-FLOOR HALL-33)
      (4TH-FLOOR HALL-43)
      (5TH-FLOOR HALL-53)
      (SIZE 2)
      (GLOBAL HALL-DOOR-E HALL-DOOR-W ELEVATOR ELEVATOR-OPERATOR)>

<ROOM HALL-4
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Hallway, North End")
      (FDESC "north end of the hallway")
      (LDESC
"You are at the northern end of the hallway; closed doors lie on either side
of you, east and west. In front of you, to the north, is an elevator,
beside which is a white call button.")
      (NORTH TO ELEVATOR-ROOM IF ELEVATOR-DOOR IS OPEN)
      (IN-DIR P?NORTH)
      (SOUTH TO HALL-3 IF FALSE-FLAG ELSE
"You continue down the hall to the next set of doorways, one to the east
and one to the west. You're now about a third of the way toward the end
of the hall.")
      (EAST SORRY "The door is locked.")
      (WEST SORRY "The door is locked.")
      (FLAGS HUTBIT)
      (2ND-FLOOR HALL-24)
      (3RD-FLOOR HALL-34)
      (4TH-FLOOR HALL-44)
      (5TH-FLOOR HALL-54)
      (SIZE 1)
      (GLOBAL HALL-DOOR-E HALL-DOOR-W ELEVATOR-BUTTON ELEVATOR-DOOR ELEVATOR-OPERATOR ELEVATOR)>

<ROOM ELEVATOR-ROOM
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "In the Elevator")
      (FDESC "elevator")
      (LDESC
"You're standing in the elevator of the apartment building...")
      (OUT-DIR P?SOUTH)
      (SOUTH TO HALL-4)
      (GLOBAL ELEVATOR-DOOR ELEVATOR-OPERATOR)
      (ACTION ELEVATOR-ROOM-F)>

<ROUTINE ELEVATOR-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<STATUS-LINE>
		<DE-QUEUE ,I-ELEVATOR-OFF>
		<TELL
"The elevator operator says, \"Which floor, please?\"" CR CR>
		<COND (,CHASE-FLAG
		       <COND (<G? ,HALL-FLOOR 1>
			      <COND (<FSET? <LOC ,TOPAZ> ,PENBIT>
				     <TELL
"At this moment, Topaz pulls himself through the window at the far end of the
hall. Fearful that you are about to give him the slip, he">)
				    (T
				     <TELL
"Topaz, still down the hall and fearful that you are about to give him the
slip,">)>
			      <TELL
" pulls out his revolver and fires twice, hitting you in the shoulder
and leg. Wounded, but not seriously, you are taken to police
headquarters, where you are treated and questioned." CR>)
			     (T
			      <TELL
"At this moment, Topaz bursts into the lobby, and motions to the police
guards, who respond by grabbing you. Clearly, they are well aware of Topaz's
identity. After a brief discussion between them, you are hustled off for
questioning." CR>)>
		       <JIGS-UP ,EPILOGUE-BAD-FAILS>)>
		<COND (<ELEVATOR-SEQUENCE>
		       <TELL
"The operator closes the door, and the elevator slowly ">
		       <COND (<G? ,P-NUMBER ,HALL-FLOOR>
			      <TELL "climb">)
			     (T
			      <TELL "descend">)>
		       <TELL "s to the ">
		       <TELL <GET ,CARDINALS ,P-NUMBER>>
		       <TELL " floor; having arrived, the operator
opens the door and hustles you out the door.">
		       <COND (<NOT <EQUAL? ,P-NUMBER 1>>
			      <TELL
" The elevator departs, presumably for the ground floor.">)>
		       <TELL CR CR>
		       <SETG CLOCK-MOVE
			     <+ 15 <* <ABS <- ,P-NUMBER ,HALL-FLOOR>> 5>>>
		       <SETG HALL-FLOOR ,P-NUMBER>
		       <COND (<EQUAL? ,P-NUMBER 1>
			      <GOTO ,APARTMENT-LOBBY>
			      <FSET ,ELEVATOR-DOOR ,OPENBIT>)
			     (T
			      <FCLEAR ,ELEVATOR-DOOR ,OPENBIT>
			      <GOTO ,HALL-4>)>)>)>> 

<ROUTINE ELEVATOR-SEQUENCE ("AUX" PTR)
	 <PRINTI ">>">
	 <PUTB ,P-INBUF 1 0>
	 <READ ,P-INBUF ,P-LEXV>
	 <SET PTR 1>
	 <COND (<AND <NUMBER? .PTR>
		     <G? ,P-NUMBER 0>
		     <L? ,P-NUMBER 6>>
		<COND (<EQUAL? ,HALL-FLOOR ,P-NUMBER>
		       <TELL
"\"We are already there, sir.\" She escorts you off the elevator." CR>
		       <COND (<EQUAL? ,HALL-FLOOR 1>
			      <GOTO ,APARTMENT-LOBBY <>>)
			     (T
			      <GOTO ,HALL-4 <>>)>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (T
		<TELL
"\"Please tell me the floor you wish to go to, from 1 to 5.\"">
		<CRLF>
		<CRLF>
	        <AGAIN>)>>

<ROUTINE I-ELEVATOR-LEAVES ()
	 <COND (<FSET? ,HERE ,HUTBIT>
		<FCLEAR ,ELEVATOR-DOOR ,OPENBIT>
		<BOLDTELL
"The elevator door closes; presumably the elevator will return to the ground
floor.">)>>

<OBJECT ELEVATOR-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "elevator door")
	(SYNONYM DOOR)
	(ADJECTIVE ELEVATOR)
	(FLAGS DOORBIT)
	(ACTION ELEVATOR-DOOR-F)>

<ROUTINE ELEVATOR-DOOR-F ()
	 <COND (<AND <VERB? OPEN> <NOT <FSET? ,PRSO ,OPENBIT>>>
		<TELL
"You might try pushing the call button." CR>)>>

<OBJECT ELEVATOR-BUTTON
	(LOC LOCAL-GLOBALS)
	(DESC "call button")
	(SYNONYM BUTTON)
	(ADJECTIVE WHITE CALL)
	(ACTION ELEVATOR-BUTTON-F)>

<ROUTINE ELEVATOR-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (<FSET? ,ELEVATOR-DOOR ,OPENBIT>
		       <TOO-LATE>
		       <RTRUE>)>
		<TELL
"Click. You hear the sound of the elevator approaching slowly." CR>
		<RT-QUEUE ,I-ELEVATOR-ARRIVES 45 ,I-ELEVATOR-OFF>
		<RTRUE>)>>

<ROUTINE I-ELEVATOR-ARRIVES ()
	 <COND (<EQUAL? ,HERE ,HALL-4>
		<BOLDTELL
"The elevator arrives; the operator, a woman, waits for you to enter.">)
	       (<FSET? ,HERE ,HUTBIT>
		<BOLDTELL
"The elevator door opens down the hall to the north.">)>
	 <FSET ,ELEVATOR-DOOR ,OPENBIT>
	 <RT-QUEUE ,I-ELEVATOR-LEAVES 80 ,I-ELEVATOR-OFF>
	 <RTRUE>>

<OBJECT HALL-DOOR-E
	(LOC LOCAL-GLOBALS)
	(DESC "eastern door")
	(SYNONYM DOOR)
	(ADJECTIVE EAST EASTERN E)
	(FLAGS DOORBIT)
	(ACTION HALL-DOOR-F)>

<OBJECT HALL-DOOR-W
	(LOC LOCAL-GLOBALS)
	(DESC "western door")
	(SYNONYM DOOR)
	(ADJECTIVE WEST WESTERN W)
	(FLAGS DOORBIT)
	(ACTION HALL-DOOR-F)>

<ROUTINE HALL-DOOR-F ()
	 <COND (<VERB? SHOOT>
		<TELL
"Risky at best; suicidal at worst." CR>)
	       (<OR <EQUAL? ,PRSO ,HALL-DOOR-W>
		    <NOT <EQUAL? ,HALL-FLOOR ,SNIPER-FLOOR>>
		    <NOT <EQUAL? ,HERE ,SNIPER-HALL ,SNIPER-ROOM>>
		    <AND <NOT <EQUAL? ,HERE ,SNIPER-ROOM>>
			 <G? ,CLOCK-TIME 1000>>>
		;"The wrong door, in fact, or too late..."
		<COND (<VERB? KNOCK>
		       <TELL
"You wait for a few seconds, but there is no answer." CR>
		       <SETG CLOCK-MOVE 20>)
		      (<VERB? LISTEN>
		       <TELL
"You can't hear anything from inside the apartment; if the sniper were a
pro, you probably wouldn't hear him anyway." CR>)
		      (<VERB? OPEN UNLOCK KICK>
		       <TELL
"Rather unsubtle, don't you think. Surely you can think of something less
likely to get you embarrassed or killed." CR>)
		      (<VERB? EXAMINE>
		       <TELL-ROOM-NUMBER>)>)
	       (<EQUAL? ,HERE ,SNIPER-ROOM>
		;"On the inside"
		<COND (<VERB? EXAMINE>
		       <TELL
"The door is closed and locked from the inside." CR>)
		      (<AND <VERB? OPEN UNLOCK>
			    <IN? ,SNIPER ,HERE>>
		       <TELL
"You move slowly toward the door, but the sniper's senses are sharper
than your own. \"Please stay away from the door. There are enemy agents
all around us; we must be on our guard!\" Backing away from the door,
you find yourself thinking that your choices are few and unpleasant." CR>)
		      (<VERB? HIDE-BEHIND>
		       <COND (,HIDING-BEHIND-DOOR
			      <TOO-LATE>)
			     (T
			      <SETG HIDING-BEHIND-DOOR T>
			      <TELL
"You move back toward the door a few feet; not enough to alarm the sniper,
but enough to be out of the line of fire, should it come to that." CR>)>)
		      (<VERB? LISTEN>
		       <TELL
"You can't hear anything from the hallway." CR>)
		      (<VERB? KNOCK>
		       <TELL
"You think twice; the sniper would probably kill you first." CR>)>) 
	       (<VERB? EXAMINE>
		<TELL-ROOM-NUMBER>)
	       (<VERB? KICK>
		<TELL
"This would no doubt alert the sniper, with dangerous results." CR>)
	       (<VERB? LISTEN>
		<TELL
"You can't hear anything from inside the apartment; if the sniper were a
pro, you probably wouldn't hear him anyway." CR>)
	       (<VERB? OPEN>
		<TELL
"You try the knob - the door is locked." CR>)
	       (<AND <VERB? KNOCK> <NOT ,AWAITING-PASSWORD>>
		<SETG AWAITING-PASSWORD ,CLOCK-TIME>
		<TELL
"There is a brief pause, then a heavily accented voice answers. There
is a distinct tension in his voice as he says \"Say the word,
please. Quickly!\"" CR>)
	       (<VERB? KNOCK>
		<TELL
"There is no answer. Your delay in answering the sniper puts you
in a very dangerous position." CR>)>>

<GLOBAL AWAITING-PASSWORD <>>

<GLOBAL HIDING-BEHIND-DOOR <>>

<ROUTINE CHECK-PASSWORD ()
	 <COND (<AND ,AWAITING-PASSWORD
		     <L? <- ,CLOCK-TIME ,AWAITING-PASSWORD> 100>>
		<COND (<EQUAL? <GET ,P-LEXV <GET ,OOPS-TABLE ,O-CONT>>
			       <GET ,SNIPER-PASSWORD-VOC ,SNIPER-CODE>>
		       <TELL
"The door opens slightly, and a small, dark man answers. He waves a
pistol in your direction, and glances both ways down the hall. ">
		       <COND (<FSET? <LOC ,TOPAZ> ,HUTBIT>
			      ;"He's in the hallway"
			      <JIGS-UP
"Seeing that you have been followed, he screams with rage, \"You have
betrayed us!\" Without a moment's hesitation, he pulls the trigger, ending
your life.">)
			     (T
			      ;"Not in sight..."
			      <TELL
"Satisfied that you were not followed, he motions you into the room.
Again, reassuring himself that you weren't followed, he ">
			      <COND (<SNIPER-SPOTS?>
				     <TELL "picks up the items on
the ground, moves them into his room, ">)>
			      <TELL "closes and
locks the door, then walks back to the window. \"There is not much time,\"
he says, blankly.">
			      <TELL CR CR
"The apartment is bare of all furniture. Kneeling in the window, perfectly
motionless, the sniper eyes his target through the sights of his high-powered
rifle." CR>
			      <GOTO ,SNIPER-ROOM <>>
			      <RTRUE>)>)
		      (T
		       <TELL
"There is no reply, though you can hear a faint shuffling of feet
through the door." CR>)>)
	       (,AWAITING-PASSWORD
		<TELL
"There is only silence coming from within the room." CR>)
	       (T
		<TELL
"Nobody here seems interested in your words." CR>)>>

<ROUTINE SNIPER-SPOTS? ("AUX" OBJ (OFF 0) F N (FLG <>))
	 <SET F <FIRST? ,SNIPER-HALL>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (T
			<SET N <NEXT? .F>>
			<COND (<AND <G? <GETP .F ,P?SIZE> 2>
				    <NOT <EQUAL? .F ,PROTAGONIST>>>
			       <SET FLG T>
			       <RETURN>)>)>
		 <SET F .N>>
	 <COND (.FLG
		<MOVE-ALL ,SNIPER-HALL ,SNIPER-ROOM>
		<RTRUE>)>>

<ROUTINE MOVE-ALL (FROM TO "AUX" F N)
	 <SET F <FIRST? .FROM>>
	 <REPEAT ()
		 <COND (<NOT .F> <RTRUE>)
		       (T
			<SET N <NEXT? .F>>
			<MOVE .F .TO>)>
		 <SET F .N>>>

<OBJECT SNIPER-WINDOW
	(LOC SNIPER-ROOM)
	(DESC "window")
	(SYNONYM WINDOW)
	(FLAGS NDESCBIT)
	(ACTION SNIPER-WINDOW-F)>

<ROUTINE SNIPER-WINDOW-F ()
	 <COND (<VERB? LOOK-INSIDE EXAMINE>
		<TELL
"From here, you have a panoramic view of the town square and the ceremonies
which will be going on throughout the afternoon." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"The sniper would kill you first." CR>)>>
	       
<OBJECT SNIPER
	(LOC SNIPER-ROOM)
	(DESC "sniper")
	(SYNONYM SNIPER MAN IRANIAN ASSASSIN)
	(ADJECTIVE DARK)
	(FLAGS NDESCBIT PERSON)
	(ACTION SNIPER-F)>

<OBJECT SNIPER-CORPSE
	(DESC "sniper's corpse")
	(SYNONYM SNIPER CORPSE SNIPER\'S IRANIAN)
	(FLAGS NDESCBIT)>

<ROUTINE SNIPER-F ("AUX" WEAPON)
	 <COND (<OR <VERB? KILL SHOOT>
		    <AND <VERB? POINT>
			 <EQUAL? ,PRSO ,BAD-GUN ,REMINGTON>>>
		<SET WEAPON ,BAD-GUN>
		<COND (<VERB? POINT>
		       <SET WEAPON ,PRSO>)
		      (,PRSI
		       <SET WEAPON ,PRSI>)
		      (<AND <NOT ,PRSI>
			    <IN? ,REMINGTON ,WINNER>>
		       <SET WEAPON ,REMINGTON>
		       <TELL
"[Assuming you're using the Remington.]" CR CR>)>
		<COND (<NOT <EQUAL? .WEAPON ,REMINGTON ,BAD-GUN>>
		       <TELL "Some weapon..." CR>
		       <RTRUE>)>
		<TELL
"You pull out ">
		<COND (<EQUAL? .WEAPON ,REMINGTON>
		       <TELL "Topaz's">)
		      (T
		       <TELL "your">)>
		<TELL " gun and fire at the sniper, who collapses
to the floor in a bloody heap. The shots will most likely draw some
attention, especially in light of the heightened security, so you make
a hasty retreat from the room.|
|
">
		<COND (<OR ,TOPAZ-IN-HALL
			   <AND <NOT ,TOPAZ-FIGHT>
				<FSET? <LOC ,TOPAZ> ,HUTBIT>>>
		       <JIGS-UP
"But Topaz is there, and taking no chances, fires three shots at you,
killing you almost instantly.">)
		      (T
		       <TELL
"Epilogue|
|
You return to the Soviet Union to file your report, but news of the
incident has already reached the Kremlin, via additional local KGB agents
who were on the scene and were friendly with the local police. Between the
death of the Iranian by shots fired">
		       <COND (<EQUAL? .WEAPON ,REMINGTON>
			      <TELL
", as it was painstakingly pieced together, by a gun which was stolen
from an American agent,">)
			     (T
			      <TELL " from a Russian-made revolver">)>
		       <TELL
" and the strange happenings on the train ending in
the loss of a coded cable ">
		       <COND (<EQUAL? .WEAPON ,REMINGTON>
			      <TELL "to that SAME agent,
a cable that had been entrusted to you">)
			     (T
			      <TELL "that was entrusted to you">)>
		       <JIGS-UP ", a pall of suspicion
hangs over you. A short time later, you are reassigned away from sensitive
materials, effectively ending your usefulness as an American double-agent.
A small price to pay, perhaps, for the life of the Ambassador, but you
cannot help but feel that things might have worked out much better.">)>)
	       (<OR <VERB? STRANGLE PUT-THROUGH KICK BITE HIT>
		    <AND <VERB? THROW> <EQUAL? ,PRSI ,SNIPER>>>
		<JIGS-UP
"The sniper, who has been watching you carefully, spins around and fires
at you, killing you instantly.">)
	       (<VERB? WALK-TO>
		<TELL
"The sniper notices you approach, and warns you back with his rifle. He's
too watchful for you to approach him successfully." CR>)
	       (<VERB? CALL TELL HELLO>
		<TELL
"The sniper motions for you to be quiet. \"I mind little the annoyance
of being watched, but stay quiet or I cannot do the work.\" He regards
you with suspicion and a barely concealed contempt." CR>
		<COND (<VERB? TELL> <STOP>)>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"He is crouching in the window, alternately staring through the sights of
his high-powered rifle and at you. He would appear to be of
Middle Eastern origin, though his nationality isn't entirely clear." CR>)>> 

<OBJECT SNIPER-RIFLE
	(LOC SNIPER-ROOM)
	(DESC "high-powered rifle")
	(SYNONYM RIFLE)
	(ADJECTIVE HIGH-POWERED)
	(FLAGS NDESCBIT)
	(ACTION SNIPER-RIFLE-F)>

<ROUTINE SNIPER-RIFLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It appears to be an East German made weapon; very professional. There
should be no problem hitting Huttinger from this distance." CR>)
	       (<VERB? TAKE WALK-TO KICK>
		<TELL
"The sniper, already suspicious of your presence, fends you off as you
approach." CR>)>>

<GLOBAL SNIPER-CODE <>>

<GLOBAL SNIPER-PASSWORD-TBL <PLTABLE "Besnap" "Riznik" "Belboz" "Brzni">>

<GLOBAL SNIPER-PASSWORD-VOC <PLTABLE W?BESNAP W?RIZNIK W?BELBOZ W?BRZNI>>

<ROOM SNIPER-ROOM
      (LOC ROOMS)
      (PATH 0)
      (PATH-TIME 0)
      (DESC "Sniper's Room")
      (FDESC "sniper's room")
      (WEST TO HALL-1 IF HALL-DOOR-E IS OPEN)
      (OUT-DIR P?WEST)
      (GLOBAL HALL-DOOR-E)
      (ACTION SNIPER-ROOM-F)>

<ROUTINE SNIPER-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The room is bare of furniture; an open window looks out over the square. ">
		<COND (<IN? ,SNIPER ,HERE>
		       <TELL
"The sniper is perched in that window; he seems to spend his time alternately
looking through the sights and looking with suspicion at you, seemingly
as ready to fire in your direction as in Huttinger's, and with as little
concern for the outcome.">)
		      (T
		       <TELL
"The motionless body of the sniper is lying in a heap near the window.">)>
		<TELL " The door to the hallway lies to the west." CR>)
	       (<AND <EQUAL? .RARG ,M-BEG> <IN? ,SNIPER ,HERE>>
		<COND (<VERB? SAY TELL>
		       <TELL
"The sniper motions you to keep silent." CR>
		       <STOP>)
		      (<VERB? YELL CALL>
		       <TELL
"The sniper would shoot you in an instant if you tried that." CR>)>)>>

<GLOBAL APT-LETTERS <PTABLE "A" "B" "C" "D" "E" "F">>

<ROUTINE TELL-ROOM-NUMBER ("AUX" TMP)
	 <TELL "The door is solid oak; the number ">
	 <TELL N ,HALL-FLOOR>
	 <SET TMP <* <- <GETP ,HERE ,P?SIZE> 1> 2>>
	 <COND (<EQUAL? ,PRSO ,HALL-DOOR-E>
		<SET TMP <+ .TMP 1>>)>
	 <TELL <GET ,APT-LETTERS .TMP>>
	 <TELL " is affixed on it in brass." CR>>

<GLOBAL CARDINALS <PLTABLE "first" "second" "third" "fourth" "fifth">>

<ROUTINE FIRE-ROOM-F (RARG "AUX" FL)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You're standing on the fire-escape ladder at the ">
		<TELL <GET ,CARDINALS <SET FL <GETP ,HERE ,P?SIZE>>>>
		<TELL " floor. Through the ">
		;<TELL <GET ,OPEN-CLOSED-TBL <GET ,FIRE-WINDOW-TBL .FL>>>
		<TELL "window in front of you, you can see a long
corridor stretching out to the north." CR>)>> 

<GLOBAL CHASE-FLAG <>>

<OBJECT GLOBAL-TOPAZ
	(LOC GLOBAL-OBJECTS)
	(SCENARIO 3)
	(DESC "Topaz")
	(SYNONYM TOPAZ AGENT)
	(ADJECTIVE AGENT)
	(FLAGS NOABIT NOTHEBIT)
	(ACTION GLOBAL-TOPAZ-F)>

<ROUTINE GLOBAL-TOPAZ-F ()
	 <COND (<VERB? HELLO TELL>
		<TELL
"He's pretty far from you, and couldn't hear you well in this crowd noise."
CR>
		<COND (<VERB? TELL> <STOP>)>
		<RTRUE>)
	       (<AND <VERB? THROW> <EQUAL? ,PRSI ,GLOBAL-TOPAZ>>
		<REMOVE ,PRSO>
		<COND (<EQUAL? ,PRSO ,SODA>
		       <COND (<FSET? <LOC ,TOPAZ> ,PENBIT>
			      <TELL
"The can hits Topaz, causing him to lose his balance on the ladder.
It will take him a little while to recover his footing." CR>
			      <PUT ,CLOCK-TBL
				   ,I-TOPAZ-OFF
				   <+ <GET ,CLOCK-TBL ,I-TOPAZ-OFF> 15>>
			      <SETG CLOCK-MOVE 3>)
			     (T
			      <TELL
"Topaz fends off the soda can; it must have hurt, but you haven't
gained any time." CR>
			      <SETG CLOCK-MOVE 2>
			      <RTRUE>)>)
		      (T
		       <TELL
"Topaz dodges the " D ,PRSO ". It wouldn't have done much damage,
anyhow." CR>)>)
	       (<VERB? CALL HELLO>
		<TELL
"There's no time for conversation now; he'd kill you if he got close
enough." CR>)
	       (<VERB? SHOOT KILL HIT POINT>
		<COND (<OR <FSET? ,HERE ,PENBIT>
			   <FSET? ,HERE ,HUTBIT>
			   <EQUAL? ,HERE ,SNIPER-ROOM>>
		       <TELL "You consider it, but">)
		      (T
		       <TELL
"At this distance, you'd probably take out a few innocent bystanders as
well, and">)>
		<TELL
" after all ... he's on your side. Killing him would be a poor
outcome indeed, though it might improve your stature with various elements
of the KGB." CR>)
	       (<VERB? SEARCH>
		<TELL
"You wouldn't want to get that close." CR>)
	       (<VERB? EXAMINE>
		<COND (<TOPAZ-VISIBLE?>
		       <SETG CLOCK-MOVE 3>
		       <TELL-TOPAZ-MOVEMENT>
		       <RTRUE>)
		      (,CHASE-FLAG
		       <TELL
"You can't see him, but he's surely following
you, just a few seconds behind." CR>)
		      (T
		       <TELL
"You can't see Topaz now." CR>)>)
	       (T
		<TELL
"You aren't close enough." CR>)>>

<OBJECT TOPAZ
	(LOC BLDG-2)
	(DESC "Topaz")
	(LDESC
"Topaz is lying unconscious on the ground.")
	(SYNONYM TOPAZ AGENT MAN)
	(ADJECTIVE AGENT)
	(FLAGS NDESCBIT NOABIT NOTHEBIT CONTBIT SURFACEBIT PERSON)
	(CAPACITY 100)
	(ACTION TOPAZ-F)>

<ROUTINE TOPAZ-F ()
	 <COND (<AND <VERB? KILL HIT SHOOT> ,HIDING-BEHIND-DOOR>
		<COND (<VERB? KILL SHOOT>
		       <TELL "Rather than killing him, y">)
		      (T
		       <TELL "Y">)>
		<TELL
"ou hit Topaz on the back of his skull">
		<COND (<IN? ,BAD-GUN ,WINNER>
		       <TELL " with your pistol">)>
		<TELL ", knocking
him out cold. You smile, thinking how neatly everything has worked out.
Assassination thwarted. Topaz makes the kill. Viper barely escapes
with his life. No bad publicity for the KGB.|
|
Sure there'll be some forms to fill out, and there'll be some
questioning, but you'll survive. You smile, and look over the scene -
one corpse, one agent with a lot of potential, but a little rough
around the edges. His story would be worth hearing someday, but
it will have to wait. You walk through the door, tipping your
hat to your unconscious counterpart. \"Until we meet again.\"|
|
|
Congratulations. You have successfully completed the final chapter
of Border Zone. If you have enjoyed this game, or if you have comments,
good or bad, please send them along to:|
|
Infocom, Inc.|
125 CambridgePark Drive|
Cambridge, MA  02140|
Attn: Topaz|
|
">
		<FINISH>)
	       (<EQUAL? ,HERE ,SNIPER-ROOM>
		<COND (<VERB? CALL YELL TELL SAY>
		       <STOP>
		       <TELL
"Unwise; he'd probably turn and shoot you." CR>)>)
	       (,TOPAZ-FIGHT
		;"Down for the count"
		<COND (<VERB? EXAMINE>
		       <TELL
"Topaz is sleeping blissfully at your feet; he should stay that way for
quite a while.">
		       <COND (<FIRST? ,TOPAZ>
			      <TELL " ">
			      <V-LOOK-INSIDE>)
			     (T
			      <CRLF>)>)
		      (<VERB? CLIMB-ON BOARD ENTER>
		       <TELL
"In this conservative country, that sort of behavior is frowned upon." CR>)
		      (<VERB? TELL CALL YELL ALARM>
		       <TELL "Too late for all that now." CR>
		       <COND (<VERB? TELL> <STOP>)>
		       <RTRUE>)
		      (<VERB? OPEN CLOSE>
		       <TELL "A surgeon, you're not." CR>)
		      (<VERB? MOVE PUSH>
		       <TELL "He's OK as he is." CR>)
		      (<VERB? SHOOT>
		       <TELL
"He's already unconscious; no need to kill him." CR>)
		      (<VERB? SEARCH>
		       <COND (<NOT <LOC ,REMINGTON>>
			      <MOVE ,REMINGTON ,WINNER>
			      <TELL
"You search Topaz, taking his gun, a Remington 38-caliber revolver.
He didn't have a scrap of ID on him." CR>)
			     (T
			      <TELL
"You don't find anything else of interest on Topaz." CR>)>)>)
	       (<EQUAL? ,HERE ,BLDG-2>
		<COND (<VERB? HELLO TELL>
		       <STOP>
		       <TELL
"There's no time for talking to Topaz now, and what could you say now
that would make any difference to him." CR>)
		      (<VERB? WALK-TO>
		       <COND (<TOPAZ-THOUGHT 2>)
			     (T
			      <TELL
"You've already given up that idea.">)>
		       <CRLF>)
		      (<AND <VERB? THROW> <EQUAL? ,PRSI ,TOPAZ>>
		       <REMOVE ,PRSO>
		       <TELL
"The " D ,PRSO " misses Topaz, but it comes close enough to grab his
attention. He rises from his table, and starts toward you." CR>
		       <START-CHASE>
		       <RTRUE>)
		      (<VERB? SHOOT>
		       <TELL
"Out here, in public, you'd never get away; and why would you want
to shoot Topaz anyway?" CR>)
		      (<VERB? EXAMINE>
		       <TELL
"He is sitting at the cafe, nursing a tall drink and his wounded left arm,
and watching the crowd. He hasn't seen you yet." CR>)
		      (<VERB? CALL YELL WAVE-AT>
		       <TELL
"You call out for Topaz, who turns in your direction. He gets up and
starts to come after you." CR>
		       <START-CHASE>
		       <RTRUE>)
		      (<VERB? POINT>
		       <TELL
"He won't see you pointing the gun at him." CR>)
		      (T
		       <TELL
"You're not close enough for that." CR>)>)>>

<OBJECT REMINGTON
	(DESC "Remington")
	(SYNONYM GUN REVOLVER PISTOL REMINGTON)
	(ADJECTIVE REMINGTON)
	(FLAGS TAKEBIT)
	(ACTION REMINGTON-F)>

<ROUTINE REMINGTON-F ()
	 <COND (<VERB? POINT>
		<GUN-POINT>)
	       (<VERB? EXAMINE>
		<TELL
"It is a standard-issue American weapon." CR>)>>

<ROUTINE GUN-POINT ()
	 <TELL "Don't bother pointing it; just shoot it at something." CR>>

<ROUTINE TOPAZ-VISIBLE? ("AUX" (TL <LOC ,TOPAZ>))
	 <COND (<EQUAL? ,HERE ,SNIPER-ROOM>
		<RFALSE>)
	       (<AND <OR <EQUAL? ,HERE ,ALLEY-1 ,ALLEY-2 ,ALLEY-3>
			 <FSET? ,HERE ,PENBIT>>
		     <OR <FSET? .TL ,PENBIT>
			 <EQUAL? .TL ,ALLEY-1 ,ALLEY-2 ,ALLEY-3>>>
		<RTRUE>)
	       (<AND <FSET? ,HERE ,HUTBIT>
		     <OR <FSET? .TL ,HUTBIT>
			 <EQUAL? .TL <GET ,FIRE-TBL ,HALL-FLOOR>>>>
		<RTRUE>)
	       (<EQUAL? <GETP .TL ,P?PATH> ,HERE>
		<RTRUE>)
	       (<AND <EQUAL? .TL ,TOPAZ-ROOM>
		     <EQUAL? ,HERE ,BLDG-1 ,ALLEY-1>>
		<RTRUE>)>>

<ROUTINE TELL-TOPAZ-MOVEMENT ("AUX" (TL <LOC ,TOPAZ>)
			      	    (NTL <GETP .TL ,P?PATH>))
	 <COND (<NOT <TOPAZ-DESC <>>>
		<COND (,TOPAZ-FIGHT
		       <TELL
"Presumably, he's on the ground where you left him." CR>)
		      (T
		       <TELL
			"Topaz is still following you; he's now between ">
		       <TELL <GETP .TL ,P?FDESC>>
		       <TELL " and ">
		       <TELL <GETP .NTL ,P?FDESC>>
		       <TELL ,PERIOD-CR>)>)>>		     

<ROUTINE TOPAZ-DESC ("OPTIONAL" (BOLD T)
		     "AUX" (L <LOC ,TOPAZ>) (NL <GETP .L ,P?PATH>) TMP
		     	   (NLT <- <GET ,CLOCK-TBL ,I-TOPAZ-OFF>
				   ,CLOCK-TIME>))
	 <COND (<TOPAZ-VISIBLE?>
		<COND (<AND <EQUAL? .L ,ALLEY-3> <EQUAL? .NL ,FIRE-1>>
		       <COND (.BOLD
			      <HLIGHT ,H-BOLD>
			      <CRLF>)>
		       <TELL "Topaz has ">
		       <COND (<G? .NLT 20>
			      <TELL "arrived at the end of the alley. He is
retrieving the trash can.">)
			     (<G? .NLT 15>
			      <TELL "retrieved the trash can and is now
positioning it under the ladder.">)
			     (<G? .NLT 10>
			      <TELL "positioned the can and is now
climbing on top of it.">)
			     (<G? .NLT 5>
			      <TELL "just about climbed within reach
of the ladder.">)
			     (T
			      <TELL "reached the ladder and is pulling
himself up onto it.">)>
		       <HLIGHT ,H-NORMAL>
		       <CRLF>) 
		      (<AND <FSET? .L ,PENBIT>
			    <FSET? .NL ,PENBIT>
			    <OR <FSET? ,HERE ,PENBIT>
				<EQUAL? ,HERE ,HALL-1>>>
		       <COND (.BOLD
			      <HLIGHT ,H-BOLD>
			      <CRLF>)>
		       <TELL "Topaz is climbing up the ladder, just ">
		       <TELL N <SET TMP <- <GETP ,HERE ,P?SIZE>
					   <GETP .L ,P?SIZE>>>>
		       <TELL " floor">
		       <COND (<NOT <EQUAL? .TMP 1>>
			      <TELL "s">)>
		       <TELL " beneath you.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)
		      (<EQUAL? .L ,TOPAZ-ROOM>
		       <COND (.BOLD
			      <HLIGHT ,H-BOLD>
			      <CRLF>)>
		       <TELL
"Topaz is entangled in a group of tourists who had been eating at the cafe,
but he continues to move in your direction.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)
		      (<L? .NLT 21>
		       <COND (.BOLD
			      <HLIGHT ,H-BOLD>
			      <CRLF>)>
		       <COND (<L? .NLT 6>
			      <TELL
"Topaz is within a few dozen yards of you; if you don't keep moving, he'll
be on top of you in just a few moments.">)
			     (<L? .NLT 11>
			      <TELL
"Topaz is closing in; he can't be more than ten seconds behind you
now.">)
			     (T
			      <TELL
"Topaz is running at full speed in your direction. He's probably only
a few dozen seconds behind you now.">)>
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)>)>>
		
<GLOBAL TOPAZ-IN-HALL <>>

<GLOBAL TOPAZ-SPOT-COUNT 0>

<ROUTINE PICK-NAME (TBL "AUX" ENT OFF DIR)
	 <REPEAT ()
		 <SET OFF <- <* <RANDOM </ <GET ,DIR-NAMES 0> 2>> 2> 1>>
		 <COND (<ZERO? <SET ENT <GET ,DIR-NAMES .OFF>>>
			<AGAIN>)
		       (T
			<PUT .TBL 0 .ENT>
			<PUT .TBL 1 <GET ,DIR-NAMES <+ .OFF 1>>>
			<PUT ,DIR-NAMES .OFF 0>
			<RTRUE>)>>>
		       
<GLOBAL DIR-NAMES
	<LTABLE "Brgmiz" 6 "Dornik" 6 "Blenka" 6 "Cyrink" 6 "Endrizen" 8
		"Galnitz" 7 "Mrtzki" 6 "Profnim" 7 "Onilik" 6 "Brzni" 5
		"Lebniz" 6 "Brlensk" 7 "Rivni" 5 "Cnezeni" 7 "Veznich" 7
		"Lengnoz" 7 "Gentezek" 8 "Carlyni" 7 "Dimwitz" 7 "Urg" 3
		"Robnerim" 8 "Bextra" 6 "Winip" 5 "Kooplitz" 8 "Sinkriz" 7
		"Blivik" 6 "Flipni" 6>>

<GLOBAL APT-DIR
	<LTABLE 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE FILL-DIR ("AUX" CNT TBL)
	 <SET CNT 24>
	 <SET TBL <REST ,APT-DIR 2>>
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0>
			<RETURN>)
		       (T
			<PICK-NAME .TBL>
			<SET TBL <REST .TBL 4>>)>>>

<ROUTINE PRINT-OPEN-WINDOWS ("AUX" (FLR 3))
	 <REPEAT ()
		 <TELL "on the " <GET ,CARDINALS .FLR> " floor, ">
		 <COND (<L? <GET ,APT-DIR <+ <* <- .FLR 2> 12> 8>> 0>
			<TELL "near the middle">)
		       (T
			<TELL "at the northern end">)>
		 <TELL " of the building">
		 <COND (<G? <SET FLR <+ .FLR 1>> 5>
			<RETURN>)
		       (<EQUAL? .FLR 5>
			<TELL ", and ">)
		       (T
			<TELL ", ">)>>>

<GLOBAL SNIPER-HALL 0>

<ROUTINE PICK-OPEN-WINDOWS ("AUX" (FLR 3) NUM H)
	 <SETG SNIPER-FLOOR <+ <RANDOM 3> 2>>
	 <REPEAT ()
		 <PUT ,APT-DIR
		      <SET NUM <+ <* <- .FLR 2> 12>
				  <COND (<PROB 50>
					 <SET H ,HALL-3>
					 8)
					(T
					 <SET H ,HALL-4>
					 4)>>>
		      <- 0 <GET ,APT-DIR .NUM>>>
		 <COND (<EQUAL? .FLR ,SNIPER-FLOOR>
			<SETG SNIPER-HALL .H>
			<PUT ,APT-DIR <- .NUM 1> 0>)>
		 <COND (<G? <SET FLR <+ .FLR 1>> 5>
			<RETURN>)>>>	 

<ROUTINE SNIPER-INIT ()
	 <SETG SNIPER-CODE <RANDOM 4>>
	 <FILL-DIR>
	 <PICK-OPEN-WINDOWS>
	 <FILL-VACANCIES>>

<ROUTINE FILL-VACANCIES ("AUX" MAX (CNT 5) RND)
	 <SET MAX </ <GET ,APT-DIR 0> 2>>
	 <REPEAT ()
		  <COND (<L? <SET CNT <- .CNT 1>> 0>
			 <RETURN>)>
		  <SET RND <RANDOM .MAX>>
		  <COND (<NOT <L? <GET ,APT-DIR <* .RND 2>> 0>>
			 <PUT ,APT-DIR <- <* .RND 2> 1> 0>)
			(T
			 <SET CNT <+ .CNT 1>>)>>>

<ROUTINE PRINT-APT-DIR ("AUX" CNT TMP TBL LEN)
	 <SET CNT -1>
	 <TELL CR
"           Gribnitz Apartments" CR CR>
	 <TELL
"     2nd      3rd      4th      5th">
	 <CRLF>
	 <REPEAT ()
		 <SET TBL <REST ,APT-DIR 2>>
		 <CRLF>
		 <COND (<G? <SET CNT <+ .CNT 1>> 5>
			<RETURN>)
		       (T
			<PRINTC <+ .CNT %<ASCII !\A>>>
			<TELL ": ">
			<SET TBL <REST .TBL <* .CNT 4>>>
			<SET TMP 0>
			<REPEAT ()
				<COND (<G? <SET TMP <+ .TMP 1>> 4>
				       <RETURN>)
				      (<ZERO? <GET .TBL 0>>
				       <TELL "         ">)
				      (T
				       <TELL <GET .TBL 0>>
				       <SET LEN <GET .TBL 1>>
				       <COND (<L? .LEN 0>
					      ;<COND (,DEBUG
						     <TELL "*">)>
					      <SET LEN <- 0 .LEN>>)>
				       <PRINT-SPACES <- 9 .LEN>>)>
				<SET TBL <+ .TBL 24>>>)>>>
	   
<GLOBAL FLOOR-PROPS
	<LTABLE 0 P?2ND-FLOOR P?3RD-FLOOR P?4TH-FLOOR P?5TH-FLOOR>>

<OBJECT HALL-21>
<OBJECT HALL-31>
<OBJECT HALL-41>
<OBJECT HALL-51>
<OBJECT HALL-22>
<OBJECT HALL-32>
<OBJECT HALL-42>
<OBJECT HALL-52>
<OBJECT HALL-23>
<OBJECT HALL-33>
<OBJECT HALL-43>
<OBJECT HALL-53>
<OBJECT HALL-24>
<OBJECT HALL-34>
<OBJECT HALL-44>
<OBJECT HALL-54>