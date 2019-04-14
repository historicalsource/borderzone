
"GOOD for
			       BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"Scenario-related routines"

<ROUTINE I-120-SECONDS () 
	 <COND (<NOT <IN? ,RIPPED-CLOTHES ,WOUNDED-LEFT-ARM>>
		<COND (<L? <SETG HEALTH <- ,HEALTH 1>> 1>
		       <JIGS-UP
"You pass out from loss of blood.">)
		      (T
		       <HLIGHT ,H-BOLD>
		       <TELL CR <GET ,HEALTH-TBL </ ,HEALTH 2>>>
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)>)>>

<GLOBAL 30-TIMER 0>

<ROUTINE I-30-SECONDS ("AUX" TMP HF (OC <LOC ,CAR>))
	 <SETG 30-TIMER <+ ,30-TIMER 1>>
	 <COND (<ZERO? <MOD ,30-TIMER 4>>
		<I-120-SECONDS>)>
	 <COND (<L? <SETG WOOD-TIMER <- ,WOOD-TIMER 1>> 0>
		<RUN-WOOD-SEQUENCE>)
	       (<NOT <ZERO? ,CAR-SEQUENCE>>
		<RUN-CAR-SEQUENCE>)
	       (,CAR-ON-ROAD?
		<SET TMP <GET ,RESTED-ROAD-TBL 0>>
		<COND (<ZERO? .TMP> <REMOVE ,CAR>)
		      (T <MOVE ,CAR .TMP>)>
		<SETG RESTED-ROAD-TBL <REST ,RESTED-ROAD-TBL 2>>
		<COND (<ZERO? .TMP>
		       <COND (<EQUAL? ,HERE ,B8 ,C8 ,D8>
			      <BOLDTELL
"You watch as the automobile speeds into the tunnel and disappears.">)>
		       <SETG CAR-ON-ROAD? <>>)
		      (<EQUAL? ,HERE .TMP>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <CAR-NEARLY-HITS>
		       <RTRUE>)
		      (<AND <EQUAL? .TMP ,ROAD-END> <NOT ,SEQUENCE-RUN?>>
		       <SETG SEQUENCE-RUN? T>
		       <SETG CAR-SEQUENCE 1>
		       <RUN-CAR-SEQUENCE>)
		      (<EQUAL? .OC ,ROOMS> T)
		      (<AND <EQUAL? .TMP ,D6>
			    ,SEQUENCE-RUN?
			    <EQUAL? ,HERE ,NORTH-HUT ,C5>>
		       <BOLDTELL
"You watch as the car makes a three-point turn, then heads back down the
road to the south.">)
		      (T
		       <GONE-TO-THE-DOGS? <HOW-FAR .OC ,HERE T>
					  <HOW-FAR .TMP ,HERE T>
					  ,CAR>)>)>>

<GLOBAL HEALTH 10>

<GLOBAL WARMTH 10>

<GLOBAL BEEN-AT-HUT? <>>

<GLOBAL CUT-VIGILANCE <>>

<ROUTINE GONE-TO-THE-DOGS? (DL NDL "OPTIONAL" (BOGEY ,DOGS) (BMOVE T)
			    	   "AUX" (N <>) (S <>) (E <>) (W <>) 
			    		 T1 T2 (F <>))
	 <COND (.BMOVE <HLIGHT ,H-BOLD>)>
	 <COND (<G? <SET T1 <GETP ,HERE ,P?NS>>
		    <SET T2 <GETP <LOC .BOGEY> ,P?NS>>>
		<SET N T>)
	       (<L? .T1 .T2>
		<SET S T>)>
	 <COND (<G? <SET T1 <GETP ,HERE ,P?EW>>
		    <SET T2 <GETP <LOC .BOGEY> ,P?EW>>>
		<SET W T>)
	       (<L? .T1 .T2>
		<SET E T>)>
	 <COND (<G? .DL 3> ;"Weren't nearby"
	        <COND (<L? .NDL 4> ;"Are now"
		       <CRLF>
		       <TELL "You can hear " A .BOGEY " off to the ">
		       <FSET .BOGEY ,PENBIT>
		       <SET F T>)
		      (T
		       <COND (.BMOVE <HLIGHT ,H-NORMAL>)>
		       <RTRUE>)>)
	       (<OR <L? .NDL .DL> <ZERO? .NDL>> ;"Closer"
		<COND (<EQUAL? .NDL 2>
		       <CRLF>
		       <COND (<EQUAL? .BOGEY ,DOGS>
			      <TELL
"The sound of barking dogs echoes into the night. They">
			      <COND (<FSET? .BOGEY ,PENBIT>
				     <COND  (<NOT .BMOVE> <TELL " are">)
					    (T <TELL "'ve moved">)>
				     <TELL " closer now, perhaps not">)
				    (T
				     <FSET .BOGEY ,PENBIT>
				     <TELL " can't be">)>)
			     (<FSET? ,HERE ,ROADBIT>
			      <COND (<FSET? .BOGEY ,PENBIT>
				     <TELL "The">)
				    (T
				     <FSET .BOGEY ,PENBIT>
				     <TELL "An">)>
			      <TELL
" automobile comes into view, moving slowly; it's no">)
			     (<NOT <FSET? .BOGEY ,PENBIT>>
			      <FSET .BOGEY ,PENBIT>
			      <TELL
"You can hear an automobile engine close by; it can't be">)
			     (T
			      <TELL
"The automobile's engine sounds closer now; it can't be">)>
		       <TELL " more than a few hundred yards to the "> 
		       <SET F T>)
		      (<EQUAL? .NDL 1>
		       <COND (<EQUAL? .BOGEY ,DOGS>
			      <CRLF>
			      <TELL
"The sound of the dogs is much louder now, and you can hear the shouting
voices of the guards they accompany. They can't be more than a hundred yards
to the ">
			      <SET F T>)
			     (<FSET? ,HERE ,ROADBIT>
			      <COND (<EQUAL? ,HERE
					     <GET ,RESTED-ROAD-TBL 0>>
				     <TELL CR
"The automobile is bearing down on you now, though it doesn't seem as if
the driver has taken notice. He's no more than a hundred yards away.">)
				    (T
				     <TELL CR
"The automobile is only a hundred yards from you, but it is moving away.
It will soon be out of sight.">)>)
			     (T
			      <TELL CR
"The automobile is much closer now, perhaps no more than one hundred
yards to the ">
			      <SET F T>)>)
		      (T
		       <TELL CR
"The sound of the dogs seems to come from all around you. They can't be
more than fifty yards away.">)>)
	       (<EQUAL? .NDL .DL>
		<COND (<EQUAL? .BOGEY ,DOGS>
		       <COND (<AND .BMOVE
				   <EQUAL? <GETP <SET T1 <LOC ,DOGS>> ,P?EW>
					   4>
				   <EQUAL? <GETP .T1 ,P?NS> 5>>
			      <TELL CR
"The dogs sound just a little bit closer and they still">)
			     (.BMOVE
			      <TELL CR
"The dogs are no closer, but now they">)
			     (T
			      <TELL
"You've moved such that the dogs now">)>
		       <TELL " seem to be off to the ">)
		      (T
		       <TELL CR
"From the sound of it, the car is now off to the ">)>
		<SET F T>)
	       (<G? .NDL 3>
		<COND (.BMOVE <CRLF>)>
		<COND (<EQUAL? .BOGEY ,DOGS>
		       <TELL
"To your relief, the sound of the dogs has faded into the distance.">)
		      (T
		       <TELL
"The sounds of the automobile fade into the night air.">)>)
	       (T
		<COND (<EQUAL? .BOGEY ,DOGS>
		       <COND (.BMOVE
			      <TELL CR
"The sounds of the dogs seem">)
			     (T
			      <TELL
"You've moved such that the barking seems">)>
		       <TELL " farther away and to the ">)
		      (T
		       <TELL CR
"The automobile sounds farther away and to the ">)>
		<SET F T>)>
	 <COND (.F
		<COND (.N <TELL "north">)
		      (.S <TELL "south">)>
		<COND (.E <TELL "east">)
		      (.W <TELL "west">)>
		<TELL ".">
		<COND (<AND <EQUAL? .BOGEY ,DOGS> ,LOST-SCENT>
		       <TELL
" The dogs' barking is more shrill now than when you first heard it.">)>)>
	 <COND (.BMOVE <HLIGHT ,H-NORMAL> <CRLF>)
	       (T
		<CRLF>
		<CRLF>)>
	 <RTRUE>>

<GLOBAL HEALTH-TBL
	<PTABLE "You are on your last legs now, and have trouble moving around. Even the most simple of actions is complicated, and you realize that your mission will soon end in failure. If you're lucky, maybe they'll find you before you die here."
	       "You've gotten to the point where you must stop and rest briefly after every few dozen steps. Unless you stop the blood loss soon, you will collapse."
	       "The weakness has taken a toll on your physical abilities; movement is slower and less sure."
	       "You are definitely weaker now, and it is starting to affect you significantly."
	       "You're starting to feel a little weak and confused; it occurs to you that you won't last very long unless you stop the bleeding from your wounded left arm."
	       >>

<OBJECT GLOBAL-TOURNIQUET
	(LOC GLOBAL-OBJECTS)
	(DESC "tourniquet")
	(SYNONYM TOURNIQUET)
	(SCENARIO 2)
	(ACTION GLOBAL-TOURNIQUET-F)>

<ROUTINE GLOBAL-TOURNIQUET-F ()
	 <COND (<AND <VERB? MAKE> ,PRSI <NOT ,CLOTHES-RIPPED>>
		<COND (<EQUAL? ,PRSI ,CLOTHES>
		       <PERFORM ,V?RIP ,CLOTHES>
		       <RTRUE>)
		      (T
		       <TELL
"You won't have any luck making a tourniquet out of that." CR>)>)
	       (<VERB? MAKE>
		<TELL
"That's easy enough to say; the question is really how you can make one." CR>)
	       (<VERB? FIND>
		<TELL
"It's unlikely that you'll just run into one. You'd do better to make
one." CR>)>>

<OBJECT RIPPED-CLOTHES
	(DESC "piece of ripped fabric")
	(SYNONYM FABRIC TOURNIQUET PIECE RAG SCRAP)
	(ADJECTIVE RIPPED TORN)
	(FLAGS TAKEBIT)
	(SCENARIO 2)
	(ACTION RIPPED-CLOTHES-F)>

<ROUTINE RIPPED-CLOTHES-F ()
	 <COND (<VERB? TIE>
		<TELL
"Tying it to that won't do you any good." CR>)
	       (<VERB? MAKE>
		<TELL
"You've already made a tourniquet, of sorts. Now you've just got to
use it to stop the bleeding." CR>)
	       (<AND <IN? ,RIPPED-CLOTHES ,WOUNDED-LEFT-ARM>
		     <VERB? TAKE TAKE-OFF UNTIE>>
		<TELL
"That would only cause you to start bleeding again." CR>)
	       (<AND <IN? ,RIPPED-CLOTHES ,RIGHT-ARM>
		     <VERB? TAKE-OFF UNTIE>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<OBJECT BODY-PARTS
	(LOC GLOBAL-OBJECTS)
	(DESC "body part")
	(SYNONYM LEG FOOT HEAD EYE NOSE)
	(ADJECTIVE MY LEFT RIGHT)
	(ACTION BODY-PARTS-F)>

<ROUTINE BODY-PARTS-F ()
	 <COND (<AND <VERB? PUT-ON> <EQUAL? ,PRSI ,BODY-PARTS>>
		<TELL
"You couldn't hide anything there." CR>)
	       (T
		<TELL
"There's no reason to refer to that part of your body." CR>)>>


<OBJECT LEFT-ARM
	(DESC "your left arm")
	(SYNONYM ARM)
	(ADJECTIVE MY LEFT)
	(FLAGS NDESCBIT NARTICLEBIT WORNBIT NOTHEBIT NOABIT OPENBIT
	 SEARCHBIT SURFACEBIT)
	(ACTION ARM-F)>

<OBJECT WOUNDED-LEFT-ARM
	(DESC "your left arm")
	(SYNONYM ARM WOUND BLOOD)
	(ADJECTIVE MY LEFT BLEEDING BLOODY INJURED HURT WOUNDED)
	(FLAGS NDESCBIT NARTICLEBIT WORNBIT SEARCHBIT SURFACEBIT
	 NOTHEBIT NOABIT OPENBIT)
	(ACTION ARM-F)>

<OBJECT RIGHT-ARM
	(LOC PROTAGONIST)
	(DESC "your right arm")
	(SYNONYM ARM)
	(ADJECTIVE MY RIGHT)
	(FLAGS NDESCBIT NARTICLEBIT WORNBIT SEARCHBIT SURFACEBIT
	 NOTHEBIT NOABIT OPENBIT)
	(ACTION ARM-F)>

<ROUTINE ARM-F ()
	 <COND (<AND <VERB? TIE PUT PUT-ON> <EQUAL? ,PRSO ,CLOTHES>>
		<COND (<IN? ,RIPPED-CLOTHES ,WINNER>
		       <PERFORM ,PRSA ,RIPPED-CLOTHES ,PRSI>
		       <RTRUE>)>
		<TELL
"With " THE ,PRSO " intact, it's hard to see how you can tie it around
your arm." CR>)
	       (<AND <VERB? TIE PUT PUT-ON>
		     <EQUAL? ,PRSO ,RIPPED-CLOTHES>
		     <NOT <IN? ,PRSO ,PRSI>>>
		<MOVE ,PRSO ,PRSI>
		<TELL
"You make a tourniquet of the torn piece of clothing and put it over ">
		<COND (<EQUAL? ,PRSI ,WOUNDED-LEFT-ARM>
		       <TELL "your bleeding left arm.">)
		      (T
		       <TELL THE ,PRSI ".">)>
		<COND (<EQUAL? ,PRSI ,WOUNDED-LEFT-ARM>
		       <TELL " Blood oozes from the wound into the cloth,
but the major bleeding appears to be stopped.">)>
		<CRLF>)
	       (<VERB? TIE PUT-ON>
		<TELL
"What a strange thing to want to do!" CR>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <EQUAL? ,PRSO ,WOUNDED-LEFT-ARM>>
		<COND (<IN? ,RIPPED-CLOTHES ,WOUNDED-LEFT-ARM>
		       <TELL
"It hurts like hell, and blood oozes from around the tourniquet, but
it's not bleeding badly." CR>)
		      (T
		       <TELL
"It looks pretty bad. The bullet has apparently damaged an artery in your
upper arm, and the bleeding is continuous." CR>)>)
	       (<AND <VERB? OFF OFF-2>
		     <EQUAL? ,PRSO ,WOUNDED-LEFT-ARM>>
		<TELL
"That appears to be your problem." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"There's nothing wrong with it">
		<COND (<IN? ,RIPPED-CLOTHES ,PRSO>
		       <TELL ", so it's something of a mystery why you've
got a tourniquet around it">)>
		<TELL ,PERIOD-CR>)
	       (<AND <VERB? HOLD>
		     <EQUAL? ,PRSO ,WOUNDED-LEFT-ARM>>
		<TELL
"That won't stop the bleeding. You'll have to do better." CR>)
	       (<VERB? REMOVE TAKE-OFF>
		<TELL
"Wishing won't make it so." CR>)>>

<OBJECT CLOTHES
	(LOC PROTAGONIST)
	(DESC "your everyday clothes")
	(SYNONYM CLOTHES SOCKS SHIRT PANTS CLOTHING)
	(ADJECTIVE MY EVERYDAY)
	(FLAGS NARTICLEBIT WEARBIT WORNBIT NOTHEBIT NOABIT)
	(ACTION CLOTHES-F)>

<GLOBAL CLOTHES-RIPPED <>>

<ROUTINE CLOTHES-F ()
	 <COND (<VERB? TAKE-OFF>
		<TELL
"It is hardly appropriate, forgetting even the weather." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"There's nothing in your clothes that can help you." CR>)
	       (<VERB? EXAMINE>
		<TELL
"Your clothes are ordinary businessman fare">
		<COND (,CLOTHES-RIPPED
		       <TELL
", with the exception of the large tear you created in making your
tourniquet">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? RIP>
		<COND (,CLOTHES-RIPPED
		       <TELL
"You've done enough damage to your wardrobe already." CR>)
		      (T
		       <TELL
"You rip a piece of " D ,PRSO " and now hold a scrap of it in your hand." CR>
		       <MOVE ,RIPPED-CLOTHES ,WINNER>
		       <THIS-IS-IT ,RIPPED-CLOTHES>
		       <SETG CLOTHES-RIPPED T>)>)>>
		
<ROUTINE I-200-SECONDS ()
	 <COND (<L? ,CLOCK-TIME 401> <RTRUE>)>
	 <COND (<AND <NOT <FSET? ,HERE ,HUTBIT>>
		     <OR <NOT <IN? ,PARKA ,PROTAGONIST>>
			 <NOT <FSET? ,PARKA ,WORNBIT>>>>
		<COND (<L? <SETG WARMTH <- ,WARMTH 1>> 1>
		       <CRLF>
		       <JIGS-UP
"Finally, you pass out from the cold, and you are fortunate enough not to
have frozen to death before the border patrol finds you.">)
		      (T
		       <HLIGHT ,H-BOLD>
		       <TELL CR <GET ,WARMTH-TBL </ ,WARMTH 2>>>
		       <COND (<AND <NOT ,BEEN-AT-HUT?>
				   <NOT <EQUAL? ,HERE ,INSIDE-SHED>>>
			      <TELL
" You look up at the sky and notice the smoke rising into
the sky to the ">
			      <TELL-DIRECTION ,HERE ,D5>
			      <TELL ".
Perhaps where there's smoke there will be warmth.">)>
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)>)
	       (<L? ,WARMTH 9>
		<SETG WARMTH <+ ,WARMTH 2>>
		<BOLDTELL "You're feeling a lot warmer now.">)>>

<GLOBAL WARMTH-TBL
	<PTABLE "You're shaking uncontrollably from the cold. It won't be long before you are competely incapacitated."
	       "You're shivering badly. If you don't find some warmth soon, it's hard to see how you can go on."
	       "Your teeth start to chatter from the cold; you are clearly slowing down, both physically and mentally."
	       "You've got quite a chill; you must move now to keep warm, but even this is not enough."
	       "In your confusion, you've all but forgotten how cold it is outside.">>



;"Guards, towers, etc."

<OBJECT WATCHING-OBJECT
	(DESC "watching")
	(LOC GLOBAL-OBJECTS)
	(SYNONYM WATCHING)
	(ACTION WATCHING-OBJECT-F)>

<ROUTINE WATCHING-OBJECT-F
	 ()
	 <COND (<VERB? OFF-2 ON-2> <RFALSE>) (T <TELL "Huh?" CR>)>>

<OBJECT TIMING-OBJECT
	(DESC "chronograph")
	(SYNONYM WATCH TIMER TIMING CLOCK TIME CHRONOGRAPH STOPWATCH
	 CHRONOMETER)
	(FLAGS WORNBIT TAKEBIT WEARBIT READBIT)
	(SCENARIO 2)
	(ACTION TIMING-OBJECT-F)>

<ROUTINE TIMING-OBJECT-F ("AUX" TMP)
	 <COND (<VERB? SET>
		<TELL
"You can only do three things to the timer: reset it, turn it on,
and turn it off." CR>)
	       (<VERB? ON>
		<SETG CHRONOGRAPH-ON T>
		<SETG CLOCK-MOVE 0>
		<TELL "The " D ,PRSO " is on." CR>)
	       (<VERB? OFF>
		<SETG CHRONOGRAPH-ON <>>
		<TELL "The " D ,PRSO " is off." CR>)
	       (<VERB? DROP>
		<TELL "Not a good idea; you'll probably need it." CR>)
	       (<VERB? RESET>
		<SETG CHRONOGRAPH-TIME 0>
		<TELL "The " D ,PRSO " is now reset." CR>
		<SETG CLOCK-MOVE 0>
		<REDISPLAY-CHRONOGRAPH>
		<RTRUE>)
	       (<VERB? READ>
		<TELL
"The time appears on your status line." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The watch is a precision Swiss instrument, incorporating both a digital
clock and a one-hour timer." CR>)>>
		
<ROUTINE REDISPLAY-CHRONOGRAPH ("AUX" TMP)
	 <SET TMP ,CHRONOGRAPH-ON>
	 <SETG CHRONOGRAPH-ON T>
	 <UPDATE-CHRONOGRAPH 0 T>
	 <SETG CHRONOGRAPH-ON .TMP>>

<OBJECT SEARCHLIGHTS
	(DESC "searchlight")
	(LOC LOCAL-GLOBALS)
	(SYNONYM SEARCHLIGHT LIGHT LIGHTS)
	(ACTION SEARCHLIGHTS-F)>

<ROUTINE SEARCHLIGHTS-F ()
	 <COND (<VERB? EXAMINE EXAMINE-THROUGH>
		<TELL 
"The three searchlights are rotating clockwise. The first and third
are moving at the same slow pace, and the middle one is moving quite
a bit faster. At this moment, the ">
		<SL-TELL <>>
		<COND (<NOT ,SL-WATCH>
		       <TELL
" Since the lights are always in motion, it might be best to WATCH them.">)>
		<CRLF>
		<RTRUE>)
	       (<VERB? WATCH>
		<SETG CHRONOGRAPH-ON T>
		<COND (,SL-WATCH <TELL "You already are." CR> <RTRUE>)>
		<COND (,G-WATCH
		       <PERFORM ,V?OFF-2 ,TIMING-OBJECT ,GUARDS>)>
		<SETG SL-WATCH T>
		<SETG CLOCK-MOVE 4>
		<SCREEN-1>
		<CURSET 2 2>
		<TELL "Left:">
		<CURSET 2 <- </ <GETB 0 33> 2> 6>>
		<TELL "Center:">
		<CURSET 2 <- <GETB 0 33> 11>>
		<TELL "Right:">
		<SL-WATCHER>
		<SCREEN-0>
		<CRLF>
		<PERFORM ,V?EXAMINE ,SEARCHLIGHTS>
		<TELL CR 
"Now that you're watching the searchlights, you'll take a moment to check
on them after everything you do until you stop watching them, or move out
of range." CR>
		<RTRUE>)
	       (<AND <VERB? OFF-2>
		     <EQUAL? ,PRSO ,TIMING-OBJECT ,WATCHING-OBJECT>>
		<COND (<NOT ,SL-WATCH>
		       <TELL "You weren't watching them." CR>
		       <RTRUE>)>
		<SETG SL-WATCH <>>
		<SETG CLOCK-MOVE 4>
		<FLUSH-WATCHER>
		<COND (<NOT ,SAVE-FLAG>
		       <TELL
"You're no longer watching the searchlights." CR>)>
		<RTRUE>)>>

<ROUTINE SL-CYCLE ()
	 <SETG SAVE-FLAG T>
	 <PERFORM ,V?OFF-2 ,TIMING-OBJECT ,SEARCHLIGHTS>
	 <PERFORM ,V?WATCH ,SEARCHLIGHTS>
	 <SETG SAVE-FLAG <>>
	 <RTRUE>>

<ROUTINE G-CYCLE ()
	 <SETG SAVE-FLAG T>
	 <PERFORM ,V?OFF-2 ,TIMING-OBJECT ,GUARDS>
	 <PERFORM ,V?WATCH ,GUARDS>
	 <SETG SAVE-FLAG <>>
	 <RTRUE>>

<GLOBAL PERIOD-CR ".|
">

<GLOBAL SL-WATCH <>>

<ROUTINE SL-TELL
	 ("OPTIONAL" (CR T))
	 <TELL "left light faces "
	       <SL-POS-STR 1>
	       ", "
	       "the middle one "
	       <SL-POS-STR 2>
	       ", "
	       "and the right one "
	       <SL-POS-STR 3>
	       ".">
	 <COND (.CR <CRLF>)>
	 T>

<ROUTINE SL-POS-STR (L)
	 <GET ,SL-POS-STR-TBL </ <+ <SL-POS .L> 112> 225>>>

<ROUTINE SL-POS-STR-AB (L)
	 <GET ,SL-POS-STR-AB-TBL </ <+ <SL-POS .L> 112> 225>>>

<ROUTINE SL-POS (L) <GET <GET ,SL-TBL .L> 0>>

<GLOBAL SL-POS-STR-TBL
	<PTABLE "north"
	       "north-northeast"
	       "northeast"
	       "east-northeast"
	       "east"
	       "east-southeast"
	       "southeast"
	       "south-southeast"
	       "south"
	       "south-southwest"
	       "southwest"
	       "west-southwest"
	       "west"
	       "west-northwest"
	       "northwest"
	       "north-northwest"
	       "north">>

<GLOBAL SL-POS-STR-AB-TBL
	<PTABLE "N"
	       "NNE"
	       "NE"
	       "ENE"
	       "E"
	       "ESE"
	       "SE"
	       "SSE"
	       "S"
	       "SSW"
	       "SW"
	       "WSW"
	       "W"
	       "WNW"
	       "NW"
	       "NNW"
	       "N">>

<GLOBAL SL-TBL <LTABLE <TABLE 0 45> <TABLE 900 90> <TABLE 2700 45>>>

<GLOBAL NOMANS-SPEED 3>

;<GLOBAL SL-DEBUG <>>

;"Movement between the towers and no-mans land"

<ROUTINE NOMANS-MOVE ("AUX" TBL MVS (MV 1) (OFF 0) SL TMP)
	 <SET TBL <GETP ,HERE ,P?NOMAN>>
	 <SET MVS </ </ <* </ <GETP ,SHOES-WORN ,P?SPEED>
			      10>
			   100>
			,WARMTH>
		     ,HEALTH>>
	 ;<COND (,SL-DEBUG
		<TELL "[MOVE-TIME: " N .MVS "]" CR>
		<TELL "[LIGHTS: ">
		<SL-TELL>
		<TELL "]" CR>)>
	 <SETG NOMANS-SPEED .MVS>
	 <SET MVS <* .MVS 5>>
	 <COND (<G? <WEIGHT ,WINNER> 50>
		<TELL
"With all the weight you are carrying, you'd never make it across
without getting caught." CR>
		<RFALSE>)
	       (<G? ,NOMANS-SPEED 6>
		<TELL "You are slowed down so extensively by ">
		<SLOWDOWN>
		<TELL " that you turn back almost at once. You'll
never get across in this condition." CR>
		<RFALSE>)>
	 ;"First set up the tables"
	 <REPEAT ()
		 <SET SL <GET .TBL .OFF>>
		 <PUT .SL 2 </ <- <GET .SL 1> <SET TMP <GET .SL 0>>> .MVS>>
		 <PUT .SL 3 .TMP>
		 <COND (<G? <SET OFF <+ .OFF 1>> 2>
			<RETURN>)>>
	 ;"Now cycle through MVS moves"
	 <REPEAT ()
		 ;<COND (,DEBUG
			<TELL "[NOMAN: OK]" CR>
			<RETURN>)>
		 <COND (<L? <SET MVS <- .MVS 1>> 0> <RETURN>)>
		 <SET OFF 0>
		 ;<COND (,SL-DEBUG <TELL "Move #" N .MV CR>)>
		 <REPEAT ()
			 <COND (<G? .OFF 2> <RETURN>)
			       (T
				<SET SL <GET .TBL .OFF>>
				<PUT .SL
				     3
				     <SET TMP <+ <GET .SL 3> <GET .SL 2>>>>
				<COND (<IN-THE-SPOTLIGHT? .TMP <+ .OFF 1>>
				       <COND (<L? .MVS 5> ;"Almost made it..."
					      <SL-CAUGHT-START>
					      <TELL
"You're almost there now, but in the corner of your eye, you see the light
from the " <GET ,SL-CAUGHT-TOWERS .OFF> "racing toward
you! Too late! The intense white light blinds you and piercing sirens
fill the night air!">
					      <JIGS-UP " ">
					      <RTRUE>)
					     (<NOT <G? </ .MVS 5>
						       </ ,NOMANS-SPEED 2>>>
					      <SL-CAUGHT-START>
					      <TELL
"You're past the halfway point, but wait! The light from the "
<GET ,SL-CAUGHT-TOWERS .OFF> "is heading right at you! You freeze,
and consider turning back, but it's too late. The searchlight is upon you now,
and before you can react, the night is filled with the sound of wailing
sirens.">
					      <JIGS-UP " ">
					      <RTRUE>)
					     (T
					      <SL-CAUGHT-START>
					      <TELL
"Well before you reach the halfway point, the light from the "
<GET ,SL-CAUGHT-TOWERS .OFF> "is bearing down on you. You decide
to turn back, and just barely manage to reach the safety of the ">
					      <COND (<EQUAL? ,P-WALK-DIR 
							     ,P?SOUTH>
						     <TELL "fence">)
						    (T
						     <TELL "forest">)>
					      <TELL " as
the light sweeps over you." CR>
					      <RFALSE>)>)>
				<SET OFF <+ .OFF 1>>)>>
		 <TURN-SL>
		 <UPDATE-CLOCK 1 T ;"Force output of SL/GUARD wtacher">
		 <COND (,SL-WATCH
			<PAUSE 2>)>
		 <SET MV <+ .MV 1>>>
	 <FSET ,HERE ,CROSSBIT>
	 <GET .TBL 3>>

<ROUTINE PAUSE (N)
	 <REPEAT ()
		 <COND (<L? <SET N <- .N 1>> 0>
			<RETURN>)
		       (T
			<INPUT 1 10 ,I-READ-FALSE>)>>>

<ROUTINE I-READ-FALSE () <RTRUE>>

<ROUTINE SL-CAUGHT-START ()
	 <TELL
"You run across the open field ">
	 <COND (<L? ,NOMANS-SPEED 4>
		<TELL "at your best speed">)
	       (<EQUAL? ,NOMANS-SPEED 4>
		<TELL "at a good clip, though you are hampered by ">
		<SLOWDOWN>)
	       (<EQUAL? ,NOMANS-SPEED 5>
		<TELL "at a rather slow pace, hampered as you are by ">
		<SLOWDOWN>)
	       (<EQUAL? ,NOMANS-SPEED 6>
		<TELL "slowly, badly hampered by ">
		<SLOWDOWN>)
	       (T
		<TELL "at a dreadful pace, slowed miserably by ">
		<SLOWDOWN>)>
	 <TELL ". ">>

<ROUTINE SLOWDOWN ("OPTIONAL" (DIAGNOSE? <>) "AUX" (FLG 0))
	 <COND (<AND <NOT .DIAGNOSE?>
		     <G? <GETP ,SHOES-WORN ,P?SPEED> 30>>
		<TELL "slick-surfaced shoes">
		<SET FLG <+ .FLG 1>>)>
	 <COND (<AND <L? ,HEALTH 9> <G? .FLG 0>>
		<COND (<L? ,WARMTH 9> <TELL ", ">)
		      (T <TELL " and ">)>)
	       (<L? ,HEALTH 9> <SET FLG <+ .FLG 1>>)>
	 <COND (<L? ,HEALTH 3>
		<TELL "severe blood loss">)
	       (<L? ,HEALTH 5>
		<TELL "considerable blood loss">)
	       (<L? ,HEALTH 9>
		<TELL "blood loss">)>
	 <COND (<AND <L? ,WARMTH 9> <G? .FLG 0>>
		<COND (<G? .FLG 1> <TELL ",">)>
		<TELL " and ">)>
	 <COND (<L? ,WARMTH 3>
		<TELL "severe exposure">)
	       (<L? ,WARMTH 5>
		<TELL "considerable cold exposure">)
	       (<L? ,WARMTH 9>
		<TELL "cold exposure">)>>
	       
<GLOBAL SL-CAUGHT-TOWERS
	<PTABLE "leftmost tower " "middle tower " "rightmost tower ">>

<CONSTANT SL-BEAM 16>

<ROUTINE IN-THE-SPOTLIGHT? (YOU IT "AUX" SL)
	 <SET SL </ <GET <GET ,SL-TBL .IT> 0> 10>>
	 ;<COND (,SL-DEBUG
		<TELL "SL #" N .IT " at " N .SL
		      "/ PLAYER at " N .YOU ": " CR>)>
	 <COND (<AND <L? .SL 271>
		     <G? .YOU <- .SL ,SL-BEAM>>
		     <L? .YOU <+ .SL ,SL-BEAM>>>
		;<COND (,SL-DEBUG <TELL "Seen." CR>)>
		<RTRUE>)
	       (T <RFALSE>)>>

<ROUTINE TURN-SL
	 ("AUX" (OFF 0) TBL SL)
	 <REPEAT ()
		 <COND (<G? <SET OFF <+ .OFF 1>> 3> <RETURN>)>
		 <SET TBL <GET ,SL-TBL .OFF>>
		 <SET SL <+ <GET .TBL 0> <GET .TBL 1>>>
		 <COND (<EQUAL? .SL 3600> <SET SL 0>)>
		 <PUT .TBL 0 .SL>>>

<GLOBAL TRUE-FLAG T>

<GLOBAL FALSE-FLAG <>>

;"Something stinks..."

<OBJECT DOGS
	(LOC A2)
	(DESC "pack of dogs")
	(SYNONYM DOGS PACK)>

<OBJECT GLOBAL-DOGS
	(LOC GLOBAL-OBJECTS)
	(DESC "pack of dogs")
	(SYNONYM DOGS PACK)
	(SCENARIO 2)
	(ACTION GLOBAL-DOGS-F)>

<ROUTINE GLOBAL-DOGS-F ("OPTIONAL" (B ,DOGS) "AUX" L HF)
	 <COND (<VERB? LISTEN FIND WATCH EXAMINE>
		<SET L <LOC .B>>
		<COND (<OR <ZERO? .L>
			   <G? <SET HF <HOW-FAR .L ,HERE>> 3>>
		       <TELL
"You are relieved to find that you can't hear the " D .B "." CR>)
		      (T
		       <TELL "You can hear the " D .B>
		       <COND (<ZERO? .HF>
			      <TELL "; they are now at close range." CR>
			      <RTRUE>)
			     (<EQUAL? .HF 1>
			      <TELL " less than a hundred yards">)
			     (<EQUAL? .HF 2>
			      <TELL " a few hundred yards">)
			     (T
			      <TELL " off in the distance">)>
		       <TELL " to the ">
		       <TELL-DIRECTION ,HERE .L>
		       <TELL ,PERIOD-CR>)>)>>

<GLOBAL NODOGS-FLAG <>>

<GLOBAL DOG-PURSUIT <>>

<GLOBAL VIGILANCE <>>

<ROUTINE I-DOGS ("AUX" (DL <LOC ,DOGS>) HF NDL)
	 ;"Debugging"
	 <COND (<L? ,CLOCK-TIME 140> <RTRUE>)>
	 <COND (,NODOGS-FLAG <RTRUE>)>
	 <COND (<AND ,DOG-PURSUIT <FSET? ,HERE ,GVIEWBIT>>
		<CRLF>
		<HLIGHT ,H-BOLD>
		<JIGS-UP
"Too late! The guards, alerted by the guard dogs who have pursued you
across no-man's-land, approach with weapons drawn.">
		<SETG NODOGS-FLAG T>
		<RTRUE>)>
	 <SET HF <HOW-FAR .DL ,HERE>>
	 <COND (<NOT <ZERO? <SET NDL <GETP .DL ,P?PATH>>>>
		<SETG LOST-SCENT <>>
		<MOVE ,DOGS .NDL>
		<COND (<EQUAL? .NDL ,HERE>
		       <CRLF>
		       <HLIGHT ,H-BOLD>
		       <COND (<OR <FSET? ,HERE ,HUTBIT>
				  <EQUAL? ,HERE ,INSIDE-SHED>>
			      <TELL
"A pair of guards, presumably with the pursuing dogs, rushes in, finding
you within seconds.">)
			     (T
			      <TELL
"The sounds of dogs barking madly and soldiers barking orders are close
upon you. A muddled explosion - a signal flare lightens the sky with a
red-orange glow. Before you can react, you are spotted! Brilliant white
searchlights are aimed upon you, blinding you long enough for more
soldiers and border guards to arrive.">)>
		       <JIGS-UP
" With no hope of escape, you surrender to the guards, and are led away,
handcuffed, to the border station.">
		       <RTRUE>)
		      (<FSET? .NDL ,CROSSBIT> ;"Player has crossed here."
		       <COND (<FSET? ,HERE ,GVIEWBIT>
			      <HLIGHT ,H-BOLD>
			      <CRLF>
			      <TELL
"From across the expanse of no-man's-land comes the sound of the search
dogs. They are moving quickly in your direction, following the tracks
made in your desperate run to the fence. The approaching dogs have
alerted the guards as well, who appear increasingly vigilant. You don't
have much time.">
			      <HLIGHT ,H-NORMAL>
			      <CRLF>
			      <SETG DOG-PURSUIT T>)>)>
		<GONE-TO-THE-DOGS? .HF <HOW-FAR .NDL ,HERE>>)
	       (T
		<SETG LOST-SCENT T>)>>

<GLOBAL LOST-SCENT <>>

<ROUTINE HOW-FAR (L1 L2 "OPTIONAL" (CAR? <>) "AUX" TMP)
	 <SET TMP <+ <* <SET TMP <NS-DIFF .L1 .L2>> .TMP>
		     <* <SET TMP <EW-DIFF .L1 .L2>> .TMP>>>
	 <COND (<L? .TMP 1> 0)
	       (<AND .CAR? <EQUAL? .TMP 2>> 2)
	       (<L? .TMP 3> 1)
	       (<L? .TMP 7> 2)
	       (<L? .TMP 13> 3)
	       (<L? .TMP 21> 4)
	       (T 5)>>

<ROUTINE NS-DIFF (L1 L2)
	 <ABS <- <GETP .L1 ,P?NS> <GETP .L2 ,P?NS>>>>

<ROUTINE EW-DIFF (L1 L2)
	 <ABS <- <GETP .L1 ,P?EW> <GETP .L2 ,P?EW>>>>
 
;"Sorry, no car chase..."

<GLOBAL ROAD-TBL <PTABLE F4 F5 E6 D6 ROAD-END D6 D7 D8 C9 0>>

<GLOBAL RESTED-ROAD-TBL 0>

;"Runs every 50 seconds; car goes past every 5th time, on average."

<GLOBAL CAR-ON-ROAD? <>>

<OBJECT CAR
	(LOC ROOMS)
	(DESC "automobile")
	(LDESC
"An official car is here, bearing the seal of Frobnia.")
	(SYNONYM DOOR CAR AUTO AUTOMOBILE)
	(FLAGS VOWELBIT AN OPENBIT METALBIT)
	(ACTION CAR-F)>

<ROUTINE CAR-F ()
	  <COND (<VERB? EXAMINE LOOK-INSIDE>
		 <TELL
"It's an official car, bearing the seal of Frobnia. There is no key in
the ignition, so starting it is out of the question.">
		 <COND (<IN? ,EXPLODING-PEN ,PRSO>
			<TELL " The pen is adhering to the side of the
car.">)>
		 
		 <CRLF>)
		(<AND <VERB? PUT PUT-ON PUT-UNDER TIE>
		      <EQUAL? ,PRSO ,EXPLODING-PEN>>
		 <MOVE ,PRSO ,PRSI>
		 <TELL
"The pen adheres to the ">
		 <COND (<VERB? PUT-UNDER> <TELL "under">)>
		 <TELL "side of the car." CR>)
		(<VERB? HIDE>
		 <TELL
"You can't get in, so hiding's inside's out of the question; neither is
there anything to be gained from hiding under the car." CR>)
		(<VERB? ON>
		 <TELL
"You can't get in, so starting it is rather difficult." CR>)
		(<VERB? BOARD CLIMB OPEN ENTER>
		 <TELL
"It wouldn't help. There's nothing important inside, and you couldn't
possibly start it up without being caught." CR>)>>

<OBJECT CAR-WINDOW
	(LOC CAR)
	(DESC "car window")
	(SYNONYM WINDOW)
	(FLAGS NDESCBIT)
	(ACTION CAR-WINDOW-F)>

<ROUTINE CAR-WINDOW-F ()
	 <COND (<VERB? MUNG KICK>
		<TELL
"This would only alert the guards, who are just fifty yards away." CR>)
	       (<VERB? OPEN>
		<TELL
"You can't open the car's windows." CR>)>>

<OBJECT CAR-STUFF
	(LOC CAR)
	(DESC "car part")
	(SYNONYM TRUNK HOOD)
	(FLAGS NDESCBIT)
	(ACTION CAR-STUFF-F)>

<ROUTINE CAR-STUFF-F ()
	 <COND (<VERB? OPEN UNLOCK BOARD ENTER>
		<TELL
"It's closed and locked; trying to get in would undoubtably alert the guards,
and lead to your arrest." CR>)>> 

<OBJECT GLOBAL-CAR
	(LOC GLOBAL-OBJECTS)
	(DESC "automobile")
	(SCENARIO 2)
	(SYNONYM CAR AUTO AUTOMOBILE)
	(FLAGS VOWELBIT AN)
	(ACTION GLOBAL-CAR-F)>	

<ROUTINE GLOBAL-CAR-F ("AUX" HF)
	 <COND (<AND <VERB? LISTEN FIND> ,CAR-SEQUENCE>
		<TELL "You can neither see nor hear the car." CR>)
	       (<VERB? LISTEN FIND>
		<GLOBAL-DOGS-F ,CAR>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<CAR-IN-VIEW?>
		       <COND (<NOT <ZERO? <LOC ,FLAMING-CAR>>>
			      <TELL
"The car is engulfed in flame; nothing else much can be seen." CR>)
			     (T
			      <TELL
"At this distance, at night and in the light snowfall, it is impossible
to make out any details." CR>)>)
		      (T
		       <TELL
"You can't see the car from here." CR>)>)
	       (<AND <VERB? THROW>
		     <EQUAL? ,PRSI ,GLOBAL-CAR>
		     <CAR-IN-VIEW?>
		     <IN? ,PRSO ,WINNER>
		     <NOT <FSET? ,PRSO ,WORNBIT>>>
		<REMOVE ,PRSO>
		<TELL
"You throw the " D ,PRSO " at the car, missing it entirely." CR>)
	       (<VERB? WAVE-AT>
		<COND (<NOT <FSET? ,HERE ,ROADBIT>>
		       <TELL "You're not even on a road!" CR>)
		      (<CAR-IN-VIEW?>
		       <TELL
"The driver seems to pay no attention and heads right toward you..." CR>)
		      (<AND ,CAR-ON-ROAD? <EQUAL? .HF 2>>
		       <TELL
"It's unlikely the driver can see you through the snow at this
distance." CR>)
		      (T
		       <TELL
"The car isn't quite in view yet, so the driver won't see you." CR>)>)>>

;<ROUTINE V-$CAR () <I-CARS T>>

<ROUTINE I-CARS ("OPTIONAL" (FORCE? <>))
	 <COND (<AND <NOT ,CAR-ON-ROAD?> <NOT ,SEQUENCE-RUN?>>
		<SETG CAR-ON-ROAD? T>
		<SETG RESTED-ROAD-TBL ,ROAD-TBL>
		<COND (<EQUAL? ,HERE ,F3 ,F4 ,G4>
		       <HLIGHT ,H-BOLD>
		       <TELL CR
"You can see the headlights of an automobile coming from the ">
		       <COND (<EQUAL? ,F3  ,HERE> <TELL "east">)
			     (<EQUAL? ,F4 ,HERE> <TELL "northeast">)
			     (T <TELL "north">)>
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)
		      (<L? <HOW-FAR ,HERE ,F4> 4>
		       <HLIGHT ,H-BOLD>
		       <TELL CR "Off to the ">
		       <TELL-DIRECTION ,HERE ,F4>
		       <TELL ", you can hear the sound of an
approaching automobile.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)>)>>

<ROUTINE TELL-DIRECTION (FR TO "AUX" (N <>) (S <>) (W <>) (E <>) T1 T2)
	 <COND (<G? <SET T1 <GETP .FR ,P?NS>>
		    <SET T2 <GETP .TO ,P?NS>>>
		<SET N T>)
	       (<L? .T1 .T2>
		<SET S T>)>
	 <COND (<G? <SET T1 <GETP .FR ,P?EW>>
		    <SET T2 <GETP .TO ,P?EW>>>
		<SET W T>)
	       (<L? .T1 .T2>
		<SET E T>)>
	 <COND (.N <TELL "north">)
	       (.S <TELL "south">)>
	 <COND (.E <TELL "east">)
	       (.W <TELL "west">)>>

<ROUTINE RET-DIRECTION (FR TO "AUX" (N <>) (S <>) (W <>) (E <>) T1 T2)
	 <COND (<G? <SET T1 <GETP .FR ,P?NS>>
		    <SET T2 <GETP .TO ,P?NS>>>
		<SET N T>)
	       (<L? .T1 .T2>
		<SET S T>)>
	 <COND (<G? <SET T1 <GETP .FR ,P?EW>>
		    <SET T2 <GETP .TO ,P?EW>>>
		<SET W T>)
	       (<L? .T1 .T2>
		<SET E T>)>
	 <SET T1 0>
	 <SET T2 <>>
	 <COND (.N)
	       (.S <SET T1 <+ .T1 4>>)
	       (.E <SET T1 3> <SET T2 T>)
	       (.W <SET T1 7> <SET T2 T>)>
	 <COND (.T2)
	       (.E <SET T1 <+ .T1 2>>)
	       (.W <SET T1 <+ .T1 1>>)>
	 <GET ,DIR-PROP-TBL .T1>>

<GLOBAL DIR-PROP-TBL
	<PTABLE P?NORTH P?NW P?NE P?EAST P?SOUTH P?SW P?SE P?WEST>>

<GLOBAL CAR-SEQUENCE <>>

<GLOBAL WOOD-TIMER 35> 

<ROUTINE CAR-NEARLY-HITS ()
	 <CRLF>
	 <JIGS-UP
"Spotting you just in time, the car skids to a slippery stop about
fifteen feet in front of you. The doors quickly open, and two guards
emerge, machine guns drawn. Brilliant white lights shine in your face.
\"So happy to see you, Mister ... Topaz ... is that right?\" Through
the lights, a face slowly appears - it is Viper, your archenemy. He
shrugs apologetically, and says, \"If we had known you were coming, well,
we would have brought a larger car...\" He signals to the guards, who
thrust you into the trunk.">>

<GLOBAL SEQUENCE-RUN? <>>

<GLOBAL CAR-SEQUENCE-TBL <LTABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>> 

<ROUTINE RUN-CAR-SEQUENCE ()
	 <COND (<EQUAL? ,CAR-SEQUENCE 1>
		<COND (<EQUAL? ,HERE ,D5 ,OUTSIDE-HUT ,SOUTH-HUT>
		       <HLIGHT ,H-BOLD>
		       <CAR-SPOTTED>)
		      (<EQUAL? ,HERE ,NORTH-HUT ,BEHIND-HUT>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <PUT ,CAR-SEQUENCE-TBL 1 1>
		       <COND (,HUT-BURNING
			      <SETG CAR-SEQUENCE <>>
			      <COND (<EQUAL? ,HERE ,NORTH-HUT>
				     <TELL
"From your hidden (and quite warm) vantage point, you watch the car stop
at the end of the road. A single man gets out, looks over the situation,
and returns to the car. After a moment, the car turns around and heads
away.">)
				    (T
				     <TELL
"You hear a car approach, then make a quick departure.">)>
			      <HLIGHT ,H-NORMAL>
			      <CRLF>
			      <RTRUE>)
			     (<EQUAL? ,HERE ,NORTH-HUT>
			      <TELL
"From your hidden vantage point, you can see the car stop at the end
of the road. The car's doors open, and two guards step out, machine guns
at the ready. A third man exits the car slowly, and all three head for
the clearing to their north.">)
			     (T
			      <TELL
"You hear a car stop nearby, followed by the sound of doors opening and
closing. Dimly, you believe you can make out some talking - it's clear
that the occupants of the car are heading toward the hut.">)>
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)
		      (<L? <HOW-FAR ,ROAD-END ,HERE> 4>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <TELL
"The sound of the automobile stops abruptly.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)>)
	       (,HUT-BURNING
		<SETG CAR-SEQUENCE <>>
		<REMOVE ,HUT-MAN>
		<COND (<EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT>
		       <HLIGHT ,H-BOLD>
		       <TELL CR CR
"With the house ablaze, the guards confer for a moment, then retreat
to their automobile.">
		       <COND (<IN? ,HUT-MAN ,OUTSIDE-HUT>
			      <TELL
" The man from the hut follows along as well, looking
visibly shaken.">)>
		       <TELL
" A moment later, the car is started and turned around.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)
		      (<L? <HOW-FAR ,ROAD-END ,HERE> 5>
		       <CRLF>
		       <BOLDTELL
"You can hear the sound of an automobile engine being started, though it's
hard to tell from which direction the sound is coming.">)>
		<RTRUE>)
	       (<EQUAL? ,CAR-SEQUENCE 3>
		<COND (<EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT ,BEHIND-HUT>
		       <PUT ,CAR-SEQUENCE-TBL 3 1>
		       <COND (<EQUAL? ,HERE ,BEHIND-HUT>
			      <BOLDTELL
"You hear knocking from the front of the house.">)
			     (<ZERO? <GET ,CAR-SEQUENCE-TBL 1>>
			      <BOLDTELL
"Carefully looking around the side of the house, you can see three
men approaching the door of the hut, then knocking loudly.">)
			     (T
			      <BOLDTELL
"The three men approach the door of the hut, then knock loudly. The
third man looks familiar, though in the darkness, it's hard to be
certain.">)>)>)
	       (<AND <EQUAL? ,CAR-SEQUENCE 4>
		     <NOT <IN? ,HUT-MAN ,OUTSIDE-HUT>>>
		<MOVE ,HUT-MAN ,OUTSIDE-HUT>
		<COND (<EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT ,BEHIND-HUT>
		       <PUT ,CAR-SEQUENCE-TBL 5 1>
		       <COND (<EQUAL? ,HERE ,BEHIND-HUT>
			      <BOLDTELL
"You can see, through the window in the back door, the occupant of the hut
walk outside.">)
			     (<OR <NOT <ZERO? <GET ,CAR-SEQUENCE-TBL 1>>>
				  <NOT <ZERO? <GET ,CAR-SEQUENCE-TBL 3>>>>
			      <BOLDTELL
"After what seems like an eternity, a man opens the door and steps
outside to talk to the men.">)
			     (T
			      <BOLDTELL
"In front of the hut, three men, two guards armed with machine guns, and
one who appears to be a civilian, are standing by the door. A few moments
later, the door opens and a fourth man walks out. They begin to
talk.">)>)>)
	       (<AND <G? ,CAR-SEQUENCE 5>
		     <L? ,CAR-SEQUENCE 11>>
		<RUN-SCOUT-SEQUENCE ,CAR-SEQUENCE>)
	       (<EQUAL? ,CAR-SEQUENCE 13>
		<MOVE ,HUT-MAN ,HUT-LIVING>
		<COND (<EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <COND (<OR <NOT <ZERO? <GET ,CAR-SEQUENCE-TBL 1>>>
				  <NOT <ZERO? <GET ,CAR-SEQUENCE-TBL 3>>>
				  <NOT <ZERO? <GET ,CAR-SEQUENCE-TBL 5>>>>
			      <TELL
"The three men from the car">)
			     (T
			      <TELL
"Three men standing at the door to the hut">)>
		       <TELL
" appear to thank the fourth man. Briskly, they reenter their car, and
start it up.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)
		      (<EQUAL? ,ROAD-END ,HERE>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <TELL
"The guards turn from the house and start in your direction. Thinking
quickly, you dart into the nearby forest to the west. You are lucky not
to have been seen." CR>
		       <GOTO ,C5 <>>)
		      (<L? <HOW-FAR ,ROAD-END ,HERE> 5>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <COND (<EQUAL? ,HERE ,HUT-LIVING>
			      <MOVE ,WINNER ,HUT-STORAGE>
			      <SETG HERE ,HUT-STORAGE>
			      <TELL
"The conversation outside seems to have ended, and you suspect that the man
is about to reenter his hut. Quickly, you retreat to the storage area, and
a moment later he does, indeed, return. You'll now have to be extra careful to
avoid detection." CR CR>)
			     (<EQUAL? ,HERE ,HUT-STORAGE ,HUT-BEDROOM>
			      <TELL
"The occupant of the hut reenters; fortunately, he hasn't seen you yet.
You'll have to be extra careful to avoid detection." CR CR>)>
		        <TELL
"You can hear the sound of an automobile engine being started, though it's
hard to tell from which direction the sound is coming.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>
		       <OWNER-NOTICES?>)>
		<SETG CAR-SEQUENCE <>>
		<RTRUE>)>
	 <SETG CAR-SEQUENCE <+ ,CAR-SEQUENCE 1>>>

;"** Modified"

<ROUTINE RUN-SCOUT-SEQUENCE (SS "AUX" TBL)
	 <SET TBL <GET ,SCOUT-TBL <- .SS 6>>>
	 <COND (<ZERO? <GET .TBL 4>> <REMOVE ,SCOUT>)
	       (T <MOVE ,SCOUT <GET .TBL 4>>)>
	 <COND (<IN? ,SCOUT ,HERE>
		<HLIGHT ,H-BOLD>
		<CRLF>
		<SCOUT-CATCHES>)
	       (<AND <IN? ,SCOUT ,BEHIND-HUT>
		     <FSET? ,HUT-BACK-DOOR ,OPENBIT>
		     <FSET? ,HERE ,HUTBIT>>
		<HLIGHT ,H-BOLD>
		<CRLF>
		<JIGS-UP
"Apparently, one of the guards was asked to check out the area around the hut.
Finding the door open, he enters, finds you, and pulls you out of the hut
to the waiting guards.">)
	       (<EQUAL? ,HERE <GET .TBL 0>>
		<BOLDTELL <GET .TBL 2>>)
	       (<EQUAL? ,HERE <GET .TBL 1>>
		<BOLDTELL <GET .TBL 3>>)>>

<ROUTINE SCOUT-CATCHES ()
	 <JIGS-UP
"A lone guard, toting a machine gun, walks up behind you and announces
himself. It is too late to react, and you are quickly taken to a nearby
waiting car, and thereby into custody.">>


<GLOBAL SCOUT-TBL
	<PTABLE <PTABLE NORTH-HUT SOUTH-HUT
		      "As if on command, a single guard breaks off from the group and walks slowly and carefully to the northeast."
		      "As if on command, a single guard breaks off from the group and walks slowly and carefully to the northeast."
		      OUTSIDE-HUT>
	       <PTABLE BEHIND-HUT HUT-LIVING
		      "You hear footsteps coming slowly in your direction from the north side of the hut."
		      "Apparently, one of the guards has been ordered to search the area, for a lone guard is walking past the window. Fortunately, he is concentrating on the grounds, rather than the inside of the hut."
		      NORTH-HUT>
	       <PTABLE SOUTH-HUT HUT-STORAGE
		      "You hear footsteps coming slowly in your direction from the back side of the hut."
		      "Through the window, you see a lone guard checking out
the rear of the hut. Fortunately, he isn't looking inside."
		      BEHIND-HUT>
	       <PTABLE ROAD-END HUT-BEDROOM
		      "You can see a single guard slowly walking around the back side of the hut to the south side of the hut."
		      "Through the window, a lone guard comes into view, awalking slowly toward the front of the hut. Fortunately, he isn't looking in your direction." 
		      SOUTH-HUT>
	       <PTABLE NORTH-HUT 0
		      "You watch as the lone guard returns to the group. He appears relieved that he has nothing to report."
		      "FOO"
		      0>>>		      

<ROUTINE GUARDS-SPOTTED ()
	 <CRLF>
	 <JIGS-UP 
"You've been spotted by one of the guards! You turn to run, but he fires a
warning shot. You spin around, and in a moment the two guards have you in 
their grasp. The third man approaches more slowly. \"Ah, we meet again!\"
he begins, \"It is so awfully good to see you!\" He motions to the guards,
who carry you to the waiting car, then throw you into the trunk.">> 

<ROUTINE CAR-SPOTTED ()
	 <CRLF>
	 <JIGS-UP
"The car pulls up to the end of the road, and you are caught in the
headlights's glare. The car's doors fly open, and armed guards aim their
rifles at you. Slowly, from the rear of the car, a man emerges - it is your
arch-rival, Viper. \"We meet again,\" he says, \"I am delighted that you
decided to remain in our friendly country. Would you show our guest to
the car?\" He chuckles, then motions to a guard, who throws you into the
trunk of the car.">>   

;"Noisome, too..."

<OBJECT SWAMP
	(LOC GLOBAL-OBJECTS)
	(DESC "swamp")
	(SYNONYM SWAMP MARSH)
	(ACTION SWAMP-F)>

<ROUTINE WRONG-SCENARIO ()
	 <TELL "You must be thinking of the wrong scenario." CR>>

<GLOBAL IN-SWAMP? <>>

<ROUTINE SWAMP-F ()
	 <COND (<NOT <EQUAL? ,SCENARIO 2>>
		<WRONG-SCENARIO>)
	       (<NOT <FSET? ,HERE ,SWAMPBIT>>
		<TELL "You can't see that here." CR>)
	       (<VERB? SMELL>
		<TELL "It's not a pretty smell." CR>)
	       (<VERB? ENTER BOARD>
		<COND (,IN-SWAMP?
		       <TELL
"You're flirting with death as it is..." CR>)
		      (<NOT ,SHOES-WORN>
		       <TELL
"Not without shoes, you're not." CR>)
		      (T
		       <SETG IN-SWAMP? T>
		       <COND (<NOT <EQUAL? ,SHOES-WORN ,BOOTS>>
			      <FSET ,SHOES-WORN ,MUNGEDBIT>
			      <PUTP ,SHOES-WORN
				    ,P?SPEED
				    <+ <GETP ,SHOES-WORN ,P?SPEED> 10>>
			      <TELL
"You're a foot deep in the swamp, but the muck has entered your " D ,SHOES-WORN ", making movement a little slower than you might like." CR>)
			     (T
			      <TELL
"You're now a foot deep in the swamp, but the boots keep your feet
nice and dry." CR>)>)>)
	       (<VERB? LEAVE DISEMBARK>
		<COND (<NOT ,IN-SWAMP?>
		       <TELL
"You're not in the swamp, merely at the edge." CR>)
		      (T
		       <SETG IN-SWAMP? <>>
		       <STATUS-LINE>
		       <TELL
"You take a large step, and pull yourself out of the swamp." CR>)>)>>

<GLOBAL HACK-FLAG <>>

;<ROUTINE V-$XY ()
	 <COND (<GETP ,HERE ,P?NS>
		<TELL "[" N <GETP ,HERE ,P?EW>
		      "," N <GETP ,HERE ,P?NS> "]" CR>)
	       (T
		<TELL "[No coordinates]" CR>)>>

;<ROUTINE V-$DIAGNOSE ()
	 <TELL "[HEALTH: " N ,HEALTH ", WARMTH: " N ,WARMTH "]" CR>>

;<ROUTINE V-$REAL ()
	 <TELL "Real-time O">
	 <COND (,INT-FLAG
		<SETG INT-FLAG <>>
		<TELL "FF">)
	       (T
		<SETG INT-FLAG T>
		<TELL "N">)>
	 <CRLF>>

<ROUTINE GUARD-DISTANCE ("AUX" TICK)
	 <SET TICK <MOD ,CLOCK-TIME 180>>
	 <COND (<NOT <L? .TICK 90>>
		<SET TICK <- 180 .TICK>>)>
	 <SET TICK <- 90 .TICK>>
	 <COND (<EQUAL? <GETP ,HERE ,P?GPOS> 90>
		.TICK)
	       (T <- 90 .TICK>)>>

<ROUTINE IN-GUARD-VIEW? ("AUX" (MT <MOD ,CLOCK-TIME 360>))
	 <COND (<AND <GUARDS-FACING-PLAYER?>
		     <L? <GUARD-DISTANCE> 86>>
		<RTRUE>)>>

;"Put more coals on the fire"

<GLOBAL WOOD-TBL
	<PLTABLE
HUT-STORAGE HUT-LIVING OUTSIDE-HUT D5 D5 OUTSIDE-SHED INSIDE-SHED
INSIDE-SHED OUTSIDE-SHED D5 D5 OUTSIDE-HUT HUT-LIVING HUT-STORAGE HUT-LIVING 0>>

<GLOBAL WOOD-COUNT 0>

<ROUTINE RUN-WOOD-SEQUENCE ("AUX" (L <LOC ,HUT-MAN>) NL)
         <COND (<L? <SETG WOOD-COUNT <+ ,WOOD-COUNT 1>> 0>
		;"Turned off by setting W-C to -10000"
		<RTRUE>)
	       (<AND <EQUAL? ,WOOD-COUNT 1>
		     <NOT <IN? ,HUT-MAN ,HUT-LIVING>>>
		;"Don't run this unless man is there"
		<SETG WOOD-COUNT 0>)
	       (<EQUAL? .L <SET NL <GET ,WOOD-TBL ,WOOD-COUNT>>>
		;"Stays in same place"
		<RTRUE>)
	       (<0? .NL>
		<SETG WOOD-COUNT -10000>
		<RTRUE>)
	       (T
		<SETG HUT-MAN-FROM .L>
		<MOVE ,HUT-MAN .NL>
		<COND (<EQUAL? ,HERE .NL>
		       <CRLF>
		       <JIGS-UP ,HUT-MAN-HALT>)
		      (T
		       <APPLY <GETP .NL ,P?WOODFCN> .L>)>)>>

<GLOBAL HUT-MAN-FROM <>>

<CONSTANT HUT-MAN-HALT
"You hear a cry of \"Halt,\" then spin around to see a large man aiming
a pistol at you. You start to run, but you're shot in the leg.  Unable to
move, you await the arrival of the border patrol.">

<ROUTINE HUT-MUNGER ("AUX" (RM <FIRST? ,ROOMS>) PRP PT DST)
	 <REPEAT ()
		 <COND (<ZERO? .RM> <RETURN>)>
		 <SET PRP 0>
		 <REPEAT ()
			 <SET PRP <NEXTP .RM .PRP>>
			 <COND (<ZERO? .PRP> <RETURN>)>
			 <SET PT <GETPT .RM .PRP>>
			 <COND (<EQUAL? <PTSIZE .PT> 5>
				<SET DST <GET .PT 0>>
				<COND (<OR <EQUAL? .DST
						   ,NORTH-HUT
						   ,SOUTH-HUT
						   ,OUTSIDE-HUT>
					   <EQUAL? .DST
						   ,BEHIND-HUT
						   ,D5>>
				       <PUT .PT
					    ,SEXITSTR
					    <GETP .DST
						  ,P?FIRE>>)>)>>
		 <SET RM <NEXT? .RM>>>>

<OBJECT GLOBAL-SEARCHLIGHTS
	(LOC GLOBAL-OBJECTS)
	(DESC "searchlights")
	(SYNONYM LIGHT LIGHTS SEARCHLIGHT)
	(SCENARIO 2)
	(ACTION GLOBAL-SEARCHLIGHTS-F)>

<ROUTINE GLOBAL-SEARCHLIGHTS-F ()
	 <COND (<NOT <FSET? ,HERE ,GVIEWBIT>>
		<CANT-SEE ,SEARCHLIGHTS>)
	       (<VERB? EXAMINE>
		<TELL
"From this position, you can see the beam of the searchlights, but not the
lights themselves. Your viewpoint also makes it impossible to correctly gauge
their positions." CR>)
	       (T
		<TELL ,TOO-FAR CR>)>>