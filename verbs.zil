
"VERBS for
		            BORDER ZONE
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

;"subtitle game commands"

<GLOBAL VERBOSITY 1> ;"0 = super-brief, 2 = verbose (1 not allowed)"

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "Verbose descriptions." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <TELL
"In BORDER ZONE, you can choose only between VERBOSE descriptions (the
default) or SUPERBRIEF descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG VERBOSITY 0>
	 <TELL "Superbrief descriptions." CR>>

<GLOBAL SAVE-FLAG <>>

<ROUTINE V-SAVE ("AUX" SV FLG)
	 <SETG SAVE-FLAG T>
	 <COND (<EQUAL? <SET SV <SAVE>> 1>
	        <CHECK-REFRESH>
		<TELL "Ok." CR>)
	       (<EQUAL? .SV 2>
		<CHECK-REFRESH>
		<COND (,G-WATCH
		       <PERFORM ,V?OFF-2 ,TIMING-OBJECT ,GUARDS>
		       <CRLF>
		       <PERFORM ,V?WATCH ,GUARDS>
		       <UPDATE-CHRONOGRAPH 0 T>)
		      (,SL-WATCH
		       <PERFORM ,V?OFF-2 ,TIMING-OBJECT ,SEARCHLIGHTS>
		       <CRLF>
		       <PERFORM ,V?WATCH ,SEARCHLIGHTS>
		       <UPDATE-CHRONOGRAPH 0 T>)
		      (T
		       <REDISPLAY-CHRONOGRAPH>
		       <FLUSH-WATCHER>)>
		<TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>
	 <UPDATE-TIME>
	 <SETG SAVE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-RESTORE ()
	 <COND (<ZERO? ,SCENARIO>
		<INIT-STATUS-LINE 3>
		<CRLF>)>
	 <COND (<RESTORE>
	        <TELL "Ok." CR CR>
		<V-LOOK>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SCRIPT ()
         <PRINT "[Transcripting o">
	 <TELL "n.]" CR>
	 <DIROUT ,D-PRINTER-ON>
	 <TRANSCRIPT "begin">
	 <RTRUE>>

<ROUTINE V-UNSCRIPT ()
	 <TRANSCRIPT "end">
	 <DIROUT ,D-PRINTER-OFF>
	 <PRINT "[Transcripting o">
	 <TELL "ff.]" CR>
	 <RTRUE>>

<ROUTINE TRANSCRIPT (STR)
	 <DIROUT ,D-SCREEN-OFF>
	 <TELL CR "Here " .STR "s a transcript of interaction with" CR>
	 <V-VERSION>
	 <DIROUT ,D-SCREEN-ON>
	 <RTRUE>>

<ROUTINE V-DIAGNOSE ()
	 <COND (<OR <L? ,HEALTH 9> <L? ,WARMTH 9>>
		<TELL "You are suffering from ">
		<SLOWDOWN T>
		<TELL ,PERIOD-CR>)
	       (<NOT <EQUAL? ,SCENARIO 2>>
		<TELL
"You're in good enough shape to accomplish your goal." CR>)
	       (T
		<TELL
"You are in reasonably good health, though your arm hurts badly and
you've lost some blood." CR>)>>

<ROUTINE V-INVENTORY ()
	 <SETG CLOCK-MOVE 5>
	 <SETG D-BIT <- ,WORNBIT ;,WEARBIT>>
	 <COND (<NOT <DESCRIBE-CONTENTS ,WINNER
					<>
					<+ ,D-ALL? ,D-PARA?>>>
		<TELL "You are empty-handed.">)>
	 <SETG D-BIT ,WORNBIT ;,WEARBIT>
	 <DESCRIBE-CONTENTS ,WINNER
			    <>
			    <+ ,D-ALL? ,D-PARA?>>
	 <SETG D-BIT <>>
	 <CRLF>>

;<ROUTINE PRINT-AMOUNT (AMT)
	 <TELL "$" N </ .AMT 100> ".">
	 <SET AMT <MOD .AMT 100>>
	 <COND (<0? .AMT>
		<TELL "00">)
	       (<L? .AMT 10>
		<TELL "0" N .AMT>)
	       (T
		<TELL N .AMT>)>>

<ROUTINE V-QUIT ()
	 <DO-YOU-WISH "leave the game">
	 <COND (<YES?>
		<QUIT>)
	       (T
		<TELL "Okay." CR>)>>

<ROUTINE V-RESTART ()
	 <DO-YOU-WISH "restart">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<ROUTINE DO-YOU-WISH (STRING)
	 <TELL CR "Do you wish to " .STRING "?:">>

<ROUTINE YES? ("OPTIONAL" (TO-PERSON <>))
	 <COND (.TO-PERSON
		<PRINTI ">>">)
	       (T
		<PRINTI ">">)>
	 <PUTB ,P-INBUF 1 0>
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<YES-WORD? <GET ,P-LEXV 1>>
		<RTRUE>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?N ,W?NO>
		<RFALSE>)
	       (<EQUAL? .TO-PERSON ,BAD-SPY>
		<TELL "\"Please, just a simple yes or no.\"">
		<CRLF>
		<CRLF>
		<AGAIN>)
	       (T
		<TELL "Please answer YES or NO.">)>
		<CRLF>
		<CRLF>
	        <AGAIN>>

<ROUTINE YES-WORD? (WRD)
	 <COND (<EQUAL? .WRD ,W?YES ,W?Y>
		<RTRUE>)
	       (<EQUAL? .WRD ,W?OK ,W?OKAY>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FINISH ("OPTIONAL" (CONTIN <>) "AUX" W)
	 <HLIGHT ,H-NORMAL>
	 <CRLF>
	 <CRLF>
	 <TELL
"Would you like to ">
	 <COND (.CONTIN
		<TELL "continue with the next scenario, ">)>
	 <TELL "start over, restore a saved position, get a hint, or
end this session of the game?|
(Type ">
	 <COND (.CONTIN
		<TELL "CONTINUE, ">)>
	 <TELL "RESTART, RESTORE, HINT, or QUIT) >">
	 <PUTB ,P-INBUF 1 0>
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <SET W <GET ,P-LEXV 1>> ,W?RESTART>
	        <RESTART>
		<TELL "Failed." CR>
		<FINISH .CONTIN>)
	       (<EQUAL? .W ,W?RESTORE>
		<COND (<RESTORE>
		       <>)
		      (T
		       <TELL "Failed." CR>
		       <FINISH .CONTIN>)>)
	       (<EQUAL? .W ,W?HINT>
		<V-HINT>
		<AGAIN>)
	       (<EQUAL? .W ,W?QUIT ,W?Q>
		<QUIT>)
	       (<AND .CONTIN
		     <EQUAL? .W ,W?CONTINUE ,W?C>>
		<FLUSH-BAD-SCENARIO .CONTIN>
		<COND (<EQUAL? .CONTIN 2>
		       <START-SCENARIO-2 T>)
		      (T
		       <START-SCENARIO-3 T>)>)
	       (T
		<AGAIN>)>>

<ROUTINE V-VERSION ("AUX" (CNT 17) V)
	 <SET V <BAND <GET 0 1> *3777*>>
	 <TELL CR 
"BORDER ZONE: A Game of Intrigue|
Copyright (c) 1987 by Infocom, Inc. All rights reserved.|
BORDER ZONE is a trademark of Infocom, Inc.|
Release " N .V " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <TELL " / ">
	 <V-$ID>
	 <CRLF>>

<CONSTANT D-RECORD-ON 4>
<CONSTANT D-RECORD-OFF -4>

<ROUTINE V-$RANDOM ()
	 <COND (<NOT <PRSO? ,INTNUM>>
		<TELL "Illegal call to #RANDOM." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<ROUTINE V-$ID ()
	 <TELL "Interpreter ">
	 <PRINTN <GETB 0 30>>
	 <TELL " Version ">
	 <PRINTC <GETB 0 31>>
	 <CRLF>
	 <RTRUE>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <EQUAL? ,P-NUMBER 811>>
		<TELL N ,SERIAL CR>)
	       (T
		<V-$ID>
		<TELL CR "[Verifying.]" CR>
	 	<COND (<VERIFY>
		       <TELL "Ok." CR>)
	       	      (T
		       <TELL CR "** Bad **" CR>)>)>>

<CONSTANT SERIAL 0>

;<GLOBAL DEBUG <>>

;<ROUTINE V-$DEBUG ()
	 <TELL "Debugging o">
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "ff">)
	       (T
		<SETG DEBUG T>
		<TELL "n">)>
	 <TELL "." CR>>


;"subtitle real verbs"

<ROUTINE V-ADVANCE ()
	 <WASTES>>

<ROUTINE V-ALARM ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?ALARM ,ME>
		<RTRUE>)
	       (T
		<TELL "But" T ,PRSO " isn't asleep." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody is awaiting your answer." CR>
	 <STOP>>

<ROUTINE V-ARREST ()
	 <TELL "Be glad it isn't you that's arrested." CR>> 

<ROUTINE V-ASK-ABOUT ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?TELL-ABOUT ,ME ,PRSI>
		<RTRUE>)
	       ;(<FSET? ,PRSO ,PERSON>
		<TELL
"A long silence tells you that" T ,PRSO " isn't interested in talking about">
		<COND (<IN? ,PRSI ,ROOMS>
		       <TELL " that." CR>)
		      (T
		       <TELL TR ,PRSI>)>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-FOR ()
	 <TELL "Unsurprisingly," T ,PRSO " doesn't oblige." CR>>    

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting ">>

<ROUTINE V-BEND ()
	 <COND (<AND ,PRSI <NOT <EQUAL? ,PRSI ,WAY>>>
		<TELL "Huh?" CR>)
	       (T
		<TELL "You can't bend that." CR>)>>

<ROUTINE PRE-BOARD ()
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<TELL ,LOOK-AROUND>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)>>

<ROUTINE V-BOARD ()
	 <TELL "You can't get into " THE ,PRSO "!" CR>>

<ROUTINE V-BUY ()
	 <TELL "It's not for sale." CR>>

<ROUTINE V-BUY-WITH ("AUX" ACTOR) ;"PAY WITH --"
	 <IMPOSSIBLES>>

<ROUTINE V-BUY-OBJECT-WITH ("AUX" ACTOR)
	 <IMPOSSIBLES>>

<ROUTINE V-CALL () ;"prso need not be in room"
	 <COND (<AND <NOT <EQUAL? <META-LOC ,PRSO> ,HERE>>
	             <NOT <EQUAL? ,PRSO ,ME>>
		     <NOT <GLOBAL-IN? ,PRSO ,HERE>>>
		<CANT-SEE ,PRSO>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-CHASTISE () <TELL ,TOO-LATE CR>>

<ROUTINE PRE-CHASTISE ()
	 <COND (<DIRECTION? ,PRSO>
		<TELL
"You'll have to go in that direction to see what's there." CR>)
	       (T
		<TELL
"Use prepositions to indicate precisely what you want to do: LOOK AT the
object, LOOK INSIDE it, LOOK UNDER it, etc." CR>)>>

<ROUTINE V-CLEAN ()
         <TELL "A nice thought, but not that important just now." CR>>

<ROUTINE V-CLIMB-NUL ()
	 <TELL
"You'll have to be more specific." CR>>

<ROUTINE V-CLIMB ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (<EQUAL? <LOC ,PRSO> ,COMP-SEAT-FRONT ,COMP-SEAT-BACK>
		<COND (<EQUAL? ,PRSO ,DOCUMENT ,SHRED ,SHREDS>
		       <TELL
"It's a clever idea, but you wouldn't get away with it." CR>)
		      (T
		       <TELL
"It would neither be comfortable nor helpful." CR>)>)
	       (T
		<TELL "You can't climb onto " THE ,PRSO ,PERIOD-CR>)>>

<ROUTINE V-CLIMB-OVER ()
	 <COND (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
	 	<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLOSE ()
	 <COND (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,PERSON>>
		<CANT-VERB-A-PRSO "close">)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,CONTBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Okay," T ,PRSO " is now closed." CR>
		       ;<NOW-DARK?>)
		      (T
		       <TELL "It's already closed." CR>)>)
	       (T
		<CANT-VERB-A-PRSO! "close">)>>

<ROUTINE V-COUNT ()
	 <IMPOSSIBLES>>

<ROUTINE V-CRAWL-UNDER ()
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
	        <TELL-HIT-HEAD>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CUT ()
	 <COND (<NOT ,PRSI>
		<IMPOSSIBLES>)
	       (<EQUAL? ,PRSI ,WOOD-SAW>
		<TELL
"It's not wood, so you won't get anywhere." CR>)
	       (<EQUAL? ,PRSI ,BOLT-CUTTER>
		<TELL
"There's no use cutting that." CR>)
	       (T
		<TELL
"You'll never get anywhere with " A ,PRSI ,PERIOD-CR>)>>

<ROUTINE V-DIG ()
	 <WASTES>>

<ROUTINE V-DISEMBARK ()
	 <COND (<AND <FSET? ,PRSO ,TAKEBIT> ;"since GET OUT is also TAKE OUT"
		     <EQUAL? <META-LOC ,PRSO> ,HERE>
		     <NOT <IN? ,PRSO ,HERE>>
		     <NOT <IN? ,PRSO ,PROTAGONIST>>
		     <NOT <IN? ,PROTAGONIST ,PRSO>>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<NOT <IN? ,PROTAGONIST ,PRSO>>
		<TELL ,LOOK-AROUND>
		<RFATAL>)
	       ;(<EQUAL? ,HERE ,CANAL>
		<PERFORM ,V?ENTER ,CANAL-OBJECT>
		<RTRUE>)
	       (T
		<MOVE ,PROTAGONIST ,HERE>
		<TELL "You">
		;<COND (<IN? ,SIDEKICK ,PRSO>
		       <MOVE ,SIDEKICK ,HERE>
		       <TELL " and " D ,SIDEKICK>)>
		<TELL " get out of the " D ,PRSO ".">		
		<CRLF>)>>

<ROUTINE V-DRINK ()
	 <TELL "You can't drink that!" CR>>

<ROUTINE V-DRINK-FROM ()
	 <IMPOSSIBLES>>

<ROUTINE V-DROP ()
	 <SETG CLOCK-MOVE 6>
	 <MOVE ,PRSO ,HERE>
	 <TELL "Dropped." CR>>

<ROUTINE SPECIAL-DROP () ;"used by drop and throw"
	 <RFALSE>>

<ROUTINE V-EAT ()
	 <TELL
"Your incipient ulcer would not be helped by eating " A ,PRSO ,PERIOD-CR>>

<ROUTINE V-EMPTY ("AUX" OBJ NXT)
	 <COND (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <SET OBJ <FIRST? ,PRSO>>
		       <COND (.OBJ
			      <REPEAT ()
				 <SET NXT <NEXT? .OBJ>>
				 <MOVE .OBJ ,HERE>
				 <COND (.NXT
				 	<SET OBJ .NXT>)
				       (T
					<RETURN>)>>
			      <TELL "You dump the contents of" T ,PRSO>
			      <TELL " onto the ground." CR>)
			     (T
			      <TELL "It's already empty!" CR>)>)
		      (T
		       <TELL "It's closed." CR>)>)
	       (<AND <HELD? ,PRSO>
		     <NOT <IN? ,PRSO ,PROTAGONIST>>>
		<MOVE ,PRSO ,HERE>
		<TELL "Done." CR>)
	       (T
		<IMPOSSIBLES>)>
	 <RTRUE>>

<ROUTINE V-ENTER ()
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL-HIT-HEAD>)
	      (T
	       <IMPOSSIBLES>)>>

<ROUTINE V-EXAMINE ()
	 <COND ;(<FSET? ,PRSO ,UNTEEDBIT>
		<TELL "It looks just like" A ,PRSO ", whatever that is." CR>)
	       (<FSET? ,PRSO ,PERSON>
		<COND (<FIRST? ,PRSO>
		       <PERFORM ,V?LOOK-INSIDE ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "There's nothing noteworthy about" TR ,PRSO>)>)
	       (<AND <OR <FSET? ,PRSO ,DOORBIT>
		         <FSET? ,PRSO ,SURFACEBIT>>>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "It's closed." CR>)>)
	       ;(<GETP ,PRSO ,P?TEXT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (T
	        <TELL 
"It's a pretty typical " D ,PRSO "." CR>)>>
	       
<ROUTINE V-EXAMINE-THROUGH-FLIP ()
	 <PERFORM ,V?EXAMINE-THROUGH ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-EXAMINE-THROUGH ()
	 <TELL "This reveals nothing new." CR>>

<ROUTINE V-EXIT ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-FEED ()
	 <TELL "You have nothing to feed " THE ,PRSO " with." CR>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<TELL "There's nothing to fill it with.">)
	       (T 
		<IMPOSSIBLES>)>>

<ROUTINE V-FIND ("OPTIONAL" (WHERE <>) "AUX" (L <LOC ,PRSO>))
	 <COND (<NOT .L>
		<TELL "You can't tell." CR>)
	       (<PRSO? ,ME>
		<TELL "You're in \"">
		<HERE-TELL <>>
		<TELL "\"." CR>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<TELL "You're holding it!" CR>)
	       (<IN? ,PRSO ,HERE>
		<TELL "It's right in front of you." CR>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<TELL "You'll have to find it yourself!" CR>)
	       (<AND <FSET? .L ,PERSON>
		     <VISIBLE? .L>>
		<TELL "It seems as though " THE .L " has it." CR>)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? ,PRSO>
		     <NOT <IN? .L ,GLOBAL-OBJECTS>>>
		<COND (<FSET? ,PRSO ,PERSON>
		       <TELL "He">)
		      (T
		       <TELL "It">)>
		<TELL "'s in" TR .L>)
	       (T
		<TELL "You'll have to find it yourself!" CR>)>>

<ROUTINE V-FLUSH ()
	 <TELL "Perhaps the strain is getting to you." CR>>

<ROUTINE V-FOLLOW ()
	 <COND (<IN? ,PRSO ,HERE>
		<TELL "But" T ,PRSO " is right here!" CR>)
	       (<NOT <FSET? ,PRSO ,PERSON>>
		<IMPOSSIBLES>)
	       (T
		<TELL "You have no idea where" T ,PRSO " is." CR>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<AND <VERB? GIVE>
		     <PRSO? ,HANDS>>
		<PERFORM ,V?SHAKE-WITH ,PRSI>
		<RTRUE>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-GIVE ()
	 <COND (<FSET? ,PRSI ,PERSON>		
		<TELL "Briskly, " THE ,PRSI " refuses your offer." CR>)
	       (T
		<TELL "You can't give " A ,PRSO " to " A ,PRSI "!" CR>)>>

<ROUTINE V-HELLO ()
       <COND (,PRSO
	      <TELL
"[The proper way to talk to characters in the story is
CHARACTER, HELLO.]" CR>)
	     (T
	      <PERFORM ,V?TELL ,ME>
	      <RTRUE>)>>

<ROUTINE V-HIDE ()
	 <COND (<EQUAL? ,HERE ,SNIPER-ROOM>
		<PERFORM ,V?HIDE-BEHIND ,HALL-DOOR-E>
		<RTRUE>)>
	 <TELL "There's no good place to hide ">
	 <COND (,PRSO
		<TELL "t">)>
	 <TELL "here." CR>>

<ROUTINE V-HIDE-BEHIND ()
	 <WASTES>>

<ROUTINE V-HOLD ()
	 <PERFORM ,V?TAKE ,PRSO>
	 <RTRUE>>

<ROUTINE V-IN ()
	 <COND (<FSET? ,HERE ,SWAMPBIT>
		<PERFORM ,V?ENTER ,SWAMP>
		<RTRUE>)
	       (T
	        <DO-WALK ,P?IN>)>>

<ROUTINE V-INFLATE ()
	 <IMPOSSIBLES>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking ">>

<ROUTINE V-KILL ()
	 <TELL "Pull yourself together." CR>>

<ROUTINE V-KISS ()
	<TELL
"Good grief! The pressure must be getting to you." CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "There's no answer." CR>)
	       (T
		<HACK-HACK "Knocking on ">)>>

<ROUTINE V-LEAP ()
	 <COND (<AND ,PRSO
		     <NOT <IN? ,PRSO ,HERE>>>
		<IMPOSSIBLES>)
	       (<AND ,PRSO
		     <FSET? ,PRSO ,PERSON>>
		<PERFORM ,V?KILL ,PRSO>
		<RTRUE>)
	       (<EQUAL? ,HERE ,TOWER-SOUTH>
		<PERFORM ,V?LEAP ,BORDER-FENCE>
		<RTRUE>)
	       (T
		<V-SKIP>)>>

<ROUTINE V-LEAP-OFF ()
	 <PERFORM ,V?LEAP ,PRSO>
	 <RTRUE>>

<ROUTINE V-LEAVE ()
	 <COND (<NOT ,PRSO>
		<SETG PRSO ,ROOMS>)>
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?OUT>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LIE-DOWN ()
	 <WASTES>>

<ROUTINE V-LISTEN ()
	 <COND (<NOT ,PRSO>
		<COND (<EQUAL? ,SCENARIO 2>
		       <TELL
"The wind is blowing through the trees, but other than that you should
be more specific with what you are listening for." CR>)
		      (<EQUAL? ,HERE ,ANTIQUE-STORAGE>
		       <PERFORM ,PRSA ,ANTIQUE-CONVERSATION>
		       <RTRUE>)
		      (T
		       <TELL
"You don't hear anything you haven't heard before." CR>)>)
	       (T
		<TELL "At the moment, " THE ,PRSO " makes no sound." CR>)>>

<ROUTINE PRE-LOCK ()
	 <RFALSE>>

<ROUTINE V-LOCK ()
	 <TELL "You can't lock that." CR>>

<ROUTINE V-LOOK ()
	 <DESCRIBE-ROOM T>
	 <DESCRIBE-OBJECTS>>

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>
	 <TELL "There is nothing behind " THE ,PRSO ,PERIOD-CR>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE WHAT-CONTENTS ()
	 <COND (<NOT <DESCRIBE-CONTENTS ,PRSO>>
		<TELL "nothing">
		<COND (<IN? ,PROTAGONIST ,PRSO>
		       <TELL " (other than you)">)>)>
	 <TELL ,PERIOD>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<TELL "On " THE ,PRSO " is ">
		<WHAT-CONTENTS>)
	       (<FSET? ,PRSO ,DOORBIT>
		<THIS-IS-IT ,PRSO>
		<TELL "All you can tell is that ">
		<TELL-OPEN-CLOSED>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<PRSO? <LOC ,WINNER>>
		       <MOVE ,PROTAGONIST ,ROOMS>
		       <TELL "Aside from you, there's ">
		       <WHAT-CONTENTS>
		       <MOVE ,PROTAGONIST ,PRSO>)
		      (<SEE-INSIDE? ,PRSO>
		       <TELL CTHE ,PRSO " contains ">
		       <WHAT-CONTENTS>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <TELL "But " THE ,PRSO " is closed." CR>
		       ;<NEW-VERB ,V?OPEN>
		       <RTRUE>)
		      (T
		       <THIS-IS-IT ,PRSO>
		       <TELL "It seems ">
		       <TELL-OPEN-CLOSED>)>)
	       (T
		<TELL "You can't look inside that." CR>)>>

<ROUTINE V-LOOK-OVER ()
	 <V-EXAMINE>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<HELD? ,PRSO>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You're wearing it!" CR>)
		      (T
		       <TELL ,HOLDING-IT>)>)
	       (T
		<TELL "There's nothing to be seen under" TR ,PRSO>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<PRSO? ,ROOMS>
		<COND (<NOT <FSET? ,HERE ,HUTBIT>>
		       <PERFORM ,V?EXAMINE ,SKY>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?EXAMINE ,CEILING>
		       <RTRUE>)>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

<ROUTINE V-MAKE ()
	 <TELL "You can't make" AR ,PRSO>>

<ROUTINE V-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "Why juggle objects?" CR>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving" T ,PRSO " reveals nothing." CR>)
	       (T
		<TELL "You can't move" TR ,PRSO>)>>

<ROUTINE V-MUNG ()
	 <HACK-HACK "Trying to break ">>

<ROUTINE V-NO ()
	 <TELL "You could use a better attitude." CR>>

<ROUTINE V-RESET ()
	 <TELL "You can't reset that." CR>>

<ROUTINE V-OFF-2 ()
	 <COND (<EQUAL? ,PRSO ,WATCHING-OBJECT>
		<TELL "Not implemented." CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,TIMING-OBJECT>
		<PERFORM ,V?OFF ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"That sentence doesn't make sense." CR>)>>

<ROUTINE V-OFF ()
	 <PERFORM ,V?DISPOSE ,PRSO>
	 <RTRUE>>

<ROUTINE V-ON-2 ()
	 <COND (<EQUAL? ,PRSO ,WATCHING-OBJECT ,TIMING-OBJECT>
		<PERFORM ,V?WATCH ,PRSI>
		<RTRUE>)
	       (T
		<TELL
"That sentence doesn't make sense." CR>)>>

<ROUTINE V-ON ()
	 <CANT-TURN "n">>

<ROUTINE CANT-TURN (STRING)
	 <TELL "You can't turn that o" .STRING "." CR>>

<ROUTINE V-OPEN ()
	 <COND (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,PERSON>>
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,OPENBIT>
		<TELL "It's already open." CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND ;(<FSET? ,PRSO ,LOCKEDBIT>
		       <TELL "It's locked. Very locked." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <TELL "The " D ,PRSO " swings open." CR>)>)
	       (<FSET? ,PRSO ,CONTBIT>
		<FSET ,PRSO ,OPENBIT>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (<OR <NOT <FIRST? ,PRSO>>
			   <FSET? ,PRSO ,TRANSBIT>>
		       <TELL "Opened." CR>)
		      (T
		       <TELL "Opening" T ,PRSO " reveals ">
		       <COND (<NOT <DESCRIBE-CONTENTS ,PRSO -1>>
			      <TELL "nothing">)>
		       <TELL "." CR>
		       ;<NOW-LIT?>)>)
	       (T
		<CANT-VERB-A-PRSO! "open">)>>

<ROUTINE V-PICK ()
	 <TELL "You can't pick that." CR>>

<ROUTINE V-PICK-UP ()
	 <PERFORM ,V?TAKE ,PRSO ,PRSI>
	 <RTRUE>>

<ROUTINE V-PLAY ()
	 <IMPOSSIBLES>>

<ROUTINE V-PLUG-IN ()
	 <IMPOSSIBLES>>

<ROUTINE V-POINT ("AUX" ACTOR)
	 <TELL "Pointless." CR>>

<ROUTINE V-POUR ()
	 <IMPOSSIBLES>>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing ">>

<ROUTINE PRE-PUT ()
	 <COND (<EQUAL? ,PRSO ,BODY-PARTS>
		<RFALSE>)
	       (<PRSI? ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<AND <IN? ,PRSO ,WINNER>
		     <FSET? ,PRSO ,WORNBIT>>
		<TELL
"But, you are wearing " THE ,PRSO ,PERIOD-CR>)
	       (<HELD? ,PRSI ,PRSO>
		<TELL
"You can't put" T ,PRSO " in" T ,PRSI
" when" T ,PRSI " is already in" T ,PRSO "!" CR>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-PUT ()
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,DOORBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<TELL "You can't put" T ,PRSO " in " A ,PRSI "!" CR>)
	       (<OR <PRSI? ,PRSO>
		    <AND <HELD? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<TELL "How can you do that?" CR>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<SETG P-IT-OBJECT ,PRSI>
		<TELL "Inspection reveals that" T ,PRSI " isn't open." CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "But" T ,PRSO " is already in" TR ,PRSI>)
	       (<FSET? ,PRSI ,DOORBIT>
		<PERFORM ,V?PUT-THROUGH ,PRSO ,PRSI>
		<RTRUE>)
	       (<G? <- <+ <WEIGHT ,PRSI> <GETP ,PRSO ,P?SIZE>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSI " for" TR ,PRSO>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <WASTES>>

<ROUTINE V-PUT-ON ()
	 <COND (<PRSI? ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "There's no good surface on" TR ,PRSI>)>>

<ROUTINE V-PUT-THROUGH ()
	 <COND (<FSET? ,PRSI ,DOORBIT>
		<TELL
"It would be imprudent to throw things through a door." CR>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-PUT-UNDER ()
         <WASTES>>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Playing in this way with ">>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<OR <FSET? ,PRSO ,PERSON>
		    <FSET? ,PRSO ,SURFACEBIT>
		    <NOT <FSET? ,PRSO ,CONTBIT>>>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		;<TELL "It's not open." CR>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (<OR <NOT .OBJ>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL "There's nothing in" TR ,PRSO>)
	       (T
		<TELL "You reach into" T ,PRSO " and feel something." CR>)>>

<ROUTINE PRE-READ ()
	 <COND (<AND ,PRSI
		     <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL
"You would need an x-ray machine for that." CR>)>>

<ROUTINE V-READ ()
	 <TELL "You cannot read" AR ,PRSO>>

<ROUTINE V-REMOVE ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-RIP ()
	 <TELL "Unrippable." CR>>

<ROUTINE V-SAVE-SOMETHING ()
	 <TELL "You would do better to start helping yourself." CR>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<EQUAL? ,SCENARIO 1>
		<SIIF>
		<STOP>)
	       (<AND <EQUAL? ,SCENARIO 3>
		     ,AWAITING-PASSWORD>
		<CHECK-PASSWORD>
		<STOP>)
	       (<OR <SET V <FIND-IN ,HERE ,PERSON>>
		    <GLOBAL-IN? ,VENDOR ,HERE>>
		<COND (<ZERO? .V> <SET V ,VENDOR>)>
		<COND (<EQUAL? ,SCENARIO 3>
		       <PERFORM ,V?TELL .V>)
		      (T
		       <TELL "You must address" T .V " directly." CR>)>
		<STOP>)
	       (T
		<PERFORM ,V?TELL ,ME>
		<STOP>)>>

<ROUTINE V-SCORE ()
	 <TELL "There is no score in this game." CR>>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "That wouldn't be polite." CR>)
	       ;(<IN? ,PROTAGONIST ,PRSO>
		<DESCRIBE-VEHICLE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<TELL "You'll have to open that first." CR>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <FIRST? ,PRSO>
		     <NOT <FSET? <FIRST? ,PRSO> ,NDESCBIT>>>
		<TELL "You find ">
		<COND (<NOT <DESCRIBE-CONTENTS ,PRSO -1>>
		       <TELL " nothing">)>
		<TELL "." CR>)
	       (T
		<TELL "You find nothing unusual." CR>)>>

<ROUTINE V-SET ()
	 <COND (<NOT ,PRSI>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <HACK-HACK "Turning ">)
		      (T
		       <TELL ,YNH TR ,PRSO>)>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "Try to vent your anger in a more productive way." CR>)
	       (T
		<HACK-HACK "Shaking ">)>>

<ROUTINE V-SHAKE-WITH ()
	 <COND (<NOT <PRSO? ,HANDS>>
		<TELL ,RECOGNIZE>)
	       (<NOT <FSET? ,PRSI ,PERSON>>
		<TELL "I don't think" T ,PRSI " even has hands." CR>)
	       (T
		<PERFORM ,V?THANK ,PRSI>
		<RTRUE>)>>
	       
<ROUTINE V-SHOW ()
	 <TELL "It's doubtful" T ,PRSI " is interested." CR>>

<ROUTINE V-SIGN ()
	 <IMPOSSIBLES>>

<ROUTINE V-SIT ()
	 <WASTES>>

<ROUTINE V-SKIP ()
	 <TELL "That won't help, and just might get you caught." CR>>

<ROUTINE V-SLEEP ()
	 <TELL "You're not tired." CR>>

<ROUTINE V-SMELL ()
	 <COND (<NOT ,PRSO>
		<PERFORM ,V?SMELL ,ME>
		<RTRUE>)
	       (T
		<TELL "It smells just like " A ,PRSO ,PERIOD-CR>)>>

<ROUTINE V-SMILE ()
         <TELL "How nice." CR>>

<ROUTINE V-SPIN ()
	 <TELL "You can't spin that!" CR>>     

<ROUTINE V-SPUT-ON ()
         <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<AND ,PRSO
		     <FSET? ,PRSO ,TAKEBIT>>
		<WASTES>)
	       (T
		<TELL "You are already standing." CR>)>>

<ROUTINE V-STAND-ON ()
	 <WASTES>>

<ROUTINE V-STELL ()
	 <PERFORM ,V?TELL ,PRSI>
	 <RTRUE>>

<ROUTINE PRE-TAKE ()
	 <COND (<EQUAL? <GET ,P-OFW 0> ,W?PHOTO ,W?PHOTOGRAPH ,W?PICTURE>
		<PERFORM ,V?PHOTOGRAPH ,PRSO>
		<RTRUE>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<EQUAL? ,PRSI ,GROUND>
		<PERFORM ,PRSA ,PRSO>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<TELL "You're in it!" CR>)
	       (<AND ,PRSI
		     <FSET? ,PRSI ,FILMBIT>
		     <FSET? ,PRSO ,FILMBIT>>
		<TELL
"You can't take the film out of the roll without destroying it." CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,PHONY-FILM>
		<RFALSE>)
	       (<AND ,PRSI
		     <FSET? ,PRSO ,FILMBIT>
		     <NOT <GET ,P-ADJW 0>>
		     <EQUAL? ,PRSI ,CAMERA>>
		<PERFORM ,PRSA ,PHONY-FILM ,CAMERA>
		<RTRUE>)
	       (<AND <NOT ,PRSI>
		     <OR <IN? ,PRSO ,PROTAGONIST>
			 <AND <HELD? ,PRSO>
			      <NOT <FSET? ,PRSO ,TAKEBIT>>>>>
		<COND (<AND <FSET? ,PRSO ,WORNBIT>
			    <NOT <EQUAL? ,PRSO ,WOUNDED-LEFT-ARM>>>
		       <TELL "You are already wearing it." CR>)
		      (T
		       <TELL "You already have it." CR>)>)
	       (<NOT ,PRSI>
		<RFALSE>)
	       (<IN? ,PRSO ,PRSI>
		<RFALSE>)
	       (<PRSO? ,ME>
		<PERFORM ,V?DROP ,PRSI>
		<RTRUE>)
	       (<AND <NOT <IN? ,PRSO ,PRSI>>
		     ;"Oh, I hate this!"
		     <NOT <EQUAL? ,PRSI ,BY-GUARDS>>>			    
		<TELL "But" T ,PRSO " isn't ">
		<COND (<FSET? ,PRSI ,PERSON>
		       <TELL "being held by ">)
		      (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on ">)
		      (T
		       <TELL "in ">)>
		<TELL THE ,PRSI ,PERIOD-CR>)
	       (T
		<SETG PRSI <>>
		<RFALSE>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<TELL "Taken." CR>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<FCLEAR ,PRSO ,WORNBIT>
		<REMOVE ,PRSO>
		<COND (<G? <+ <WEIGHT ,PRSO> <WEIGHT ,PROTAGONIST>>
			   ,MAX-WEIGHT>
		       <MOVE ,PRSO ,HERE>
		       <TELL
"You take off " THE ,PRSO ". It's too heavy to carry, so you put it down on
the ground." CR>)
		      (T
		       <MOVE ,PRSO ,WINNER>
		       <TELL
"Okay, you're no longer wearing " THE ,PRSO ,PERIOD-CR>)>)
	       (T
		<TELL "You aren't wearing" TR ,PRSO>)>>

<ROUTINE V-TELL ()
	 <COND (<EQUAL? ,SCENARIO 1>
		<COND (<EQUAL? ,PRSO ,BAD-SPY>
		       <TELL
"He is engaged in conversation with some people in another compartment,
so it isn't surprising that he ignores you." CR>)
		      (T
		       <TELL
"To say something out loud, try SAY \"what you want to say\"" CR>)>)
	       (<EQUAL? ,SCENARIO 2>
		<TELL
"Talking out loud here is only going to get you caught." CR>)
	       (T
		<TELL "You can't talk to that!" CR>)>
	 <STOP>>

<ROUTINE V-TELL-ABOUT ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?WHAT ,PRSI>
		<RTRUE>)
	       (T
		<TELL "It doesn't look like" T ,PRSO " is interested." CR>)>>

<ROUTINE V-THANK ()
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL
"You do so, but" T ,PRSO " seems less than overjoyed." CR>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-THROW ()
	 <COND (<NOT <SPECIAL-DROP>>
	 	<TELL "An almost perfect waste of time." CR>)>>

<ROUTINE V-THROW-OFF ()
	 <IMPOSSIBLES>>

<ROUTINE V-TIE ()
	 <TELL "You can't tie" AR ,PRSO>>

<ROUTINE V-TIE-FLIP ()
	 <PERFORM ,V?TIE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-TIE-TOGETHER ()
	 <V-TIE>>

<ROUTINE V-TOUCH ()
	 <COND (<LOC-CLOSED>
		<RTRUE>)
	       (T
		<HACK-HACK "Fiddling with ">)>>

<ROUTINE V-UNLOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "But the " D ,PRSO " isn't locked." CR>)
	       (T
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-UNTIE ()
	 <IMPOSSIBLES>>

<ROUTINE V-USE ()
	 <TELL
"You'll have to be more specific about how you want to use" TR ,PRSO>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GET .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <COND (<AND <EQUAL? ,SCENARIO 3>
					  <BACKTRACK? .RM T>>
				     <RFATAL>)>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,SEXIT>
		       <COND (<SET STR <GET .PT ,SEXITSTR>>
			      <COND (<AND <EQUAL? ,SCENARIO 3>
					  <BACKTRACK? <GET .PT ,REXIT>>>
				     <RFATAL>)
				    (T
				     <TELL .STR CR>)>)>
		       <COND (<SET STR <VALUE <GETB .PT ,SEXITFLG>>>
			      <CRLF>)>
		       <GOTO <GET .PT ,REXIT> .STR>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GET .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GET .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <SETG P-IT-OBJECT .OBJ>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <SETG P-IT-OBJECT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <EQUAL? ,PRSO ,P?IN>
		     <SET STR <GETP ,HERE ,P?IN-DIR>>>
		<SETG PRSO .STR>
		<AGAIN>)
	       (<AND <EQUAL? ,PRSO ,P?OUT>
		     <SET STR <GETP ,HERE ,P?OUT-DIR>>>
		<SETG PRSO .STR>
		<AGAIN>)
	       (T
		<COND (<PRSO? ,P?OUT ,P?IN>
		       <V-WALK-AROUND>)
		      (T
		       <TELL ,CANT-GO>)>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Just say the direction you want to move in." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<DIRECTION? ,PRSO>
		<DO-WALK ,P-DIRECTION>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 0) "AUX" PERSON NW)
	 <COND (,MINUTES-FLAG
		<SET NUM <* .NUM 60>>)>
	 <COND (<G? .NUM 999>
		<TELL
"That's too long to wait! You've not much time left!" CR>
		<SETG CLOCK-MOVE 0>
		<RTRUE>)>
	 <TELL "Time passes..." CR>
	 <COND (<ZERO? .NUM>
		<SET NUM 30>
		<COND (<EQUAL? ,SCENARIO 1>
		       <SET NUM 90>)>)>
	 <SET NW </ .NUM 5>>
	 <SETG I-FATAL <>>
	 <REPEAT ()
		 <COND (<OR ,I-FATAL <L? <SET NW <- .NW 1>> 0>>
			<RETURN>)
		       (T
			<I-CLOCKER 5>)>>
	 <SETG CLOCK-MOVE 0>
	 <RTRUE>>

<ROUTINE V-$WAIT ()
	 <COND (<EQUAL? ,PRSO ,INTNUM>
		<V-WAIT ,P-NUMBER>)
	       (T
		<V-WAIT>)>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<EQUAL? ,PRSO ,INTNUM>
		<PERFORM ,V?$WAIT ,INTNUM>
		<RTRUE>)
	       (T
		<TELL "You may be waiting quite a while." CR>)>>

<ROUTINE V-WAIT-IN ()
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<V-WAIT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-WAVE ()
	 <IMPOSSIBLES>>

<ROUTINE V-WAVE-AT ()
	 <COND (<NOT ,PRSO>
		<V-SMILE>)
	       (T
		<TELL
"It doesn't seem that " THE ,PRSO " is likely to respond." CR>)>>

<ROUTINE V-WEAR ()
         <COND (<FSET? ,PRSO ,WORNBIT>
		<TELL "You're already wearing" TR ,PRSO>)
	       (<FSET? ,PRSO ,WEARBIT>
		<MOVE ,PRSO ,PROTAGONIST>
		<FSET ,PRSO ,WORNBIT>
		<TELL "You are now wearing" TR ,PRSO>)
	       (T
		<TELL "You can't wear " THE ,PRSO ,PERIOD-CR>)>>

<ROUTINE V-WHAT ()
	 <COND (<NOT ,PRSO>
		<TELL "That's what." CR>)
	       (T
		<TELL "Good question." CR>)>
	 <STOP>>

<ROUTINE V-WHERE ()
	 <COND (,PRSO
		<V-FIND T>)
	       (T
		<TELL "Right here." CR>)>>

<ROUTINE V-WHO ()
	 <COND (<NOT ,PRSO>
		<TELL "You." CR>)
	       (<FSET? ,PRSO ,PERSON>
		<PERFORM ,V?WHAT ,PRSO>
		<RTRUE>)
	       (T
		<TELL "That's for you to find out!" CR>)>>

<ROUTINE V-WHY ()
	 <TELL "In this country, it is best not to ask." CR>>

<ROUTINE V-YELL ()
	 <TELL "Not wise. It would only call attention to yourself." CR>
	 <STOP>>

<ROUTINE V-YES ()
	 <TELL "Yes?" CR>>


;"subtitle object manipulation"

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" ;CNT OBJ)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <IMPOSSIBLES>)>
		<RFATAL>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,PROTAGONIST>>
			 ,MAX-WEIGHT>>
		<COND (.VB
		       <TELL
"It's too heavy, considering ">
		       <COND (<OR <NOT <EQUAL? ,SCENARIO 2>>
				  <G? <WEIGHT ,PROTAGONIST>
				      </ ,MAX-WEIGHT 2>>>
			      <TELL "what you're already holding">
			      <COND (<EQUAL? ,SCENARIO 2>
				     <TELL " and ">)>)>
		       <COND (<EQUAL? ,SCENARIO 2>
			      <TELL "your bad arm">)>
		       <TELL ,PERIOD-CR>)>
		<RFATAL>)
	       (<G? <CCOUNT ,PROTAGONIST> 5>
		<COND (.VB
		       <TELL
"You're already holding as many items as you can">
		       <COND (<EQUAL? ,SCENARIO 2>
			      <TELL ", especially in light
of your bad arm">)>
		       <TELL ,PERIOD-CR>)>
		<RFATAL>)>
	 <COND (<AND <EQUAL? ,PRSO ,EXPLODING-PEN>
		     <IN? ,PRSO ,FENCE>>
		<FCLEAR ,HERE ,PENBIT>
		<FCLEAR <GETP ,HERE ,P?ACROSS> ,PENBIT>)>
	 <MOVE ,PRSO ,PROTAGONIST>
	 <FSET ,PRSO ,TOUCHBIT>
	 <FCLEAR ,PRSO ,NDESCBIT>
	 <FCLEAR ,PRSO ,WORNBIT>
	 <RTRUE>>

;"IDROP is called by PRE-GIVE and PRE-PUT.
  IDROP acts directly as PRE-DROP, PRE-THROW and PRE-PUT-THROUGH."

<ROUTINE IDROP ()
	 <COND (<PRSO? ,INTNUM>
		<SETG CLOCK-WAIT T>
		<RFATAL>)	       	       	       	       
	       (<PRSO? ,HANDS>
		<COND (<VERB? DROP THROW GIVE>
		       <IMPOSSIBLES>)
		      (T
		       <RFALSE>)>)
	       (<IN? ,PRSO ,GLOBAL-OBJECTS>
		<TELL
"Don't lose your head, now! You can't do that!" CR>)
	       (<NOT <HELD? ,PRSO>>
		<TELL
"That's easy for you to say since you don't even have" TR ,PRSO>)
	       (<AND <NOT <IN? ,PRSO ,PROTAGONIST>>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "Impossible because" T <LOC ,PRSO> " is closed." CR>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL "You'll have to remove ">
		<COND (<FSET? ,PRSO ,PLURALBIT>
		       <TELL "them">)
		      (T
		       <TELL "that">)>
		<TELL " first." CR>)
	       (T
		<RFALSE>)>>	       	       
	       
<ROUTINE CCOUNT	(OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"Gets SIZE of supplied object, recursing to nth level."

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <EQUAL? .OBJ ,PROTAGONIST>
				    <FSET? .CONT ,WORNBIT>>
			       <SET WT <+ .WT 1>>) ;"worn things don't count"
			      (<AND <EQUAL? .OBJ ,PROTAGONIST>
				    <FSET? <LOC .CONT> ,WORNBIT>>
			       <SET WT <+ .WT 1>>)
			              ;"things in worn things shouldn't count"
			      (<EQUAL? .OBJ ,PROTAGONIST>
			       <SET WT <+ .WT 1>>)
			      (T
			       <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

;"subtitle movement and death"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 2>
<CONSTANT NEXIT 3>
<CONSTANT FEXIT 4>
<CONSTANT SEXIT 5>
<CONSTANT DEXIT 6>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT SEXITSTR 1>
<CONSTANT SEXITFLG 4>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 2>

<GLOBAL MOVE-FORCED <>>

<ROUTINE GOTO (NEW-LOC "OPTIONAL" (DESC? T) "AUX" OLD-HERE)
	 <COND (<NOT .DESC?> <SETG MOVE-FORCED T>)
	       (T <SETG MOVE-FORCED <>>)>
	 <FCLEAR ,COMP-N-DOOR ,OPENBIT>
	 <COND (<EQUAL? ,SCENARIO 2>
		<SETG CLOCK-MOVE
		      </ </ <* <GETP ,SHOES-WORN ,P?SPEED> 100>
			    ,HEALTH>
			 ,WARMTH>>
		<COND (<AND <FSET? .NEW-LOC ,VILLAGEBIT>
			    <FSET? ,HERE ,VILLAGEBIT>>
		       <SETG CLOCK-MOVE </ ,CLOCK-MOVE 4>>)
		      (<EQUAL? ,INSIDE-SHED .NEW-LOC ,HERE>
		       <SETG CLOCK-MOVE </ ,CLOCK-MOVE 4>>)
		      (<OR <FSET? .NEW-LOC ,VILLAGEBIT>
			   <FSET? ,HERE ,VILLAGEBIT>>
		       <SETG CLOCK-MOVE </ ,CLOCK-MOVE 2>>)
		      (<AND <FSET? .NEW-LOC ,GVIEWBIT>
			    <FSET? ,HERE ,GVIEWBIT>>
		       <COND (<OR <EQUAL? ,PRSO ,P?NORTH ,P?SOUTH>
				  <EQUAL? ,PRSO ,P?UP ,P?DOWN>>
			      <SETG CLOCK-MOVE </ ,CLOCK-MOVE 3>>)>)>)
	       (<EQUAL? ,SCENARIO 1>
		<COND (<FSET? ,HERE ,PLATFORMBIT>
		       <SETG CLOCK-MOVE 25>)
		      (T
		       <SETG CLOCK-MOVE 15>)>)
	       (T
		<SETG CLOCK-MOVE 29>
		<COND (<FSET? ,HERE ,HUTBIT>
		       <SETG CLOCK-MOVE 7>)
		      (<EQUAL? ,HERE ,FIRE-2 ,FIRE-3 ,FIRE-4>
		       <SETG CLOCK-MOVE 9>)>
		<COND (,TOPAZ-FIGHT
		       <SETG CLOCK-MOVE </ <* ,CLOCK-MOVE 2> 3>>)>)>
	 ;<COND (,DEBUG <TELL "[CLOCK-MOVE = " N ,CLOCK-MOVE "]" CR>)>
	 <COND (<AND <EQUAL? ,SCENARIO 3>
		     <BACKTRACK? .NEW-LOC>>
		<RTRUE>)>
	 <SET OLD-HERE ,HERE>
	 <MOVE ,PROTAGONIST .NEW-LOC>
	 <COND (<IN? .NEW-LOC ,ROOMS>
		<SETG HERE .NEW-LOC>)
	       (T
		<SETG HERE <LOC .NEW-LOC>>)>
	 ;<SETG LIT <LIT? ,HERE>>
	 <APPLY <GET ,SCENARIO-TBL ,SCENARIO> ,M-ENTER .OLD-HERE>
	 <COND (<NOT <EQUAL? ,HERE .NEW-LOC>> <RTRUE>)>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<NOT <EQUAL? ,HERE .NEW-LOC>> <RTRUE>)>
	 <COND (<AND .DESC?
		     <NOT ,DONT-DESCRIBE-ROOM>>
		<DESCRIBE-ROOM>)>
	 <SETG DONT-DESCRIBE-ROOM <>>
	 <COND (<AND <NOT <EQUAL? ,VERBOSITY 0>>
		     <OR <EQUAL? ,SCENARIO 2 3 ;"3 JUST ADDED"> .DESC?>>
		<DESCRIBE-OBJECTS>)>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER-DESC>
	 <COND (<OR ,G-WATCH ,SL-WATCH>
		<UPDATE-CHRONOGRAPH 0 T>)>
	 <RTRUE>>

<ROUTINE BACKTRACK? (NEW-LOC "AUX" (TOO-LATE? <>))
	 <COND (<AND <IN? ,TOPAZ .NEW-LOC>
		     ;<OR * <BACKTRACKING? ,HERE>>
		     ,CHASE-FLAG
		     <NOT ,TOPAZ-FIGHT>>
		<COND (.TOO-LATE?
		       <TELL
"Seeing that this has put you closer to Topaz, you hastily retreat to
your last position.">)
		      (T
		       <TELL
"You decide not to go in that direction - it would put you in
Topaz's hands.">)>
		<TOPAZ-THOUGHT>
		<CRLF>
		<RTRUE>)>>

<GLOBAL DONT-DESCRIBE-ROOM <>>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (CONTIN <>)
		       "AUX" (FLG <>) (L <LOC ,EXPLODING-PEN>))
	 <TELL .DESC>
	 <COND (<AND <G? ,FUSE-ARMED 0>
		     <L? <SET DESC <- <GET ,CLOCK-TBL ,I-FUSE-OFF>
				      ,CLOCK-TIME>> 120>
		     <G? .DESC 0>>
		<SETG CHRONOGRAPH-TIME ,FUSE-ARMED>
		<COND (<AND <L? .DESC 180>
			    <IN? .L ,ROOMS>
			    <IN? ,HUT-MAN ,HERE>>
		       <COND (<EQUAL? .L ,HERE>
			      <TELL CR CR
"Just when you think that things couldn't get worse, they do. As
you await the arrival of the border guards, the pen explodes,
seriously wounding both you and your captor. The end result is the
same, however.">)
			     (<AND <FSET? .L ,HUTBIT>
				   <FSET? ,HERE ,HUTBIT>>
			      <TELL CR CR
"A short while later, the pen explodes, turning the hut into an inferno.
Unfortunately, the owner keeps his wits about him, and hustles you out of the
hut to await the authorities." CR>)>)
		      (<AND <L? .DESC 30>
			    <BOMB-IN-TOWER?>
			    <EQUAL? ,HERE
				    ,TOWER-SOUTH
				    ,LADDER-TOP>>
		       <SET FLG T>
		       <TELL CR CR
"As you are taken down the ladder, the bomb explodes, sending you and
the guards tumbling to earth. In the confusion, you try to escape, but you
are quickly recaptured.">)
		      (<AND <FSET? ,HERE ,GVIEWBIT>
			    <BOMB-IN-TOWER?>>
		       <SET FLG T>
		       <TELL CR CR
"As you are taken away, the bomb explodes, and the tower
collapses.">)>
		<COND (<AND .FLG
			    <EQUAL? <LOC ,EXPLODING-PEN> ,NE-POST ,NW-POST>>
		       <TELL " Ironically, the northernmost part
of the tower falls onto and over the border fence, landing at the place
where you had been hoping to arrive.">)>
		<HLIGHT 0>
		<UPDATE-CHRONOGRAPH 0>)>
	 <COND (<EQUAL? ,SCENARIO 2>
		<TELL CR CR
"****  You have been arrested  ****" CR>)>
	 <HLIGHT ,H-NORMAL>
	 <STATUS-LINE>
	 <FINISH .CONTIN>
	 ;<COND (<NOT ,DEBUG> <FINISH .CONTIN>)>
	 ;<TELL
"|
...continuing...|
">
	 <RTRUE>>

<ROUTINE BOMB-IN-TOWER? ("AUX" (L <LOC ,EXPLODING-PEN>))
	 <COND (<OR <EQUAL? .L ,NE-POST ,NW-POST ,TOWER-SOUTH>
		    <EQUAL? .L ,LADDER-TOP ,SE-POST>
		    <EQUAL? .L ,SW-POST>>
		<RTRUE>)>>

;"subtitle useful utility routines"

<ROUTINE ACCESSIBLE? (OBJ "AUX" L) ;"can player TOUCH object?"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       ;(<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)	       
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" L) ;"can player SEE object"	 
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TEE) ;"finds room on others side of door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T
			<SET TEE <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TEE> ,DEXIT>
				    <EQUAL? <GETB .TEE ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE ULTIMATELY-IN? (OBJ "OPTIONAL" (WHR <>))
	 <COND (<NOT .WHR> <SET WHR ,PROTAGONIST>)>
	 <HELD? .OBJ .WHR>>

<ROUTINE HELD? (OBJ "OPTIONAL" (CONT <>))
	 <COND (<NOT .CONT>
		<SET CONT ,WINNER>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ .CONT>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       (<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<HELD? <LOC .OBJ> .CONT>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND .OBJ
	      <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<SET TEE <GETPT .OBJ2 ,P?GLOBAL>>
		<INTBL? .OBJ1 .TEE </ <PTSIZE .TEE> 2>>)>>

<ROUTINE FIND-IN (WHERE FLAG-IN-QUESTION "OPTIONAL" (STRING <>) "AUX" OBJ)
	 <SET OBJ <FIRST? .WHERE>>
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .OBJ .FLAG-IN-QUESTION>
			     <NOT <FSET? .OBJ ,INVISIBLE>>>
			<COND (.STRING
			       <TELL "(" .STRING T .OBJ ")" CR>)>
			<RETURN .OBJ>)
		       (<NOT <SET OBJ <NEXT? .OBJ>>>
			<RETURN <>>)>>>

<ROUTINE DIRECTION? (OBJ)
	 <COND (<OR <EQUAL? .OBJ ,P?NORTH ,P?SOUTH ,P?EAST>
		    <EQUAL? .OBJ ,P?WEST ,P?NE ,P?NW>
		    <EQUAL? .OBJ ,P?SE ,P?SW>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOC-CLOSED ()
	 <COND (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>
		     <FSET? ,PRSO ,TAKEBIT>>
		<TELL "But" T <LOC ,PRSO> " is closed!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE STOP ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR THE ,PRSO <PICK-ONE ,HO-HUM> CR>>

<GLOBAL HO-HUM
	<LTABLE
	 0 
	 " won't help you."
	 " is useless, or worse."
	 " can have no desirable effect.">>		 

<GLOBAL YUKS
	<LTABLE
	 0 
	 "What a concept!"
         "That's ridiculous!"
	 "Not a chance!">>

<ROUTINE IMPOSSIBLES ()
	 <TELL <PICK-ONE ,IMPOSSIBLE-LIST> CR>>	 

<GLOBAL IMPOSSIBLE-LIST
	<LTABLE
	 0 
	 "Don't even consider it!"
	 "The strain is showing!"
	 "That's impossible!"
	 "Try to think more rationally!">>

<ROUTINE WASTES ()
	 <TELL <PICK-ONE ,WASTE-LIST> CR>>

<GLOBAL WASTE-LIST
	<LTABLE 0
"That's a waste of time, and you haven't much left."
"Stop wasting time."
"There's another few seconds down the drain.">>

<ROUTINE V-WATCH () <PERFORM ,V?EXAMINE ,PRSO> <RTRUE>>

<ROUTINE V-SHOOT-FLIP ()
	 <PERFORM ,V?SHOOT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHOOT ()
	 <COND (<OR <EQUAL? <GET ,P-OFW 0> ,W?PHOTO ,W?PHOTOGRAPH ,W?PICTURE>
		    <AND <EQUAL? ,SCENARIO 1>
			 <IN? ,CAMERA ,WINNER>>>
		<PERFORM ,V?PHOTOGRAPH ,PRSO>
		<RTRUE>)>
	 <COND (<FSET? ,PRSO ,PERSON>
		<TELL "That wouldn't help." CR>)
	       (T <TELL "You can't shoot that." CR>)>>

<ROUTINE V-OIL ()
	 <TELL "There's nothing to be gained by oiling that." CR>>

<ROUTINE V-TAKE-WITH ()
	 <TELL "You don't need to take it with that." CR>>

<ROUTINE V-LOAD ()
	 <TELL "You can't load that." CR>>

<ROUTINE V-SLOAD ()
	 <PERFORM ,V?LOAD ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-REPLACE ()
	 <COND (<AND <NOT ,PRSI>
		     <EQUAL? ,PRSO ,PEN-CAP>>
		<PERFORM ,V?PUT-ON ,PEN-CAP ,EXPLODING-PEN>
		<RTRUE>)
	       (T
		<TELL
"You'll have to say what to put the " D ,PRSO " in." CR>)>>

<ROUTINE V-PHOTOGRAPH ()
	 <COND (<AND ,PRSI <NOT <EQUAL? ,PRSI ,CAMERA>>>
		<TELL
"You're not much of a photographer, if you think you can take pictures with
a " D ,PRSI "." CR>)
	       (<AND <NOT ,PRSI> <NOT <IN? ,CAMERA ,WINNER>>>
		<TELL
"Perhaps you're thinking of a mental picture, since you won't get any
other without a camera." CR>)
	       (<AND <EQUAL? ,PRSO ,CAMERA>
		     <NOT <EQUAL? ,HERE ,LAVATORY>>>
		<TELL
"Too bad you haven't got a mirror." CR>)
	       (<OR <EQUAL? ,PRSO ,BODY-PARTS ,LEFT-ARM ,RIGHT-ARM>
		    <EQUAL? ,PRSO ,PICTURE>>
		<TELL "That would be a good trick." CR>)
	       (<AND <ULTIMATELY-IN? ,PRSO ,WINNER>
		     <NOT <EQUAL? ,PRSO ,CAMERA>>>
		<TELL
"You'll have to put it down if you're going to take a picture of it." CR>)
	       (<EQUAL? ,PRSO ,ME>
		<TELL
"You have more than enough of these already." CR>)
	       (<EQUAL? <LOC ,PRSO> ,TOWEL-DISPENSER ,TOILET-KIT ,BRIEFCASE>
		<TELL
"You might take it out of the " D <LOC ,PRSO> " first." CR>)
	       (<FSET? ,HERE ,PLATFORMBIT>
		<TELL
"A guard approaches you, waving his arms, and saying \"Nye mneshna
fotomattni!\"" CR>)
	       (T
		<TAKE-A-PICTURE>
		<RTRUE>)>>

<ROUTINE V-REWIND ()
	 <TELL "That is quite a concept." CR>>

<ROUTINE V-CROSS ()
	 <TELL
"You'll have to indicate which direction you intend to go." CR>>

<ROUTINE V-FOLD ()
	 <TELL "There's no use in folding that." CR>>

<ROUTINE V-UNFOLD ()
	 <TELL "It's not folded up." CR>>

<ROUTINE V-SURRENDER ()
	 <COND (<EQUAL? ,SCENARIO 2>
		<JIGS-UP
"You walk to the border station, waving your bloody shirt like a
white flag, until the guards come and take you away.">)
	       (T
		<TELL
"To whom? Why?" CR>)>> 

<ROUTINE V-DISPOSE ()
	 <COND (<AND <EQUAL? ,HERE ,COMP-5>
		     <FSET? ,COMP-WINDOW ,OPENBIT>
		     <IN? ,PRSO ,WINNER>>
		<PERFORM ,V?PUT-THROUGH ,PRSO ,COMP-WINDOW>
		<RTRUE>)
	       (<FSET? ,PRSO ,PERSON>
	        <TELL
"That's something you'll have to do on your own." CR>)
	       (T
		<TELL
"You'll have to be more explicit about how you want to throw it out." CR>)>> 

<ROUTINE V-WET ()
	 <PERFORM ,V?PUT ,PRSO ,GLOBAL-WATER>
	 <RTRUE>>

<ROUTINE V-BRIBE ()
	 <TELL "You can't bribe " THE ,PRSO ,PERIOD-CR>>

<ROUTINE V-TOPPLE ()
	 <PERFORM ,V?KILL ,PRSO>>

<ROUTINE V-STRANGLE ()
	 <TELL "Why on earth do that?" CR>>

<ROUTINE V-HINTS-OFF ()
	 <TELL "[Hints are now disabled for this session.]" CR>
	 <SETG HINTS-OFF T>>

<ROUTINE V-HIT ()
	 <PERFORM ,V?KILL ,PRSO ,PRSI>
	 <RTRUE>>

<ROUTINE V-STACK ()
	 <TELL "You're wasting time." CR>>

;<ROUTINE V-$CLOCK ()
	 <COND (,VERBOSE-CLOCK <SETG VERBOSE-CLOCK <>>)
	       (T <SETG VERBOSE-CLOCK T>)>
	 <RTRUE>>

;<ROUTINE V-$SUSPICION ()
	 <COND (<NOT ,PRSO>)
	       (<EQUAL? ,PRSO ,INTNUM>
		<SETG SUSPICION ,P-NUMBER>)>
	 <TELL "[Suspicion: " N ,SUSPICION "]" CR>>

;<ROUTINE V-$CONTACT ()
	 <TELL D ,CONTACT CR>>

<ROUTINE FLUSH-BAD-SCENARIO (SC "AUX" F N)
	 <SET F <FIRST? ,PROTAGONIST>>
	 <REPEAT ()
		 <COND (<ZERO? .F> <RETURN>)
		       (T
			<SET N <NEXT? .F>>
			<COND (<AND <GETP .F ,P?SCENARIO>
				    <NOT <EQUAL? <GETP .F ,P?SCENARIO> .SC>>>
			       ;<TELL CR "[Flushing " D .F "]">
			       <REMOVE .F>)>
			<SET F .N>)>>
	 ;<TELL CR "[Chapter Flushed/ RETURN to continue]" CR>
	 ;<INPUT 1>>

<ROUTINE V-SLOW-TIME ()
	 <SETG READ-CLOCK 30>
	 <SETG CLOCK-MOVE 0>
	 <TELL "Slow time." CR>>

<ROUTINE V-FAST-TIME ()
	 <SETG READ-CLOCK 10>
	 <SETG CLOCK-MOVE 0>
	 <TELL "Fast (real) time." CR>>

;<ROUTINE V-$WATCH ()
	 <TELL "WATCH debugging ">
	 <COND (,SL-DEBUG
		<SETG SL-DEBUG <>>
		<TELL "off">)
	       (T
		<SETG SL-DEBUG T>
		<TELL "on">)>
	 <TELL ,PERIOD-CR>>

<ROUTINE V-PULL ()
	 <TELL "It's not clear what you're driving at." CR>>