
"HINTS for
			       BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<GLOBAL LAST-HINT 0>
<GLOBAL LAST-Q 0>

<GLOBAL HINT-WARNING <>>

<GLOBAL HINTS-OFF <>>

<ROUTINE V-HINT ("AUX" CURQ CURL CHR MAXQ MAXL (Q <>))
         <COND (,HINTS-OFF
		<TELL
"[Hints have been disallowed for this session.]" CR>
		<RTRUE>)
	       (<NOT ,HINT-WARNING>
		<SETG HINT-WARNING T>
		<TELL "[Warning: It is recognized that the temptation
for help may at times be so exceedingly strong that you might fetch
hints prematurely. Therefore, you may at any time during the story type
HINTS OFF, and this will disallow the seeking out of help for the
present session of the story. If you still want a hint now, indicate
HINT.]" CR>
		<RTRUE>)>
	 <COND (<EQUAL? ,SCENARIO 2>
		<SETG HINT-TBL ,HINT-TBL-2>)
	       (<EQUAL? ,SCENARIO 1>
		<SETG HINT-TBL ,HINT-TBL-1>)
	       (T
		<SETG HINT-TBL ,HINT-TBL-3>)>
	 <SET MAXQ <GET ,HINT-TBL 0>>
	 <INIT-HINT-SCREEN>
	 <CURSET 4 1>
	 <SET MAXL <PUT-UP-QUESTIONS 1>>
	 <SET CURQ 1>
	 <SET CURL 5>
	 <COND (<G? ,LAST-HINT 0>
		<SET CURL ,LAST-HINT>)>
	 <COND (<G? ,LAST-Q 0>
		<SET CURQ ,LAST-Q>)>
	 <CURSET .CURL 2>
	 <PRINTI "->">
	 <REPEAT ()
		 <SET CHR <INPUT 1>>
		 <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
			<SETG LAST-HINT .CURL>
			<SETG LAST-Q .CURQ>
			<SET Q T>
			<RETURN>)
		       (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n>>
			<COND (<EQUAL? .CURQ .MAXQ> T)
			      (T
			       <CURSET .CURL 2>
			       <PRINTI "  ">
			       <SET CURL <+ .CURL 1>>
			       <SET CURQ <+ .CURQ 1>>
			       <CURSET .CURL 2>
			       <PRINTI "->">)>)
		       (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p>>
			<COND (<EQUAL? .CURQ 1> T)
			      (T
			       <CURSET .CURL 2>
			       <PRINTI "  ">
			       <SET CURL <- .CURL 1>>
			       <SET CURQ <- .CURQ 1>>
			       <CURSET .CURL 2>
			       <PRINTI "->">)>)
		       (<EQUAL? .CHR 13 10>
			<SETG LAST-HINT .CURL>
			<SETG LAST-Q .CURQ>
			<DISPLAY-HINT .CURQ>
			<RETURN>)>>
	 <COND (<NOT .Q> <AGAIN>)>
	 <SPLIT 0>
	 <CLEAR -1>
	 <BUFOUT T>
	 <V-$ISL>
	 <TELL "Back to the game..." CR>>

<ROUTINE DISPLAY-HINT (N "AUX" H MX (CNT ,HINT-HINTS) CHR (FLG T))
	 <SPLIT 0>
	 <CLEAR -1>
         <SPLIT 3>
	 <SCREEN ,S-WINDOW>
	 <CURSET 1 1>
	 <INVERSE-LINE>
	 <CENTER-LINE 1 "INVISICLUES (TM)" %<LENGTH "INVISICLUES (TM)">>
	 <CURSET 3 1>
	 <INVERSE-LINE>
	 <LEFT-LINE 3 " RETURN for hint">
	 <RIGHT-LINE 3 "Q to go back"
		     %<LENGTH "Q to go back">>
	 <HLIGHT ,H-BOLD>
	 <CENTER-LINE 2 <GET <SET H <GET ,HINT-TBL .N>> ,HINT-QUESTION>>
	 <HLIGHT ,H-NORMAL>
	 <SET MX <GET .H 0>>
	 <SCREEN ,S-TEXT>
	 <BUFOUT T>
	 <CRLF>
	 <REPEAT ()
		 <COND (<EQUAL? .CNT <GET .H ,HINT-SEEN>>
			<RETURN>)
		       (T
			<TELL <GET .H .CNT> CR CR>
			<SET CNT <+ .CNT 1>>)>>
	 <REPEAT ()
		 <COND (<AND .FLG <G? .CNT .MX>>
			<SET FLG <>>
			<TELL "[That's all folks!]" CR>)
		       (.FLG
			<TELL "Hint (">
			<COND (<0? <- .MX .CNT>>
			       <TELL "last">)
			      (T
			       <TELL N <- .MX .CNT> " left">)>
			<TELL ") -> ">
			<SET FLG <>>)>
		 <SET CHR <INPUT 1>>
		 <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
			<PUT .H ,HINT-SEEN .CNT>
			<RETURN>)
		       (<EQUAL? .CHR 13 10>
			<COND (<G? .CNT .MX>
			       T)
			      (T
			       <SET FLG T>
			       <TELL <GET .H .CNT> CR CR>
			       <SET CNT <+ .CNT 1>>
			       <COND (<G? .CNT .MX>
				      <SET FLG <>>
				      <TELL
"[That's all folks!]" CR>)>)>)>>
	 <BUFOUT <>>
	 T>

<ROUTINE PUT-UP-QUESTIONS (ST "AUX" MXQ MXL LN)
	 <SET MXQ <GET ,HINT-TBL 0>>
	 <SET MXL <GETB 0 32>>
	 <SET LN 6>
	 <REPEAT ()
		 <SET LN <+ .LN 1>>
		 <COND (<G? .ST .MXQ>
			<CURSET <- .LN 2> 1>
			<TELL "[Last question]">
			<RETURN .MXQ>)
		       ;(<G? .LN .MXL>
			<TELL CR "[More questions follow]" CR>
			<RETURN <- .ST 1>>)
		       (T
			<CURSET <- .LN 2> 1>
			<TELL "    "
			      <GET <GET ,HINT-TBL .ST> ,HINT-QUESTION>>)>
		 <SET ST <+ .ST 1>>>>

<ROUTINE INIT-HINT-SCREEN ("AUX" WID LEN)
	 <SET WID <GETB 0 33>>
	 <SPLIT 0>
	 <CLEAR -1>
	 <SPLIT <- <GETB 0 32> 1>>
	 <SCREEN ,S-WINDOW>
	 <BUFOUT <>>
	 <CURSET 1 1>
	 <INVERSE-LINE>
	 <CURSET 2 1>
	 <INVERSE-LINE>
	 <CURSET 3 1>
	 <INVERSE-LINE>
	 <CENTER-LINE 1 "INVISICLUES (TM)" 16>
	 <LEFT-LINE 2 " N for Next hint">
	 <RIGHT-LINE 2 "P for Previous hint" %<LENGTH "P for Previous hint">>
	 <LEFT-LINE 3 " RETURN to see hint">
	 <RIGHT-LINE 3 "Q to return to game" %<LENGTH "Q to return to game">>>

<CONSTANT HINT-COUNT 0>
<CONSTANT HINT-QUESTION 1>
<CONSTANT HINT-SEEN 2>
<CONSTANT HINT-OFF 3>
<CONSTANT HINT-HINTS 4>

<DEFINE NEW-HINT (NAME Q "ARGS" HINTS)
	;<SETG .NAME 1>
	<COND (<G? <LENGTH .Q> 35>
	       <ERROR QUESTION-TOO-LONG!-ERRORS NEW-HINT .Q>)>
	<LTABLE .Q
		4
		0 ;.NAME
		!.HINTS>>

<GLOBAL HINT-TBL <>>

<GLOBAL HINT-TBL-1
   <PLTABLE
      <NEW-HINT H-ANSWER
		 "How do I answer the man?"
		 "It is possible to answer either way, although you must be careful."
		 "If he thinks you are lying, it will raise his level of suspicion, regardless of what you said."
		 "Also, the admission that you have seen the American agent is enough to generate a little suspicion.">
      <NEW-HINT H-BLOOD
		 "Why doesn't he believe my answer?"
		 "Is there any reason the man might KNOW that you've seen
the American agent?"
		 "Might the agent have left something behind, besides the document and the carnation?"
		 "Wasn't he holding his left arm? Mightn't it have been wounded?"
		 "LOOK AT THE FLOOR to see the blood that he's left here. It's a dead giveaway, no pun intended. It would be best to clean up after him."
		 "In the lavatory, across the hall and to the south, there is a towel. Get it, wet it, then use it to clean up the blood."
		 "Also, answering in a way that contradicts the evidence (i.e. the bloodiness of the floor), adds suspicion.">
      <NEW-HINT H-SUSPICIOUS
		 "Why am I searched so thoroughly?"
		 "For one reason, there's an important document missing."
		 "For another, they know the American agent had it."
		 "You are American, therefore somewhat suspicious."
		 "If you're wearing that crushed carnation, you might look peculiar to them."
		 "Depending on how you handled your 'interview' with the trench coated man, you might have appeared suspicious."
		 "Also, if you have been seen outside of your compartment holding any unusual items - a carnation, a briefcase, etc...">
      <NEW-HINT H-FOLLOW
		 "Why am I followed at the station?"
		 "Clearly, you are under suspicion."
		 "There are a number of things you may have done to make the situation worse. See the previous two questions. Also, if the guards found anything peculiar in their search of your possessions, that would increase their suspicions.">
      <NEW-HINT H-DOCUMENT
		 "How can I deliver the document?"
		 "You'll have to make sure the guards don't find it."
		 "Have you tried hiding it...?"
		 "...in your compartment?"
		 "...in the lavatory?"
		 "...in your camera?"
		 "Oh, you have? Then, you should be aware that you CANNOT deliver the document."
		 "However, you can deliver its contents."
		 "Your camera can be used for more than tourist shots."
		 "PHOTOGRAPH the document."
		 "You must be clever to avoid the guards destroying your film during the search."
		 "Try rewinding the roll that's in there, and loading the camera with the exposed roll. That will divert suspicion.">
      <NEW-HINT H-CONTACT
		 "Who is my contact?"
		 "It depends on what the American agent said at the very beginning."
		 "Check your Frobnian phrase book (in your Border Zone package) for the translation of the phrase that your contact was supposed to repeat. Be careful; the exact words must be used."
		 "When your contact appears, you must SAY \"It is my fault\" in Frobnian. Check your phrase book for the translation."
		 "Then, GIVE THE COLOR ROLL TO THE CONTACT. Alternatively, you can DROP THE COLOR FILM; this latter method is less obvious, in case you are followed. Depending on how much suspicion you have raised, you may be able to do either, both, or none of these two things.">
      <NEW-HINT H-EVER1
		"Have you ever tried...?"
		"[Please don't read further until you have successfully completed this chapter.]"
		"...dropping things in the passageway?"
		"...entering other compartments (they're all different!)"
		"...photographing things at the train platform?"
		"...photographing the bad spy? yourself? the camera?"
		"...pulling the stop cord on the train?"
		"...jumping out the window in your compartment?"
		"...giving the document (or shreds) to the bad spy?"
		"...reading the graffiti in the bathroom?"
		"...putting things in the sink?"
		"...flushing things down the toilet?"
		"...trying to hide the document every place you can think of?"
		"...taking a gun from one of the guards?">
>>

<GLOBAL HINT-TBL-2
   <PLTABLE
      <NEW-HINT H-BLEEDING
		 "How do I stop myself from bleeding?"
		 "Have you tried using a tourniquet?"
		 "Is there any cloth or fabric you can use?"
		 "RIP your CLOTHES."
		 "Then, TIE THE PIECE OF CLOTHING AROUND LEFT ARM.">
      <NEW-HINT H-WARMTH
		 "How can I get warm?"
		 "Have you found any shelter?"
		 "Go east and north from your starting point."
		 "You'll have to get into the hut."
		 "There's a very nice parka inside."
		 "See the question \"How do I get into the hut?\"">
      <NEW-HINT H-DOGS
		 "How can I keep away from the dogs?"
		 "Can you find food to distract them?"
		 "Didn't think so."
		 "Can you hide your tracks?"
		 "Guess not."
		 "Can you confuse their senses?"
		 "How about a place where you don't leave tracks..."
		 "... and don't worry much about odors."
		 "Have you been at the swamp?"
		 "Make sure that you ENTER THE SWAMP; then move somewhere else along the edge, so they'll lose the trail."
		 "Oh, I hope you weren't wearing any of your nice shoes.">
      <NEW-HINT H-CAR
		 "What about the automobile I hear?"
		 "Have you observed it from up close?"
		 "If you get in it's way, you'll be caught."
		 "There's a good spot where you can observe the car."
		 "Like the north side of the hut."
		 "Basically, three enemy guards are in the car."
		 "They come to warn the man in the hut that you are an escaped lunatic."
		 "Who else would be walking around, wounded and cold, in the middle of nowhere?">
      <NEW-HINT H-HUT
		 "How can I get into the hut?"
		 "Have you tried the front and back doors?"
		 "Well, it works better if nobody's inside."
		 "You can get in when the occupant is talking to the men from the car. [See the hint about the car if this is meaningless...]"
		 "Also, the occupant will leave at some point to get more wood from the shed."
		 "Also, there's another way, but that's for you to figure out...">
      <NEW-HINT H-SCOUT
		 "How can I get out of the hut?"
		 "If the owner hasn't returned and there's no scout prowling around, it's no problem."
		 "The scout will be gone when the car leaves (you'll hear it)."
		 "But now, the owner's returned as well. The squeaky door alerts him to your presence."
		 "Take the oil can, then OIL THE HINGES."
		 "Now you can leave - just don't come back!">
      <NEW-HINT H-BOMB
		 "How do I use the explosive?"
		 "Better might be \"Where...?\""
		 "To use the explosive, REMOVE the CAP, PUSH the BUTTON once for every minute you want the fuse to run, and REPLACE the CAP."
		 "Oh... you won't want to be there when it goes off."
		 "Try placing it in different places to see what happens; remember it's magnetic so you can PUT it ON metallic objects."
		 "You don't really need this until you've gotten as far as the border fences."
		 "See \"How can I cross the border?\" for details.">
      <NEW-HINT H-SL
		 "How can I avoid the searchlights?"
		 "If you are not WATCHing them, you should."
		 "The status line will show you the current positions of the lights."
		 "You should plan to head NORTH when the three lights are all aimed away from you."
		 "Make sure you understand where YOU are in relation to the three lights; the right times to cross differ depending on your position."
		 "To cross successfully, you must be in good physical condition."
		 "That means warm and not bleeding."
		 "You should also be wearing proper shoes."
		 "For example, the WORK SHOES in the hut.">
      <NEW-HINT H-FENCE
		 "How can I cross the first fence?"
		 "It's electrified, so you'd best not touch it."
		 "Also, you'll need something to break the chain links."
		 "You could use something insulating on your hands."
		 "Perhaps RUBBER GLOVES, from the woodshed."
		 "You'll also need the BOLT CUTTERS, also found in the woodshed."
		 "You'll have to LOOK AT THE TOOLS to find the gloves and the bolt cutters."
		 "Try CUTting the LINKS WITH THE BOLT CUTTERS."
		 "Oh, yeah. If you want to get through the fence, you'll have to BEND (or PULL) it back, otherwise you'll get zapped going through.">
      <NEW-HINT H-GAS
		 "How can I survive the tear gas?"
		 "Did you don your gas mask?"
		 "And why not?"
		 "Oh, you don't have one."
		 "Perhaps you're playing the wrong game?"
		 "Or cheating?"
		 "Either way, it doesn't reflect well on you.">
      <NEW-HINT H-GUARDS
		 "How can I avoid the border guards?"
		 "Both are moving, so you should WATCH them."
		 "When they are facing away from you, you have some freedom of action."
		 "Unless you're in front of the middle tower, you are ALWAYS in view of one of the guards."
		 "The quieter you are, the better."
		 "The farther away they are, the better."
		 "The less you hang around there, the better.">
      <NEW-HINT H-BORDER
		 "How do I get past the second fence?"
		 "There's no way."
		 "You can't."
		 "Really."
		 "No."
		 "!">
      <NEW-HINT H-CROSS
		 "How can I cross the border?"
		 "If you haven't gotten to the guard tower yet, don't read any further."
		 "How tall is the fence?"
		 "How tall is the tower?"
		 "It might be possible to \"ride\" the tower across the border."
		 "An explosive device would be useful in this regard."
		 "But where to put it?"
		 "The posts are fairly weak, but choose well."
		 "The northern posts will work. ATTACH THE PEN TO THE NE (NW) POST"
		 "Oh, first you should set the timer and arm the device."
		 "Then, you should get INTO the tower.">
      <NEW-HINT H-TOWER
		 "How do I get into the tower?"
		 "Did you try knocking on the door?"
		 "Well, that doesn't mean that you should be just standing there with a stupid look on your face..."
		 "Check out the brace; you can GET ON it."
		 "Then try KNOCKing on the DOOR."
		 "No, we're not pulling your leg.">
      <NEW-HINT H-CHASE
		 "The guards are coming after me!"
		 "Well, what did you expect?"
		 "You can't leave; you can't fight; or can you?"
		 "You'll have to somehow blow up the tower and yet stay in relative safety (no mean trick)."
		 "This hinges on where you've placed the explosive, how you've set the timer, and where you are when it goes off."
		 "See the question regarding \"How can I cross the border?\"">
      <NEW-HINT H-EVER2
		"Have you ever tried...?"
		"[Please don't read further until you have successfully completed this chapter.]"
		"...having the bomb explode in the car? Or in or adjacent to the hut? Or the shed?"
		"...going farther into the swamp?"
		"...knocking on the tower door for a second time?"
		"...using the binoculars? On something you're carrying?"
		"...climbing the hut?">
>>

<GLOBAL HINT-TBL-3
   <PLTABLE
      <NEW-HINT H-FIND-SNIPER
		 "Where is the sniper hiding?"
		 "Have you seen your contact, the antique dealer?"
		 "The antique shop is just west of the southwest corner of the square (i.e. south and west of your starting position)."
		 "Be careful; the police are sometimes inside, checking around. They know who you are, so you'd better not get seen."
		 "You'll have to find out yourself on which floor of the apartment building the sniper is hiding, but at least your contact had the password."
		 "Perhaps he is, in some way, visible from the street; the town square might be a good vantage point."
		 "From the town square, try LOOKing AT THE WINDOWS or BUILDINGS. There are three open windows in the apartment building; the sniper is in one of them."
		 "In the apartment building's lobby, there is a directory of residents; maybe there is some information there."
		 "There is only one vacant apartment with the window open. Guess who's in it?">
      <NEW-HINT H-TO-SNIPER
		 "How do I get TO the sniper?"
		 "You can try using the elevator in the apartment lobby."
		 "Or, have you been into the alley?"
		 "Down at the end is a fire-escape ladder."
		 "If you TAKE THE TRASH CAN, then PUT THE TRASH CAN UNDER THE LADDER, then STAND ON THE CAN, you can easily reach the ladder. Then, go up to the proper floor."
		 "Knock on the door, and have the password handy. If you don't give the password quickly, the sniper will ignore you for the remainder of the scenario.">
      <NEW-HINT H-PASSWORD
		 "How do I get the password?"
		 "You'll have to meet with your contact, the antique dealer. See the previous question.">
      <NEW-HINT H-DILEMMA
		 "Should I kill the sniper?"
		 "An interesting dilemma. If you kill the sniper, your cover is broken, due to suspicion regarding the gun used (yours) and the incident on the train, in which you lost the coded document. On the other hand, you stop the assassination. All in all, a mixed bag. You can do better.">
      <NEW-HINT H-SNIPER-KILLS
		 "Why does the sniper kill me?"
		 "A variety of reasons. First, anything you do that might cause him to think you're intent on defeating him will get you killed. Also, arriving at his door while you're being pursued is a definite killer.">
      <NEW-HINT H-TOPAZ
		 "How can I avoid Topaz?"
		 "Once he's seen you, he will doggedly pursue you for the remainder of your alloted time (i.e. until the assassination happens.)"
		 "He can be avoided by staying away from the cafe. The more you pass by there or spend time there, the more likely that he'll see you."
		 "Maybe you don't want to avoid him...">
      <NEW-HINT H-TOPAZ-HELP
		 "Can Topaz help me?"
		 "Firstly, his interest and yours are similar - preventing the assassination. In your case, however, you daren't risk exposing yourself to Topaz, firstly, for fear of being seen by other Soviet agents and, secondly,
for fear of being killed by Topaz, who has an axe to grind with you."
		 "Can you arrange for Topaz to kill the sniper?"
		 "Think about it..."
		 "Topaz will follow you anywhere, even to the sniper's room."
		 "If you can lead him there, you're home free. Almost.">
      <NEW-HINT H-CART
		 "Topaz always catches me. Why?"
		 "He's about the same speed as you, so you're usually fine. Unless you're in the alley, trying to get to the fire-escape ladder. That takes more time than you've got."
		 "Can you put a stumbling block in his way?"
		 "You can TOPPLE THE VENDOR'S CART and make an unholy mess; that will hold Topaz for a little while. After that, it's up to you.">
      <NEW-HINT H-BEST
		 "I can't get the best ending. Why?"   
		 "Presumably, you have found the sniper and know the password."
		 "Also, you know that Topaz can be made to kill the sniper for you."
		 "Meaning that Topaz must follow you up to the sniper's room. See the previous clue for help in this regard."
		 "Once you're in the sniper's room, Topaz will never find you in time unless you've helped him along."
		 "DROP something before giving the password; it's presence will alert Topaz to yours. Oh, and make it small or the sniper will find it instead."
		 "And HIDE or STAND BEHIND THE DOOR so that you won't get in Topaz's line of fire and get killed with the sniper."
		 "Then, HIT TOPAZ, and he'll never know what happened.">
      <NEW-HINT H-EVER3
		"Have you ever tried...?"
		"[Please don't read further until you have successfully completed this chapter.]"
		"...buying food from the vendor?"
		"...taking food after toppling the cart?"
		"...throwing things at Topaz as he chases you?"
		"...killing the sniper yourself? with Topaz's gun?"
		"...figuring out how many Infocom people live in the Gribnitz apartments?">
>>
		 
<ROUTINE CENTER-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	 <COND (<ZERO? .LEN>
		<DIROUT ,D-TABLE-ON ,DIROUT-TBL>
		<TELL .STR>
		<DIROUT ,D-TABLE-OFF>
		<SET LEN <GET ,DIROUT-TBL 0>>)>
	 <CURSET .LN </ <- <GETB 0 33> .LEN> 2>>
	 <COND (.INV <HLIGHT ,H-INVERSE>)>
	 <TELL .STR>
	 <COND (.INV <HLIGHT ,H-NORMAL>)>>

<ROUTINE LEFT-LINE (LN STR "OPTIONAL" (INV T))
	 <CURSET .LN 1>
	 <COND (.INV <HLIGHT ,H-INVERSE>)>
	 <TELL .STR>
	 <COND (.INV <HLIGHT ,H-NORMAL>)>>

<ROUTINE RIGHT-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	 <COND (<ZERO? .LEN>
		<DIROUT 3 ,DIROUT-TBL>
		<TELL .STR>
		<DIROUT -3>
		<SET LEN <GET ,DIROUT-TBL 0>>)>
	 <CURSET .LN <- <GETB 0 33> .LEN>>
	 <COND (.INV <HLIGHT ,H-INVERSE>)>
	 <TELL .STR>
	 <COND (.INV <HLIGHT ,H-NORMAL>)>>
	 
<GLOBAL DIROUT-TBL <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>>