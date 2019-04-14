
"GLOBALS for
		             BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<DIRECTIONS ;"Do not change the order of the first 8 without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

;"status line stuff"

<CONSTANT S-TEXT 0>       ;"<SCREEN 0> puts cursor in text part of screen"
<CONSTANT S-WINDOW 1>     ;"<SCREEN 1> puts cursor in window part of screen"
<CONSTANT H-NORMAL 0>     ;"<HLIGHT 0> returns printing to normal (default)"
<CONSTANT H-INVERSE 1>    ;"<HLIGHT 1> sets printing mode to inverse video"
<CONSTANT H-BOLD 2>       ;"<HLIGHT 2> sets printing mode to bold, else normal"
<CONSTANT H-ITALIC 4>     ;"<HLIGHT 4> italicizes, else underline, else normal"
<CONSTANT D-SCREEN-ON 1>  ;"<DIROUT 1> turns on printing to the screen"
<CONSTANT D-SCREEN-OFF -1>;"<DIROUT -1> turns off printing to the screen"
<CONSTANT D-PRINTER-ON 2> ;"<DIROUT 2> turns on printing to the printer"
<CONSTANT D-PRINTER-OFF -2>;"<DIROUT -2> turns off printing to the printer"
<CONSTANT D-TABLE-ON 3>   ;"<DIROUT 3 .TABLE> turns on printing to that table"
<CONSTANT D-TABLE-OFF -3> ;"<DIROUT -3> turns off printing to that table"
<CONSTANT D-RECORD-ON 4>  ;"<DIROUT 4> sends READs and INPUTs to record file"
<CONSTANT D-RECORD-OFF -4>;"<DIROUT -4> stops sending READs and INPUTs to file"

<ROUTINE V-$ISL ("OPTIONAL" (PRT? T))
	 <INIT-STATUS-LINE 3>
	 <COND (,SL-WATCH <SL-CYCLE>)
	       (,G-WATCH <G-CYCLE>)>
	 <UPDATE-CHRONOGRAPH 0 T>
	 <UPDATE-TIME>
	 <COND (.PRT? <TELL "Done." CR>)>
	 <RTRUE>>

<ROUTINE INIT-STATUS-LINE (HEIGHT "OPTIONAL" (DONT-CLEAR <>))
	 <COND (<NOT .DONT-CLEAR>
		<CLEAR -1>
		<SPLIT .HEIGHT>)>
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 <CURSET 1 1>
	 <INVERSE-LINE>
	 <CURSET 2 1>
	 <INVERSE-LINE>
	 <CURSET 3 1>
	 <INVERSE-LINE>
	 <BUFOUT T>
	 <SCREEN ,S-TEXT>>

<ROUTINE INVERSE-LINE ("AUX" (CENTER-HALF <>)) 
	 <HLIGHT ,H-INVERSE>
	 <PRINT-SPACES <GETB 0 33>>
	 <HLIGHT ,H-NORMAL>>

<ROUTINE PRINT-SPACES (CNT)
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0>
			<RETURN>)
		       (T
			<PRINTC 32>)>>>

;<ROUTINE CONTINUE ("AUX" (CURRENTLY-SCRIPTING <>) CNT)
	 <COND (<G? <GETB 0 32> 21> ;"is screen more than 21 lines tall?"
	        <SET CNT <- <GETB 0 32> 21>>
	        <REPEAT ()
			<SET CNT <- .CNT 1>>
			<CRLF>
			<COND (<EQUAL? .CNT 0>
			       <RETURN>)>>)>
	 <COND (<BTST <GET 0 8> 1> ;"turn scripting off so [MORE] won't print"
		<SET CURRENTLY-SCRIPTING T>
		<DIROUT ,D-PRINTER-OFF>)>
	 <TELL "[Hit any key to continue.]">
	 <BUFOUT <>>
	 <BUFOUT T>
	 <COND (.CURRENTLY-SCRIPTING
		<DIROUT ,D-PRINTER-ON>)>
	 <INPUT 1>>

;<GLOBAL SL-BUFFER <ITABLE NONE 80>>

<ROUTINE STATUS-LINE ("AUX" LEN LOCATION)
	 <SCREEN-1>
	 <CURSET 1 2>
	 <HERE-TELL>
	 <SCREEN-0>>

<ROUTINE HERE-TELL ("OPTIONAL" (PAD? T) "AUX" LEN)
	 <DIROUT ,D-TABLE-ON ,DIROUT-TBL>
	 <COND (,IN-SWAMP? <TELL "In the Swamp">)
	       (,ON-BRACE? <TELL "On the Brace">)
	       (,ON-THE-CAN <TELL "On the Trash Can">)
	       (T <TELL D ,HERE>)>
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,DIROUT-TBL 0>>
	 <COND (<G? .LEN 24>
		<TELL "** Desc too long **">)
	       (T
		<COND (,IN-SWAMP? <TELL "In the Swamp">)
		      (,ON-BRACE? <TELL "On the Brace">)
		      (,ON-THE-CAN <TELL "On the Trash Can">)
		      (T <TELL D ,HERE>)>
		<COND (.PAD?
		       <PRINT-SPACES <- 24 .LEN>>)>)>
	 <RTRUE>>

<GLOBAL HERE <>>

;<GLOBAL LIT T>

;<GLOBAL INDENTS
	<PTABLE ""
	        "   "
	        "      "
	        "         "
	        "            ">>
		
<OBJECT GLOBAL-OBJECTS
	(SYNONYM ZZMGCK FRONT MR) ;"No, it doesn't need to exist... sigh"
	(DESC "GloObj")
	(FLAGS INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT OPENBIT SEARCHBIT
	       TRANSBIT WEARBIT MUNGEDBIT RLANDBIT WORNBIT
	       CONTBIT VOWELBIT
	       NDESCBIT DOORBIT PERSON CROSSBIT
	       NARTICLEBIT SLVIEWBIT FENCECUTBIT FENCEBENTBIT PENBIT
	       FENCEBLOWNBIT HUTBIT PLATFORMBIT
	       AN NOABIT THE NOTHEBIT)
	(TRANSIENT ROADBLOCK)>

<OBJECT LOCAL-GLOBALS
	(LOC GLOBAL-OBJECTS)
	(DESC "LocGlo")
	(SYNONYM $XY) ;"Yes, this synonym needs to exist... sigh"
	(DESCFCN 0)
        (GLOBAL GLOBAL-OBJECTS)
	(FDESC "F")
	(LDESC "F")
	(SIZE 0)
	(TEXT "")
	(CAPACITY 0)
	(GENERIC 0)
	(THINGS <PSEUDO (ZZMGCK ZZMGCK ME-F)>)>

<OBJECT ROOMS
	(DESC "Rms")
	(SIZE 0)>

;<OBJECT INTDIR
	(LOC GLOBAL-OBJECTS)
	(DESC "direction")
	(SYNONYM DIRECTION)
	(ADJECTIVE NORTH EAST SOUTH WEST NE NW SE SW ;UP ;DOWN)>

<OBJECT INTNUM
	(LOC GLOBAL-OBJECTS)
	(SYNONYM NUMBER INTNUM)
	;(DESC "number")
	(SDESC "number")
	;(ACTION INTNUM-F)>

<OBJECT IT
	(LOC GLOBAL-OBJECTS)
	(SYNONYM IT THEM)
	(DESC "it")
	(FLAGS VOWELBIT AN NARTICLEBIT TOUCHBIT)>

<OBJECT HIM
	(LOC GLOBAL-OBJECTS)
	(SYNONYM HIM HIMSELF)
	(DESC "him")
	(FLAGS NARTICLEBIT TOUCHBIT)>

<OBJECT HER
	(LOC GLOBAL-OBJECTS)
	(SYNONYM HER HERSELF)
	(DESC "her")
	(FLAGS NARTICLEBIT TOUCHBIT)>

<OBJECT NOT-HERE-OBJECT
	(DESC "it")
	(FLAGS NARTICLEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ (X <>))
	 <COND (<AND <PRSO? ,NOT-HERE-OBJECT>
		     <PRSI? ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (<AND .PRSO?
		     <PRSO-MOBY-VERB?>>
		<SET X T>)
	       (<AND <NOT .PRSO?>
		     <PRSI-MOBY-VERB?>>
		<SET X T>)>
	 <COND (.X ;"the verb is a moby-find verb"
		<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		<COND (<AND .OBJ
			    <NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>>
		       <RTRUE>)
		      (T
		       <RFALSE>)>
		<TELL "You'll have to be more specific, I'm afraid." CR>)
	       (<EQUAL? ,WINNER ,PROTAGONIST>
		<TELL "You can't see">
		<COND (<NOT <NAME? ,P-XNAM>>
		       <TELL " any">)> 
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!" CR>)
	       (T
		<TELL "Looking confused, the " ,WINNER " says, \"I don't see">
		<COND (<NOT <NAME? ,P-XNAM>>
		       <TELL " any">)>
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!\"" CR>)>
	 <STOP>>

<ROUTINE PRSO-MOBY-VERB? (;"OPTIONAL" ;(A ,PRSA))
	 <COND (<OR <EQUAL? ,PRSA ,V?FIND ,V?FOLLOW>
		    <EQUAL? ,PRSA ,V?WHAT ,V?WHERE ,V?WHO>
		    <EQUAL? ,PRSA ,V?WAIT-FOR ,V?WALK-TO>
		    <EQUAL? ,PRSA ,V?CALL ,V?SAY ,V?YELL>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRSI-MOBY-VERB? ()
	 <COND (<EQUAL? ,PRSA ,V?ASK-ABOUT ,V?ASK-FOR ,V?TELL-ABOUT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
;"Protocol: return T if case was handled and msg TELLed, NOT-HERE-OBJECT
  if 'can't see' msg TELLed, <> if PRSO/PRSI ready to use"
;"Special-case code goes here. <MOBY-FIND .TBL> returns # of matches. If 1,
then P-MOBY-FOUND is it. You can treat the 0 and >1 cases alike or differently.
Always return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	;<COND (,DEBUG
	       <TELL "[Found " N .M-F " obj]" CR>)>
	<COND (<EQUAL? 1 .M-F>
	       ;<COND (,DEBUG
		      <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<AND <L? 1 .M-F>
		    <SET OBJ <APPLY <GETP <SET OBJ <GET .TBL 1>> ,P?GENERIC>>>>
;"Protocol: returns .OBJ if that's the one to use
  		    ,NOT-HERE-OBJECT if case was handled and msg TELLed
		    <> if WHICH-PRINT should be called"
	       ;<COND (,DEBUG
		      <TELL "[Generic: " D .OBJ "]" CR>)>
	       <COND (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
		      <RTRUE>)
		     (.PRSO?
		      <SETG PRSO .OBJ>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI .OBJ>)>
	       <RFALSE>)
	      (T
	       ,NOT-HERE-OBJECT)>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
	 <COND (,P-OFLAG
	        <COND (,P-XADJ
		       <TELL " ">
		       <PRINTB ,P-XADJN>)>
	        <COND (,P-XNAM
		       <TELL " ">
		       <PRINTB ,P-XNAM>)>)
               (.PRSO?
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
               (T
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

<OBJECT GROUND
	(LOC GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND)
	(DESC "ground")
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-ON CLIMB BOARD>
		<WASTES>)
	       (<VERB? LOOK-UNDER>
		<IMPOSSIBLES>)
	       (<VERB? LEAVE>
		<DO-WALK ,P?UP>)
	       (<VERB? CLEAN>
		<COND (<IN? ,COMP-BLOOD-STAIN ,HERE>
		       <PERFORM ,V?CLEAN ,COMP-BLOOD-STAIN>
		       <RTRUE>)
		      (T
		       <TELL
"You're not aware that it needs cleaning." CR>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,COMP-5>
		     <IN? ,COMP-BLOOD-STAIN ,HERE>>
		<TELL
"When you look at the floor in front of you, your eye is immediately
drawn to ">
		<COND (<FSET? ,COMP-BLOOD-STAIN ,CROSSBIT>
		       <TELL "a smeared blood stain">)
		      (T
		       <TELL "some drops of blood bunched together">)>
		<TELL " near the door." CR>)
	       (<VERB? EXAMINE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<AND <VERB? DIG> <EQUAL? ,SCENARIO 2>>
		<TELL
"Except for digging up some snow, you wont get anywhere; the frozen ground is
much too hard." CR>)>>

<OBJECT WALLS
	(LOC GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)>

<OBJECT CEILING
	(LOC GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILING ROOF)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<AND <FSET? ,HERE ,OUTHUTBIT>
		     <VERB? CLIMB CLIMB-UP>>
		<TELL
"You'd never make it with that bad arm of yours." CR>)
	       (<VERB? LOOK-UNDER>
		<PERFORM ,V?LOOK>
		<RTRUE>)>>

<OBJECT HANDS
	(LOC GLOBAL-OBJECTS)
	(SYNONYM HANDS HAND PALM FINGERS)
	(ADJECTIVE BARE MY YOUR)
	(DESC "hand")
	(FLAGS NDESCBIT TOUCHBIT NARTICLEBIT PLURALBIT)
	(ACTION HANDS-F)>

<ROUTINE HANDS-F ("AUX" ACTOR)
	 <COND (<VERB? WAVE>
	        <SETG PRSO <>>
		<PERFORM ,V?WAVE-AT>
		<RTRUE>)
	       (<VERB? SHAKE>
		<COND ;(<EQUAL? ,HERE ,THRONE-ROOM>
		       <PERFORM ,V?SHAKE-WITH ,HANDS ,MITRE>
		       <RTRUE>)
		      (<SET ACTOR <FIND-IN ,HERE ,PERSON "with">>
		       <PERFORM ,V?SHAKE-WITH ,HANDS .ACTOR>
		       <RTRUE>)
		      (T
		       <TELL "Pleased to meet you." CR>)>)
	       (<VERB? CLEAN>
		<TELL "They're as clean as they'll get." CR>)>>

<OBJECT EYES
	(LOC GLOBAL-OBJECTS)
	(DESC "your eyes")
	(SYNONYM EYE EYES)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PLURALBIT NOTHEBIT NOABIT)
	;(ACTION EYES-F)>

;<OBJECT EARS
	(LOC GLOBAL-OBJECTS)
	(DESC "your ears")
	(SYNONYM EAR EARS)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PLURALBIT)>

;<OBJECT NOSE
	(LOC GLOBAL-OBJECTS)
	(DESC "your nose")
	(SYNONYM NOSE NOSTRIL)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT)
	(ACTION NOSE-F)>

;<ROUTINE NOSE-F ()
	 <COND (<VERB? TAKE>
		<PERFORM ,V?SPUT-ON ,NOSE ,HANDS>
		<RTRUE>)>>

;<OBJECT MOUTH
	(LOC GLOBAL-OBJECTS)
	(DESC "your mouth")
	(SYNONYM MOUTH LIP LIPS)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT)>

;<OBJECT KNEECAPS
	(LOC GLOBAL-OBJECTS)
	(DESC "your kneecaps")
	(SYNONYM KNEECAP KNEE KNEES)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT)>

<OBJECT PROTAGONIST
	(LOC B8)
	(SYNONYM PROTAG)
	(DESC "it")
	(FLAGS NDESCBIT INVISIBLE PERSON)>

;<OBJECT YOU
        (LOC GLOBAL-OBJECTS)
	(SYNONYM YOU YOURSELF HIMSELF HERSELF)
	(DESC "himself or herself")
	(FLAGS NDESCBIT)
	(ACTION YOU-F)>

;<ROUTINE YOU-F ()
	 <COND (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,YOU>>
		<PERFORM ,V?ASK-ABOUT ,PRSO ,PRSO>
		<RTRUE>)
	       (<AND <VERB? TELL-ABOUT> 
		     <PRSI? ,YOU>>
		<PERFORM ,V?TELL-ABOUT ,PRSO ,WINNER>
		<RTRUE>)>>
 
<OBJECT ME
	(LOC GLOBAL-OBJECTS)
	(SYNONYM ME SELF MYSELF $FN $LN)
	(DESC "yourself")
	(FLAGS PERSON TOUCHBIT NARTICLEBIT NOTHEBIT NOABIT)
	(ACTION ME-F)>

<ROUTINE ME-F () 
	 <COND (<VERB? SAVE-SOMETHING>
		<TELL
"Perhaps you need a HINT?" CR>)
	       (<VERB? LOOK-BEHIND>
		<TELL
"In this country, looking over one's shoulder is a way of life; at
the moment, you don't see anything you haven't seen before." CR>)
	       (<VERB? TELL>
		<TELL
"Talking to yourself is a sign of impending mental collapse." CR>
		<STOP>)
	       (<VERB? LISTEN>
		<TELL "Yes?" CR>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,ME>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<VERB? MOVE>
		<V-WALK-AROUND>)
	       (<VERB? SEARCH>
		<V-INVENTORY>
		<RTRUE>)
	       ;(<VERB? EXAMINE>
		<TELL "You're wearing" AR ,GARMENT>)
	       (<VERB? KILL HIT MUNG OFF>
		<TELL "Self-flagellation is not the answer." CR>)
	       (<VERB? FIND>
		<TELL "You're right here!" CR>)
	       (<VERB? FOLLOW>
		<TELL
"When you talk this way, you're very hard to follow." CR>)>>

<OBJECT GLOBAL-ROOM
	(LOC GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM PLACE LOCATION AREA)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK LOOK-INSIDE EXAMINE>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<VERB? ENTER WALK-TO>
		<PERFORM ,V?WALK-AROUND ,PRSO>
		<RTRUE>)
	       (<VERB? LEAVE EXIT>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<VERB? WALK-AROUND>
                <TELL
"Walking around here reveals nothing new. To move elsewhere, just type
the desired direction." CR>)>>

<OBJECT WAY
	(LOC GLOBAL-OBJECTS)
	(DESC "way")
	(SYNONYM WAY)>

;<OBJECT STAIRS
	(LOC LOCAL-GLOBALS)
	(DESC "stair")
	(SYNONYM STAIR STAIRS STAIRW STEP)
	(ADJECTIVE STEEP WINDING)
	(ACTION STAIRS-F)>

;<ROUTINE STAIRS-F ()
	 <COND (<VERB? CLIMB CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)>>

<OBJECT SKY
	(LOC GLOBAL-OBJECTS)
	(DESC "sky")
	(SYNONYM SKY)
	(ADJECTIVE NIGHT DARK)
	(ACTION SKY-F)>

<ROUTINE SKY-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,SCENARIO 3>
		       <TELL
"It's a beautiful, sunny day in Ostnitz." CR>)
		      (<EQUAL? ,SCENARIO 1>
		       <TELL
"It's dark outside and cloudy, if memory serves." CR>)
		      (<OR <EQUAL? ,HERE ,INSIDE-SHED ,HUT-LIVING>
			   <EQUAL? ,HERE ,HUT-BEDROOM ,HUT-STORAGE>>
		       <TELL
"It's hard to tell from here, but it can be assumed that it is still dark
and cloudy out." CR>)
		      (T
		       <TELL
"It is dark and cloudy, though the clouds are thin enough to see the
pale image of a full moon lighting up the sky.">
		       <COND (<OR <EQUAL? ,HERE ,OUTSIDE-HUT ,NORTH-HUT>
				  <EQUAL? ,HERE ,SOUTH-HUT ,D5 ,BEHIND-HUT>>
			      <CRLF>)
			     (T
			      <TELL " Off to the ">
			      <TELL-DIRECTION ,HERE ,D5>
			      <COND (,HUT-BURNING
				     <TELL ", you can see a dull
orange glow with plumes of black smoke billowing upwards." CR>)
				    (T
				     <TELL ", you can see some wisps of
black smoke rising up into the heavens." CR>)>)>)>)>>

;<ROUTINE DONT-HANDLE? (OBJECT)
	 <COND (<OR <AND <EQUAL? .OBJECT ,PRSO>
			 <PRSO-MOBY-VERB?>>
		    <AND <EQUAL? .OBJECT PRSI>
			 <PRSI-MOBY-VERB?>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<ROUTINE TALKING-TO? (ACTOR)
	 <COND (<OR <ASKING? .ACTOR>
		    <EQUAL? ,WINNER .ACTOR>>
		<RTRUE>)
	       (<AND <VERB? TELL TELL-ABOUT HELLO WAVE-AT REPLY YELL ALARM>
		     <PRSO? .ACTOR>>
	        <RTRUE>) 
	       (T
		<RFALSE>)>>

;<ROUTINE ASKING? (ACTOR)
	 <COND (<AND <VERB? ASK-ABOUT ASK-FOR>
		     <PRSO? .ACTOR>>
	        <RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TOUCHING? (THING)
	 <COND (<AND <OR <EQUAL? ,PRSA ,V?TAKE ,V?TOUCH ,V?SHAKE>
			 <EQUAL? ,PRSA ,V?SPIN ,V?PUT-ON>
			 <EQUAL? ,PRSA ,V?PUSH ,V?CLOSE>
			 <EQUAL? ,PRSA ,V?MOVE ,V?OPEN>
			 <EQUAL? ,PRSA ,V?RAISE ,V?CLIMB-OVER>
			 <EQUAL? ,PRSA ,V?CLIMB-UP ,V?BEND>
			 <EQUAL? ,PRSA ,V?CLIMB ,V?CLIMB-DOWN ,V?CLIMB-ON>
			 <EQUAL? ,PRSA ,V?BOARD ,V?ENTER ,V?CRAWL-UNDER>
			 <HURT? .THING>>
		     <PRSO? .THING>>
		<RTRUE>)
	       (<AND <PRSI? .THING>
		     <VERB? PUT PUT-ON>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<ROUTINE DISTURB? (THING)
	 <COND (<OR <TOUCHING? .THING>
		    <TALKING-TO? .THING>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HURT? (THING)
	 <COND (<AND <OR <EQUAL? ,PRSA ,V?MUNG ,V?KICK ,V?KILL>
			 <EQUAL? ,PRSA ,V?KNOCK ,V?CUT ;,V?WHIP>
			 <EQUAL? ,PRSA ,V?BITE ,V?PUSH>>
		     <PRSO? .THING>>
		<RTRUE>)
	       (<AND <VERB? THROW>
		     <PRSI? .THING>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRSO-PRINT ("AUX" PTR) ;"moved directly into CANT-SEE"
	 <COND (<OR ,P-MERGED
		    <==? <GET <SET PTR <GET ,P-ITBL ,P-NC1>> 0> ,W?IT>>
		<TELL " " D ,PRSO>)
	       (T <BUFFER-PRINT .PTR <GET ,P-ITBL ,P-NC1L> <>>)>>

<ROUTINE PRSI-PRINT ("AUX" PTR) ;"moved directly into CANT-SEE"
	 <COND (<OR ,P-MERGED
		    <==? <GET <SET PTR <GET ,P-ITBL ,P-NC2>> 0> ,W?IT>>
		<TELL " " D ,PRSI>)
	       (T <BUFFER-PRINT .PTR <GET ,P-ITBL ,P-NC2L> <>>)>>

<ROUTINE CANT-SEE ("OPTIONAL" (OBJ <>) (STRING <>))
	 <SETG P-WON <>>
	 ;<COND (,P-MULT
		 <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>)>
	 <TELL "You can't see">
	 <COND (<OR <NOT .OBJ>
		    <AND .OBJ
			 <NOT <NAME? .OBJ>>>>
		<TELL " any">)>
	 <COND (<NOT .OBJ>
		<TELL " " .STRING>)
	       (<EQUAL? .OBJ ,PRSI>
		<PRSI-PRINT>)
	       (T
		<PRSO-PRINT>)>
	 <TELL " here." CR>>

<ROUTINE CANT-VERB-A-PRSO! (STRING)
	 <TELL "You can't " .STRING AR ,PRSO>>

<ROUTINE TELL-HIT-HEAD ()
	 <TELL "You hit your head against the " D ,PRSO
	       " as you attempt this." CR>>

;<ROUTINE IS-NOUN? (TEST-NOUN)
	 <COND (<EQUAL? .TEST-NOUN <GET ,P-NAMW 0> <GET ,P-NAMW 1>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<ROUTINE IS-ADJ? (OBJ TEST-ADJECTIVE "AUX" INPUT-ADJECTIVE)
	 <COND (<EQUAL? .OBJ ,PRSO>
		<SET INPUT-ADJECTIVE <GET ,P-ADJW 0>>)
	       (T
		<SET INPUT-ADJECTIVE <GET ,P-ADJW 1>>)>
	 <COND (<EQUAL? .TEST-ADJECTIVE .INPUT-ADJECTIVE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<ROUTINE IS-ADJ? (TEST-ADJ)
	 <COND (<EQUAL? .TEST-ADJ <GET ,P-ADJW 0> <GET ,P-ADJW 1>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<CONSTANT TOO-DARK "It's too dark to see a thing.">

<CONSTANT YNH "You're not holding">

;<GLOBAL YOU-SEE "You can see">

<CONSTANT LOOK-AROUND "Look around you.|">

<CONSTANT CANT-GO "You can't go that way.|">

<ROUTINE REFERRING ("OPTIONAL" (FOO <>))
	 <TELL "[I don't see what you're referring to.]" CR>>

<CONSTANT RECOGNIZE "[That sentence isn't one I recognize.]|">

<CONSTANT HOLDING-IT "You're holding it!|">

<CONSTANT PERIOD ".|">


	