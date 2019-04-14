
"BYSTANDER for
			       BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROOM PLATFORM-1
      (LOC ROOMS)
      (DESC "Platform, North End")
      (SOUTH PER PLATFORM-MOVE-2)
      (NORTH SORRY
"The platform ends here at a tall fence, marking the actual border between
Frobnia and Litzenburg.")
      (WEST SORRY
"A guard prevents you from boarding the train. \"Nye mneshna pletska bli!\"")
      (GLOBAL PLAT-TRAIN PLAT-GUARDS PLAT-PEOPLE PLAT-FENCE)
      (FLAGS PLATFORMBIT)
      (ACTION PLATFORM-ROOM-F)>

<OBJECT PLAT-FENCE
	(LOC LOCAL-GLOBALS)
	(DESC "fence")
	(SYNONYM FENCE)
	(ADJECTIVE BORDER)
	(ACTION PLAT-FENCE-F)>

<ROUTINE PLAT-FENCE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The fence is perhaps twenty feet tall, and virtually unscalable. It's
a good thing you have a ticket." CR>)>>

<ROOM PLATFORM-2
      (LOC ROOMS)
      (DESC "Train Platform")
      (NORTH PER PLATFORM-MOVE-1)
      (SOUTH PER PLATFORM-MOVE-3)
      (WEST SORRY
"A guard prevents you from boarding the train. \"Nye mneshna pletska bli!\"")
      (GLOBAL PLAT-TRAIN PLAT-GUARDS PLAT-PEOPLE)
      (FLAGS PLATFORMBIT)
      (ACTION PLATFORM-ROOM-F)>

<ROOM PLATFORM-3
      (LOC ROOMS)
      (DESC "Train Platform")
      (NORTH PER PLATFORM-MOVE-2)
      (SOUTH PER PLATFORM-MOVE-4)
      (WEST SORRY
"A guard prevents you from boarding the train. \"Nye mneshna pletska bli!\"")
      (GLOBAL PLAT-TRAIN PLAT-GUARDS PLAT-PEOPLE)
      (FLAGS PLATFORMBIT)
      (ACTION PLATFORM-ROOM-F)>

<ROOM PLATFORM-4
      (LOC ROOMS)
      (DESC "Platform, South End")
      (NORTH PER PLATFORM-MOVE-3)
      (SOUTH SORRY
"The platform ends here, and a guard prevents you from going any farther.")
      (WEST SORRY
"A guard prevents you from boarding the train. \"Nye mneshna pletska bli!\"")
      (GLOBAL PLAT-TRAIN PLAT-GUARDS PLAT-PEOPLE)
      (FLAGS PLATFORMBIT)
      (ACTION PLATFORM-ROOM-F)>

<ROUTINE PLATFORM-MOVE-1 ()
	 <PLATFORM-MOVE ,PLATFORM-1>>

<ROUTINE PLATFORM-MOVE-2 ()
	 <PLATFORM-MOVE ,PLATFORM-2>>

<ROUTINE PLATFORM-MOVE-3 ()
	 <PLATFORM-MOVE ,PLATFORM-3>>

<ROUTINE PLATFORM-MOVE-4 ()
	 <PLATFORM-MOVE ,PLATFORM-4>>

<GLOBAL FOLLOW-WARNING <>>

<GLOBAL FOLLOW-SURE <>>

<ROUTINE PLATFORM-MOVE (RM)
	 <TELL 
"You walk slowly through the crowd">
	 <COND (<NOT <IN? ,CONTACT ,HERE>>
		<TELL ", eyes open but totally in the dark
regarding the nature of your contact">)>
	 <TELL ".">
	 <COND (<AND <G? ,SUSPICION 0>
		     <NOT ,FOLLOW-WARNING>>
		<SETG FOLLOW-WARNING T>
		<TELL " It's probably nothing, but you could swear
that a man you see behind you was also behind you before you started
walking.">)
	       (<AND ,FOLLOW-WARNING <NOT ,FOLLOW-SURE>>
		<COND (<PROB 40>
		       <SETG FOLLOW-SURE T>
		       <TELL
" There he is again, ducking behind a group of tourists. It's all but
certain you're being followed!">)
		      (T
		       <TELL
" You nonchalantly look around, and are relieved that the man you
saw earlier is no longer around.">)>)>
	 <COND (<EQUAL? .RM ,PLATFORM-1>
		<TELL CR CR
"You've come to the northern end of the platform now, and you can see in the
distance the darkness that is Litzenburg.">)
	       (<EQUAL? .RM ,PLATFORM-4>
		<TELL CR CR
"You've arrived at the platform's southern end, and can look back into
Frobnia, sighting its formidible border defenses: guard towers, searchlights,
patrols, guard dogs - God knows what else. It's a whole lot better to have a
ticket, and you smile, realizing that it's not easy this way either.">)>
	 <CRLF>
	 <SETG DONT-DESCRIBE-ROOM T>
	 .RM>

<ROUTINE PLATFORM-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The platform itself is
the same size as the trains which cross the border here - four
train-lengths - a hundred yards or so. The train you arrived on is
standing here, each entrance door guarded so as to prevent passengers
from reboarding until the train is ready to leave. Why? Don't ask." CR>
		<TELL CR
"There are people everywhere, milling back and forth - men, women, even
a few children. And then there are the guards, the ones you can see, and,
more troublesome, the ones you can't." CR CR>
		<COND (<EQUAL? ,HERE ,PLATFORM-1>
		       <TELL
"Right now, you're standing at the northern end of the platform. Looking
ahead, you can see the darkness that is Litzenburg at night. In just a few
minutes, you hope to be there ... after making your contact." CR>)
		      (<EQUAL? ,HERE ,PLATFORM-2>
		       <TELL
"You're now alongside the second car." CR>)
		      (<EQUAL? ,HERE ,PLATFORM-3>
		       <TELL
"You're now alongside the third car." CR>)
		      (T
		       <TELL
"You're at the southern end of the platform. Looking back into Frobnia,
you can start to make out the border defenses of Frobnia. Incredible.
Guard towers. Searchlights. Patrols. Guard dogs. God knows what else.
Better to have a ticket. You smile, thinking that even then it's not all that
easy!" CR>)>)>>

<OBJECT PLAT-GUARDS
	(LOC LOCAL-GLOBALS)
	(DESC "guard")
	(SYNONYM GUARD GUARDS)
	(FLAGS PERSON)
	(ACTION PLAT-GUARDS-F)>

<ROUTINE PLAT-GUARDS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"There guards here are many and close between, to twist a phrase. They
are all in uniform - well, you think so, in any case. Each is constantly
looking about for whatever happens to be illegal on this particular day." CR>)
	       (<HURT? ,PLAT-GUARDS>
		<TELL
"To what end? The jails are not known for their comfort or amenities." CR>)>>

<OBJECT PLAT-PEOPLE
	(LOC LOCAL-GLOBALS)
	(DESC "crowd of people")
	(SYNONYM PEOPLE MEN WOMEN CHILDREN CROWD THRONG)
	(ACTION PLAT-PEOPLE-F)>

<ROUTINE PLAT-PEOPLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"There are quite a large number of people here on the platform - maybe a
few hundred or more - men, women, children - and no idea of who your
contact is to be." CR>)
	       (<VERB? SEARCH>
		<TELL
"You stare at the people in the crowd, but it's no use. You have no idea
who the contact might be." CR>)>>

<OBJECT GLOBAL-CONTACT
	(LOC GLOBAL-OBJECTS)
	(DESC "contact")
	(SYNONYM CONTACT)
	(ACTION GLOBAL-CONTACT-F)>

<ROUTINE GLOBAL-CONTACT-F ()
	 <COND (<NOT <EQUAL? ,SCENARIO 1 3>>
		<TELL
"You must be thinking of another scenario." CR>)
	       (<EQUAL? ,SCENARIO 3>
		<COND (<VERB? FIND WHERE>
		       <TELL
"Your contact is Riznik, the antique dealer. His business card clearly
shows how to find him." CR>)>)
	       (<IN? ,CONTACT ,HERE>
		<COND (<EQUAL? ,PRSO ,GLOBAL-CONTACT>
		       <PERFORM ,PRSA ,CONTACT ,PRSI>)
		      (T
		       <PERFORM ,PRSA ,PRSO ,CONTACT>)>
		<RTRUE>)
	       (<VERB? FIND WHERE>
		<TELL
"You have almost nothing to go on, but in any event, the contact was
supposed to find you at the station platform." CR>)
	       (T
		<TELL
"You can't see your contact here, or if you can, you don't know it." CR>)>>

<GLOBAL SMALL-NUMS-TBL
	<PLTABLE "one compartment"
		 "two compartments"
		 "three compartments"
		 "four compartments"
		 "five compartments">>

<OBJECT GLOBAL-COMPARTMENT
	(LOC GLOBAL-OBJECTS)
	(DESC "compartment")
	(SYNONYM COMPARTMENT)
	(ADJECTIVE MY)
	(SCENARIO 1)
	(ACTION GLOBAL-COMPARTMENT-F)>

<ROUTINE GLOBAL-COMPARTMENT-F ()
	 <COND (<VERB? FIND WALK-TO>
		<COND (<EQUAL? ,HERE ,COMP-5 ,PASS-5>
		       <TELL "Right here." CR>)
		      (T
		       <TELL
"It's the southmost compartment along the passageway." CR>)>)
	       (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,PASS-5>
		       <DO-WALK ,P?IN>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,COMP-5>
		       <TELL "Right here." CR>)
		      (<OR <EQUAL? ,HERE ,PASS-2 ,PASS-3 ,PASS-4>
			   <EQUAL? ,HERE ,PASS-1>>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)
		      (T
		       <TELL ,GET-THERE-FIRST CR>)>)
	       (<VERB? LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,COMP-5>
		       <DO-WALK ,P?OUT>
		       <RTRUE>)
		      (T
		       <TELL ,GET-THERE-FIRST CR>
		       <RTRUE>)>)
	       (<AND <VERB? LOOK-INSIDE>
		     <NOT <EQUAL? ,HERE ,COMP-5>>>
		<PERFORM ,PRSA ,COMP-N-DOOR>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,COMP-5>
		       <PERFORM ,V?LOOK>
		       <RTRUE>)
		      (T
		       <TELL "It's easier from inside." CR>)>)>>

<CONSTANT GET-THERE-FIRST "You'll have to get there first.">

<ROOM COMP-5
      (LOC ROOMS)
      (DESC "Your Compartment")
      (OUT PER COMP-EXIT)
      (EAST PER COMP-EXIT)
      (WEST SORRY "Your situation is serious, but not desperate.")
      (GLOBAL COMP-5-DOOR)
      (ACTION COMP-5-F)>

<ROUTINE COMP-5-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL 
"This is your compartment on the train to Litzenburg. You were lucky enough
to avoid having a roommate on this trip, so the two bench-style seats are
more than enough. The compartment itself is quite simple - the two seats
on either side, the openable window looking out over the nighttime landscape,
the emergency stop cord, the luggage rack. It easily could be worse; this is
the first-class car, after all. What little privacy exists on this train
is in the form of a door to the east which is now ">
		<COND (<FSET? ,COMP-5-DOOR ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<COND (<IN? ,COMP-BLOOD-STAIN ,HERE>
		       ;<NOT <FSET? ,COMP-BLOOD-STAIN ,INVISIBLE>>
		       <TELL
". A blood stain is noticeable on the floor here, a grim reminder of
the task that lies ahead">)>
		<TELL ,PERIOD-CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<FCLEAR ,COMP-5-DOOR ,OPENBIT>
		<RTRUE>)>>

<OBJECT COMP-CORD
	(LOC COMP-5)
	(DESC "emergency stop cord")
	(SYNONYM CORD ROPE HANDLE)
	(ADJECTIVE EMERGENCY STOP)
	(FLAGS NDESCBIT)
	(ACTION COMP-CORD-F)>

<ROUTINE COMP-CORD-F ()
	 <COND (<VERB? PULL>
		<TELL
"You pull the cord, but nothing happens. This doesn't surprise you,
considering the train itself." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It's just a piece of cord with a small wooden handle on the end." CR>)>> 

<OBJECT COMP-RACK
	(LOC COMP-5)
	(DESC "luggage rack")
	(SYNONYM RACK)
	(ADJECTIVE LUGGAGE)
	(FLAGS OPENBIT TRANSBIT SEARCHBIT NDESCBIT CONTBIT SURFACEBIT)
	(CAPACITY 100)
	(ACTION COMP-RACK-F)>

<ROUTINE COMP-RACK-F ()
	 <COND (<OR <VERB? OPEN CLOSE>
		    <AND <VERB? EXAMINE> <NOT <FIRST? ,PRSO>>>>
		<TELL
"It's just an open rack at your eye-level." CR>)>>

<OBJECT COMP-SEAT-BACK
	(LOC COMP-5)
	(DESC "rear-facing seat")
	(SYNONYM SEAT BENCH)
	(ADJECTIVE BACK-FACING REAR-FACING REAR FACING)
	(FLAGS NDESCBIT CONTBIT SURFACEBIT OPENBIT SEARCHBIT)
	(CAPACITY 100)
	(ACTION COMP-SEAT-F)>

<OBJECT UNDER-SEAT
	(LOC COMP-5)
	(DESC "space under the rear bench")
	(SYNONYM $XY)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT TRANSBIT)>
	
<OBJECT COMP-SEAT-FRONT
	(LOC COMP-5)
	(DESC "front-facing seat")
	(SYNONYM SEAT BENCH)
	(ADJECTIVE FRONT-FACING FORWARD-FACING FRONT FORWARD FACING)
	(FLAGS NDESCBIT CONTBIT SURFACEBIT SEARCHBIT OPENBIT)
	(CAPACITY 100)
	(ACTION COMP-SEAT-F)>

<ROUTINE COMP-SEAT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The seats are simple wooden benches, with nothing to soften the ride.
You are told that this is an improvement over second class, but it's
difficult to imagine what this could mean.">
		<COND (<EQUAL? ,PRSO ,COMP-SEAT-BACK>
		       <TELL " Further inspection reveals a narrow
space under the seat.">)>
		<COND (<FIRST? ,PRSO>
		       <TELL " ">
		       <PERFORM ,V?LOOK-INSIDE ,PRSO>
		       <RTRUE>)
		      (T
		       <CRLF>)>)
	       (<VERB? CLIMB-ON BOARD>
		<TELL
"You've always thought better on your feet, and there's no better time
to be thinking." CR>)
	       (<AND <VERB? PUT-UNDER> <EQUAL? ,PRSI ,COMP-SEAT-BACK>>
		<COND (<EQUAL? ,PRSO ,CAMERA-BAG ,BRIEFCASE ,CAMERA>
		       <TELL "It's too bulky to fit." CR>
		       <RTRUE>)>
		<MOVE ,PRSO ,UNDER-SEAT>
		<TELL
"You slide the " D ,PRSO " under the rear-facing bench." CR>)
	       (<VERB? LOOK-UNDER>
		<COND (<EQUAL? ,PRSO ,COMP-SEAT-FRONT>
		       <TELL
"The front-facing bench has no space underneath it; however, a quick look
indicates that the rear bench has a narrow space underneath it." CR>)
		      (T
		       <PERFORM ,V?LOOK-INSIDE ,UNDER-SEAT>
		       <RTRUE>)>)
	       (<VERB? CRAWL-UNDER>
		<TELL
"There's not enough room for you under the seat." CR>)
	       (<AND <VERB? REACH-IN>
		     <EQUAL? ,PRSO ,COMP-SEAT-BACK>>
		<TELL "You reach under the seat">
		<COND (<NOT <FIRST? ,UNDER-SEAT>>
		       <TELL ", but come up empty." CR>)
		      (T
		       <TELL
" and pull out the " D <FIRST? ,UNDER-SEAT> "." CR>
		       <MOVE <FIRST? ,UNDER-SEAT> ,WINNER>)>)>>

<OBJECT COMP-WINDOW
	(LOC COMP-5)
	(DESC "window")
	(SYNONYM WINDOW)
	(FLAGS NDESCBIT DOORBIT)
	(ACTION COMP-WINDOW-F)>

<ROUTINE COMP-WINDOW-F ()
	 <COND (<VERB? LOOK-INSIDE CLEAN>
		<PERFORM ,PRSA ,PASS-WINDOW>
		<RTRUE>)
	       (<VERB? DISEMBARK LEAP-OFF ENTER EXIT>
		<TELL
"Your situation is serious, but not desperate." CR>)
	       (<AND <VERB? PUT-THROUGH PUT>
		     <EQUAL? ,PRSI ,COMP-WINDOW>>
		<COND (<ULTIMATELY-IN? ,PASSPORT ,PRSO>
		       <SETG PRSO ,PASSPORT>)
		      (<ULTIMATELY-IN? ,TICKET ,PRSO>
		       <SETG PRSO ,TICKET>)>
		<COND (<EQUAL? <LOC ,PRSO> ,GLOBAL-OBJECTS ,LOCAL-GLOBALS>
		       <TELL "Funny." CR>)
		      (<NOT <ULTIMATELY-IN? ,PRSO ,WINNER>>
		       <TELL
"You're not holding that." CR>)
		      (<EQUAL? ,PRSO ,PASSPORT ,TICKET>
		       <TELL
"Without your " D ,PRSO
", you won't be leaving Frobnia for a good long time." CR>)
		      (<FSET? ,PRSI ,OPENBIT>
		       <REMOVE-TO-BOTTOM ,PRSO>
		       <TELL
"The " D ,PRSO " goes through the window and out of your life." CR>)
		      (T
		       <TELL
"The window's closed. Surely you don't mean through the window!" CR>)>)>>

<OBJECT PASS-WINDOW
	(LOC LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW)
	(ACTION PASS-WINDOW-F)>

<ROUTINE PASS-WINDOW-F ()
	 <COND (<VERB? CLEAN>
		<TELL
"The windows are clean enough, at least by FNR standards." CR>)
	       (<VERB? KICK MUNG>
		<TELL
"With guards posted at either end of the car, and the level of tension high,
you would only call attention to yourself." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"The windows along the passageway aren't openable." CR>)
	       (<VERB? LOOK-INSIDE>
		<COND (<RT-QUEUED? ,I-BAD-BORDER>
		       <TELL
"The landscape is dark and bleak; this is the area just preceding
the border checkpoint." CR>)
		      (,BAD-TUNNEL
		       <TELL
"From the sound of it, you're in a tunnel, and a long one at that.
There is only blackness punctuated by single trouble lights every
ten seconds or so." CR>)
		      (<RT-QUEUED? ,I-GORMNASH>
		       <TELL
"The train is sitting at the border station platform, which is
crowded with people." CR>)
		      (T
		       <TELL
"The sky is dark now, but you can see the occasional lights of small
villages here and there. You don't know exactly where you are, but
you are getting near the border checkpoint." CR>)>)>>
	
<OBJECT COMP-5-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "compartment door")
	(SYNONYM DOOR)
	(ADJECTIVE COMPARTMENT)
	(FLAGS DOORBIT)>

<GLOBAL GUARD-NOTICE-FLAG <>>

<OBJECT GLOBAL-BAD-SPY
	(LOC GLOBAL-OBJECTS)
	(DESC "man in the trench coat")
	(SYNONYM MAN SPY VIPER)
	(ADJECTIVE BAD)
	(SCENARIO 1)
	(TRANSIENT <PLTABLE PASS-1 PASS-2 PASS-3 PASS-4 PASS-5 PASS-6
			    COMP-5 LAVATORY>)
	(ACTION GLOBAL-BAD-SPY-F)>

<ROUTINE GLOBAL-BAD-SPY-F ()
	 <COND (<AND <LOC ,BAD-SPY>
		     <FSET? <LOC ,BAD-SPY> ,HUTBIT>
		     <FSET? ,HERE ,HUTBIT>
		     <NOT <EQUAL? ,HERE ,LAVATORY>>>
		<COND (<AND <EQUAL? ,PRSI ,GLOBAL-BAD-SPY>
			    <VERB? SHOW GIVE>>
		       <COND (<EQUAL? ,PRSO ,DOCUMENT ,SHRED ,SHREDS>
			      <BAD-SPY-F>
			      <RTRUE>)
			     (T
			      <TELL
"There's nothing to be gained by doing that." CR>)>) 
		      (<VERB? PHOTOGRAPH BRIBE LISTEN EXAMINE>
		       <PERFORM ,PRSA ,BAD-SPY>
		       <RTRUE>)
		      (<VERB? FOLLOW WATCH>
		       <TELL
"If you just stand around here, you'll be able to watch his movements.
On the other hand, it might look suspicious to him." CR>)>)
	       (<VERB? FOLLOW>
		<TELL
"You don't know where he is at the moment." CR>)
	       (<VERB? PHOTOGRAPH BRIBE LISTEN>
		<PERFORM ,PRSA ,BAD-SPY>
		<RTRUE>)
	       (T
		<CANT-SEE ,GLOBAL-BAD-SPY>)>> 

<ROUTINE PASS-F (RARG "AUX" BSL)
	 <SET BSL <LOC ,BAD-SPY>>
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing in the passageway that runs along the length of the
car. ">
		<COND (,AT-STATION
		       <TELL
"Just north of your compartment, a guard is standing. He is motioning
you out of the train to the south.">)
		      (T
		       <TELL
"At either end of the passageway, a guard is standing, machine gun
poised at his side.">)>
		<TELL " Right now, you're standing outside ">
		<COND (<EQUAL? ,HERE ,PASS-5>
		       <TELL "your own compartment">)
		      (T
		       <TELL "the " <GET ,PASS-TELLS <GETP ,HERE ,P?NS>>>)>
		<TELL ".">
		<COND (<AND .BSL <FSET? .BSL ,HUTBIT>>
		       <TELL
" A man, wearing a trench coat, is ">
		       <COND (<EQUAL? .BSL ,HERE>
			      <TELL "also standing here">)
			     (<EQUAL? .BSL ,PASS-5>
			      <TELL "standing outside of your
compartment, motioning for you to return">)
			     (T
			      <TELL "standing outside ">
			      <TELL "the "
				    <GET ,PASS-TELLS <GETP .BSL ,P?NS>>>
			      <TELL ", and talking to its
occupants in rapid-fire Frobnian">)>
		       <TELL ".">)>
		<CRLF>)
	       (<EQUAL? .RARG ,M-ENTER>
		<SETG CURRENT-PASS ,HERE>
		<RFALSE>)>>

<ROUTINE HST? ()
	 <COND (<OR <IN? ,CAMERA ,WINNER>
		    <IN? ,DOCUMENT ,WINNER>
		    <IN? ,SHREDS ,WINNER>
		    <IN? ,COLOR-ROLL ,WINNER>
		    <IN? ,EXPOSED-ROLL ,WINNER>>
		<RTRUE>)>>

<GLOBAL PASS-TELLS
	<PLTABLE "northernmost compartment"
		 "second northernmost compartment"
		 "middle compartment"
		 "compartment next to your own"
		 ""
		 "lavatory">>

<GLOBAL CURRENT-PASS <>>

<ROOM PASS-1
      (LOC ROOMS)
      (DESC "Outside 1st Compartment")
      (IN-DIR P?WEST)
      (WEST PER COMP-MOVE)
      (NORTH SORRY "A stern-faced guard refuses to let you pass.")
      (SOUTH PER PASS-MOVE-2)
      (GLOBAL COMP-N-DOOR PASS-WINDOW BY-GUARDS BY-GUN)
      (FLAGS HUTBIT)
      (NS 1)
      (EJECT
"Two newlyweds here are enjoying their privacy, and not enjoying your
presence. The woman, who appears to be the man of the house, escorts
you out of the door.")
      (ACTION PASS-F)>

<ROOM PASS-2
      (LOC ROOMS)
      (DESC "Outside 2nd Compartment")
      (IN-DIR P?WEST)
      (WEST PER COMP-MOVE)
      (NORTH PER PASS-MOVE-1)
      (SOUTH PER PASS-MOVE-3)
      (GLOBAL COMP-N-DOOR PASS-WINDOW BY-GUARDS BY-GUN)
      (FLAGS HUTBIT)
      (NS 2)
      (EJECT
"A family of five is having what appears to be a rather heated argument.
You are nearly socked in the head before you retreat to the corridor.
The door slams behind you.")
      (ACTION PASS-F)>

<ROOM PASS-3
      (LOC ROOMS)
      (DESC "Outside 3rd Compartment")
      (IN-DIR P?WEST)
      (WEST PER COMP-MOVE)
      (NORTH PER PASS-MOVE-2)
      (SOUTH PER PASS-MOVE-4)
      (GLOBAL COMP-N-DOOR PASS-WINDOW BY-GUARDS BY-GUN)
      (FLAGS HUTBIT)
      (NS 3)
      (EJECT
"This smoke-filled compartment is filled with a dozen or more men, playing
some sort of card game. They regard you with hostility, and force you
back into the corridor.")
      (ACTION PASS-F)>

<ROOM PASS-4
      (LOC ROOMS)
      (DESC "Outside 4th Compartment")
      (IN-DIR P?WEST)
      (WEST PER COMP-MOVE)
      (NORTH PER PASS-MOVE-3)
      (SOUTH PER PASS-MOVE-5)
      (GLOBAL COMP-N-DOOR PASS-WINDOW BY-GUARDS BY-GUN)
      (FLAGS HUTBIT)
      (NS 4)
      (EJECT
"Three women are here, busily engaging in what probably amounts to gossip.
They stop abruptly as you enter, and stare at you stonily. After a moment,
you mumble some apologetic word and return to the corridor.")
      (ACTION PASS-F)>

<ROUTINE COMP-5-ENTER ()
	 <COND (<AND <NOT <SLOW-CLOCK-QUEUED? ,I-BAD-WAITS>>
		     <NOT <SLOW-CLOCK-QUEUED? ,I-BAD-LAV-WAITS>>>
		<TELL
"You enter your compartment, closing the door behind you">
		<TELL ,PERIOD-CR>)>
	 <SETG DONT-DESCRIBE-ROOM T>
	 ,COMP-5>

<ROOM PASS-5
      (LOC ROOMS)
      (DESC "Outside Your Compartment")
      (IN-DIR P?WEST)
      (WEST PER COMP-5-ENTER)
      (NORTH PER PASS-MOVE-4)
      (SOUTH PER PASS-MOVE-6)
      (GLOBAL COMP-5-DOOR PASS-WINDOW BY-GUARDS BY-GUN)
      (FLAGS HUTBIT)
      (NS 5)
      (ACTION PASS-F)>

<ROOM PASS-6
      (LOC ROOMS)
      (DESC "Outside Lavatory")
      (IN PER LAVATORY-MOVE)
      (WEST PER LAVATORY-MOVE)
      (SOUTH SORRY "A stern-faced guard refuses to let you pass.")
      (NORTH PER PASS-MOVE-5)
      (GLOBAL LAVATORY-DOOR PASS-WINDOW BY-GUARDS BY-GUN)
      (FLAGS HUTBIT)
      (NS 6)
      (ACTION PASS-F)>

<ROUTINE COMP-MOVE ()
	 <COND (<FSET? ,COMP-N-DOOR ,OPENBIT>
		,COMP-N)
	       (<IN? ,BAD-SPY ,HERE>
		<TELL
"It would be not only rude, but suspicious, for you to enter now." CR>
		<RFALSE>)
	       (T
		<TELL
"The door to that compartment is closed." CR>
		<RFALSE>)>>

<ROUTINE LAVATORY-MOVE ()
	 <COND (<FSET? ,LAVATORY-DOOR ,OPENBIT>
		<TELL "You">)
	       (T
		<FSET ,LAVATORY-DOOR ,OPENBIT>
		<TELL "You open the door, then">)>
	 <TELL " enter the lavatory. ">
	 <LAVATORY-F ,M-LOOK>
	 <SETG DONT-DESCRIBE-ROOM T>
	 ,LAVATORY>

<ROUTINE PASS-MOVE-1 ()
	 <PASS-MOVE ,PASS-1>>

<ROUTINE PASS-MOVE-2 ()
	 <PASS-MOVE ,PASS-2>>

<ROUTINE PASS-MOVE-3 ()
	 <PASS-MOVE ,PASS-3>>

<ROUTINE PASS-MOVE-4 ()
	 <PASS-MOVE ,PASS-4>>

<ROUTINE PASS-MOVE-5 ()
	 <PASS-MOVE ,PASS-5>>

<ROUTINE PASS-MOVE-6 ()
	 <PASS-MOVE ,PASS-6>>

<ROUTINE PASS-MOVE (WHR "OPTIONAL" (NFP <>) "AUX" BSL)
	 <SET BSL <LOC ,BAD-SPY>>
	 <COND (<NOT .NFP>
		<TELL "You move along the passageway until you come to ">
		<COND (<EQUAL? .WHR ,PASS-5>
		       <TELL "your own compartment">)
		      (T
		       <TELL "the " <GET ,PASS-TELLS <GETP .WHR ,P?NS>>>)>
		<TELL ".">)>
	 <COND (,AT-STATION
		<TELL
" Just north of your position, a guard is standing. He is motioning
you out of the train to the south.">)>
	 <COND (<NOT ,GUARD-NOTICE-FLAG>
		<TELL
" You scan the passageway, noting guards at either end, machine guns
poised at their sides. You don't remember them from the beginning of
the trip, so you can only suppose that security has been tightened in the
search for the American agent.">
		<SETG GUARD-NOTICE-FLAG T>)>
	 <COND (<AND .BSL <FSET? .BSL ,HUTBIT>>
		<TELL CR CR>
		<COND (,BAD-SPY-SEEN
		       <TELL "The man in the coat">)
		      (T
		       <TELL "Another man, wearing a trench coat,">)>
		<TELL " is ">
		<COND (<EQUAL? ,BAD-SPY-SEEN .BSL>
		       <TELL "still ">)>
		<SETG BAD-SPY-SEEN .BSL>
		<COND (<EQUAL? .BSL .WHR>
		       <TELL "standing here">)
		      (<EQUAL? .BSL ,PASS-5>
		       <TELL
"standing outside of your compartment, motioning for you to return">)
		      (T
		       <TELL "standing outside ">
		       <TELL "the "
			     <GET ,PASS-TELLS <GETP .BSL ,P?NS>>>
		       <TELL ", and talking to its
occupants in rapid-fire Frobnian">)>
		<HST-CHECK .BSL .WHR>
		<TELL ".">)>
	 <DOC-CHECK>
	 <CRLF>
	 <SETG DONT-DESCRIBE-ROOM T>
	 .WHR>

<ROUTINE DOC-CHECK ()
	 <COND (<AND <IN? ,BAD-SPY ,HERE> <IN? ,DOCUMENT ,WINNER>>
		<TELL CR CR>
		<REMOVE ,DOCUMENT>
		<FSET ,DOCUMENT ,PENBIT>
		<TELL
"He looks again, this time directly at the document. \"Ah, thank you very
much for returning this document,\" he says. He takes it from you and
regards you with contempt. \"We may need to talk more about this later.\"
And with this, he returns to his conversation with the other passengers.">
		<SETG SUSPICION <+ ,SUSPICION 1>>)>>

<ROUTINE HST-CHECK (BSL WHR "OPTIONAL" (STR <>))
	 <COND (<NOT .STR>
		<SET STR
". He gives you a sidelong glance, and then a subtle double take, and
you fear you have given yourself away">)>
	 <COND (<AND <HST?>
		     <NOT ,HST-FLAG>
		     <L? <ABS <- <GETP .BSL ,P?NS>
				 <GETP .WHR ,P?NS>>> 3>>
		<TELL .STR>
		<SETG HST-FLAG T>
		<SETG SUSPICION <+ ,SUSPICION 1>>)>>

<GLOBAL BAD-SPY-SEEN <>>

<ROUTINE LAVATORY-EXIT ()
	 <COMP-EXIT ,LAVATORY-DOOR ,PASS-6>>

<ROUTINE COMP-EXIT ("OPTIONAL" (DOOR ,COMP-5-DOOR) (PASS ,PASS-5))
	 <COND (<NOT <FSET? .DOOR ,OPENBIT>>
		<COND (<EQUAL? .DOOR ,COMP-5-DOOR>
		       <FSET .DOOR ,OPENBIT>)>
		<TELL "You open the door and">)
	       (T
		<TELL "You">)>
	 <TELL
" walk out into the passageway.">
	 <PASS-MOVE .PASS T>> 

<GLOBAL HST-FLAG <>>

<ROOM COMP-N
      (LOC ROOMS)
      (DESC "Compartment")
      (ACTION COMP-N-F)>

<ROUTINE COMP-N-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<TELL <GETP ,CURRENT-PASS ,P?EJECT> CR>
		<FCLEAR ,COMP-N-DOOR ,OPENBIT>
		<GOTO ,CURRENT-PASS <>>
		<RTRUE>)>>

<OBJECT COMP-N-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "compartment door")
	(SYNONYM DOOR)
	(ADJECTIVE COMPARTMENT)
	(FLAGS DOORBIT)
	(ACTION COMP-N-DOOR-F)>

<ROUTINE COMP-N-DOOR-F ()
	 <COND (<AND <VERB? OPEN CLOSE> <IN? ,BAD-SPY ,HERE>>
		<TELL
"That would be terribly rude." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<COND (<IN? ,BAD-SPY ,HERE>
		       <TELL
"The man in the coat is talking to the passengers inside; you
can't tell much about them from here, and it would be rude to
force yourself into the doorway." CR>)
		      (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"You might as well just go in and find out..." CR>)>)>>		      

<ROOM LAVATORY
      (LOC ROOMS)
      (DESC "Lavatory")
      (OUT PER LAVATORY-EXIT)
      (EAST PER LAVATORY-EXIT)
      (GLOBAL LAVATORY-DOOR)
      (ACTION LAVATORY-F)>

<ROUTINE LAVATORY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Like most facilities here, it is rather primitive.
There is a flush toilet, naturally, and a sink with a mirror above it.
Conveniently located alongside the sink is a paper towel dispenser -
inconveniently, there is no place to put the paper towels once used. A small,
grimy window looks out over the darkened landscape." CR>)>>

<OBJECT LAVATORY-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "lavatory door")
	(SYNONYM DOOR)
	(ADJECTIVE LAVATORY)
	(FLAGS DOORBIT)>

<OBJECT LAV-TOILET
	(LOC LAVATORY)
	(DESC "toilet")
	(SYNONYM TOILET BOWL HANDLE)
	(ADJECTIVE TOILET)
	(FLAGS NDESCBIT OPENBIT SEARCHBIT CONTBIT)
	(CAPACITY 20)
	(ACTION LAV-TOILET-F)>

<ROUTINE LAV-TOILET-F ()
	 <COND (<VERB? USE>
		<PERFORM ,PRSA ,GLOBAL-LAVATORY>
		<RTRUE>)
	       (<VERB? CLIMB-ON BOARD>
		<TELL
"You aren't in need of the facilities at the moment." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,LAV-TOILET>
		     <G? <GETP ,PRSO ,P?SIZE> 5>>
		<TELL
"That's not the sort of thing one puts in the toilet." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,LAV-TOILET>
		     <EQUAL? ,PRSO ,PAPER-TOWEL>>
		<TELL
"The paper towel drops into the toilet." CR>
		<REMOVE ,PAPER-TOWEL>
		<THIS-IS-IT ,WET-PAPER-TOWEL>
		<MOVE ,WET-PAPER-TOWEL ,LAV-TOILET>)
	       (<VERB? OPEN CLOSE>
		<TELL
"You can't open and close the toilet; there's no lid, and how very
typical." CR>)
	       (<AND <VERB? SEARCH LOOK-INSIDE>
		     <IN? ,SHRED ,LAV-TOILET>
		     <NOT <NEXT? ,SHRED>>
		     <NOT <FSET? ,SHRED ,TOUCHBIT>>>
		<TELL
"You see a small shred of the document floating in the toilet." CR>)
	       (<VERB? FLUSH MOVE>
		<TELL
"With an all too loud whooshing sound, the toilet flushes.">
		<COND (<OR <IN? ,DOCUMENT ,LAV-TOILET>
			   <IN? ,SHREDS ,LAV-TOILET>>
		       <RANDOM-QUEUE ,I-SHRED 25>)>
		<DOWN-THE-DRAIN ,LAV-TOILET 6>
		<CRLF>)>>
	
<ROUTINE I-SHRED ()
	 <MOVE ,SHRED ,LAV-TOILET>
	 <DE-RANDOM-QUEUE>
	 <RFALSE>>

<GLOBAL DRAIN-TBL <LTABLE 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE DOWN-THE-DRAIN (OBJ "OPTIONAL" (SIZE 2) "AUX" (OFF 0) F N)
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (T
			<SET N <NEXT? .F>>
			<COND (<AND <L? <GETP .F ,P?SIZE> .SIZE>
				    <NOT <EQUAL? .F ,TICKET ,PASSPORT>>>
			       <REMOVE .F>
			       <SET OFF <+ .OFF 1>>
			       <PUT ,DRAIN-TBL .OFF .F>)>)>
		 <SET F .N>>
	 <COND (<NOT <ZERO? .OFF>>
		<TELL " Down the drain, along with the water, goes the ">
		<REPEAT ()
			<TELL D <GET ,DRAIN-TBL .OFF>>
			<COND (<L? <SET OFF <- .OFF 1>> 1>
			       <RETURN>)
			      (<EQUAL? .OFF 1>
			       <TELL ", and ">)
			      (T
			       <TELL ", ">)>>
		<TELL ".">)>> 

<OBJECT GLOBAL-LAVATORY
	(LOC GLOBAL-OBJECTS)
	(DESC "lavatory")
	(SYNONYM LAVATORY WC BATHROOM)
	(SCENARIO 1)
	(ACTION GLOBAL-LAVATORY-F)>

<ROUTINE GLOBAL-LAVATORY-F ()
	 <COND (<VERB? ENTER WALK-TO FIND>
		<COND (<EQUAL? ,HERE ,PASS-6>
		       <DO-WALK ,P?IN>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,LAVATORY>
		       <TELL "There is no other..." CR>)
		      (T
		       <TELL
"The lavatory, as you recall, is at the south end of the passageway." CR>)>)
	       (<VERB? USE>
		<COND (<EQUAL? ,HERE ,LAVATORY>
		       <TELL
"You have no need of it now, and a good thing too. Just looking at the
fixtures is likely to cause disease." CR>)
		      (T
		       <TELL ,GET-THERE-FIRST CR>)>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,LAVATORY>
		       <PERFORM ,V?LOOK>
		       <RTRUE>)
		      (T
		       <TELL "You should go there first." CR>)>)
	       (<VERB? LEAVE>
		<COND (<EQUAL? ,HERE ,LAVATORY>
		       <DO-WALK ,P?OUT>
		       <RTRUE>)
		      (T
		       <TELL "You're not there!" CR>)>)>>

<OBJECT BRIEFCASE
	(LOC COMP-5)
	(DESC "briefcase")
	(SYNONYM CASE BRIEFCASE)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT TRYTAKEBIT)
	(SCENARIO 1)
	(CAPACITY 65)
	(SIZE 16)
	(ACTION BRIEFCASE-F)>

<ROUTINE BRIEFCASE-F ()
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,BRIEFCASE>
		     <FSET? ,PRSO ,OPENBIT>>
		<TELL "You'd best close the briefcase first." CR>
		<RTRUE>)>> 

<OBJECT CAMERA-BAG
	(LOC COMP-5)
	(DESC "camera bag")
	(SYNONYM BAG)
	(ADJECTIVE CAMERA)
	(FLAGS TAKEBIT CONTBIT OPENBIT SEARCHBIT)
	(SCENARIO 1)
	(CAPACITY 40)
	(SIZE 41)>

<OBJECT CAMERA
	(LOC CAMERA-BAG)
	(DESC "camera")
	(SYNONYM CAMERA)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(SCENARIO 1)
	(SIZE 25)
	(ACTION CAMERA-F)>

<ROUTINE CAMERA-F ("AUX" FILM SHOT)
	 <SET FILM <FIRST? ,CAMERA>>
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a Pentax 35-mm SLR camera; you could have done better, but the
dollar's not been so good, and getting Japanese goods here is difficult
at best. Right now, it's ">
		<COND (<ZERO? .FILM>
		       <TELL "not loaded with any film">)
		      (<NOT <FSET? .FILM ,FILMBIT>>
		       <TELL "got a " D .FILM " inside">)
		      (<ZERO? <SET SHOT <GETP .FILM ,P?SHOT>>>
		       <TELL "got a " D .FILM
			     " inside that's ready to be loaded">)
		      (<L? .SHOT 0>
		       <TELL "got a rewound " D .FILM " inside">)
		      (T
		       <TELL "loaded with a " D .FILM>)>
		<TELL ". ">
		<COND (<FSET? ,CAMERA ,OPENBIT>
		       <TELL
"The back of the camera is open.">)
		      (<AND .FILM
			    <FSET? .FILM ,FILMBIT>
			    <EQUAL? <GETP .FILM ,P?SHOT> -1>>
		       <TELL
"The gizmo on top says that the film inside is rewound.">)
		      (<AND .FILM <FSET? .FILM ,FILMBIT>>
		       <TELL
"According to the gizmo on top, you're currently at picture number ">
		       <TELL N <GETP .FILM ,P?SHOT>>
		       <TELL " of a roll of 24.">)>
		<CRLF>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,CAMERA>>
		<COND (<NOT <FSET? ,CAMERA ,OPENBIT>>
		       <TELL "The camera's not open." CR>)
		      (.FILM
		       <TELL "There's already something there." CR>)
		      (<G? <GETP ,PRSO ,P?SIZE> 5>
		       <TELL "That won't fit in the camera." CR>)
		      (T
		       <TELL "The " D ,PRSO
			     " is now resting in the camera." CR>
		       <MOVE ,PRSO ,PRSI>)>)
	       (<VERB? OPEN>
		<COND (<FSET? ,CAMERA ,OPENBIT>
		       <TOO-LATE>)
		      (T
		       <FSET ,CAMERA ,OPENBIT>
		       <TELL
"The camera is now opened.">
		       <COND (<AND .FILM
				   <FSET? .FILM ,FILMBIT>
				   <NOT <EQUAL? <GETP .FILM ,P?SHOT>
						-1
						0>>>
			      <COND (<EQUAL? .FILM ,COLOR-ROLL>
				     <SETG FILM-RUINED T>)>
			      <PUTP .FILM ,P?SHOT -1>
			      <TELL
" Sadly, the film was not rewound, so some of your photos have probably
been destroyed. It's too late now, but you rewind the roll anyway.">)>
		       <CRLF>)>)
	       (<VERB? CLOSE>
		<COND (<FSET? ,CAMERA ,OPENBIT>
		       <FCLEAR ,CAMERA ,OPENBIT>
		       <TELL
"The camera is now closed." CR>)
		      (T
		       <TOO-LATE>)>)
	       (<VERB? LOAD>
		<COND (<NOT .FILM>
		       <COND (<AND ,PRSI <FSET? ,PRSI ,FILMBIT>>
			      <PERFORM ,V?PUT
				       ,PRSI
				       ,PRSO>
			      <COND (<OR <NOT <SET FILM <FIRST? ,CAMERA>>>
					 <NOT <EQUAL? .FILM ,PRSI>>>
				     <RTRUE>)>)
			     (T
			      <TELL
"In order to properly load the film into the camera's winding mechanism, you
must first put the film in the camera." CR>
			      <RTRUE>)>)>
		<COND (<NOT <FSET? .FILM ,FILMBIT>>
		       <TELL
"Not likely, with the " D .FILM " sitting in there." CR>)
		      (<AND ,PRSI <NOT <EQUAL? .FILM ,PRSI>>>
		       <TELL
"There's another roll already in there." CR>)
		      (<L? <SET SHOT <GETP .FILM ,P?SHOT>> 0>
		       <TELL
"The film has been rewound back into the spool; there's no way to load
it onto the winding mechanism now." CR>)
		      (<G? .FILM 0>
		       <TELL
"It's already loaded properly." CR>)
		      (T
		       ;<PUTP .FILM ,P?SHOT 1>
		       ;<TELL
"The camera is loaded and ready for action." CR>)>)
	       (<VERB? REWIND>
		<COND (<OR <NOT .FILM> <NOT <FSET? .FILM ,FILMBIT>>>
		       <TELL
"There's no film in the camera." CR>)
		      (<NOT <G? <SET FILM <GETP .FILM ,P?SHOT>> 1>>
		       <TELL
"The film in the camera isn't loaded." CR>)
		      ;(<FSET? ,CAMERA ,OPENBIT>
		       <TELL
"The camera is usually closed when film is to be rewound; otherwise,
all of the film will be exposed and ruined." CR>)
		      (T
		       <PUTP <FIRST? ,CAMERA> ,P?SHOT -1>
		       <TELL
"The film in the camera is now rewound." CR>)>)>>  

<OBJECT COLOR-ROLL
	(LOC CAMERA)
	(DESC "roll of color film")
	(SYNONYM ROLL FILM)
	(ADJECTIVE COLOR)
	(FLAGS TAKEBIT FILMBIT)
	(SCENARIO 1)
	(SIZE 4)
	(GENERIC GENERIC-FILM)
	(SHOT 23)
	(PHOTO <TABLE -1 -1>)
	(ACTION COLOR-ROLL-F)>

<ROUTINE COLOR-ROLL-F ()
	 <COND (<AND <VERB? LOAD> <NOT ,PRSI>>
		<PERFORM ,V?LOAD ,CAMERA ,PRSO>
		<RTRUE>)
	       (<VERB? BEND>
		<PERFORM ,PRSA ,EXPOSED-ROLL>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<TELL "Not a chance." CR>)
	       (<VERB? REWIND>
		<REWIND-FILM>)>>

<OBJECT EXPOSED-ROLL
	(LOC CAMERA-BAG)
	(DESC "old roll of film")
	(SYNONYM ROLL FILM)
	(ADJECTIVE EXPOSED OLD)
	(FLAGS TAKEBIT FILMBIT CONTBIT OPENBIT VOWELBIT AN)
	(SCENARIO 1)
	(SIZE 4)
	(GENERIC GENERIC-FILM)
	(SHOT -1)
	(ACTION EXPOSED-ROLL-F)>

<GLOBAL FILM-RUINED <>>

<OBJECT PHONY-FILM
	(DESC "film")
	(LOC GLOBAL-OBJECTS)
	(FLAGS FILMBIT)
	(SCENARIO 1)
	(ACTION PHONY-FILM-F)>

<ROUTINE PHONY-FILM-F ("AUX" F)
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,PHONY-FILM>
		     <EQUAL? ,PRSI ,COLOR-ROLL ,EXPOSED-ROLL>>
		<TELL
"You can't remove the film from the roll it's on." CR>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,PRSI ,CAMERA>>
		<COND (<NOT <FSET? ,CAMERA ,OPENBIT>>
		       <TELL
"The camera's closed." CR>)
		      (<OR <NOT <SET F <FIRST? ,CAMERA>>>
			   <NOT <FSET? .F ,FILMBIT>>>
		       <TELL
"There's no film in the camera." CR>)
		      (T
		       <PERFORM ,V?TAKE .F>
		       <RTRUE>)>)
	       (T
		<TELL
"There's no film there." CR>)>>

<ROUTINE GENERIC-FILM ("AUX" F)
	 <COND (<VERB? REWIND>
		,CAMERA)
	       (<AND <VERB? TAKE> <EQUAL? ,P-NCN 2>>
		,PHONY-FILM)>>

<ROUTINE EXPOSED-ROLL-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "Don't be ridiculous." CR>)
	       (<AND <VERB? LOAD> <NOT ,PRSI>>
		<PERFORM ,V?LOAD ,CAMERA ,PRSO>
		<RTRUE>)
	       (<VERB? BEND>
		<TELL
"You can't pull the film out of the roll." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The exposed roll has been rewound into the spool. If your memory serves, it
contains pictures of your last family outing at Lake Gurthark. Why you
didn't have it developed months ago is a mystery to you." CR>)
	       (<VERB? REWIND>
		<REWIND-FILM>)>>

<ROUTINE REWIND-FILM ()
	 <COND (<NOT <IN? ,CAMERA ,WINNER>>
		<TELL
"It's a lot easier if you're holding the camera." CR>)
	       (<NOT <FIRST? ,CAMERA>>
		<TELL
"There's no film in the camera." CR>)
	       (T
		<PERFORM ,V?REWIND ,CAMERA>
		<RTRUE>)>>

<OBJECT GLOBAL-FILM
	(LOC GLOBAL-OBJECTS)
	(DESC "film")
	(SYNONYM FILM)
	(ADJECTIVE COLOR EXPOSED OLD)
	(ACTION GLOBAL-FILM-F)>

<ROUTINE GLOBAL-FILM-F ()
	 <COND (<AND <EQUAL? ,SCENARIO 1>
		     <VERB? REWIND>>
		<REWIND-FILM>
		<RTRUE>)
	       (T
		<TELL
"You can't see any such film here." CR>)>>

<OBJECT TOILET-KIT
	(LOC BRIEFCASE)
	(DESC "toilet kit")
	(SYNONYM KIT)
	(ADJECTIVE TOILET)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(SCENARIO 1)
	(SIZE 15)
	(CAPACITY 14)>

<OBJECT TOOTHBRUSH
	(LOC TOILET-KIT)
	(DESC "toothbrush")
	(SYNONYM BRUSH TOOTHBRUSH)
	(FLAGS TAKEBIT)
	(SCENARIO 1)
	(SIZE 3)
	(ACTION TOOTHBRUSH-F)>

<ROUTINE TOOTHBRUSH-F ()
	 <COND (<VERB? EXAMINE USE>
		<TELL
"You brought the toothbrush along, but you forgot the toothpaste, making
the device utterly worthless." CR>)>>

<OBJECT TEETH
	(LOC GLOBAL-OBJECTS)
	(DESC "your teeth")
	(SYNONYM TEETH)
	(ADJECTIVE MY)
	(ACTION TEETH-F)>

<ROUTINE TEETH-F ()
	 <COND (<VERB? CLEAN>
		<TELL
"A nice idea, but not very helpful." CR>)>> 

<OBJECT BYSTANDER-WATCH
	(DESC "wristwatch")
	(SYNONYM CLOCK WATCH WRISTWATCH)
	(ADJECTIVE WRIST)
	(FLAGS WEARBIT WORNBIT READBIT)
	(ACTION BYSTANDER-WATCH-F)>

<ROUTINE BYSTANDER-WATCH-F ()
	 <COND (<VERB? DROP TAKE-OFF>
		<TELL
"If you're to make your connections, you shouldn't be without it." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It's a Timex, and not a particularly nice one at that." CR>)
	       (<VERB? READ>
		<TELL
"You can read the time on your status line." CR>)>>

<OBJECT TWEEZERS
	(LOC TOILET-KIT)
	(DESC "pair of tweezers")
	(SYNONYM PAIR TWEEZERS)
	(FLAGS TAKEBIT)
	(SCENARIO 1)
	(SIZE 4)
	(ACTION TWEEZERS-F)>
	
<ROUTINE TWEEZERS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"They're your ordinary pair of tweezers. You don't know why you keep
it in your toilet kit, since you never use it." CR>)>>

<OBJECT PICTURE
	(LOC GLOBAL-OBJECTS)
	(DESC "picture")
	(SYNONYM PICTURE PHOTOGRAPH PHOTO)
	(ACTION PICTURE-F)>

<ROUTINE PICTURE-F ()
	 <COND (<VERB? TAKE>
		<TELL "You'll have to say what you want to photograph." CR>)>>

<ROUTINE TAKE-A-PICTURE ("AUX" FILM SHOT)
	 <COND (<FSET? ,CAMERA ,OPENBIT>
		<TELL
"But the back of the camera is open!" CR>)
	       (<NOT <SET FILM <FIRST? ,CAMERA>>>
		<TELL
"There's no film in the camera, or hadn't you noticed?" CR>)
	       (<NOT <FSET? .FILM ,FILMBIT>>
		<TELL
"There's something in the camera, but it sure isn't film." CR>)
	       (<EQUAL? <SET SHOT <GETP .FILM ,P?SHOT>> -1>
		<TELL
"The camera's shutter makes a clicking noise, but nothing else happens;
the film is rewound." CR>)
	       (<EQUAL? .SHOT 0>
		<TELL
"The film's in the camera, all right, but it's not loaded." CR>)
	       (<EQUAL? .SHOT 25>
		<TELL
"Nothing happens; it appears you've taken your last shot on this roll." CR>)
	       ;(<NOT <EQUAL? .SHOT 23 24>>
		<TELL
"You take the picture of the " D ,PRSO ", but you doubt it will come out
well since you've already used this film before." CR>)
	       (T
		<PUTP .FILM ,P?SHOT <SET SHOT <+ .SHOT 1>>>
		<PUT <GETP .FILM ,P?PHOTO>
		     <- .SHOT 24>
		     ,PRSO>
		<TELL
"You take the picture of " THE ,PRSO ". The film is automatically
advanced to frame number " N .SHOT ,PERIOD-CR>)>>

<OBJECT BYSTANDER-CLOTHES
	(DESC "your clothes")
	(SYNONYM CLOTHES SOCKS SHIRT PANTS CLOTHING CLOTH SUIT)
	(FLAGS NARTICLEBIT WORNBIT SEARCHBIT SURFACEBIT OPENBIT CONTBIT
	       NOTHEBIT NOABIT)
	(ACTION BYSTANDER-CLOTHES-F)>

<ROUTINE BYSTANDER-CLOTHES-F ()
	 <COND (<VERB? TAKE-OFF REMOVE>
		<TELL
"This would be highly inappropriate." CR>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,SCENARIO 1>
		       <TELL
"You are looking rather dapper in your business suit.">)
		      (T
		       <TELL
"You're doing your best to look nondescript in your trench coat." CR>)>
		<COND (<AND <IN? ,CARNATION ,PRSO>
			    <EQUAL? ,SCENARIO 1>>
		       <TELL "
A white carnation adorns your jacket's lapel.">)>
		<CRLF>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"There's nothing in your clothes that can help you." CR>)
	       (<VERB? RIP>
		<TELL
"Why on earth should you damage your rather expensive outfit?" CR>)>>

<OBJECT CARNATION
	(LOC BYSTANDER-CLOTHES)
	(SYNONYM CARNATION FLOWER)
	(ADJECTIVE WHITE RUMPLED)
	(DESC "rumpled white carnation")
	(FLAGS WEARBIT WORNBIT TAKEBIT)
	(ACTION CARNATION-F)>

<ROUTINE CARNATION-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a sad looking carnation, though it is arguably in better shape than
its previous owner." CR>)
	       (<AND <VERB? TAKE-OFF> <IN? ,PRSO ,BYSTANDER-CLOTHES>>
		<MOVE ,PRSO ,WINNER>
		<FCLEAR ,PRSO ,WORNBIT>
		<TELL
"You take off the carnation. It is a sorry sight." CR>)
	       (<AND <VERB? WEAR> <NOT <FSET? ,PRSO ,WORNBIT>>>
		<MOVE ,PRSO ,BYSTANDER-CLOTHES>
		<FSET ,PRSO ,WORNBIT>
		<TELL
"You put the rumpled carnation through the hole in your lapel. Except
for the contact, you can only pray that nobody notices." CR>)>> 

<OBJECT BAD-SPY
	(DESC "man in a trench coat")
	(SYNONYM SPY MAN VIPER)
	(ADJECTIVE BAD TRENCHCOATED)
	(FLAGS NDESCBIT PERSON)
	(ACTION BAD-SPY-F)>

<ROUTINE BAD-SPY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"He is a rather large man, though unassuming in appearance. He wears an
off-white trench coat and a hat and talks with a beautiful, resonant voice.
In all, he doesn't appear very formidable, but your intuition tells you
that he is a very high-level official - in what agency, you could never
know." CR>)
	       (<VERB? BRIBE>
		<TELL
"It's too risky; you'd probably end up in jail." CR>)
	       (<AND <VERB? GIVE SHOW>
		     <EQUAL? ,PRSO ,SHRED ,SHREDS ,DOCUMENT>>
		<TELL
"Even in a text-only game, that would be stupid beyond words." CR>)
	       (<AND <VERB? GIVE> <EQUAL? ,PRSI ,BAD-SPY>>
		<TELL "He waves you away with his hand." CR>)
	       (<VERB? PHOTOGRAPH>
		<TELL
"Seeing what you are about to do, he turns to you, and speaks harshly.
\"This is not permitted.\" You decide against taking the picture." CR>
		<SETG SUSPICION <+ ,SUSPICION 1>>)
	       (<VERB? LISTEN>
		<TELL
"You know little Frobnian, and he is speaking very quickly." CR>)>>

<GLOBAL BAD-SPY-MOVES <PLTABLE PASS-1 PASS-2 PASS-3 PASS-4 PASS-5 PASS-6>>

<GLOBAL BAD-SPY-COUNT 0>

<ROUTINE I-BAD-SPY ("AUX" SM)
	 <SETG BAD-SPY-COUNT <+ ,BAD-SPY-COUNT 1>>
	 <COND (<AND <0? <MOD ,BAD-SPY-COUNT 6>>
		     <L? <SET SM </ ,BAD-SPY-COUNT 6>> 7>>
		<MOVE ,BAD-SPY <SET SM <GET ,BAD-SPY-MOVES .SM>>>
		<COND (<FSET? ,HERE ,HUTBIT>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <COND (<EQUAL? .SM ,PASS-1>
			      <SETG BAD-SPY-SEEN T>
			      <TELL
"You watch as a man in a trench coat enters your car to the north. He ">
			      <COND (<NOT <FSET? ,COMP-N-DOOR ,OPENBIT>>
				     <TELL
"opens the door to the first compartment, and ">)>
			      <TELL "begins to speak to the
occupants, though you can't make out a word.">)
			     (<EQUAL? .SM ,PASS-5 ,PASS-6>
			      <COND (<EQUAL? .SM ,PASS-5>
				     <TELL
"The man arrives at your compartment and sees that nobody is inside.
After a moment, he looks in your direction">)
				    (T
				     <TELL
"The man walks up to you,">)>
			      <TELL " and speaks to you in a
beautifully deep voice with a heavily Russian accent. \"Please
return now to your compartment.\"">
			      <SETG BAD-DISTANCE
				    <ABS <- <GETP <LOC ,BAD-SPY> ,P?NS>
					    <GETP ,HERE ,P?NS>>>>
			      <SLOW-CLOCK-QUEUE ,I-BAD-WAITS 20>)
			     (<EQUAL? ,HERE .SM>
			      <TELL
"The man politely thanks the people in the next compartment, closes
their door, and moves to where you are standing. He looks you over
briefly, then proceeds to speak to the occupants in what you
realize to be Frobnian; sadly, you don't understand enough to make
sense of his speech.">) 
			     (T
			      <TELL
"The man in the trench coat tips his hat at the occupants of the
compartment, shuts the door, and moves to the next compartment, where
he opens the door and starts to converse. He's now ">
			      <TELL <GET ,SMALL-NUMS-TBL
					 <ABS <- <GETP .SM ,P?NS>
					         <GETP ,HERE ,P?NS>>>>>
			      <TELL " away from you.">)>
		       <HST-CHECK .SM ,HERE
"|
|
The man, seeming to notice you for the first time, turns casually in
your direction. A second later, he seems to do a double take and you fear
you have given yourself away.">
		       <DOC-CHECK>
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)
		      (<AND <EQUAL? .SM ,PASS-6> <EQUAL? ,HERE ,LAVATORY>>
		       <SLOW-CLOCK-QUEUE ,I-BAD-LAV-WAITS 20>
		       <BOLDTELL
"There are two sharp raps on the lavatory door, and a man with a thick
accent speaks. \"Please forgive the intrusion, but I must have a word with
you, outside, in your compartment.\"">)
		      (<AND <EQUAL? .SM ,PASS-5 ,PASS-6>
			    <EQUAL? ,HERE ,COMP-5>>
		       <DE-SLOW-CLOCK-QUEUE>
		       <BOLDTELL
"There are two sharp raps on your door, and a man wearing a trench coat
enters.">
		       <BAD-INTERVIEW>
		       <COND (<NOT ,PRSA> <SETG READ-INTERRUPTED T>)>
		       <RTRUE>)>)>>

<GLOBAL READ-INTERRUPTED <>>

<GLOBAL BAD-INTERVIEW-FLAG <>>

<ROUTINE BAD-INTERVIEW ("OPTIONAL" (FORCE? <>))
	 <DE-SLOW-CLOCK-QUEUE>
	 <SETG BAD-INTERVIEW-FLAG T>
	 <TELL CR
"He speaks beautiful, correct English, though his accent is rather
thick. \"I am so sorry to ">
	 <COND (.FORCE? <TELL "well, shall I say 'insist'">)
	       (T <TELL "intrude">)>
	 <TELL ", but I was hoping you could be of some
assistance.\" His eyes dart around the room as he speaks, taking in
everything. Then, his gaze settles on you - his searching eyes take
you in from top to bottom">
	 <COND (<FSET? ,CARNATION ,WORNBIT>
		<FSET ,CARNATION ,HUTBIT>
		<SETG SUSPICION <+ ,SUSPICION 1>>
		<TELL
", and you imagine that he is frowning slightly, as if slightly confused.">)
	       (T
		<TELL ".">)>
	 <COND (<IN? ,CAMERA ,WINNER>
		<TELL " He looks at the camera, and raises an eyebrow. \"You
are taking pictures? I hope you are using fast film.\"">
		<SETG SUSPICION <+ ,SUSPICION 1>>)>
	 <COND (<IN? ,STAINED-PAPER-TOWEL ,WINNER>
		<SETG SUSPICION <+ ,SUSPICION 1>>
		<TELL " He then stares for a moment at the blood-stained
towel in your hand, then smiles and looks you in the eye.">)>
	 <CRLF>
	 <COND (<OR <BAD-SEARCH ,WINNER>
		    <BAD-SEARCH ,HERE>
		    <BAD-SEARCH ,COMP-SEAT-FRONT>
		    <BAD-SEARCH ,COMP-SEAT-BACK>>
		<RTRUE>)>
	 <TELL CR
"He casually takes a cigarette and a book of matches from his pocket
and attempts to light a match, giving up after the fourth try. He
smiles good-naturedly, and says, \"I should be giving these up
anyway.\" He returns them to his pocket and continues.">
	 <TELL CR CR
"\"I will come to the point. We are looking for ">
	 <COND (<FSET? ,DOCUMENT ,PENBIT>
		<TELL
"the man who gave you the document. Perhaps you have seen where he
has gone?\" He eyes you suspiciously, but you are relieved to be able
to answer him honestly - you have no idea where he's gone.">)
	       (T
		<TELL
"a man - tall, slight, a bit
disheveled - hurt, perhaps. We believe he may have come this way, and
we have need to find him, for his own safety.\" He smiles wanly. \"Have
you seen such a man?\"">)>
	 <TELL CR CR>
	 <COND (<FSET? ,DOCUMENT ,PENBIT> T)
	       (<YES? ,BAD-SPY>
		<CRLF>
		<COND (<OR <IN? ,COMP-BLOOD-STAIN ,HERE>
			   <IN? ,STAINED-PAPER-TOWEL ,WINNER>>
		       <TELL ,BAD-YES-START CR CR>
		       <SETG SUSPICION <+ ,SUSPICION 1>>)
		      (T
		       <TELL ,BAD-YES-START>
		       <TELL " The man pauses for a moment, then looks
around furtively, but unmistakably, as if he had misplaced something." CR CR>
		       <SETG SUSPICION <+ ,SUSPICION 2>>)>)
	       (<OR <IN? ,COMP-BLOOD-STAIN ,HERE>
		    <IN? ,STAINED-PAPER-TOWEL ,WINNER>>
		<CRLF>
		<TELL
"You answer negatively with a shake of your head and a curt \"Nobody like
that has been here. Sorry.\"" CR CR>
		<TELL "He ">
		<COND (<IN? ,COMP-BLOOD-STAIN ,HERE>
		       <TELL
"lowers his eyes to the floor, as if in thought">)
		      (T
		       <TELL "looks at your hands">)>
		<TELL ", then looks you straight
in the eye. \"You are certain, then?\" he asks, with a hint of humor - or is
it disbelief? You again reassure him that you would certainly have noticed
someone of that description." CR CR>
		<SETG SUSPICION <+ ,SUSPICION 3>>)
	       (T
		<CRLF>
		<TELL
"He looks around again briefly, and nods his head a few times as if
agreeing with you." CR CR>)>
	 <COND (<G? ,SUSPICION 2>
		<TELL
"\"Well, thank you anyway. We shall be arriving at the checkpoint in a
few minutes, and then we must conduct our border search - you understand.
Until then, I would appreciate it if you would remain here.\" He leaves with a
tip of his hat. As he leaves, he speaks briefly with one of the guards
stationed in the passageway." CR>
		<SETG BAD-CONFINED T>)
	       (T
		<FCLEAR ,COMP-5-DOOR ,OPENBIT>
		<TELL
"\"Thank you anyway. We shall be arriving shortly at the border, and I
will see you again at that time.\" He leaves with a tip of his hat,
closing the door behind him." CR>)>
	 <SETG I-FATAL T>
	 <SETG BAD-INTERVIEW-FLAG <>>
	 <REMOVE ,BAD-SPY>>

<GLOBAL BAD-CONFINED <>>

<GLOBAL SUSPICION 0>

<GLOBAL BAD-YES-START
"You reply that indeed a wounded man did wander into the compartment,
apparently looking for someone. A moment later, he was gone. You are
asked whether he gave you anything, a piece of paper perhaps, but you
shake your head in the negative.">

<OBJECT COMP-BLOOD-STAIN
	(LOC COMP-5)
	(DESC "blood stain")
	(SYNONYM BLOOD STAIN)
	(ADJECTIVE BLOOD)
	(FLAGS NDESCBIT ;INVISIBLE)
	(ACTION COMP-BLOOD-STAIN-F)> 

<ROUTINE COMP-BLOOD-STAIN-F ()
	 <COND (<OR <AND <VERB? CLEAN>
			 <EQUAL? ,PRSI ,WET-PAPER-TOWEL>>
		    <AND <VERB? CLEAN>
			 <NOT ,PRSI>
			 <IN? ,WET-PAPER-TOWEL ,WINNER>>>
		<TELL
"You wipe up the drops of blood; it is unlikely anyone would
notice the slight discoloration that remains." CR>
		<MOVE ,STAINED-PAPER-TOWEL ,WINNER>
		<REMOVE ,WET-PAPER-TOWEL>
		<REMOVE ,COMP-BLOOD-STAIN>)
	       (<OR <AND <VERB? CLEAN>
			 <EQUAL? ,PRSI ,PAPER-TOWEL>>
		    <AND <VERB? CLEAN>
			 <NOT ,PRSI>
			 <IN? ,PAPER-TOWEL ,WINNER>>>
		<FSET ,PRSO ,CROSSBIT>
		<TELL
"The dry towel merely smears the blood around, leaving, in all,
a bigger mess than when you started." CR>)
	       (<VERB? CLEAN>
		<TELL
"It's a good idea to cover the agent's tracks, but you don't have
anything suitable for cleaning up the mess." CR>)
	       (<AND <VERB? PUT PUT-ON> <EQUAL? ,PRSI ,COMP-BLOOD-STAIN>>
		<TELL
"You'd only ruin the " D ,PRSO ,PERIOD-CR>)>>

<GLOBAL BAD-DISTANCE 0>

<ROUTINE I-BAD-WAITS ()
	 <COND (<NOT <LOC ,BAD-SPY>> <RTRUE>)
	       (<AND <NOT <L? <ABS <- <GETP <LOC ,BAD-SPY> ,P?NS>
				      <GETP ,HERE ,P?NS>>>
			      ,BAD-DISTANCE>>
		     <NOT <EQUAL? ,HERE ,COMP-5>>>
		<COND (<OR <EQUAL? ,HERE ,LAVATORY>
			   <G? <SETG BAD-WAIT-COUNT <+ ,BAD-WAIT-COUNT 1>> 4>>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <SETG SUSPICION <+ ,SUSPICION 1>>
		       <COND (<EQUAL? ,HERE ,LAVATORY>
			      <TELL
"A guard forces his way into the lavatory and leads">)
			     (T
			      <TELL
"The man signals to a guard, who arrives and forcibly takes">)>
		       <TELL " you to your compartment. \"That is better,\"
the trench coated man says.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>
		       <GOTO ,COMP-5 <>>
		       <DE-SLOW-CLOCK-QUEUE>
		       <BAD-INTERVIEW T>
		       <RTRUE>)
		      (<NOT <EQUAL? ,BAD-WAIT-COUNT 1>>
		       <BOLDTELL <GET ,BAD-WAIT-TBL ,BAD-WAIT-COUNT>>)>)
	       (<L? <SETG BAD-DISTANCE <- ,BAD-DISTANCE 1>> 1>
		<BOLDTELL
"\"Thank you so much for your patience.\" He leads you into your
compartment and shuts the door.">
		<GOTO ,COMP-5 <>>
		<BAD-INTERVIEW>
		<DE-SLOW-CLOCK-QUEUE>
		<RTRUE>)>>

<GLOBAL BAD-WAIT-TBL
	<PLTABLE
""
"\"I am in a hurry. If you wouldn't mind...\""
"The man looks at you impatiently. \"Please...\" he implores."
"\"I am afraid that you really must come with me.\"">>

<GLOBAL BAD-WAIT-COUNT 0>

<ROUTINE I-BAD-LAV-WAITS ()
	 <COND (<NOT <LOC ,BAD-SPY>> <RTRUE>)
	       (<FSET? ,LAVATORY-DOOR ,OPENBIT>
		<BOLDTELL
"The man in the trench coat takes you by the arm and walks you back to your
compartment.">
		<GOTO ,COMP-5 <>>
		<BAD-INTERVIEW>
		<DE-SLOW-CLOCK-QUEUE>
		<RTRUE>)
	       (<G? <SETG BAD-WAIT-COUNT <+ ,BAD-WAIT-COUNT 1>> 4>
		<BOLDTELL
"Without warning, the door is knocked open by one of the uniformed guards. The
man in the trench coat then takes you by the arm and escorts you back to your
compartment.">
		<SETG SUSPICION <+ ,SUSPICION 1>>
		<GOTO ,COMP-5 <>>
		<BAD-INTERVIEW T>
		<DE-SLOW-CLOCK-QUEUE>
		<RTRUE>)
	       (<NOT <EQUAL? ,BAD-WAIT-COUNT 1>>
		<BOLDTELL <GET ,BAD-LAV-WAIT-TBL ,BAD-WAIT-COUNT>>)>>

<GLOBAL BAD-LAV-WAIT-TBL
	<PLTABLE
""
"There is a knock on the door. \"If you wouldn't mind, I really must speak
to you.\""
"\"I really must insist.\" After a moment, the man speaks loudly in
Frobnian, as if to somebody farther away than yourself."
"\"If you won't come out, we can arrange something else...\" His voice
trails off in a rather sarcastic way.">>

<OBJECT GRAFFITI
	(LOC LAVATORY)
	(DESC "graffiti")
	(SYNONYM GRAFITTI GRAFFITI WORDS WRITING)
	(FLAGS NDESCBIT)
	(ACTION GRAFFITI-F)>

<ROUTINE GRAFFITI-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"The words don't make a lot of sense, and your Frobnian is poor, but it seems
to say:|
|
         BORDER ZONE|
    Written by Marc Blank|
Copyright (c) 1987, Infocom, Inc.|
" CR>)>>

<OBJECT TOWEL-DISPENSER
	(LOC LAVATORY)
	(DESC "towel dispenser")
	(SYNONYM DISPENSER MACHINE)
	(ADJECTIVE TOWEL)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT OPENBIT)
	(CAPACITY 5)
	(ACTION TOWEL-DISPENSER-F)>

<ROUTINE TOWEL-DISPENSER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's your ordinary metal towel dispenser. Here, as in the States, people
tend to write grafitti on towel dispensers, and this one is no exception.">
		<COND (<IN? ,PAPER-TOWEL ,PRSO>
		       <TELL
" You are in luck - there's at least one paper towel inside.">)
		      (T
		       <TELL
" It seems to be empty, which is somehow not surprising.">)>
		<CRLF>)
	       (<VERB? OPEN>
		<TELL
"You can't open it, reminding yourself of how stupid it is that all
towel dispensers seem to be locked." CR>)
	       (<VERB? CLOSE>
		<TELL
"It already is." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,TOWEL-DISPENSER>>
		<COND (<EQUAL? ,PRSO ,DOCUMENT ,SHRED ,SHREDS>
		       <MOVE ,PRSO ,PRSI>
		       <TELL
"You carefully place the " D ,PRSO " inside the dispenser." CR>)
		      (<EQUAL? ,PRSO ,PAPER-TOWEL>
		       <MOVE ,PRSO ,PRSI>
		       <TELL
"You replace the paper towel in the dispenser." CR>)
		      (T
		       <TELL
"The opening is too small and narrow for that." CR>)>)
	       (<VERB? UNLOCK MUNG KICK HIT>
		<TELL
"Did it occur to you to simply take the towel rather than vandalizing
the machine?" CR>)>>

<OBJECT PAPER-TOWEL
	(LOC TOWEL-DISPENSER)
	(DESC "paper towel")
	(SYNONYM TOWEL)
	(ADJECTIVE PAPER)
	(FLAGS TAKEBIT)
	(SCENARIO 1)
	(SIZE 2)
	(ACTION PAPER-TOWEL-F)>

<ROUTINE PAPER-TOWEL-F ()
	 <COND (<VERB? CUT RIP>
		<TELL
"That won't serve any purpose." CR>)
	       (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSO ,DOCUMENT>>
		<TELL "You'd never get away with it." CR>)
	       (<AND <VERB? TAKE MOVE>
		     <EQUAL? ,PRSO ,PAPER-TOWEL>
		     <IN? ,PRSO ,TOWEL-DISPENSER>>
		<TELL
"You pull out the paper towel - it's the last one." CR>
		<MOVE ,PRSO ,WINNER>)>>

<OBJECT STAINED-PAPER-TOWEL
	(DESC "blood-stained paper towel")
	(SYNONYM TOWEL)
	(ADJECTIVE WET BLOOD-STAINED STAINED BLOODY PAPER)
	(FLAGS TAKEBIT)
	(SCENARIO 1)
	(SIZE 4)
	(ACTION PAPER-TOWEL-F)>

<OBJECT WET-PAPER-TOWEL
	(DESC "wet paper towel")
	(SYNONYM TOWEL)
	(ADJECTIVE WET PAPER)
	(FLAGS TAKEBIT)
	(SCENARIO 1)
	(SIZE 4)
	(ACTION PAPER-TOWEL-F)>

<OBJECT LAV-SINK
	(LOC LAVATORY)
	(DESC "sink")
	(SYNONYM SINK)
	(FLAGS NDESCBIT CONTBIT OPENBIT TRANSBIT SEARCHBIT)
	(CAPACITY 12)
	(ACTION LAV-SINK-F)>

<ROUTINE LAV-SINK-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "An odd idea." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The sink is hideously dirty and grimy">
		<COND (<FSET? ,LAV-FAUCET ,OPENBIT>
		       <TELL ", in spite of the running water">)>
		<TELL "; you hesitate to even consider
using it.">
		<COND (<FIRST? ,LAV-SINK>
		       <TELL " ">
		       <FCLEAR ,LAV-SINK ,NDESCBIT>
		       <V-EXAMINE>
		       <FSET ,LAV-SINK ,NDESCBIT>)
		      (T
		       <CRLF>
		       )>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,LAV-SINK>
		     <G? <GETP ,PRSO ,P?SIZE> 2>>
		<TELL
"That would only clog the drain, which won't help you, though it
would make an interesting sort of statement." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,LAV-SINK>
		     <FSET? ,LAV-FAUCET ,OPENBIT>>
		<PERFORM ,V?PUT-UNDER ,PRSO ,LAV-FAUCET>
		<RTRUE>)>>

<OBJECT GLOBAL-TAIL
	(LOC GLOBAL-OBJECTS)
	(DESC "man following you")
	(SYNONYM MAN AGENT TAIL)
	(SCENARIO 1)
	(TRANSIENT <PLTABLE PLATFORM-1 PLATFORM-2 PLATFORM-3 PLATFORM-4>)
	(ACTION GLOBAL-TAIL-F)>

<ROUTINE GLOBAL-TAIL-F ()
	 <COND (<NOT ,FOLLOW-WARNING>
		<TELL
"You don't see any particular man around here, at least none that you
recognize." CR>)
	       (T
		<TELL
"You try to find the man who appears to be tailing you, but he has gone
out of sight." CR>)>>

<OBJECT GLOBAL-WATER
	(LOC GLOBAL-OBJECTS)
	(DESC "water")
	(SYNONYM WATER)
	(ADJECTIVE COLD)
	(ACTION GLOBAL-WATER-F)>

<ROUTINE GLOBAL-WATER-F ()
	 <COND (<NOT <EQUAL? ,HERE ,LAVATORY>>
		<TELL
"There's no water here." CR>)
	       (<VERB? DRINK EAT>
		<TELL "You ">
		<COND (<NOT <FSET? ,LAV-FAUCET ,OPENBIT>>
		       <TELL "turn on the faucet and ">)>
		<TELL "take a nice, refreshing drink, after which you
turn the water back off again." CR>
		<FCLEAR ,LAV-FAUCET ,OPENBIT>)
	       (<VERB? WALK>
		<PERFORM ,V?OPEN ,LAV-FAUCET>
		<RTRUE>)
	       (<VERB? ON OFF SET OPEN CLOSE>
		<PERFORM ,PRSA ,LAV-FAUCET>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-UNDER> <EQUAL? ,PRSI ,GLOBAL-WATER>>
		<COND (<NOT <FSET? ,LAV-FAUCET ,OPENBIT>>
		       <TELL
"There's no water running, so it'll take some time..." CR>)
		      (<EQUAL? ,PRSO ,PAPER-TOWEL>
		       <TELL
"You put the " D ,PRSO " under the running water until it's good
and wet." CR>
		       <MOVE ,WET-PAPER-TOWEL <LOC ,PAPER-TOWEL>>
		       <THIS-IS-IT ,WET-PAPER-TOWEL>
		       <REMOVE ,PAPER-TOWEL>)
		      (T
		       <TELL
"There's nothing to be gained by wetting that." CR>)>)>>

<OBJECT LAV-FAUCET
	(LOC LAVATORY)
	(DESC "faucet")
	(SYNONYM FAUCET)
	(FLAGS NDESCBIT)
	(ACTION LAV-FAUCET-F)>

<ROUTINE LAV-FAUCET-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Like much of the rest of Frobnia, you have a choice of cold or cold
running water - thus, only one faucet.">
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL " At the moment, the faucet is
open and water splashes into the sink and down the drain.">)>
		<CRLF>)
	       (<AND <VERB? PUT-UNDER> <EQUAL? ,PRSI ,LAV-FAUCET>>
		<PERFORM ,PRSA ,PRSO ,GLOBAL-WATER>
		<RTRUE>)
	       (<OR <VERB? OPEN ON>
		    <AND <VERB? SET> <NOT <FSET? ,PRSO ,OPENBIT>>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"The pressure is low, but the faucet is quite open." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <TELL
"You turn the faucet and the cold water starts to flow into the sink.">
		       <DOWN-THE-DRAIN ,LAV-SINK 3>
		       <CRLF>)>)
	       (<OR <VERB? CLOSE OFF>
		    <AND <VERB? SET> <FSET? ,PRSO ,OPENBIT>>>
		<COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <TELL
"The faucet is already closed." CR>)
		      (T
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL
"You turn off the faucet which, after some dripping, finally obliges." CR>)>)
>>

<OBJECT DOCUMENT
	(DESC "document")
	(SYNONYM PAPER DOCUMENT DRAWING)
	(ADJECTIVE TYPED FRONT)
	(FLAGS TAKEBIT)
	(SIZE 5)
	(SCENARIO 1)
	(ACTION DOCUMENT-F)>

<ROUTINE DOCUMENT-F ()
	 <COND (<VERB? FOLD>
		<COND (<G? <GETP ,PRSO ,P?SIZE> 4>
		       <PUTP ,PRSO ,P?SIZE 2>
		       <TELL
"The document is now folded up." CR>)
		      (T
		       <TELL
"It's already folded up as much as it can be." CR>)>)
	       (<VERB? UNFOLD>
		<COND (<L? <GETP ,PRSO ,P?SIZE> 4>
		       <TELL
"The document is no longer folded up." CR>
		       <PUTP ,PRSO ,P?SIZE 5>)
		      (T
		       <TOO-LATE>)>)
	       (<VERB? RIP MUNG>
		<TELL "You ">
		<COND (<VERB? RIP> <TELL "rip">)
		      (T <TELL "cut">)>
		<TELL
" up the document into a number of pieces, leaving you with a handful
of shreds." CR>
		<REMOVE ,DOCUMENT>
		<THIS-IS-IT ,SHREDS>
		<MOVE ,SHREDS ,WINNER>)
	       (<VERB? EXAMINE READ>
		<COND (<L? <GETP ,PRSO ,P?SIZE> 4>
		       <TELL
"Before you start reading, you first unfold the document." CR CR>
		       <PUTP ,PRSO ,P?SIZE 5>)>
		<TELL
"It's an official document of some kind, though you can't understand a
word of the contents - it's in Frobnian, naturally, so you wouldn't expect
to." CR>)
	       (<OR <VERB? OPEN CLOSE LOOK-INSIDE>
		    <AND <VERB? PUT PUT-ON> <EQUAL? ,DOCUMENT ,PRSI>>>
		<TELL "That's ridiculous." CR>)>>

<OBJECT SHRED
	(DESC "shred of the document")
	(SYNONYM SHRED DOCUMENT)
	(ADJECTIVE SMALL WET)
	(FLAGS TAKEBIT)
	(SCENARIO 1)
	(SIZE 1)
	(ACTION SHRED-F)>

<ROUTINE SHRED-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"You can tell it's from the original document, though it's hard to
make much of anything out of the small, wet shred of paper." CR>)>> 

<OBJECT SHREDS
	(DESC "handful of shreds")
	(SYNONYM SHRED SHREDS HANDFUL PILE PIECES)
	(ADJECTIVE PAPER)
	(FLAGS TAKEBIT)
	(SCENARIO 1)
	(SIZE 1)
	(ACTION SHREDS-F)>

<ROUTINE SHREDS-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"There about a dozen of them, none small enough to read which, presumably,
was the idea." CR>)
	       (<VERB? EAT>
		<TELL
"Just like in the movies, you eat the shreds; they don't go down easy,
and you hope you won't be seeing them again." CR>
		<REMOVE ,SHREDS>)
	       (<AND <VERB? TAKE> <IN? ,PRSO ,LAV-TOILET>>
		<TELL
"The shreds are wet, now. You can't take them." CR>)>>

<OBJECT LAV-MIRROR
	(LOC LAVATORY)
	(DESC "mirror")
	(SYNONYM MIRROR)
	(FLAGS NDESCBIT)
	(ACTION LAV-MIRROR-F)>

<ROUTINE LAV-MIRROR-F ()
	 <COND (<AND <VERB? PUT-BEHIND> <EQUAL? ,PRSI ,LAV-MIRROR>>
		<TELL "The mirror is flush with the wall." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL
"You see yourself, of course">
		<COND (<IN? ,CARNATION ,BYSTANDER-CLOTHES>
		       <TELL
", and the mangled carnation on your lapel reminds you of your task">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? MUNG KICK>
		<TELL
"There are enough vandals around without your getting into the act." CR>)>> 

<OBJECT LAV-WINDOW
	(LOC LAVATORY)
	(DESC "window")
	(SYNONYM WINDOW)
	(ADJECTIVE GRIMY)
	(FLAGS NDESCBIT)
	(ACTION LAV-WINDOW-F)>

<ROUTINE LAV-WINDOW-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL
"You can't make out much; the window is much too grimy." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"The window here doesn't open or close, which is a shame considering the not
too pleasant odors contained here. The only ones that ever seem to open are
those in the compartments." CR>)
	       (<VERB? CLEAN>
		<TELL
"It's good that somebody thought of it, but the grime is on the outside
and out of reach." CR>)
	       (<VERB? MUNG KICK>
		<TELL
"That would make lots of noise and bring attention to yourself, so you
reconsider." CR>)>>  

<GLOBAL BAD-TUNNEL <>>

<ROUTINE I-BAD-TUNNEL ()
	 <BOLDTELL
"From the sound of it, the train has just entered a tunnel. If memory
serves, you should be very near the border now.">
	 <SETG BAD-TUNNEL T>
	 <RT-QUEUE ,I-BAD-TUNNEL-END 160>
	 <RTRUE>>

<ROUTINE I-BAD-TUNNEL-END ()
	 <HLIGHT ,H-BOLD>
	 <TELL CR
"The train has left the tunnel; these are the final moments
before arriving at the checkpoint." CR>
	 <SETG BAD-TUNNEL <>>
	 <COND (<NOT <EQUAL? ,HERE ,LAVATORY>>
		<TELL CR
"Out of the corner of your eye, you catch a glimpse of someone
falling from the roof of the train! Though you can't be sure,
you'd swear it was the American agent.">)>
	 <HLIGHT ,H-NORMAL>
	 <CRLF>
	 <RT-QUEUE ,I-BAD-BORDER 100>>

<ROUTINE I-BAD-BORDER ("AUX" ITM TMP)
	 <HLIGHT ,H-BOLD>
	 <SETG BAD-CONFINED <>>
	 ;<COND (,DEBUG
		<TELL "[Suspicion: " N ,SUSPICION "]" CR>)>
	 <TELL CR
"The train, without warning, slams on its brakes and comes to a stop at
the border station. After so many trips, you'd think you were used to
this jarring moment, but alas, it's always the same." CR>
	 <HLIGHT ,H-NORMAL>
	 <CRLF>
	 <COND (<NOT <EQUAL? ,HERE ,COMP-5>>
		<GOTO ,COMP-5 <>>
		<TELL
"A guard comes up to you, speaks some gibberish you take for a lower-class
dialect of Frobnian, and hustles you back to your compartment." CR CR>)>
	 <TELL
"Within seconds, the man in the trench coat along with two uniformed
guards enter. This border search ritual has become second-nature
to you, although the man in the coat is a new twist." CR CR>
	 <TELL
"They begin by asking about your trip, your nationality (as if they
didn't know), and a host of inquiries about currency and other possible
contraband.">
	 <COND (<AND <FSET? ,CARNATION ,WORNBIT>
		     <NOT <FSET? ,CARNATION ,HUTBIT>>>
		<TELL " During the questioning, a guard motions to
the man in the trench coat who then appears to stare straight at your
clothing, frowning slightly.">
		<SETG SUSPICION <+ ,SUSPICION 1>>)>
	 <TELL " Then, as usual, they move on to the possessions." CR>
	 <COND (<ULTIMATELY-IN? ,BRIEFCASE ,HERE>
		<MOVE-ALL ,BRIEFCASE ,COMP-SEAT-FRONT>
		<THEY-START-WITH ,BRIEFCASE>
		<SET TMP T>
		<COND (<BAD-SEARCH ,BRIEFCASE>
		       <RTRUE>)>)>
	 <COND (<ULTIMATELY-IN? ,CAMERA-BAG ,HERE>
		<MOVE-ALL ,CAMERA-BAG ,COMP-SEAT-FRONT>
		<COND (.TMP
		       <FINDING-NOTHING ,CAMERA-BAG>)
		      (T
		       <THEY-START-WITH ,CAMERA-BAG>
		       <SET TMP T>)>
		<COND (<BAD-SEARCH ,CAMERA-BAG>
		       <RTRUE>)>)>
	 <COND (<ULTIMATELY-IN? ,CAMERA ,HERE>
		<COND (.TMP
		       <FINDING-NOTHING ,CAMERA>)
		      (T
		       <THEY-START-WITH ,CAMERA>
		       <SET TMP T>)>
		<TELL " The guard examines it for a moment, then
passes it to the trench coated man." CR>
		<COND (<CAMERA-SEARCH>
		       <RTRUE>)>
		<CRLF>)
	       (<NOT <ZERO? <LOC ,CAMERA>>>
		<TELL CR CR
"Just at this moment, another guard enters the compartment, holding your
camera. He speaks quickly, in Frobnian, then leaves. \"That was very
careless of you, leaving your camera in the " D <LOC ,CAMERA> ".\"" CR>
		<COND (<CAMERA-SEARCH>
		       <RTRUE>)>
		<CRLF>)
	       (<OR <ULTIMATELY-IN? ,COLOR-ROLL ,HERE>
		    <ULTIMATELY-IN? ,EXPOSED-ROLL ,HERE>>
		<TELL CR CR>
		<COND (<OR <IN? ,COLOR-ROLL ,COMP-SEAT-FRONT>
			   <IN? ,EXPOSED-ROLL ,COMP-SEAT-FRONT>>
		       <TELL
"The man in the trench coat looks down at the front facing seat and
holds up your film, frowning as though puzzled.">)
		      (T
		       <TELL
"The guards, who have started looking elsewhere in your compartment, find
your film and hand it to over to the trench coated man.">)>
		<TELL " \"Now this I find
peculiar. We find no camera of yours on this train, yet
here you have film.\" He toys with the film for a moment, then exposes
it all, handing it finally to one of the guards standing by. \"Let us
hope that the pictures were not so good anyway.\"">
		<COND (<ULTIMATELY-IN? ,COLOR-ROLL ,HERE>
		       <REMOVE ,COLOR-ROLL>)>
		<COND (<ULTIMATELY-IN? ,EXPOSED-ROLL ,HERE>
		       <REMOVE ,EXPOSED-ROLL>)>
		<CRLF>)>
	 <COND (<AND <L? ,SUSPICION 2>
		     ,SECOND-ROLL
		     <OR <DONT-CONFISCATE ,BRIEFCASE>
			 <DONT-CONFISCATE ,COMP-SEAT-BACK>
			 <DONT-CONFISCATE ,COMP-SEAT-FRONT>
			 <DONT-CONFISCATE ,COMP-RACK>>> T)
	       (<AND <G? ,SUSPICION 0>
		     <NOT ,SECOND-ROLL> ;"No roll in camera"
		     <CONFISCATE-FILM ,BRIEFCASE>> T)
	       (<AND <G? ,SUSPICION 1>
		     ,SECOND-ROLL
		     <OR <CONFISCATE-FILM ,BRIEFCASE>
			 <CONFISCATE-FILM ,COMP-SEAT-FRONT>
			 <CONFISCATE-FILM ,COMP-SEAT-BACK>
			 <CONFISCATE-FILM ,COMP-RACK>>> T)
	       (<OR <IN? ,COLOR-ROLL ,WINNER>
		    <IN? ,EXPOSED-ROLL ,WINNER>>
		<REMOVE-IF-IN? ,COLOR-ROLL ,WINNER>
		<REMOVE-IF-IN? ,EXPOSED-ROLL ,WINNER>
		<TELL CR
"He then notices the film you're holding, exposes that, and hands it
over to one of the guards. \"I do not understand why you would be holding
your film. It is night, and the view... well, the view is not so exciting.
We can only hope that the pictures here were not so good, eh?\"" CR>)>
	 ;"Look everywhere else..."
	 <COND (<OR <BAD-SEARCH ,LAV-TOILET>
		    <BAD-SEARCH ,LAV-SINK>
		    <BAD-SEARCH ,LAVATORY>
		    <BAD-SEARCH ,TOWEL-DISPENSER>
		    <BAD-SEARCH ,WINNER>
		    <BAD-SEARCH ,HERE>
		    <BAD-SEARCH ,TOILET-KIT>
		    <BAD-SEARCH ,COMP-RACK>
		    <BAD-SEARCH ,COMP-SEAT-FRONT>
		    <BAD-SEARCH ,COMP-SEAT-BACK>
		    <BAD-SEARCH ,UNDER-SEAT>>
		<RTRUE>)>
	 <TELL CR
"\"You have been through worse, I am sure.\" The man smiles that unnerving
smile of his and ">
	 <COND (<IN? ,CARNATION ,WINNER>
		<SETG SUSPICION <+ ,SUSPICION 1>>
		<TELL "seems to notice your carnation for the first time">)
	       (T
		<TELL "continues">)>
	 <TELL ". \"And you have been very patient. Have a pleasant
journey, and feel free to leave the train, if you wish. We shall be stopping
here longer than usual today.\" He exits, along with the other guards."> 
	 <SETG AT-STATION T>
	 <RT-QUEUE ,I-GORMNASH 850>
	 <I-CLOCKER 240>
	 <FCLEAR ,PASS-5 ,TOUCHBIT>
	 <FCLEAR ,PASS-6 ,TOUCHBIT>
	 <CRLF>>

<GLOBAL AT-STATION <>>

<ROUTINE DONT-CONFISCATE (OBJ)
	 <COND (<OR <IN? ,COLOR-ROLL .OBJ>
		    <IN? ,EXPOSED-ROLL .OBJ>>
		<TELL CR
"The man pauses, then moves to " THE .OBJ ", picking up the film that
lies there. He rolls it in his hand, then returns it. \"I was
thinking...\" he starts. He stops for a tense moment, then continues,
\"I was thinking that perhaps we are on the wrong track.\" And with
that, he returns the film to its place." CR>)>>

<ROUTINE CONFISCATE-FILM (OBJ)
	 <COND (<OR <IN? ,COLOR-ROLL .OBJ>
		    <IN? ,EXPOSED-ROLL .OBJ>>
		<REMOVE-IF-IN? ,COLOR-ROLL .OBJ>
		<REMOVE-IF-IN? ,EXPOSED-ROLL .OBJ>
		<TELL CR
"The man pauses, then moves to " THE .OBJ ", picking up the film that
is ">
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "sitting there">)
		      (T
		       <TELL "inside">)>
		<TELL ". \"I am afraid that this film will have to be
confiscated. We cannot be too careful with potential enemies
of the state.\"" CR>)>>

<ROUTINE REMOVE-IF-IN? (OBJ CNT)
	 <COND (<IN? .OBJ .CNT>
		<REMOVE .OBJ>
		<RTRUE>)>>

<ROUTINE CAMERA-SEARCH ("AUX" OBJ)
	 <TELL CR
"He smiles at you, but you find it difficult to return the
gesture. \"You like to take pictures,
then...\" He pauses, massaging his upper lip between his thumb and
forefinger, then ">
	 <COND (<FSET? ,CAMERA ,OPENBIT> <TELL "looks in">)
	       (T <TELL "opens">)>
	 <TELL " the back of the camera.">
	 <COND (<OR <IN? ,SHRED ,CAMERA>
		    <IN? ,SHREDS ,CAMERA>
		    <IN? ,DOCUMENT ,CAMERA>>
		<TELL CR CR
"He shakes his head for a moment, then pulls the " D <FIRST? ,CAMERA> "
out of the camera. ">
		<TELL ,BAD-END CR CR>
		<JIGS-UP ,EPILOGUE-ASS>
		<RTRUE>)
	       (<AND <SET OBJ <FIRST? ,CAMERA>>
		     <FSET? .OBJ ,FILMBIT>>
		<COND (<EQUAL? .OBJ ,COLOR-ROLL>
		       <SETG SECOND-ROLL ,EXPOSED-ROLL>)
		      (T
		       <SETG SECOND-ROLL ,COLOR-ROLL>)>
		<REMOVE .OBJ>
		<TELL
" \"I myself have quite an interest in photography, but as for these
pictures...\" He pulls the film out of the roll, exposing every
frame. \"These pictures...\" he continues, \"...were probably not your
best.\" He hands the exposed film to a guard, who pockets it.">)>
	 <RFALSE>>

<GLOBAL SECOND-ROLL <>>

<ROUTINE FINDING-NOTHING (OBJ)
	 <TELL " Seeing nothing of interest there, they continue with the "
	       D .OBJ ".">>

<ROUTINE THEY-START-WITH (OBJ)
	 <TELL CR "They start with the " D .OBJ
	       ", looking it over, and finally dumping its
contents onto the front facing seat.">>

<ROUTINE BAD-FOUND (ITM CNT)
	 <CRLF>
	 <COND (<EQUAL? .CNT ,WINNER>
		<COND (,BAD-INTERVIEW-FLAG
		       <TELL
"The man notices what you are carrying, and forces it from your hand.">)
		      (T
		       <TELL
"At the signal from a the man in the trench coat, a guard searches you,
finding the " D .ITM ". Looking pleased, he hands it">)>)
	       (<EQUAL? .CNT ,HERE>
		<COND (,BAD-INTERVIEW-FLAG
		       <TELL
"The man sees the " D .ITM " on the floor, and picks it up.">)
		      (T
		       <TELL
"One of the guards notices the " D .ITM " sitting on the floor. He
hands it">)>)
	       (<OR <EQUAL? .CNT ,LAVATORY>
		    <ULTIMATELY-IN? .CNT ,LAVATORY>>
		<TELL
"A guard bursts into the room, holding the " D .ITM ". He hands it">)
	       (<EQUAL? .CNT ,COMP-RACK ,COMP-SEAT-FRONT ,COMP-SEAT-BACK>
		<TELL
"One of the guards, who had been searching the " D .CNT ", finds the "
D .ITM " there and hands it">)
	       (T
		<TELL
"The guard searches for a moment, then finds the " D .ITM " which he
hands">)>
	 <COND (<AND <EQUAL? .CNT ,WINNER ,HERE> ,BAD-INTERVIEW-FLAG>
		<TELL "
He looks it over and shakes his head. \"I am afraid we shall have to
discuss this at length,\" he says. He assigns a guard to watch over
you until the train reaches the station. Once there, you are led into
a holding room, where you undergo a few hours of detailed interrogation.
You are finally released, but not before missing your rendezvous." CR CR>
		<JIGS-UP ,EPILOGUE-ASS>)
	       (T
		<TELL " to the man in the coat, who shakes
his head back and forth. ">)>
	 <COND (<EQUAL? .CNT ,TOWEL-DISPENSER ,LAV-TOILET>
		<TELL "\"In the " D .CNT
		      ", how very clever,\" the man begins. ">)>
	 <TELL ,BAD-END CR CR>
	 <JIGS-UP ,EPILOGUE-ASS>>

<GLOBAL BAD-END
"\"I am afraid you have not been very honest
with us. We will need to ask some, how to say, more difficult
questions now.\" He motions to the guards, who lead you into a
holding area nearby. After hours of questioning, you are
finally released, but not before missing your rendezvous.">

<GLOBAL EPILOGUE-ASS
"Epilogue|
|
Two days later, in your hotel room in Vienna, you notice the headline
reporting the assassination of the American ambassador to Litzenburg in
the small border town of Ostnitz. The apparent assassin
was a member of a radical Islamic group, although details of the plot
may never be known since the assassin himself was found dead at the
scene of the crime, an apparent suicide.">

<ROUTINE BAD-SEARCH (OBJ "AUX" (FND <>))
	 <COND (<IN? ,SHREDS .OBJ>
		<SET FND ,SHREDS>)
	       (<IN? ,DOCUMENT .OBJ>
		<SET FND ,DOCUMENT>)
	       (<IN? ,SHRED .OBJ>
		<SET FND ,SHRED>)>
	 <COND (.FND
		<BAD-FOUND .FND .OBJ>
		<RTRUE>)>>
		
<ROUTINE REMOVE-TO-BOTTOM (OBJ "AUX" N F)
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (T
			<SET N <NEXT? .F>>
			<COND (<FIRST? .F>
			       <REMOVE-TO-BOTTOM .F>)
			      (T
			       <REMOVE .F>)>
			<SET F .N>)>>
	 <REMOVE .OBJ>>

<OBJECT BY-GUN
	(LOC LOCAL-GLOBALS)
	(DESC "gun")
	(SYNONYM GUN GUNS)
	(ADJECTIVE MACHINE)
	(ACTION BY-GUN-F)>

<ROUTINE BY-GUN-F ()
	 <COND (<VERB? TAKE>
		<TELL
"You're likely to get only the bullets." CR>)
	       (T
		<TELL
"There's nothing useful for you to do with the gun." CR>)>>

<OBJECT BY-GUARDS
	(LOC LOCAL-GLOBALS)
	(DESC "guard")
	(SYNONYM GUARD GUARDS)
	(FLAGS PERSON)
	(ACTION BY-GUARDS-F)>

<ROUTINE BY-GUARDS-F ()
	 <COND (<VERB? PHOTOGRAPH>
		<TELL
"As you raise your camera, the guard raises his weapon. It would be a shame
to waste your last picture on him." CR>)
	       (<VERB? BRIBE>
		<TELL
"It's too risky; you'd probably end up in jail." CR>)
	       (<HURT? ,PRSO>
		<TELL
"Don't be ridiculous! You'd only get thrown in jail, and an iron-curtain
jail at that!" CR>)
	       (<VERB? EXAMINE>
		<COND (,AT-STATION
		       <TELL
"The guard is standing just north of your position, and he motions for
you to exit the train to the south." CR>)
		      (T
		       <TELL
"The guards are in uniform and appear to be heavily armed. There is one
at each end of the passageway; although this train is always heavily guarded,
today's showing is somewhat unnerving." CR>)>)
	       (<AND <VERB? SHOW GIVE>
		     <EQUAL? ,PRSO ,DOCUMENT ,SHRED ,SHREDS>>
		<PERFORM ,V?GIVE ,PRSO ,BAD-SPY>
		<RTRUE>)>>

<OBJECT SAY-IT-IN-FROBNIAN
	(LOC BRIEFCASE)
	(DESC "tourist guide and phrase book")
	(SYNONYM BOOK GUIDE)
	(ADJECTIVE TOURIST FROBNIAN PHRASE)
	(FLAGS TAKEBIT)
	(SIZE 8)
	(ACTION SAY-IT-IN-FROBNIAN-F)>

<ROUTINE SAY-IT-IN-FROBNIAN-F ()
	 <COND (<VERB? EXAMINE READ OPEN>
		<CAN-BE-FOUND>)>>

<OBJECT PASSPORT
	(LOC BRIEFCASE)
	(DESC "passport")
	(SYNONYM PASSPORT)
	(FLAGS TAKEBIT READBIT)
	(SIZE 6)
	(ACTION PASSPORT-F)>

<ROUTINE PASSPORT-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"It's yours, all right, and it hasn't changed since you last looked at
it." CR>)>>

<OBJECT TICKET
	(LOC BRIEFCASE)
	(DESC "train ticket")
	(SYNONYM TICKET)
	(ADJECTIVE TRAIN)
	(FLAGS TAKEBIT)
	(ACTION TICKET-F)>

<ROUTINE TICKET-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"It's your ticket out of the country, and is printed in Frobnian." CR>)>>

<OBJECT PLAT-TRAIN
	(LOC LOCAL-GLOBALS)
	(DESC "train")
	(SYNONYM TRAIN)
	(ACTION PLAT-TRAIN-F)>

<ROUTINE PLAT-TRAIN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The train is stopped here at the station. There are four cars in
all, and a guard is posted at each entrance to prevent the passengers
from reboarding until the train is ready to get underway again. You've
never understood this procedure, but that's nothing new in Frobnia." CR>)
	       (<VERB? BOARD ENTER CLIMB-ON>
		<TELL
"You are stopped by one of the guards. \"Nye mneshna pletska bli!\"" CR>)>>

<ROUTINE I-GORMNASH ()
	 <HLIGHT ,H-BOLD>
	 <TELL CR
"The train's conductor cries \"Gormnash floogle nomnetz!\" indicating
that the train is ready to leave. ">
	 <COND (<FSET? ,HERE ,PLATFORMBIT>
		<TELL "Not wishing to remain here with an
invalid ticket, you return to the train,">)
	       (T
		<TELL "A minute later, the train pulls away from the
station, and you kick yourself for">)>
	 <TELL " having failed to make contact
with the friendly agent." CR>
	 <HLIGHT ,H-NORMAL>
	 <CRLF>
	 <JIGS-UP ,EPILOGUE-ASS>>
	 


;"Saying it in frobnian..."

<GLOBAL CONTACT <>>

<GLOBAL BUMPER-FLAG <>>

<GLOBAL CONTACT-WAIT <>>

<GLOBAL I-FATAL <>>

<GLOBAL PASSWORD-GIVEN <>>

<ROUTINE I-PLATFORM ()
	 <COND (,CONTACT-WAIT
		<SETG CONTACT-WAIT <>> 
		<RFALSE>)
	       (,BUMPER-FLAG
		<SETG I-FATAL T>
		<HLIGHT ,H-BOLD>
		<CRLF>
		<COND (<EQUAL? ,BUMPER-FLAG ,CONTACT>
		       <COND (<AND <IN? ,COLOR-ROLL <LOC ,BUMPER-FLAG>>
				   ,PASSWORD-GIVEN>
			      <COND (<L? ,SUSPICION 2>
				     <SCENE-1-FINISH ,COLOR-ROLL>)
				    (T
				     <TELL
"The " D ,BUMPER-FLAG " bends down to pick up the roll of film when
two men approach, guns raised.">
				     <SCENE-1-ARREST>)>
			      <RTRUE>)
			     (T
			      <TELL
"Your contact looks around nervously, then darts off and out of sight." CR>)>
		       <CRLF>
		       <TELL
"Having lost sight of your contact, you have failed in your mission, and
you return to your train dejectedly." CR CR>
		       <JIGS-UP ,EPILOGUE-ASS>)
		      (<NOT <IN? ,BUMPER-FLAG ,HERE>>
		       <TELL
"You have walked away from the " D ,BUMPER-FLAG ", who barely seems to
have noticed.">)
		      (T
		       <TELL
"The " D ,BUMPER-FLAG " walks off and is lost in the crowd.">)>
		<REMOVE ,BUMPER-FLAG>
		<SETG BUMPER-FLAG <>>
		<HLIGHT ,H-NORMAL>
		<CRLF>
		<RTRUE>)
	       (<AND <IN? ,CARNATION ,BYSTANDER-CLOTHES>
		     ;"** Increase this with time"
		     <PROB ,CONTACT-PROB>>
		<SETG I-FATAL T>
		<HLIGHT ,H-BOLD>
		<TELL CR
		      <GETP ,CONTACT ,P?BUMPER>
		      " \""
		      <GET <GETP ,CONTACT ,P?FROBNIAN> 0>
		      "\"">
		<HLIGHT ,H-NORMAL>
		<CRLF>
		<SETG BUMPER-FLAG ,CONTACT>
		<MOVE ,BUMPER-FLAG ,HERE>)
	       (<PROB 50>
		<SETG CONTACT-PROB <+ ,CONTACT-PROB 10>>
		<SETG I-FATAL T>
		<SETG BUMPER-FLAG <PICK-WRONG-BUMPER>>
		<FSET ,BUMPER-FLAG ,TOUCHBIT>
		<HLIGHT ,H-BOLD>
		<TELL CR
		      <GETP ,BUMPER-FLAG ,P?BUMPER>
		      " \""
		      <GET <GETP ,BUMPER-FLAG ,P?FROBNIAN> 0>
		      "\"">
		<HLIGHT ,H-NORMAL>
		<CRLF>
		<MOVE ,BUMPER-FLAG ,HERE>)
	       (T
		<SETG CONTACT-PROB <+ ,CONTACT-PROB 10>>
		<RFALSE>)>>

<GLOBAL CONTACT-PROB 25>

<ROUTINE PICK-WRONG-BUMPER ("AUX" TMP)
	 <REPEAT ()
		 <COND (<NOT <EQUAL? <SET TMP <PICK-ONE ,BUMPERS>> ,CONTACT>>
			<RETURN .TMP>)>>>

<GLOBAL BUMPERS <LTABLE 0
			OLD-MAN
			YOUNG-BOY
			RUSSIAN-GUARD
			SMALLISH-WOMAN
			YOUNG-GIRL>>

<OBJECT YOUNG-GIRL
	(DESC "young girl")
	(SYNONYM GIRL)
	(ADJECTIVE YOUNG)
	(BDESC
"The young girl is holding the hand of her mother, tugging gently.
She seems distracted, as young girls will be.")
	(BUMPER
"A young girl, holding her mother's hand, walks into you and stumbles.
She says, meekly,")
	(FROBNIAN <PTABLE "Pripsa dazi, vaz!"
			 "Pardon me, sir.">)
	(ACTION BUMPER-F)>

<OBJECT OLD-MAN
	(DESC "old man")
	(SYNONYM MAN)
	(ADJECTIVE OLD)
	(BDESC
"The man is old and infirm. He apparently can't see too well, for he is
constantly squinting. He also appears to be mumbling to himself.")
	(BUMPER
"An old man seems to walk right into you. He adjusts his glasses and
says")
	(FROBNIAN <PTABLE "Pripsa dazi!"
			 "Pardon me.">)
	(ACTION BUMPER-F)>

<OBJECT YOUNG-BOY
	(DESC "young boy")
	(SYNONYM BOY)
	(ADJECTIVE YOUNG)
	(BDESC
"The boy is looking rather ashamed at having bumped into you. He
clearly recognizes you as a stranger, and starts to look away.")
	(BUMPER
"A young boy, perhaps twelve years old, backs into you. He bows,
saying")
	(FROBNIAN <PTABLE "Hartzi dazi!"
			 "Forgive me.">)
	(ACTION BUMPER-F)>

<OBJECT RUSSIAN-GUARD
	(DESC "Russian soldier")
	(SYNONYM SOLDIER)
	(ADJECTIVE RUSSIAN)
	(BDESC
"He stares you down as you look clearly at him, but his face reveals
nothing more than his words.")
	(BUMPER
"A stern-faced Russian soldier brushes into you. He leers at you, spits,
and says")
	(FROBNIAN <PTABLE "Vinchim dorn!"
			 "You are in my way!">)
	(ACTION BUMPER-F)>

<OBJECT SMALLISH-WOMAN
	(DESC "smallish woman")
	(SYNONYM WOMAN)
	(ADJECTIVE SMALLISH)
	(BDESC
"She averts her gaze as you attempt to get a better look at her. You
can tell she's fairly young and quite beautiful.")
	(BUMPER
"A smallish woman, in peasant dress, bumps into you. She looks at you
fiercely and says")
	(FROBNIAN <PTABLE "Oopzi dazi. Izi slep!"
			 "Excuse me. I am sorry.">)
	(ACTION BUMPER-F)>

<ROUTINE SCENE-1-ARREST ()
	 <TELL "
\"Nye yensk. Ouzna gotcha!\" he says. You don't recognize the
first sentence, but the second is practically the national motto.
A moment later, the man in the trench coat arrives. \"You have
been quite clever,\" he begins, \"but I'm afraid you have given
yourself away.\" He smiles, as the two of you are hustled off
to an interrogation room.">
	 <TELL CR CR
"You are charged with espionage, but after a few months
and with the intervention of the American consulate, you are finally
released." CR CR>
	 <FINISH>>

<ROUTINE BUMPER-F ()
	 <COND (<AND <VERB? FOLLOW> <NOT <IN? ,PRSO ,HERE>>>
		<COND (<FSET? ,PRSO ,TOUCHBIT>
		       <TELL
"It's no good; you've lost sight of the " D ,PRSO "." CR>)
		      (T
		       <TELL
"You haven't seen that person, at least not yet." CR>)>)
	       (<AND <VERB? GIVE SHOW> <GETP ,PRSI ,P?BUMPER>>
		<COND (<G? ,SUSPICION 0>
		       <TELL
"You start to hand the " D ,PRSO " to the " D ,PRSI ", when a
man steps up behind you and places a gun in the small of your back.">
		       <SCENE-1-ARREST>)
		      (<AND <EQUAL? ,BUMPER-FLAG ,CONTACT> ,PASSWORD-GIVEN>
		       <COND (<L? <WEIGHT ,PRSO> 20>
			      <SCENE-1-FINISH>)
			     (T
			      <TELL
"The " D ,BUMPER-FLAG " looks horrified at the size of your delivery,
waving you off and moving away; so near to your goal, but you have
failed!" CR CR>
			      <JIGS-UP ,EPILOGUE-ASS>)>
		       <RTRUE>)
		      (T
		       <TELL
"The " D ,BUMPER-FLAG " looks at you suspiciously, and fends you
off with a wave of the hand and the words \"Nyep. Prep tipna.\"" CR>
		       <BAD-ARREST?>
		       <RTRUE>)>)
	       (<AND <VERB? EXAMINE> <GETP ,PRSO ,P?BDESC>>
		<TELL <GETP ,PRSO ,P?BDESC> CR>)>>

<ROUTINE SCENE-1-FINISH ("OPTIONAL" (OBJ <>) "AUX" PHOTO)
	 <COND (<NOT .OBJ> <SET OBJ ,PRSO>)>
	 <TELL
"The " D ,CONTACT " surreptitiously takes the " D .OBJ " and hides
it under some clothes. A moment later, your contact is gone, lost in
the crowd." CR>
	 <COND (<AND <OR <EQUAL? .OBJ ,COLOR-ROLL>
			 <IN? ,COLOR-ROLL .OBJ>>
		     <OR <EQUAL? <GET <SET PHOTO <GETP ,COLOR-ROLL ,P?PHOTO>>
				      0>
				 ,DOCUMENT>
			 <EQUAL? <GET .PHOTO 1>
				 ,DOCUMENT>>
		     <NOT ,FILM-RUINED>>
		<TELL CR
"You congratulate yourself on your good work, and happily reboard the
train for Vienna, wondering what it was all about and what, if any,
fruits your efforts have borne." CR CR>
		<JIGS-UP
"|
Epilogue|
|
Two days later, in your hotel room in Vienna, you notice a headline
referring to an attempted assassination of a high-ranking American
diplomat in the small border town of Ostnitz, Litzenburg. Accounts
were sketchy, but it appears as if local police were tipped off about
the impending attack in time to prevent it.|
|
Congratulations! You get no medals, but you've successfully finished
the first chapter of Border Zone. The story continues with Chapter 2:
The Border. To start, type CONTINUE at the next prompt.
|
" 2>)
	       (T
		<JIGS-UP ,EPILOGUE-ASS>
		<RTRUE>)>>

<BUZZ OOPZI DAZI IZI SLEP POPKA IZIM HARTZI PRIPSA
      BESNAP BELBOZ BRZNI>

<GLOBAL FROBNIAN
	<PLTABLE <PTABLE <PLTABLE W?HARTZI W?DAZI> FZ-EXCUSES>
		 <PTABLE <PLTABLE W?OOPZI W?DAZI> FZ-EXCUSES>
		 <PTABLE <PLTABLE W?PRIPSA W?DAZI> FZ-EXCUSES>
		 <PTABLE <PLTABLE W?POPKA W?IZIM> FZ-MY-FAULT>>>

<GLOBAL BUMPER-ACTIONS 0>

<ROUTINE BAD-ARREST? ()
	 <SETG BUMPER-ACTIONS <+ ,BUMPER-ACTIONS 1>>
	 <COND (<AND <G? ,SUSPICION 1>
		     <G? ,BUMPER-ACTIONS <- 4 ,SUSPICION>>>
		<TELL CR
"A man walks up behind you, shoves a gun into the small of your back,
and asks you to walk with him. You can hardly refuse, and you are led
to a small back room at the station where you are greeted by the man
in the trench coat. \"We meet again,\" he says, \"and it appears that
you have been ">
		<COND (<AND ,BAD-SPEAKING <PROB 50>>
		       <TELL "conversing">)
		      (<PROB 60>
		       <TELL "consorting">)
		      (T
		       <TELL "molesting">)>
		<TELL " with Frobnian nationals. This is not allowed,
as you must know.\"" CR>
		<TELL CR
"You are questioned continuously just until your train is ready to depart,
and as an added security measure, you are escorted back to your compartment.
You realize that you must have done something to have raised the Frobnians'
suspicion of you, but it is too late now. You have missed your
rendezvous!" CR CR>
		<FINISH>)>>

<ROUTINE FZ-EXCUSES ()
	 <COND (,BUMPER-FLAG
		<TELL
"The " D ,BUMPER-FLAG " seems to understand your apology and nods in
acknowledgement." CR>
		<BAD-ARREST?>
		<SETG BAD-SPEAKING T>
		<RTRUE>)
	       (T
		<TELL ,NO-FROBNIAN CR>)>> 

<GLOBAL BAD-SPEAKING <>>

<ROUTINE FZ-MY-FAULT ()
	 <COND (<IN? ,CONTACT ,HERE>
		<SETG CONTACT-WAIT T>
		<SETG PASSWORD-GIVEN T>
		<TELL
"The " D ,CONTACT " makes eye contact, then looks away, nervously.
You are evidently not what was expected." CR>
		<BAD-ARREST?>)
	       (T
		<FZ-EXCUSES>)>>

<GLOBAL NO-FROBNIAN
"Nobody responds. Maybe it is your accent, or maybe you should reread
your phrase book, or just maybe nobody's interested.">

<ROUTINE SIIF ("AUX" PTR (LEN 0) FLEN (FOFF 0) FEXP TMP FWRD FWLEN)
	 <SET PTR <GET ,OOPS-TABLE ,O-CONT>>
	 <SET TMP <GET ,OOPS-TABLE ,O-LEN>>
	 <REPEAT ()
		 <COND (<OR <EQUAL? <GET ,P-LEXV .PTR> ,W?QUOTE>
			    <L? <SET TMP <- .TMP 1>> 0>>
			<RETURN>)
		       (T
			<SET LEN <+ .LEN 1>>
			<SET PTR <+ .PTR 2>>)>>
	 <SET FLEN <GET ,FROBNIAN 0>>
	 <REPEAT ()
		 <COND (<G? <SET FOFF <+ .FOFF 1>> .FLEN>
			<COND (,BUMPER-FLAG
			       <TELL
"The " D ,BUMPER-FLAG " looks confused. It doesn't appear that your
Frobnian has made a big impression." CR>
			       <SETG BAD-SPEAKING T>
			       <BAD-ARREST?>)
			      (T
			       <TELL ,NO-FROBNIAN CR>)>
			<RTRUE>)
		       (T
			<SET FEXP <GET ,FROBNIAN .FOFF>>
			<COND (<EQUAL? <SET FWLEN
					    <GET <SET FWRD <GET .FEXP 0>>
						 0>>
				       .LEN>
			       ;"Right length"
			       <SET TMP 0>
			       <SET PTR <GET ,OOPS-TABLE ,O-CONT>>
			       <REPEAT ()
				       <COND (<G? <SET TMP <+ .TMP 1>> .FWLEN>
					      <SET TMP -1>
					      <RETURN>)
					     (<EQUAL? <GET .FWRD .TMP>
						      <GET ,P-LEXV .PTR>>
					      <SET PTR <+ .PTR 2>>)
					     (T
					      <RETURN>)>>
			       <COND (<L? .TMP 0>
				      <SET FOFF -1>)>)>)>
		 <COND (<L? .FOFF 0>
			<APPLY <GET .FEXP 1>>
			<RTRUE>)>>>