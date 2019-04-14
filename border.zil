"BORDER for
			       BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROOM OUTF-1
      (LOC ROOMS)
      (DESC "Outside Fence")
      (PATH 0)
      (EAST TO OUTF-2 IF FALSE-FLAG ELSE
"You crawl along the ground until you reach a point directly south of the
next guard tower.")
      (WEST SORRY
"That would put you directly in front of the border station, and that
would be suicidal.")
      (SOUTH PER NOMANS-MOVE)
      (SE SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the forest to the south.")

      (SW SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the forest to the south.")

      (NORTH PER FENCE-CROSS)
      (NOMAN
<TABLE <TABLE 180 180 0 0> <TABLE 270 225 0 0> <TABLE 270 240 0 0> C2>)

      (ACROSS INF-1)
      (NS 1)
      (EW 3)
      (ACTION OUTF-F)
      (GPOS 0)
      (FLAGS GVIEWBIT SLVIEWBIT)
      (GLOBAL SEARCHLIGHTS FENCE FENCE-HOLE FENCE-SIGN TOWER GUARDS BORDER-FENCE)>

<ROUTINE OUTF-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are crouched at the base of the first fence. Behind you is the
hundred yards of no-man's-land you've crossed, searchlights dancing
across the snow-covered ground. Before you, not fifteen feet away, is
the base of the guard tower, and beyond that, another fence, the
last barrier to your freedom. Although you are relatively exposed,
the low snowdrifts provide reasonable cover from the guards." CR CR>
		<SETG P-WALK-DIR <>>
		<PERFORM ,V?EXAMINE ,FENCE>
		<COND (<NOT ,G-WATCH>
		       <CRLF>
		       ;<I-CLOCKER ,CLOCK-MOVE>
		       <PERFORM ,V?EXAMINE ,GUARDS>
		       ;<SETG CLOCK-MOVE 0>)>
		<RTRUE>)>>

<OBJECT CAR-GUARDS
	(LOC GLOBAL-OBJECTS)
	(DESC "men from the car")
	(SYNONYM MEN GUARDS)
	(FLAGS SEARCHBIT)
	(SCENARIO 2)
	(ACTION CAR-GUARDS-F)>

<ROUTINE CAR-GUARDS-F ()
	 <COND (<AND <IN? ,CAR ,ROAD-END>
		     <EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT ,ROAD-END>>
		<COND (<VERB? LISTEN EXAMINE WATCH>
		       <CAR-SEQ-TELL>
		       <RTRUE>)>)
	       (<AND <IN? ,CAR ,ROAD-END>
		     <EQUAL? ,HERE ,BEHIND-HUT ,HUT-LIVING>>
		<COND (<VERB? LISTEN EXAMINE WATCH>
		       <TELL
"You can't see the guards here, but you can faintly hear them talking." CR>)>)
	       (T
		<TELL
"There are no guards here, which is fortunate." CR>)>>

<OBJECT SCOUT
	(DESC "guard")>

<OBJECT GLOBAL-SCOUT
	(LOC GLOBAL-OBJECTS)
	(DESC "guard")
	(SYNONYM GUARD SCOUT)
	(ADJECTIVE LONE SINGLE)
	(SCENARIO 2)
	(ACTION GLOBAL-SCOUT-F)>

<ROUTINE GLOBAL-SCOUT-F ()
	 <COND (<NOT <LOC ,SCOUT>>
		<CANT-SEE ,GLOBAL-SCOUT>)
	       (<VERB? EXAMINE WATCH>
		<SCOUT-TELL <>>
		<RTRUE>)
	       (T
		<TELL ,TOO-FAR CR>)>> 

<ROUTINE SCOUT-TELL ("OPTIONAL" (LOOK? T) "AUX" (SS <>))
	 <COND (<NOT .SS> <SET SS " A">)>
	 <COND (<NOT .LOOK?> <SET SS "The">)>
	 <COND (<AND <EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT>
		     <IN? ,SCOUT ,OUTSIDE-HUT>>
		<TELL .SS
" scout is in front of the hut, walking slowly toward the north side." CR>)
	       (<AND <EQUAL? ,HERE ,BEHIND-HUT ,HUT-LIVING>
		     <IN? ,SCOUT ,NORTH-HUT>>
		<TELL .SS
" scout is slowly making his way toward the back side of the hut." CR>)
	       (<AND <EQUAL? ,HERE ,SOUTH-HUT>
		     <IN? ,SCOUT ,BEHIND-HUT>>
		<TELL .SS
" scout is coming around the back side of the hut, and heading toward the
south side." CR>)
	       (<AND <EQUAL? ,HERE ,ROAD-END>
		     <IN? ,SCOUT ,SOUTH-HUT>>
		<TELL .SS
" scout is rounding the south side of the hut and heading back toward
the group of guards at the front door." CR>)
	       (<NOT .LOOK?>
		<CANT-SEE ,SCOUT>)
	       (T
		<RFALSE>)>>

<OBJECT GUARDS
	(LOC LOCAL-GLOBALS)
	(DESC "guard")
	(SYNONYM GUARDS GUARD ;"Added 9/23" MEN)
	(ACTION GUARDS-F)>

<ROUTINE GUARDS-F ("AUX" MT (POS <GETP ,HERE ,P?GPOS>) DIR FACE? TMP) 
	 <COND (<AND <AT-NML?> <NOT <VERB? OFF-2>>>
		<COND (<VERB? EXAMINE WATCH>
		       <TELL
"You can't make them out too well from here; they keep moving in and out
of the searchlight's glare." CR>)
		      (<VERB? WAVE CALL YELL>
		       <TELL
"A suicidal idea, and you're pretty far away as well." CR>)
		      (T <TELL
"The guards are too far away." CR>)>)
	       (<AND <VERB? OFF-2>
		     <EQUAL? ,PRSO ,TIMING-OBJECT ,WATCHING-OBJECT>>
		<COND (<NOT ,G-WATCH>
		       <TELL "You weren't watching them." CR>
		       <RTRUE>)>
		<SETG G-WATCH <>>
		<SETG CLOCK-MOVE 4>
		<FLUSH-WATCHER>
		<COND (<NOT ,SAVE-FLAG>
		       <TELL
"You're no longer watching the guards." CR>)>
		<RTRUE>)
	       (<VERB? WATCH>
		<COND (,G-WATCH
		       <TELL "You're already watching them." CR>)
		      (T
		       <COND (,SL-WATCH
			      <PERFORM ,V?OFF-2
				       ,TIMING-OBJECT
				       ,SEARCHLIGHTS>
			      <CRLF>)>
		       <SETG G-WATCH T>
		       <SETG CHRONOGRAPH-ON T>
		       <SETG CLOCK-MOVE 4>
		       <GUARD-WATCHER T>
		       <TELL
"You start to watch the guards, and take a moment to check their position
after everything you do.|
|
[The asterisk is your position, the T's are the three guard towers, and the
< and > characters are the guards, indicating their direction of motion.]"
CR>)>)
	       (<VERB? EXAMINE>		
		<I-CLOCKER ,CLOCK-MOVE>
		<SETG CLOCK-MOVE 0>
		<COND (<ZERO? .POS> <SET DIR "right">)
		      (<EQUAL? .POS 180> <SET DIR "left">)>
		<SET MT <MOD ,CLOCK-TIME 180>>
		<COND (<NOT <L? .MT 90>> <SET MT <- 180 .MT>>)>
		<SET FACE? <GUARDS-FACING-EACH-OTHER?>>
		<TELL
"Two guards are now visible, patrolling the area between the fences; ">
		<COND (<EQUAL? .POS 90>
		       <SET TMP <* </ <- 100 .MT> 10> 10>>
		       <COND (<ZERO? .TMP> <SET TMP 5>)>
		       <TELL "both are about " N .TMP
			     " yards away, ">
		       <COND (<NOT ,GUARD-CHASE>
			      <TELL "and they are walking ">
			      <FACE-TELL .FACE? <>>)
			     (T
			      <TELL "moving carefully in your
direction, weapons drawn.">)>)
		      (T
		       <SET TMP <* </ <+ .MT 5> 10> 10>>
		       <COND (<ZERO? .TMP> <SET TMP 5>)>
		       <TELL "both are off to your " .DIR ", though
one is about " N  .TMP " yards away, and the other is much farther off.
The guards are moving ">
		       <FACE-TELL .FACE? <>>)>
		<COND (<NOT ,G-WATCH>
		       <TELL
" Since they are moving all the time, you would do
well to WATCH them.">)>
		<CRLF>)
	       (<VERB? CALL YELL WAVE>
		<TELL "Not very smart." CR>)
	       (T
		<TELL
"You can't get close enough to the guards, and it's just as well." CR>)>>
		      
<ROUTINE FLUSH-WATCHER ()
	 <SCREEN 1>
	 <BUFOUT <>>
	 <CURSET 2 1>
	 <INVERSE-LINE>
	 <CURSET 3 1>
	 <INVERSE-LINE>
	 <BUFOUT T>
	 <SCREEN 0>>

<ROUTINE FACE-TELL (FACE? "OPTIONAL" (CR? T))
	 <COND (.FACE? <TELL "toward">)
	       (T <TELL "away from">)>
	 <TELL " each other.">
	 <COND (.CR? <CRLF>)>
	 <RTRUE>>

<ROOM INF-1
      (LOC ROOMS)
      (NS 1)
      (EW 3)
      (PATH 0)
      (DESC "Inside Fence")
      (EAST TO INF-2 IF FALSE-FLAG ELSE
"You crawl along the ground until you reach a point directly south of the
next guard tower.")
      (WEST SORRY
"That would put you directly in front of the border station, and that
would be suicidal.")
      (NW SORRY
"That would put you directly in front of the border station, and that
would be suicidal.")
      (SOUTH PER FENCE-CROSS)
      (NE PER GUARD-MOVE-TWR)
      (NORTH PER GUARD-CATCH)
      (ACROSS OUTF-1)
      (ACTION INF-F)
      (GPOS 0)
      (FLAGS GVIEWBIT)
      (GLOBAL SEARCHLIGHTS FENCE FENCE-HOLE FENCE-SIGN TOWER GUARDS BORDER-FENCE)>

<ROUTINE INF-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You're just inside the fence. Fifteen feet before you is the base of
the guard tower, and beyond that the fence at the border itself. Behind
you, to the south, is the hundred yards of no-man's-land you've been
across. It is peaceful here, but the searchlights passing harmlessly
overhead remind you that you are in great danger. Fortunately, some small
snowdrifts give some protection from the guards, although you're
easily spotted once their suspicions are aroused. You'd best be very
careful if you're to avoid detection." CR>
		<COND (<NOT ,G-WATCH>
		       <CRLF>
		       ;<I-CLOCKER ,CLOCK-MOVE>
		       <SETG P-WALK-DIR <>>
		       <PERFORM ,V?EXAMINE ,GUARDS>
		       ;<SETG CLOCK-MOVE 0>)>
		<RTRUE>)>>

<ROUTINE FENCE-CROSS ()
	 <SETG P-WALK-DIR <>>
	 <PERFORM ,V?ENTER ,FENCE>
	 <RFALSE>>

<ROOM OUTF-2
      (LOC ROOMS)
      (DESC "Outside Fence")
      (NS 1)
      (EW 4)
      (PATH 0)
      (NORTH PER FENCE-CROSS)
      (EAST TO OUTF-3 IF FALSE-FLAG ELSE
"You crawl along the ground until you reach a point directly south of the
next guard tower.")
      (WEST TO OUTF-1 IF FALSE-FLAG ELSE
"You crawl along the ground until you reach a point directly south of the
next guard tower.")
      (SOUTH PER NOMANS-MOVE)
      (SE SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the forest to the south.")

      (SW SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the forest to the south.")

      (NOMAN
<TABLE <TABLE 90 135 0 0> <TABLE 180 180 0 0> <TABLE 270 225 0 0> D2>)
      (ACROSS INF-2)
      (ACTION OUTF-F)
      (GPOS 90)
      (FLAGS GVIEWBIT SLVIEWBIT)
      (GLOBAL SEARCHLIGHTS FENCE FENCE-HOLE FENCE-SIGN TOWER GUARDS BORDER-FENCE)>

<ROOM INF-2
      (LOC ROOMS)
      (NS 1)
      (EW 4)
      (PATH 0)
      (DESC "Inside Fence")
      (EAST TO INF-3 IF FALSE-FLAG ELSE
"You crawl along the ground until you reach a point directly south of the
next guard tower.")
      (WEST TO INF-1 IF FALSE-FLAG ELSE
"You crawl along the ground until you reach a point directly south of the
next guard tower.")
      (NE PER GUARD-CATCH)
      (NW PER GUARD-CATCH)
      (NORTH PER GUARD-MOVE-TWR)
      (SOUTH PER FENCE-CROSS)
      (ACROSS OUTF-2)
      (ACTION INF-F)
      (GPOS 90)
      (FLAGS GVIEWBIT)
      (GLOBAL SEARCHLIGHTS FENCE FENCE-HOLE FENCE-SIGN TOWER GUARDS BORDER-FENCE)>

<ROOM OUTF-3
      (LOC ROOMS)
      (DESC "Outside Fence")
      (NS 1)
      (EW 5)
      (PATH 0)
      (NORTH PER FENCE-CROSS)
      (EAST SORRY "That would be suicidal.")
      (WEST TO OUTF-2 IF FALSE-FLAG ELSE
"You crawl along the ground until you reach a point directly south of the
next guard tower.")
      (SOUTH PER NOMANS-MOVE)
      (SE SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the forest to the south.")

      (SW SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the forest to the south.")

      (NOMAN
<TABLE <TABLE 90 120 0 0> <TABLE 90 135 0 0> <TABLE 180 180 0 0> E2>)
      (ACROSS INF-3)
      (ACTION OUTF-F)
      (GPOS 180)
      (FLAGS GVIEWBIT SLVIEWBIT)
      (GLOBAL SEARCHLIGHTS FENCE FENCE-HOLE FENCE-SIGN TOWER GUARDS BORDER-FENCE)>

<ROOM INF-3
      (LOC ROOMS)
      (NS 1)
      (EW 5)
      (PATH 0)
      (DESC "Inside Fence")
      (EAST SORRY "That would be suicidal.")
      (WEST TO INF-2 IF FALSE-FLAG ELSE
"You crawl along the ground until you reach a point directly south of the
next guard tower.")
      (NW PER GUARD-MOVE-TWR)
      (NORTH PER GUARD-CATCH)
      (NE SORRY "That would be suicidal.")
      (SOUTH PER FENCE-CROSS)
      (ACROSS OUTF-3)
      (ACTION INF-F)
      (GPOS 180)
      (FLAGS GVIEWBIT)
      (GLOBAL SEARCHLIGHTS FENCE FENCE-HOLE FENCE-SIGN TOWER GUARDS BORDER-FENCE)>

<OBJECT FENCE-HOLE
	(LOC LOCAL-GLOBALS)
	(DESC "hole")
	(SYNONYM HOLE SLIT CUT BREAK)
	(ACTION FENCE-HOLE-F)>

<ROUTINE FENCE-HOLE-F ()
	 <COND (<VERB? OPEN>
		<PERFORM ,V?OPEN ,FENCE>
		<RTRUE>)
	       (<VERB? CUT>
		<PERFORM ,V?CUT ,FENCE ,PRSI>
		<RTRUE>)
	       (<AND <NOT <FSET? ,HERE ,FENCECUTBIT>>
		     <NOT <FSET? ,HERE ,FENCEBLOWNBIT>>>
		<TELL
"There's no hole here." CR>)
	       (<VERB? ENTER BOARD>
		<PERFORM ,PRSA ,FENCE>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<OR <FSET? ,HERE ,FENCEBLOWNBIT>
			   <FSET? ,HERE ,FENCEBENTBIT>>
		       <TELL
"The hole in the fence is large enough to go through." CR>)
		      (T
		       <TELL
"The vertical slit is about three feet long, though you'd
have to get it out of the way if you wanted to go through." CR>)>)>>

<ROUTINE GUARD-CATCH ()
	 <JIGS-UP
"You start across to the guard tower, but you are spotted by one of the
guards, who was facing in your direction. He calls out, and you turn to
find a place to hide. A shot rings out, and you are hit! When you come
to, you are surrounded by guards.">
	 <RFALSE>>

<ROUTINE GUARD-MOVE-TWR ("OPTIONAL" (RM ,TWR-2))
	 <COND (<IN-GUARD-VIEW?>
		<GUARD-CATCH>)
	       (T
		<TELL
"You run across to the base of the ">
		<COND (<EQUAL? .RM ,TWR-2> <TELL "guard tower">)
		      (<EQUAL? .RM ,BDR-2> <TELL "border fence">)
		      (T <TELL "first fence">)>
		<TELL "; apparently, you weren't
seen by the guards." CR CR>
		.RM)>>

<ROUTINE GUARD-MOVE-BDR () <GUARD-MOVE-TWR ,BDR-2>>

<ROUTINE GUARD-MOVE-INF () <GUARD-MOVE-TWR ,INF-2>>

<ROUTINE LADDER-CLIMB ()
	 <SETG CLOCK-MOVE 10>
	 <TELL
"You quietly ascend the ladder and arrive at the closed door." CR CR>
	 ,LADDER-TOP>

<ROUTINE LADDER-DESCEND ()
	 <COND (,ON-BRACE?
		<TELL
"You'd better get off the brace first." CR>
		<RFALSE>)>
	 <SETG CLOCK-MOVE 10>
	 <TELL
"You clamber down the ladder to the base of the tower." CR CR>
	 ,TWR-2>

<ROOM TOWER-SOUTH
      (LOC ROOMS)
      (NS 1)
      (EW 4)
      (GPOS 90)
      (PATH 0)
      (DESC "Tower, South Side")
      (LDESC
"The guard post itself looks both north and south. To the south, one can
look out over the no-man's-land and toward the forest.
The machine gun bolted to the floor is a grim reminder of the obstacles you
have faced so far. To the north, only a few feet beyond reach and about
five feet below you, lies the border fence.")
      (NORTH SORRY
"That would mean jumping off the tower to your death.")
      (OUT-DIR P?WEST)
      (WEST TO LADDER-TOP IF TOWER-DOOR IS OPEN)
      (FLAGS GVIEWBIT)
      (GLOBAL TOWER-DOOR BORDER-FENCE FENCE TOWER)>

<OBJECT GLOBAL-MACHINE-GUN
	(LOC GLOBAL-OBJECTS)
	(DESC "machine gun")
	(SYNONYM GUN GUNS MACHINE-GUN)
	(SCENARIO 2)
	(ADJECTIVE MACHINE)
	(ACTION GLOBAL-MACHINE-GUN-F)>

<ROUTINE GLOBAL-MACHINE-GUN-F ()
	 <COND (<EQUAL? ,HERE ,BDR-2>
		<TELL
"The gun is on the other side of the tower." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It's hard to tell much, since all you can see is the business end, but
it's primary purpose would appear to be sniping at people crossing
the open field to the south. It doesn't appear that it can pivot
enough to hit anybody that has crossed the outer fence." CR>)
	       (T
		<TELL ,TOO-FAR CR>)>>

<OBJECT MACHINE-GUN
	(LOC TOWER-SOUTH)
	(DESC "machine gun")
	(SYNONYM GUN MACHINE-GUN)
	(ADJECTIVE MACHINE)
	(FLAGS NDESCBIT)
	(ACTION MACHINE-GUN-F)>

<ROUTINE MACHINE-GUN-F ()
	 <COND (<VERB? SHOOT KILL>
		<TELL
"The machine gun is on a turret that swings in an arc of about 90 degrees,
taking in the entirety of no-man's-land. In retrospect, it must appear a
strange oversight that the gun cannot be used on the area between the fences.
In any event, there's nothing to be gained by firing the gun except to vent
some frustration." CR>)>> 

<ROUTINE TOWER-ENTRY ()
	 <COND (,ON-BRACE?
		<TELL "You'd better get off the brace first." CR>
		<RFALSE>)
	       (<FSET? ,TOWER-DOOR ,OPENBIT>
		,TOWER-SOUTH)
	       (T
		<TELL "The tower door is closed." CR>
		<RFALSE>)>>

<ROOM LADDER-TOP
      (LOC ROOMS)
      (NS 1)
      (EW 4)
      (GPOS 90)
      (PATH 0)
      (DESC "Tower Entrance")
      (DOWN PER LADDER-DESCEND)
      (IN-DIR P?EAST)
      (EAST PER TOWER-ENTRY)
      (FLAGS GVIEWBIT)
      (GLOBAL LADDER GUARDS TOWER TOWER-DOOR)
      (ACTION LADDER-TOP-F)>

<ROUTINE LADDER-TOP-F (RARG "AUX" GD)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<NOT ,ON-BRACE?>
		       <TELL
"You are standing at the top of the wooden ladder, at the entrance to
the tower. The ladder itself is bolted to the tower near the base of
the door; for additional support, a metal brace runs horizontally between
the ladder and the southwest post, just a few steps below the top
rung. With a little luck, it would be possible to climb onto the brace."
CR CR>)
		      (T
		       <TELL
"You are perched on the metal brace which runs horizontally between
the ladder and the southwest post. From here, you are about two feet
below the level of the tower entrance, and can easily watch the border
guards' movements with little chance of detection." CR CR>)>
		<SETG P-WALK-DIR <>>
		<PERFORM ,V?EXAMINE ,GUARDS>)
	       (<AND ,GUARD-WAIT
		     <EQUAL? .RARG ,M-ENTER>>
		<JIGS-UP
"You walk out into the open, as five guards with weapons raised stand
ready. Slowly, you descend the stairs and are taken into custody.">)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? DROP>
		     ,ON-BRACE?>
		<COND (<G? <GETP ,PRSO ,P?SIZE>
			   </ <SET GD <GUARD-DISTANCE>> 3>>
		       <TELL
"The " D ,PRSO " drops to the ground, and the sound of its impact
is loud enough to alert the guards.">
		       <COND (<L? .GD 25>
			      <JIGS-UP "
One of the guards, close enough to take a good shot, fires, hitting you
in the leg. You drop to the ground, injured, but alive.">)
			     (T
			      <TELL
" They start to approach, weapons drawn." CR>)>
		       <START-GUARD-CHASE>)
		      (T
		       <TELL
"The " D ,PRSO " falls to the ground, where it becomes lost in a soft
pile of snow." CR>
		       <COND (<EQUAL? ,PRSO ,EXPLODING-PEN>
			      <DE-QUEUE ,I-FUSE-OFF>)>
		       <REMOVE ,PRSO>)>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>
		     ,ON-BRACE?>
		<COND (<EQUAL? ,PRSO ,P?UP>
		       <PERFORM ,V?DISEMBARK ,BRACE>
		       <RTRUE>)>
		<TELL
"You'd better get off the brace first." CR>
		<RTRUE>)>>

<OBJECT BRACE-POST
	(LOC LADDER-TOP)
	(DESC "post")
	(SYNONYM POST POSTS)
	(ADJECTIVE SW SOUTHWEST)
	(FLAGS NDESCBIT)
	(ACTION BRACE-POST-F)>

<ROUTINE BRACE-POST-F ()
	 <COND (<VERB? EXAMINE>
		<PERFORM ,PRSA ,SW-POST>)
	       (<NOT ,ON-BRACE?>
		<TELL
"You can't reach it from here; perhaps if you were on the brace, though,
it would be possible." CR>)
	       (<EQUAL? ,BRACE-POST ,PRSO>
		<PERFORM ,PRSA ,SW-POST ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,PRSA ,PRSO ,SW-POST>
		<RTRUE>)>> 

<OBJECT TOWER-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "door")
	(SYNONYM DOOR)
	(ADJECTIVE TOWER METAL GUARD)
	(FLAGS NDESCBIT DOORBIT)
	(ACTION TOWER-DOOR-F)>

<ROUTINE TOWER-DOOR-F ()
	 <COND (<AND <VERB? CLOSE>
		     <FSET? ,PRSO ,OPENBIT>>
		<COND (<EQUAL? ,HERE ,TOWER-SOUTH>
		       <TELL
"The door closes and locks." CR>
		       <FCLEAR ,PRSO ,OPENBIT>)>)
	       (<VERB? LOCK>
		<TELL
"The door locks automatically when it closes." CR>)
	       (<AND <VERB? OPEN>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<COND (<EQUAL? ,HERE ,LADDER-TOP>
		       <TELL
"It's locked; trying to open it would only get you caught." CR>)>)
	       (<VERB? KNOCK>
		<COND (,GUARD-FOOLED
		       <JIGS-UP
"You rap on the door again. This time, the guard has figured out your
game and is prepared. He swings around, and smashes his automatic weapon into
your head, knocking you to the ground below. You aren't killed, but it sure
feels like it, and a moment later, you are surrounded by unsympathetic
guards.">)
		       (<IN? ,GUARD-LEG ,HERE>
			<TELL
"Are you crazy? The guard is practically on top of you!" CR>)
		       (,ON-BRACE?
			<TELL
"You reach up and rap on the door. A few moments later, you hear the
door open, and the guard calls out \"Who is there?\" He pauses for a moment,
then takes a step down the ladder, his left leg barely missing your cheek."
CR>
			<MOVE ,GUARD-LEG ,HERE>
			<FSET ,TOWER-DOOR ,OPENBIT>
			<RT-QUEUE ,I-GUARD-BACK 40>)
		      (T
		       <JIGS-UP
"You knock on the door. A moment later, the door opens, and you are
facing a guard whose automatic weapon is aimed at your head.">)>)>>

<GLOBAL GUARD-FOOLED <>>

<ROUTINE I-GUARD-BACK ()
	 <COND (<ZERO? <LOC ,GUARD-LEG>>
		<RTRUE>)>
	 <REMOVE ,GUARD-LEG>
	 <SETG GUARD-FOOLED T>
	 <FCLEAR ,TOWER-DOOR ,OPENBIT>
	 <BOLDTELL
"Having satisfied himself that he has been daydreaming, the guard
moves back into the tower, shutting the door behind him.">>

<OBJECT GUARD-LEG
	(DESC "guard's leg")
	(SYNONYM GUARD LEG)
	(ADJECTIVE GUARDS GUARD\'S)
	(FLAGS NDESCBIT)
	(ACTION GUARD-LEG-F)>

<ROUTINE GUARD-LEG-F ("AUX" GD)
	 <COND (<VERB? EXAMINE>
		<TELL
"There's not much to say, really. It's just a pair of legs in uniform,
presumably attached to a man whom you would prefer not to meet." CR>)
	       (<OR <VERB? TAKE MOVE PULL>
		    <HURT? ,PRSO>>
		<TELL
"With a short yelp, the guard stumbles,
then falls head-first to the ground with a sickening thud. The guards
on their rounds take notice and start moving toward you. Not knowing
whether or not you are armed, they approach slowly and carefully." CR>
		<REMOVE ,GUARD-LEG>
		<MOVE ,INJURED-GUARD ,TWR-2>
		<COND (<L? <SET GD <GUARD-DISTANCE>> 25>
		       <CRLF>
		       <JIGS-UP
"They are close enough to take a few quick shots, one of which hits you
in the leg, causing you to topple off the brace and onto the ground.
You survive, but it's little consolation.">
		       <RTRUE>)
		      (T
		       <START-GUARD-CHASE .GD>)>
		<RTRUE>)>>

<ROUTINE START-GUARD-CHASE (GD)
	 <RT-QUEUE ,I-TOWER <- .GD 25>>
	 <SETG GUARD-CHASE .GD>
	 <SETG NODOGS-FLAG T>
	 <SETG GUARD-CHASE-TIME ,CLOCK-TIME>>

<GLOBAL GUARD-CHASE <>>

<GLOBAL GUARD-CHASE-TIME <>>

<OBJECT INJURED-GUARD
	(DESC "crumpled body")
	(FDESC
"The crumpled body of the fallen guard is lying on the ground. Beneath
him lies his machine gun.")
	(SYNONYM BODY HEAP GUN MACHINE-GUN)
	(ADJECTIVE INJURED MACHINE CRUMPLED CONTORTED)
	(ACTION INJURED-GUARD-F)>

<ROUTINE INJURED-GUARD-F ()
	 <TELL
"The guards are drawing closer as you reach the sprawled body." CR CR>
	 <I-TOWER>
	 <RTRUE>>

<ROUTINE INT-TIME () <+ ,CLOCK-TIME ,CLOCK-TICKS>>

<ROUTINE I-TOWER ()
	 <COND (<EQUAL? ,HERE ,LADDER-TOP ,TWR-2 ,BDR-2>
		<COND (,G-WATCH
		       <UPDATE-CHRONOGRAPH 0 T>)>
		<HLIGHT ,H-BOLD>
		<CRLF>
		<TELL
"The guards reach a position within firing range, and fire at you, hitting
you in the back. You ">
		<COND (<NOT <EQUAL? ,HERE ,LADDER-TOP>>
		       <TELL "s">)>
		<TELL "tumble to the ground, unconscious, but alive.">
		<COND (<EQUAL? ,HERE ,LADDER-TOP>
		       <SETG HERE ,TWR-2>
		       <MOVE ,WINNER ,TWR-2>
		       <STATUS-LINE>)>
		<JIGS-UP " ">)
	       (<EQUAL? ,HERE ,TOWER-SOUTH>
		<BOLDTELL
"The guards reach the base of the tower, and fire a few shots. After some
muffled discussion, they call out: \"It is of no use. Come out, or we shall
be forced to kill you! You have 15 seconds to decide!\"">
		<RT-QUEUE ,I-CHARGE 15>
		<SETG GUARD-WAIT T>)
	       (T
		<HLIGHT ,H-BOLD>
		<CRLF>
		<JIGS-UP
"All at once, you feel lightheaded and stumble to the ground, overcome
by the cumulative effects of pain, blood loss, cold, and your strenuous
efforts. You are found not long afterwards, and placed under arrest.">)>> 

<GLOBAL GUARD-WAIT <>>

<ROUTINE I-CHARGE ()
	 <HLIGHT ,H-BOLD>
	 <CRLF>
	 <TELL
"You can hear the guards charging up the ladder." CR CR>
	 <COND (<FSET? ,TOWER-DOOR ,OPENBIT>
		<JIGS-UP
"A moment later, they burst through the door and take you into custody.">)
	       (T
		<TELL
"They arrive at the door, and find it locked. Angrily, one guard calls
down for the key; a moment later, shots ring out as the frustrated guard
riddles the lock mechanism with holes. You've only got moments before
you are captured!">
		<HLIGHT ,H-NORMAL>
		<CRLF>
		<RT-QUEUE ,I-CATCH 10>)>>

<ROUTINE I-CATCH ()
	 <HLIGHT ,H-BOLD>
	 <CRLF>
	 <JIGS-UP
"The guards burst through the door; a shot is fired - you are hit!">> 

<OBJECT BRACE
	(LOC LADDER-TOP)
	(DESC "brace")
	(SYNONYM BRACE)
	(ADJECTIVE METAL)
	(FLAGS NDESCBIT)
	(ACTION BRACE-F)>

<GLOBAL ON-BRACE? <>>

<ROUTINE BRACE-F ()
	 <COND (<VERB? BOARD CLIMB-ON CLIMB CLIMB-UP>
		<COND (,ON-BRACE?
		       <TELL "You're already on it." CR>)
		      (T
		       ;<FCLEAR ,HERE ,GVIEWBIT>
		       <SETG CLOCK-MOVE 8>
		       <TELL 
"You're now standing on the brace, just a few feet below the top rung
of the ladder. The bottom corner of the door is just visible from your
position. A quick check below confirms that you are relatively well hidden
from the pacing guards." CR>)>
		<SETG ON-BRACE? T>)
	       (<VERB? LEAP>
		<COND (<NOT ,ON-BRACE?>
		       <TELL
"You're not on the brace." CR>
		       <RTRUE>)>
		<TELL
"You'd break both of your legs." CR>)
	       (<VERB? DISEMBARK TAKE-OFF CLIMB-DOWN>
		<COND (<NOT ,ON-BRACE?>
		       <TELL
"You're not on the brace." CR>
		       <RTRUE>)>
		<COND (<IN? ,GUARD-LEG ,HERE>
		       <JIGS-UP
"As you start to reach the ladder, the guard glimpses you out of the
corner of his eye, and instinctively swings his weapon into your head,
knocking you onto the ground. You survive, fortunately, but you
have been captured.">
		       <RTRUE>)>
		<SETG CLOCK-MOVE 5>
		<TELL
"You're now back at the top of the ladder." CR>
		<FSET ,HERE ,GVIEWBIT>
		<SETG ON-BRACE? <>>
		<RTRUE>)>> 

<ROOM TWR-2
      (LOC ROOMS)
      (NS 1)
      (EW 4)
      (GPOS 90)
      (PATH 0)
      (DESC "Center Tower")
      (UP PER LADDER-CLIMB)
      (SE PER GUARD-CATCH)
      (SW PER GUARD-CATCH)
      (NORTH PER GUARD-MOVE-BDR)
      (EAST PER GUARD-CATCH)
      (WEST PER GUARD-CATCH)
      (SOUTH PER GUARD-MOVE-INF)
      (NE PER GUARD-CATCH)
      (NW PER GUARD-CATCH)
      (GLOBAL LADDER TOWER BORDER-FENCE GUARDS)
      (FLAGS GVIEWBIT)
      (ACTION TWR-F)>

<ROUTINE TWR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You're underneath the middle guard tower. The tower itself is supported
by four metal posts which rise to a height of twenty feet or so. Entrance to
the tower itself is via a wooden ladder running up and to the east at
the southwest corner of the tower
and leading to a closed door. Just a few dozen feet beyond the northern posts,
beyond a seemingly impenetrable border fence, lies freedom." CR CR>
		<SETG P-WALK-DIR <>>
		<PERFORM ,V?EXAMINE ,GUARDS>)>>

<OBJECT BINOCULARS
	(LOC INSIDE-SHED)
	(DESC "pair of binoculars")
	(SYNONYM PAIR BINOCULARS GLASSES BINOCS)
	(FDESC
"Hanging from a hook near the door is a pair of binoculars.")
	(ADJECTIVE FIELD)
	(FLAGS TAKEBIT TRANSBIT)
	(SCENARIO 2)
	(ACTION BINOCULARS-F)>

<ROUTINE BINOCULARS-F ()
	 <COND (<VERB? WEAR>
		<TELL
"The strap seems to be gone; you'll just have to carry them." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"They are your typical pair of binoculars with a magnification of perhaps
eight times. If you want to look at something in particular through them,
try saying \"LOOK THROUGH BINOCULARS AT something.\"" CR>)
	       (<AND <VERB? EXAMINE-THROUGH>
		     <EQUAL? ,PRSI ,BINOCULARS>>
		<COND (<AND <EQUAL? ,PRSO ,FENCE-SIGN>
			    <AT-NML?>>
		       <SIGN-READER>
		       <RTRUE>)
		      (<AND <EQUAL? ,PRSO ,FENCE>
			    <AT-NML?>>
		       <PERFORM ,V?EXAMINE ,FENCE>
		       <TELL CR
"Through the binoculars, you can make out what the signs say:" CR>
		       <SIGN-READER>)
		      (<AND <EQUAL? ,PRSO ,BORDER-FENCE>
			    <AT-NML?>>
		       <PERFORM ,V?EXAMINE ,PRSO>
		       <TELL CR
"It doesn't appear that any more detail has been found than you could
see with your naked eye." CR>)
		      (<AND <EQUAL? ,PRSO ,GUARDS>
			    <AT-NML?>>
		       <TELL
"It's a little easier to see the guards now, but the glare of the
searchlights is still annoying. There are clearly two guards; they
appear to march back and forth between the three towers, meeting in the
middle under the second tower. They are armed with automatic weapons,
and have that distinctive no-nonsense air about them which seems quite
appropriate for their job. A quick scan at the towers themselves reveal
that each has a guard poised ready at his machine gun." CR>)
		      (<AND <EQUAL? ,PRSO ,TOWER>
			    <AT-NML?>>
		       <TELL
"With the " D ,PRSI ", the towers are easily seen. The important detail
seems to be that each tower has a guard inside, with a machine gun trained
on the field that lies before you." CR>
		       <COND (,TOWER-DESTROYED
			      <TELL CR
"The bomb you left seems to have quite an impact, as the middle tower
is lying in ruins on the ground." CR>)>
		       <RTRUE>)
		      ;(<AND <EQUAL? ,PRSO ,SHED>
			    <EQUAL? ,HERE ,OUTSIDE-SHED>>
		       <TELL
"It appears to be a small, wooden building; too small, in fact, for a home.
Perhaps it is a utility shed or an outhouse.">
		       <COND (<IN? ,HUT-MAN ,OUTSIDE-SHED>
			      <TELL
" There's somebody standing outside, but you don't recognize him.">)>
		       <CRLF>)
		      (<ULTIMATELY-IN? ,PRSO ,WINNER>
		       <TELL
"Perhaps you are becoming near-sighted, but this is surely extreme.
You remind yourself to get a \"company\" physical, if you survive." CR>)
		      (T
		       <TELL
"There's nothing more to be seen than with the naked eye." CR>)>)>>

<ROUTINE AT-NML? ()
	 <OR <EQUAL? ,HERE ,B2 ,C2 ,D2>
	     <EQUAL? ,HERE ,E2 ,A2>>>

<OBJECT EXPLODING-PEN
	(DESC "pen")
	(SYNONYM PEN EXPLOSIVE)
	(ADJECTIVE EXPLODING)
	(FLAGS TAKEBIT OPENBIT CONTBIT SURFACEBIT)
	(SCENARIO 2)
	(ACTION EXPLODING-PEN-F)>

<CONSTANT SANITY-2
"Your sanity is coming into question. Perhaps it is the blood loss.">

<ROUTINE EXPLODING-PEN-F ()
	 <COND (<AND <VERB? TIE PUT-ON>
		     <EQUAL? ,PRSO ,EXPLODING-PEN>>
		<COND (<IN? ,PRSI ,GLOBAL-OBJECTS>
		       <TELL ,SANITY-2 CR>)
		      (T
		       <TELL
"The pen won't stick to the " D ,PRSI ,PERIOD-CR>)>)
	       (<VERB? EXAMINE>
		<COND (,BOMB-DUD
		       <TELL
"It looks like the bomb is a dud." CR>)
		      (T
		       <TELL
"Although the pen looks quite ordinary, it's nothing of the sort. It is,
in fact, an explosive device that you've always thought well-suited for a
James Bond movie. When the cap is removed, a small button is revealed.
Each push of the button sets the internal timer for an additional minute
before detonation. When the cap is replaced, the explosive is armed and
nothing can stop it. It's not very powerful, but it can do the job. It
is also highly magnetic, making it easier to place, but more difficult
to handle in the vicinity of wire hangers and the like." CR>)>)
	       (<AND <VERB? PUT PUT-ON TIE>
		     <EQUAL? ,PRSI ,EXPLODING-PEN>
		     <NOT <EQUAL? ,PRSO ,PEN-CAP>>>
		<TELL
"The only thing you can put on the pen is the pen cap." CR>)
	       (<AND <VERB? OPEN>
		     <IN? ,PEN-CAP ,EXPLODING-PEN>>
		<PERFORM ,V?TAKE ,PEN-CAP>
		<THIS-IS-IT ,EXPLODING-PEN>
		<RTRUE>)
	       (<VERB? OPEN>
		<TELL
"It's as open as it gets." CR>)
	       (<AND <VERB? CLOSE>
		     <IN? ,PEN-CAP ,WINNER>>
		<PERFORM ,V?PUT-ON ,PEN-CAP ,EXPLODING-PEN>
		<THIS-IS-IT ,EXPLODING-PEN>
		<RTRUE>)
	       (<VERB? THROW>
		<TELL
"No, it's not the sort of explosive that detonates on impact, though
come to think of it, that wouldn't be bad to have. Just place it where you
want it." CR>)>>	       

<GLOBAL BOMB-DUD <>>

<ROUTINE I-FUSE ("AUX" RM RMA L)
	 <SETG I-FATAL T>
	 <PUT ,CLOCK-TBL ,I-FUSE-OFF 32767>
	 <SETG CHRONOGRAPH-TIME ,FUSE-ARMED>
	 <UPDATE-CHRONOGRAPH 0>
	 <HLIGHT ,H-BOLD>
	 <CRLF>
	 <COND (<IN? ,EXPLODING-PEN ,KNAPSACK>
		<MOVE ,EXPLODING-PEN <LOC ,KNAPSACK>>
		<REMOVE ,KNAPSACK>)>
	 <SET L <LOC ,EXPLODING-PEN>>
	 <COND (<ULTIMATELY-IN? ,EXPLODING-PEN ,WINNER>
		<TELL
"The exploding pen does its thing, and you have finished doing yours.">
		<HLIGHT ,H-NORMAL>
		<CRLF>
		<FINISH>)
	       (<OR <ULTIMATELY-IN? ,EXPLODING-PEN ,HERE>
		    <AND <EQUAL? .L ,FENCE>
			 <GLOBAL-IN? ,FENCE ,HERE>
			 <FSET? ,HERE ,PENBIT>>>
		<TELL 
"The pen explodes nearby, and you are wounded by the flying debris. ">
		<COND (,GUARD-CHASE
		       <JIGS-UP
"The pursuing guards are more fortunate.">)
		      (T
		       <JIGS-UP
"Naturally, the explosion attracts the attention of the border guards, who
are rapidly on the scene.">)>)
	       (<IN? ,EXPLODING-PEN ,FENCE>
		<COND (<FSET? ,OUTF-1 ,PENBIT>
		       <SET RM ,OUTF-1>)
		      (<FSET? ,OUTF-2 ,PENBIT>
		       <SET RM ,OUTF-2>)
		      (T
		       <SET RM ,OUTF-3>)>
		<SET RMA <GETP .RM ,P?ACROSS>>
		<FSET .RM ,FENCEBLOWNBIT>
		<FSET .RMA ,FENCEBLOWNBIT>
		<FCLEAR .RM ,PENBIT>
		<FCLEAR .RMA ,PENBIT>
		<SETG VIGILANCE T>
		<BOMB-TELL .RM>)
	       (<EQUAL? .L ,NW-POST ,NE-POST>
		<COND (<EQUAL? ,HERE ,TOWER-SOUTH>
		       <TELL
"The pen explodes, and a long moment passes in silence. The tower
starts to tremble, and a moment later you're tumbling down toward
the ground. You don't arrive, however, as the rear of the tower
catches the top of the border fence. For a second, you are suspended
over the border, the sound of approaching guards and
scattered machine gun fire echoing in your ears. And then the tower itself
falls over, landing in a small heap just across the border. As if by instinct,
you lift yourself up and move into the darkness beyond. You don't quite
know where you are, but what the heck, you're safe now. Somebody will
find you sooner or later, but for now sleep doesn't sound so bad...|
|
|
Congratulations! You have survived the second chapter of Border Zone.
The story continues with Chapter 3: The Assassination. To start, type
CONTINUE at the next prompt.|
|
">
		       <FINISH 3>)
		      (<EQUAL? ,HERE ,LADDER-TOP>
		       <PEN-POOF>
		       <TELL
" The tower gives way, and you fall to the ground. This must be your
lucky day, because the falling tower misses you by a small margin. Before
you are captured, you notice that the rearmost section of the
tower has fallen on the other side of the border.">
		       <JIGS-UP " ">)
		      (<EQUAL? ,HERE ,TWR-2 ,BDR-2>
		       <PEN-POOF>
		       <TELL
" The tower is about to give way, but you quickly move
aside, as the tower falls backward into the border fence, the northmost
section of the tower landing across the border, and the
remaining portion landing in a heap alongside you. Guards are everywhere,
and it's not long before you are captured.">
		       <JIGS-UP " ">)
		      (<FSET? ,HERE ,GVIEWBIT>
		       <PEN-POOF>
		       <TELL
" The tower gives way, falling backward toward the border fence. The
rearmost portion hits the fence itself, projecting part of the tower across
the border. The remainder falls in a heap on the ground. Guards quickly
arrive on the scene; one of them spots you, and you are speedily
captured.">
		       <JIGS-UP " ">)
		      (T
		       <SETG TOWER-DESTROYED T>
		       <TELL ,EXPLOSION-HEARD CR>)>)
	       (<EQUAL? .L ,SE-POST ,SW-POST ,LADDER-TOP>
		<COND (<EQUAL? ,HERE ,TOWER-SOUTH ,LADDER-TOP>
		       <PEN-POOF>
		       <TELL 
" The tower gives way, falling southward and to the group. You are flung
to the ground, fortunately just a few feet away from the bulk of the
debris. Dazed, you slowly regain your feet as the guards arrive to place
you under arrest.">
		       <JIGS-UP " ">)
		      (<EQUAL? ,HERE ,TWR-2 ,BDR-2>
		       <PEN-POOF>
		       <TELL
" The tower is about to give way, but you quickly move
aside, as the tower falls forward, away from the border, landing in a
heap alongside you. Guards
are everywhere, and it's not long before you are captured.">
		       <JIGS-UP " ">)
		      (<FSET? ,HERE ,GVIEWBIT>
		       <PEN-POOF>
		       <TELL
" The tower gives way, falling forward, away from the border, in a heap.
Guards quickly
arrive on the scene; one of them spots you, and you are speedily
captured.">
		       <JIGS-UP " ">)
		      (T
		       <SETG TOWER-DESTROYED T>
		       <TELL ,EXPLOSION-HEARD CR>)>)
	       (<OR <FSET? .L ,HUTBIT>
		    <FSET? .L ,OUTHUTBIT>>
		<SETG HUT-BURNING T>
		<HUT-MUNGER>
		<REMOVE ,SCOUT>
		<COND (<FSET? ,HERE ,HUTBIT> ; "In another room"
		       <TELL
"The pen explodes nearby, and immediately the hut
catches fire. You stumble through the smoke-filled air, and end up
outside the rear of the hut, dazed but unhurt.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>
		       <CRLF>
		       <GOTO ,BEHIND-HUT>
		       <STATUS-LINE>)
		      (<FSET? ,HERE ,OUTHUTBIT>
		       <TELL "The pen explodes ">
		       <COND (<FSET? .L ,OUTHUTBIT>
			      <TELL "around the other side of">)
			     (T
			      <TELL "somewhere inside">)>
		       <TELL " the hut. Almost at once,
you can smell the burning wood as the hut starts to go up in flames.">)
		      (T
		       <BOMB-TELL .L>)>
		<COND (,CAR-SEQUENCE
		       <RUN-CAR-SEQUENCE>)>
		<COND (<IN? ,HUT-MAN ,OUTSIDE-HUT>
		       <SETG WOOD-COUNT -10000>
		       <REMOVE ,HUT-MAN>)>)
	       (<FSET? .L ,GVIEWBIT>
	        <SETG VIGILANCE T>
		<COND (<OR <FSET? ,HERE ,GVIEWBIT>
			   <FSET? ,HERE ,SLVIEWBIT>>
		       <TELL
"The pen explodes, sending debris flying into the air. Naturally, the guards
have all taken notice, making your position quite precarious." CR>)
		      (T
		       <BOMB-TELL .L>)>)
	       (<EQUAL? .L ,OUTSIDE-SHED>
		<COND (<EQUAL? ,HERE ,INSIDE-SHED>
		       <TELL
"The bomb explodes outside the shed; fortunately for you, the wet ground
prevents a fire from spreading." CR>)
		      (T
		       <BOMB-TELL .L>)>)
	       (<EQUAL? .L ,INSIDE-SHED>
		;<TELL "Unimplemented explosion: Shed destroyed." CR>
		<SETG I-FATAL <>>
		<MOVE ,EXPLODING-PEN ,INSIDE-SHED>
		<SETG BOMB-DUD T>)
	       (<AND <L? <HOW-FAR ,D5 .L> 3>
		     <NOT <IN? ,HUT-MAN ,OUTSIDE-HUT>>>
	        <MOVE ,HUT-MAN ,OUTSIDE-HUT>
		<COND (<EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT ,BEHIND-HUT>
		       <TELL
"The pen explodes nearby with a rather loud noise; loud enough, in fact,
to ">
		       <COND (<AND <G? ,CAR-SEQUENCE 0>
				   <L? ,CAR-SEQUENCE 6>>
			      <SETG CAR-SEQUENCE 6>
			      <TELL
"hurry the owner up in reaching the guards outside.">)
			     (T
			      <SETG HUT-MAN-DIVERSION T>
			      <RT-QUEUE ,I-MAN-BACK 150>
			      <TELL
"alert the man inside the hut, who stands up and walks out of the
door to look around.">)>)
		      (T
		       <BOMB-TELL .L>)>)
	       (<EQUAL? .L ,CAR>
		<COND (<ZERO? <LOC ,CAR>> T)
		      (<IN? ,CAR ,ROAD-END>
		       <REMOVE ,SCOUT>
		       <COND (<EQUAL? ,HERE ,SOUTH-HUT ,NORTH-HUT>
			      <COND (<EQUAL? ,HERE ,SOUTH-HUT>
				     <TELL
"The car explodes in a ball of red-orange flame.">)
				    (T
				     <TELL
"You hear the sound of the car exploding to the south.">)>
			      <TELL " The guards quickly
regroup and march off to the northeast (presumably to the roadblock
there).">
			      <COND (<IN? ,HUT-MAN ,OUTSIDE-HUT>
				     <MOVE ,HUT-MAN ,HUT-LIVING>
				     <TELL
" The man from the hut returns to the safety of his home.">)>)
			     (T
			      <BOMB-TELL .L>)>
		       <DEMOLISH-CAR>
		       <HLIGHT ,H-NORMAL>
		       <RTRUE>)
		      (<CAR-IN-VIEW?>
		       <TELL "Off to your ">
		       <TELL-DIRECTION ,HERE <LOC ,CAR>>
		       <DEMOLISH-CAR>
		       <TELL ", you watch as the car explodes in a ball
of red-orange flame. It's hard to believe there are any survivors.">)
		      (T
		       <BOMB-TELL .L>
		       <DEMOLISH-CAR>)>) 
	       (T
		<BOMB-TELL .L>)>
	 <REMOVE ,EXPLODING-PEN>
	 <HLIGHT ,H-NORMAL>
	 <CRLF>>

<GLOBAL TOWER-DESTROYED <>>

<OBJECT FLAMING-CAR
	(DESC "burning car")
	(SYNONYM CAR AUTOMOBILE)
	(ADJECTIVE BURNING FLAMING)
	(ACTION FLAMING-CAR-F)>

<ROUTINE FLAMING-CAR-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The car is entirely engulfed in flame, and it's hard to get very close. ">
		<COND (,GUARDS-IN-CAR
		       <TELL
"Through the smoke and fire, you can see the burning bodies of the guards
inside; none, it seems, was lucky enough to get away">)
		      (T
		       <TELL
"You can't make out anything inside">)>
		<TELL ,PERIOD-CR>)
	       (<OR <VERB? OPEN BOARD ENTER>
		    <TOUCHING? ,PRSO>>
		<TELL
		 "You can't get close enough for that." CR>)>>

<GLOBAL GUARDS-IN-CAR <>>

<ROUTINE DEMOLISH-CAR ()
	 <COND (<NOT ,CAR-SEQUENCE>
		<SETG GUARDS-IN-CAR T>)>
	 <SETG CAR-SEQUENCE <>>
	 <SETG CAR-ON-ROAD? <>>
	 <SETG SEQUENCE-RUN? T>
	 <MOVE ,FLAMING-CAR <LOC ,CAR>>
	 <REMOVE ,CAR>>

<ROUTINE CAR-IN-VIEW? ("AUX" (L <LOC ,CAR>))
	 <COND (<NOT <ZERO? <LOC ,FLAMING-CAR>>>
		<SET L <LOC ,FLAMING-CAR>>)>
	 <COND (<AND <EQUAL? .L ,ROAD-END>
		     <EQUAL? ,HERE ,SOUTH-HUT ,NORTH-HUT>>
		T)
	       (<AND <EQUAL? .L ,F4 ,F5>
		     <EQUAL? ,HERE ,F4 ,F5>>
		T)
	       (<AND <EQUAL? .L ,D6 ,E6>
		     <EQUAL? ,HERE ,D6 ,E6>>
		T)
	       (<AND <EQUAL? .L ,D6 ,D7 ,D8>
		     <EQUAL? ,HERE ,D6 ,D7 ,D8>>
		T)>>

<GLOBAL HUT-MAN-DIVERSION <>>

<ROUTINE I-MAN-BACK ()
	 <SETG HUT-MAN-DIVERSION <>>
	 <MOVE ,HUT-MAN ,HUT-LIVING>
	 <COND (<OR <EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT ,BEHIND-HUT>
		    <EQUAL? ,HERE ,HUT-STORAGE ,HUT-BEDROOM>>
		<BOLDTELL
"The man, confused about the source of the recent explosion, returns to the
comfort of his living room.">)>>

<ROUTINE BOMB-TELL (RM "AUX" HF)
	 <COND (<NOT <IN? .RM ,ROOMS>>
		<SET RM <LOC .RM>>)>
	 <HOW-FAR ,HERE .RM>
	 <TELL "You hear a">
	 <COND (<L? .HF 2>
		<TELL " loud ">)
	       (<L? .HF 4>
		<TELL "n ">)
	       (T
		<TELL " muffled ">)>
	 <TELL "explosion ">
	 <COND (<EQUAL? .HF 0> <TELL "nearby">)
	       (T
		<TELL "off to the ">
		<TELL-DIRECTION ,HERE .RM>)>
	 <TELL ,PERIOD-CR>>

<ROUTINE PEN-POOF ()
	<TELL "The exploding pen does its thing, taking the "
	      D <LOC ,EXPLODING-PEN> " with it.">>

<GLOBAL EXPLOSION-HEARD 
"You can hear an explosion in the distance.">

<GLOBAL FUSE-TIME 0>

<OBJECT PEN-CAP
	(LOC EXPLODING-PEN)
	(DESC "cap")
	(SYNONYM CAP COVER)
	(FLAGS TAKEBIT)
	(SCENARIO 2)
	(ACTION PEN-CAP-F)>

<ROUTINE PEN-CAP-F ()
	 <COND (<AND <VERB? TAKE>
		     <IN? ,PEN-CAP ,EXPLODING-PEN>>
		<TELL
"Taking the cap reveals the internal timer button." CR>
		<MOVE ,PEN-CAP ,WINNER>
		<MOVE ,TIMER-BUTTON ,EXPLODING-PEN>)
	       (<AND <VERB? PUT PUT-ON>
		     <NOT <IN? ,PRSO ,PRSI>>
		     <EQUAL? ,PRSI ,EXPLODING-PEN>>
		<MOVE ,PRSO ,PRSI>
		<REMOVE ,TIMER-BUTTON>
		<COND (<AND <ZERO? ,FUSE-ARMED>
			    <G? ,FUSE-TIME 0>>
		       <SETG FUSE-ARMED <* ,FUSE-TIME 60>>
		       <TELL
"The explosive is now armed; it will explode in ">
		       <NSPRINT ,FUSE-TIME "minute">
		       <TELL ". You reset your chronometer's
timer to zero and start it up." CR>
		       <SETG CLOCK-MOVE 0>
		       <SETG CHRONOGRAPH-TIME 0>
		       <SETG CHRONOGRAPH-ON T>
		       <UPDATE-CHRONOGRAPH 0>
		       <PUT ,CLOCK-TBL
			    ,I-FUSE-OFF
			    <+ ,CLOCK-TIME ,FUSE-ARMED>>
		       <RTRUE>)
		      (<ZERO? ,FUSE-TIME>
		       <TELL
"You replace the cap, but the timing button was never pushed, so the
explosive isn't armed." CR>)>)
	       (<VERB? OPEN>
		<PERFORM ,PRSA ,EXPLODING-PEN>
		<RTRUE>)>>

<GLOBAL FUSE-ARMED 0>

<OBJECT TIMER-BUTTON
	(DESC "timer button")
	(SYNONYM BUTTON)
	(ADJECTIVE TIMER RED)
	(FLAGS NDESCBIT)
	(ACTION TIMER-BUTTON-F)>

<ROUTINE TIMER-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<SETG CLOCK-MOVE 3>
		<COND (<G? ,FUSE-ARMED 0>
		       <TELL
"It won't make any difference; the device is armed." CR>)
		      (<G? ,FUSE-TIME 59>
		       <TELL
"Nothing happens; perhaps you've worn the damned thing out." CR>)
		      (T
		       <TELL
"The button replies with an almost silent \"click\"; you've pushed
the timer button ">
		       <NSPRINT <SETG FUSE-TIME <+ ,FUSE-TIME 1>> "time">
		       <TELL ,PERIOD-CR>)>)
	       (<VERB? EXAMINE>
		<TELL
"The button is small, red, and quite lethal." CR>)>>

<OBJECT LADDER
	(LOC LOCAL-GLOBALS)
	(DESC "ladder")
	(SYNONYM LADDER)
	(ADJECTIVE METAL)
	(ACTION LADDER-F)>

<ROUTINE LADDER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The ladder is made of wood and climbs steeply up and to the east
at the southwest side of the tower, ending at a narrow landing
at the entrance to the tower
itself. It is secured in place not only at the tower entrance, but,
additionally, by a brace running horizontally between the ladder and the
southwest post at a point a few feet lower. From the sturdiness of
construction, you could probably climb the ladder without drawing the
attention of the occupant." CR>)
	       (<VERB? CUT>
		<TELL "That would make too much noise." CR>)
	       (<OR <VERB? CLIMB CLIMB-UP BOARD>
		    <AND <VERB? CLIMB-ON> ,ON-BRACE?>>
		<COND (<EQUAL? ,HERE ,TWR-2>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (,ON-BRACE?
		       <PERFORM ,V?DISEMBARK ,BRACE>
		       <RTRUE>)
		      (T
		       <TELL "You're at the top." CR>)>)
	       (<VERB? CLIMB-DOWN>
		<COND (<EQUAL? ,HERE ,LADDER-TOP>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (T
		       <TELL "You're at the bottom." CR>)>)
	       (<AND <VERB? BOARD CLIMB-ON>
		     ,ON-BRACE?>
		<PERFORM ,V?LEAVE ,BRACE>
		<RTRUE>)>>

<OBJECT POSTS
	(LOC TWR-2)
	(DESC "posts")
	(SYNONYM POSTS)
	(ADJECTIVE METAL STEEL)
	(FLAGS NDESCBIT)
	(ACTION POSTS-F)>

<ROUTINE POSTS-F ("AUX" (L <LOC ,EXPLODING-PEN>))
	 <COND (<VERB? EXAMINE>
		<TELL
"Each guard tower is supported by four posts of six-inch square steel.
They are situated on the northeast, northwest, southeast, and southwest
corners of the building. The posts rise to a height of twenty feet, where they
are welded to the underside of the tower proper." CR>
		<COND (<OR <EQUAL? .L ,NE-POST ,NW-POST>
			   <EQUAL? .L ,SE-POST ,SW-POST>>
		       <TELL CR
"The pen is attached to the " D .L ,PERIOD-CR>)>
		<RTRUE>)
	       (T
		<TELL
"It would be best to refer to each post individually, by its position
around the base of the tower (e.g. northeast, northwest, etc.)" CR>)>>

<OBJECT NW-POST
	(LOC TWR-2)
	(DESC "northwest post")
	(SYNONYM POST)
	(ADJECTIVE NORTHWEST NW)
	(FLAGS NDESCBIT OPENBIT METALBIT)
	(ACTION POST-F)>

<OBJECT NE-POST
	(LOC TWR-2)
	(DESC "northeast post")
	(SYNONYM POST)
	(ADJECTIVE NORTHEAST NE)
	(FLAGS NDESCBIT OPENBIT METALBIT)
	(ACTION POST-F)>

<OBJECT SW-POST
	(LOC TWR-2)
	(DESC "southwest post")
	(SYNONYM POST)
	(ADJECTIVE SOUTHWEST SW)
	(FLAGS NDESCBIT OPENBIT METALBIT)
	(ACTION POST-F)>

<OBJECT SE-POST
	(LOC TWR-2)
	(DESC "southeast post")
	(SYNONYM POST)
	(ADJECTIVE SOUTHEAST SE)
	(FLAGS NDESCBIT OPENBIT METALBIT)
	(ACTION POST-F)>	

<ROUTINE POST-F ()
	 <COND (<AND <VERB? TIE PUT PUT-ON>
		     <OR <EQUAL? ,PRSI ,NW-POST ,NE-POST>
			 <EQUAL? ,PRSI ,SE-POST ,SW-POST>>>
		<COND (<EQUAL? ,PRSO ,EXPLODING-PEN>
		       <MOVE ,PRSO ,PRSI>
		       <COND (<EQUAL? ,HERE ,LADDER-TOP>
			      <TELL
"The pen adheres to the post after sliding down it to a point
just a few feet from the ground. You can't reach it again from here,
but you could from down below." CR>)
			     (T
			      <TELL
"The pen adheres strongly to the metallic post, and you remember to
position it out of the line of sight of the passing guards.">)>)>)
	       (<VERB? EXAMINE>
		<TELL
"Each post is six inches square, made of steel, and twenty-odd feet high.">
		<COND (<EQUAL? ,PRSO ,SW-POST>
		       <TELL
" Near the top of this post, a horizontal brace can be seen connecting
the post to the ladder which leads to the tower's entrance.">)>
		<COND (<IN? ,EXPLODING-PEN ,PRSO>
		       <TELL
" Positioned away from the guards' line of sight, the magnetic pen is
adhering to the post.">)>
		<CRLF>)
	       (<VERB? MUNG KICK>
		<CRLF>
		<JIGS-UP
"You don't get anywhere so far as damaging the post is concerned; you
do, however, rattle it enough to alert the guard inside, who within
five seconds is upon you, gun drawn.">)>>  

<OBJECT BORDER-FENCE
	(LOC LOCAL-GLOBALS)
	(DESC "border fence")
	(SYNONYM FENCE LINK LINKS)
	(ADJECTIVE CHAIN-LINK CHAIN BORDER IMPENETRABLE TALL)
	(GENERIC GENERIC-FENCE)
	(FLAGS METALBIT)
	(ACTION BORDER-FENCE-F)>

<ROUTINE BORDER-FENCE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The fence is quite formidable. It rises to a height of fifteen feet above
the ground, and is made of a much heavier chain-link construction than the
first. The overhang, six feet wide, is a solid
sheet of metal, providing no possibility for scaling." CR>)
	       (<AT-NML?>
		<TELL
"You'll have to get there first." CR>)
	       (<VERB? LEAP>
		<COND (<EQUAL? ,HERE ,TOWER-SOUTH>
		       <TELL
"You're high enough, all right, but you'd probably end up skewered
on the barbed wire." CR>)
		      (T
		       <TELL "You're not Superman." CR>)>)
	       (<VERB? CLIMB-UP CLIMB CLIMB-OVER>
		<TELL "Utterly hopeless." CR>)
	       (<AND <VERB? PUT PUT-ON TIE>
		     <EQUAL? ,PRSO ,EXPLODING-PEN>>
		<TELL
"The pen won't adhere to the fence; perhaps it is not steel." CR>)
	       (<VERB? CUT MUNG>
		<TELL "You haven't a chance of breaking through." CR>)>>

<ROOM BDR-2
      (LOC ROOMS)
      (NS 1)
      (EW 4)
      (PATH 0)
      (GPOS 90)
      (DESC "Border")
      (SOUTH PER GUARD-MOVE-TWR)
      (EAST PER GUARD-CATCH)
      (WEST PER GUARD-CATCH)
      (NE PER GUARD-CATCH)
      (NW PER GUARD-CATCH)
      (SE PER GUARD-CATCH)
      (SW PER GUARD-CATCH)
      (NORTH SORRY "That appears to be the problem at hand.")
      (FLAGS GVIEWBIT)
      (GLOBAL BORDER-FENCE TOWER GUARDS)
      (ACTION BDR-F)>

<ROUTINE BDR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing just a few feet away from the border. The fence here is
simply too much to hope
to overcome. Behind you, to the south, is the central guard tower,
the other two flanking the first a hundred yards on each side." CR>
		<SETG P-WALK-DIR <>>
		<PERFORM ,V?EXAMINE ,GUARDS>)>>

<OBJECT TOWER
	(LOC LOCAL-GLOBALS)
	(DESC "tower")
	(SYNONYM TOWER TOWERS)
	(ADJECTIVE WATCH GUARD LEFT MIDDLE CENTER RIGHT)
	(ACTION TOWER-F)>

<ROUTINE TOWER-F ()
	 <COND (<AND <VERB? ENTER BOARD>
		     <EQUAL? ,HERE ,LADDER-TOP>>
		<COND (,ON-BRACE?
		       <TELL
"You'll have to get off the brace first." CR>)
		      (T
		       <DO-WALK ,P?IN>
		       <RTRUE>)>)
	       (<VERB? LEAP-OFF>
		<COND (<EQUAL? ,HERE ,TOWER-SOUTH>
		       <PERFORM ,V?LEAP ,BORDER-FENCE>
		       <RTRUE>)
		      (T
		       <TELL
"Tell me again when you've gotten there." CR>)>)
	       (<VERB? CRAWL-UNDER>
		<COND (<EQUAL? ,HERE ,INF-2>
		       <DO-WALK ,P?NORTH>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,TWR-2>
		       <TELL "You already are." CR>)
		      (<EQUAL? ,HERE ,BDR-2>
		       <DO-WALK ,P?SOUTH>
		       <RTRUE>)
		      (T
		       <TELL
"You're not close enough for that yet." CR>)>)
	       (<VERB? WALK-TO>
		<TELL
"Just say the direction you wish to cross in; given the lights and
the distances involved, however, it would only safe to cross directly
to the north." CR>)
	       (<VERB? EXAMINE FIND WATCH EXAMINE-THROUGH>
		<COND (<AT-NML?>
		       <TELL
"It's hard to make out much detail at this distance, but each tower is
the same - fifteen, perhaps twenty feet high, supported by long posts.
It could be presumed that guards are inside, but you couldn't be
certain." CR>)
		      (<EQUAL? ,HERE ,TOWER-SOUTH>
		       <TELL "You're in it; there's no more to be seen." CR>)
		      (T
		       <TELL
"From this distance, you are more-or-less looking up at the tower,
which is supported by four metal posts. You can see the business end of
a machine gun poking out of the guard's platform, but otherwise can make
out no significant details.">)>)
	       (<AT-NML?>
		<TELL
"It's awfully hard to do anything to the tower at this distance." CR>)>>

<OBJECT FENCE
	(LOC LOCAL-GLOBALS)
	(DESC "first fence")
	(SYNONYM CHAIN-LINK LINK LINKS FENCE)
	(ADJECTIVE FIRST CHAIN ELECTRIFIED)
	(GENERIC GENERIC-FENCE)
	(FLAGS METALBIT OPENBIT)
	(ACTION FENCE-F)>

<ROUTINE GENERIC-FENCE ()
	 <COND (<OR <EQUAL? ,HERE ,OUTF-1 ,OUTF-2 ,OUTF-3>
		    <EQUAL? ,HERE ,INF-1 ,INF-2 ,INF-3>>
		,FENCE)
	       (<OR <EQUAL? ,HERE ,TOWER-SOUTH ,LADDER-TOP ,BDR-2>
		    <EQUAL? ,HERE ,TWR-2>>
		,BORDER-FENCE)>>

<OBJECT FENCE-SIGN
	(LOC LOCAL-GLOBALS)
	(DESC "warning sign")
	(SYNONYM SIGN SIGNS NOTICE NOTICES)
	(ADJECTIVE WARNING)
	(FLAGS READBIT)
	(ACTION FENCE-SIGN-F)>

<ROUTINE FENCE-SIGN-F ()
	 <COND (<VERB? TOUCH>
		<PERFORM ,V?TOUCH ,FENCE>
		<RTRUE>)
	       (<VERB? READ EXAMINE>
		<COND (<AT-NML?>
		       <TELL
"At this distance, you can't read the sign." CR>
		       <RTRUE>)>
		<SIGN-READER>)>>

<ROUTINE SIGN-READER ()
	 <BOLDTELL
"|
    Enkipna!|
Nizemzi obstch im!|
 Fingri en Morz!">
	 <TELL CR CR
"You smile, thinking of the literal translation: Have fear! The fence
will incinerate you! Touch it and die!" CR>>

<ROUTINE FENCE-F ("AUX" (ACROSS <GETP ,HERE ,P?ACROSS>))
	 <COND (<VERB? EXAMINE>
		<TELL
"The fence runs across the entire length of the border area. It is of
chain-link construction, and reaches a height of eight feet. At the top
the fence slopes back toward you, forming an overhang of about four
feet, which is completely covered with razor-sharp barbs.">
		<COND (<FSET? ,HERE ,FENCEBLOWNBIT>
		       <TELL " The fence has been destroyed here
by the blast of the exploding pen. Enough has been blown away to allow
passage easily to the other side.">)
		      (<FSET? ,HERE ,FENCECUTBIT>
		       <TELL " The fence has been cut
here">
		       <COND (<FSET? ,HERE ,FENCEBENTBIT>
			      <TELL " and has been bent out of the way,
so that it's possible to safely go through it.">)
			     (T
			      <TELL ".">)>)>
		<TELL " Every ten feet along the fence
is a warning sign.">
		<COND (<FSET? ,HERE ,PENBIT>
		       <TELL
" The pen is adhering to the fence at this point.">)>
		<CRLF>)
	       (<AT-NML?>
		<TELL
"You'll have to get a lot closer for that." CR>)
	       (<VERB? DIG>
		<PERFORM ,V?DIG ,GROUND>
		<RTRUE>)
	       (<VERB? CRAWL-UNDER ENTER>
		<COND (<OR <FSET? ,HERE ,FENCEBENTBIT>
			   <FSET? ,HERE ,FENCEBLOWNBIT>>
		       <TELL
"You carefully negotiate yourself through the ">
		       <COND (<FSET? ,HERE ,FENCEBENTBIT>
			      <TELL "bent">)
			     (T
			      <TELL "mangled">)>
		       <TELL " fence, making
sure no part of your body contacts the fence itself." CR CR>
		       <GOTO .ACROSS>
		       <RTRUE>)
		      (<FSET? ,HERE ,FENCECUTBIT>
		       <TELL "You start through the fence..." CR CR>
		       <REMOVE ,RUBBER-GLOVES>
		       <PERFORM ,V?TOUCH ,FENCE>
		       <RTRUE>)
		      (T
		       <TELL
"Just how to achieve that goal is your predicament at the moment." CR>)>)
	       (<AND <TOUCHING? ,PRSO>
		     <OR <NOT <IN? ,RUBBER-GLOVES ,PROTAGONIST>>
			 <NOT <FSET? ,RUBBER-GLOVES ,WORNBIT>>>>
		<JIGS-UP
"You are jolted by the 240 volts which courses through your body. Just
before passing out, you manage to pull yourself away from the
electrified fence, saving you from a certain death. You regain
consciousness some time later, but not before the border patrol
arrives.">)
	       (<AND <VERB? PUT PUT-ON TIE>
		     <EQUAL? ,PRSO ,EXPLODING-PEN>>
		<MOVE ,PRSO ,PRSI>
		<TELL
"The pen is now adhering to the fence at this point." CR>
		<FSET ,HERE ,PENBIT>
		<FSET <GETP ,HERE ,P?ACROSS> ,PENBIT>
		<RTRUE>)
	       (<VERB? TOUCH>
		<TELL
"You find you can safely touch the fence." CR>)
	       (<VERB? CLIMB CLIMB-UP CLIMB-OVER CLIMB-ON>
		<TELL
"You clamber up the fence and reach the overhang. From here, the small
caliber of the wires and the bulky gloves on your hands, makes it clear
that the overhang is simply not negotiable. You drop back to the
ground." CR>)
	       (<VERB? CUT MUNG>
		<COND (<FSET? ,HERE ,FENCEBLOWNBIT>
		       <TELL
"It's not necessary; there's little fence left here." CR>)
		      (<FSET? ,HERE ,FENCECUTBIT>
		       <TELL
"It won't help to break any more links on the fence; you'd just
risk setting off an alarm if the fence happens to be wired to detect
voltage drop." CR>)
		      (<EQUAL? ,PRSI ,BOLT-CUTTER>
		       <FSET ,HERE ,FENCECUTBIT>
		       <FSET .ACROSS ,FENCECUTBIT>
		       <SETG CUT-DETECTED <+ ,CLOCK-TIME 800>>
		       <TELL
"It's not easy, but you manage to cut a dozen or so of the chain links,
making a vertical slit about three feet long." CR>)
		      (<EQUAL? ,PRSI ,WOOD-SAW>
		       <TELL
"You try it for a while, and make little progress. Apparently, the wood saw
isn't very useful with metal." CR>)
		      (T
		       <TELL
"You won't make any progress with that!" CR>)>)
	       (<VERB? BEND PUSH MOVE OPEN>
		<COND (<FSET? ,HERE ,FENCEBLOWNBIT>
		       <TELL
"It's not necessary any more." CR>)
		      (<FSET? ,HERE ,FENCECUTBIT>
		       <COND (<FSET? ,HERE ,FENCEBENTBIT>
			      <FCLEAR ,HERE ,FENCEBENTBIT>
			      <FCLEAR .ACROSS ,FENCEBENTBIT>
			      <TELL
"You bend the fence back to its original position." CR>)
			     (T
			      <FSET ,HERE ,FENCEBENTBIT>
			      <FSET .ACROSS ,FENCEBENTBIT>
			      <TELL
"You bend back the fence far enough to allow you to go through." CR>)>)
		      (T
		       <TELL
"You can't bend the fence while it's just sitting there in one
piece." CR>)>)>>

<GLOBAL CUT-DETECTED <>>

<OBJECT RUBBER-GLOVES
	(DESC "pair of rubber gloves")
	(SYNONYM PAIR GLOVES)
	(ADJECTIVE RUBBER OLD)
	(FLAGS TAKEBIT WEARBIT)
	(SCENARIO 2)>

<ROOM B2
      (EW 2)
      (NS 2)
      (LOC ROOMS)
      (DESC "Border Zone, Station")
      (PATH 0)
      (WEST TO A2 IF HACK-FLAG ELSE
"You emerge from the forest into an open area through which runs
a railroad track oriented north and south. Beyond the tracks, the
ground rises steeply.")
      (EAST TO C2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (SE TO C3 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (SW TO A3 IF HACK-FLAG ELSE
"You emerge from the forest into an open area through which runs
a railroad track oriented north and south. Beyond the tracks, the
ground rises steeply.")
      (SOUTH TO B3 IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on through the forest.")
      (NORTH SORRY
"Attempting a run directly at the border station would be tantamount to
surrendering to the authorities and giving up on your mission.")
      (NE SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the tower to the north.")

      (NW SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the tower to the north.")

      (FLAGS SLVIEWBIT)
      (GLOBAL SEARCHLIGHTS GUARDS TOWER FENCE FENCE-SIGN BORDER-FENCE BORDER-FIELD)
      (ACTION EDGE-ROOM-F)>

<ROUTINE EDGE-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing at the edge of the forest; before you, to the north,
is an open field perhaps 200 yards wide beyond which lies the border.
Three guard towers, ">
		<COND (<EQUAL? ,HERE ,B2>
		       <TELL "all to your right">)
		      (T
		       <TELL "one before you and ">
		       <COND (<EQUAL? ,HERE ,C2>
			      <TELL "two to your right">)
			     (<EQUAL? ,HERE ,D2>
			      <TELL "one to either side">)
			     (T
			      <TELL "two to your left">)>)>
		<TELL ",
and each with a rotating searchlight mounted on top, stand watch over this
no-man's-land. And assuming you could cross without being seen, two more
obstacles remain, in the form of imposing fences, one before and the
other beyond the tower. You can continue along the edge of the forest
to the ">
		<COND (<NOT <EQUAL? ,HERE ,E2>>
		       <TELL "east and ">)>
		<TELL "west or reenter the forest to the south.">
		<COND (<EQUAL? ,HERE ,E2>
		       <TELL " To the east, the ground dips sharply;
you'd probably be hurt trying to go that way.">)>
		<CRLF>)>>

<ROOM C2
      (EW 3)
      (NS 2)
      (LOC ROOMS)
      (DESC "Border Zone, Left")
      (PATH 0)
      (WEST TO B2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible. Directly across the border zone is
the border crossing station.")
      (EAST TO D2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (SE TO D3 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (SW TO B3 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (SOUTH TO C3 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (NORTH PER NOMANS-MOVE)
      (NE SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the tower to the north.")

      (NW SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the tower to the north.")

      (NOMAN
<TABLE <TABLE 180 180 0 0> <TABLE 225 270 0 0> <TABLE 240 270 0 0> OUTF-1>)

      (FLAGS SLVIEWBIT)
      (GLOBAL SEARCHLIGHTS GUARDS TOWER FENCE FENCE-SIGN BORDER-FENCE BORDER-FIELD)
      (ACTION EDGE-ROOM-F)>

<ROOM D2
      (EW 4)
      (NS 2)
      (LOC ROOMS)
      (DESC "Border Zone, Center")
      (PATH 0)
      (WEST TO C2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (EAST TO E2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (SE TO E3 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (SW TO C3 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (SOUTH TO D3 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (NORTH PER NOMANS-MOVE)
      (NE SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the tower to the north.")

      (NW SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the tower to the north.")

      (NOMAN
<TABLE <TABLE 135 90 0 0> <TABLE 180 180 0 0> <TABLE 225 270 0 0> OUTF-2>)

      (FLAGS SLVIEWBIT)
      (GLOBAL SEARCHLIGHTS GUARDS TOWER FENCE FENCE-SIGN BORDER-FENCE BORDER-FIELD)
      (ACTION EDGE-ROOM-F)>

<ROOM E2
      (EW 5)
      (NS 2)
      (LOC ROOMS)
      (DESC "Border Zone, Right")
      (PATH 0)
      (WEST TO D2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (EAST SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (SE TO F3 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SW TO D3 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SOUTH TO E3 IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on through the forest.")
      (NORTH PER NOMANS-MOVE)
      (NE SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the tower to the north.")

      (NW SORRY
"Given the rate at which the searchlights are turning, it would be suicidal
to attempt anything other than a direct run at the tower to the north.")

      (NOMAN
<TABLE <TABLE 120 90 0 0> <TABLE 135 90 0 0> <TABLE 180 180 0 0> OUTF-3>)

      (FLAGS SLVIEWBIT)
      (GLOBAL SEARCHLIGHTS GUARDS TOWER FENCE FENCE-SIGN BORDER-FENCE BORDER-FIELD)
      (ACTION EDGE-ROOM-F)>

<OBJECT BORDER-FIELD
	(LOC LOCAL-GLOBALS)
	(DESC "open field")
	(SYNONYM FIELD LAND)
	(ADJECTIVE OPEN NOMANS NO-MANS)
	(FLAGS VOWELBIT AN)
	(ACTION BORDER-FIELD-F)>

<ROUTINE BORDER-FIELD-F ()
	 <COND (<VERB? CROSS ENTER CLIMB>
		<DO-WALK ,P?NORTH>
		<RTRUE>)>>

<ROOM A2
      (EW 1)
      (NS 2)
      (LOC ROOMS)
      (DESC "Border Zone, Tracks")
      (PATH A3)
      (WEST SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (EAST TO B2 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest,
until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (SE TO B3 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (SOUTH TO A3 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (NORTH SORRY
"You'd do as well to surrender.")
      (NE SORRY
"You'd do as well to surrender.")
      (NW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (GLOBAL SEARCHLIGHTS)
      (FLAGS TRACKSBIT)
      (ACTION TRACKS-ROOM-F)>

<OBJECT TRACKS
	(LOC GLOBAL-OBJECTS)
	(DESC "tracks")
	(SCENARIO 2)
	(SYNONYM TRACKS)
	(ADJECTIVE RAILROAD)
	(ACTION TRACKS-F)>

<ROUTINE TRACKS-F ("OPTIONAL" (FLG T))
	 <COND (<AND .FLG <NOT <FSET? ,HERE ,TRACKSBIT>>>
		<TELL
"There are no tracks here." CR>)
	       (<VERB? FOLLOW>
		<TELL
"You'll have to specify a direction." CR>)
	       (<VERB? LISTEN>
		<TELL
"You listen for a while; there's no train coming." CR>)>> 

<OBJECT ROAD
	(LOC GLOBAL-OBJECTS)
	(DESC "road")
	(SYNONYM ROAD ROADWAY PAVEMENT)
	(ACTION ROAD-F)>

<ROUTINE ROAD-F ()
	 <COND (<NOT <FSET? ,HERE ,ROADBIT>>
		<TELL
"There is no road here." CR>)
	       (<TRACKS-F <>>
		<RTRUE>)>> 

<ROUTINE TRACKS-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing on tracks ">
		<COND (<EQUAL? ,HERE ,A7>
		       <TELL
"which lead off far to the north, but at this point bend to the southeast.">)
		      (<EQUAL? ,HERE ,B8>
		       <TELL
"which run from northwest to southeast.">)
		      (T
		       <TELL
"which run directly north-south.">)>
		<TELL
" The terrain rises sharply just to the west">
		<COND (<EQUAL? ,HERE ,A7 ,B8>
		       <TELL " and south">)>
		<TELL ", and it's unlikely
that you could scramble up very far. To the east lies a dense forest.">
		<COND (<EQUAL? ,HERE ,A2>
		       <TELL
" Just north of here, the tracks enter a brightly lit clearing just
beyond which is the border station. It would be suicidal to continue
in that direction.">)
		      (<AND <EQUAL? ,HERE ,B8>
			    ,FIRST-B8-FLAG>
		       <SETG FIRST-B8-FLAG <>>
		       <TELL
" Off to the northeast you can see smoke rising into the night sky.">)>
		<CRLF>)>>

<GLOBAL FIRST-B8-FLAG T>

<ROOM A3
      (EW 1)
      (NS 3)
      (LOC ROOMS)
      (DESC "Railroad Tracks")
      (PATH A4)
      (WEST SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (EAST TO B3 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SE TO B4 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (SOUTH TO A4 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (NORTH TO A2 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (NE TO B2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible. Directly across the border zone is
the border crossing station.")
      (NW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (FLAGS TRACKSBIT)
      (ACTION TRACKS-ROOM-F)>

<ROOM A4
      (EW 1)
      (NS 4)
      (LOC ROOMS)
      (DESC "Railroad Tracks")
      (PATH A5)
      (WEST SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (EAST TO B4 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SE TO B5 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (SOUTH TO A5 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (NORTH TO A3 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (NE TO B3 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (NW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (FLAGS TRACKSBIT)
      (ACTION TRACKS-ROOM-F)>

<ROOM A5
      (EW 1)
      (NS 5)
      (LOC ROOMS)
      (DESC "Railroad Tracks")
      (PATH A6)
      (WEST SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (EAST TO B5 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SE TO B6 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (SOUTH TO A6 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (NORTH TO A4 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (NE TO B4 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (NW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (FLAGS TRACKSBIT)
      (ACTION TRACKS-ROOM-F)>

<ROOM A6
      (EW 1)
      (NS 6)
      (LOC ROOMS)
      (DESC "Railroad Tracks")
      (PATH A7)
      (WEST SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (EAST TO B6 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SE TO B7 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (SOUTH TO A7 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards, reaching a spot
at which the tracks bend off to the southeast.")
      (NORTH TO A5 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (NE TO B5 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (NW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (FLAGS TRACKSBIT)
      (ACTION TRACKS-ROOM-F)>

<ROOM A7
      (EW 1)
      (NS 7)
      (LOC ROOMS)
      (DESC "Railroad Tracks")
      (PATH B8)
      (WEST SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (EAST TO B7 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SE TO B8 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (SW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (SOUTH SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (NORTH TO A6 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (NE TO B6 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (NW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (FLAGS TRACKSBIT)
      (ACTION TRACKS-ROOM-F)>

<ROOM B3
      (EW 2)
      (NS 3)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO A3 IF HACK-FLAG ELSE
"You emerge from the forest into an open area through which runs
a railroad track oriented north and south. Beyond the tracks, the
ground rises steeply.")
      (EAST TO C3 IF TRUE-FLAG ELSE
"You move deeper into the forest, until you reach...")
      (SE TO OUTSIDE-SHED IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest, until you stop at
a small wooden shed.")
      (SW TO A4 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
more-or-less north and south. Behind the tracks, the ground rises
steeply.")
      (SOUTH TO B4 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (NORTH TO B2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible. Directly across the border zone is
the border crossing station.")
      (NE TO C2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (NW TO A2 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
more-or-less north and south. Behind the tracks, the ground rises
steeply.")
      (ACTION FOREST-ROOM-F)>

<ROUTINE FOREST-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing in the middle of the forest, which surrounds you
on every side." CR>)>>

<ROOM B4
      (EW 2)
      (NS 4)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO A4 IF HACK-FLAG ELSE
"You emerge from the forest into an open area through which runs
a railroad track oriented north and south. Beyond the tracks, the
ground rises steeply.")
      (EAST TO OUTSIDE-SHED IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest, until
you reach a small wooden shed.")
      (SE TO C5 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (SW TO A5 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
more-or-less north and south. Behind the tracks, the ground rises
steeply.")
      (SOUTH TO B5 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (NORTH TO B3 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (NE TO C3 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (NW TO A3 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
more-or-less north and south. Behind the tracks, the ground rises
steeply.")
      (ACTION FOREST-ROOM-F)>

<ROOM B5
      (EW 2)
      (NS 5)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO A5 IF HACK-FLAG ELSE
"You emerge from the forest into an open area through which runs
a railroad track oriented north and south. Beyond the tracks, the
ground rises steeply.")
      (EAST TO C5 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (SE TO C6 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (SW TO A6 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
more-or-less north and south. Behind the tracks, the ground rises
steeply.")
      (SOUTH TO B6 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (NORTH TO B4 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (NE TO OUTSIDE-SHED IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest, until you stop at
a small wooden shed.")
      (NW TO A4 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
more-or-less north and south. Behind the tracks, the ground rises
steeply.")
      (ACTION FOREST-ROOM-F)>

<ROOM B6
      (EW 2)
      (NS 6)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO A6 IF HACK-FLAG ELSE
"You emerge from the forest into an open area through which runs
a railroad track oriented north and south. Beyond the tracks, the
ground rises steeply.")
      (EAST TO C6 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (SE TO C7 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SW TO A7 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
more-or-less north and south. Behind the tracks, the rises steeply.")
      (SOUTH TO B7 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (NORTH TO B5 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (NE TO C5 IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest.")
      (NW TO A5 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
more-or-less north and south. Behind the tracks, the ground rises
steeply.")
      (ACTION FOREST-ROOM-F)>

<ROOM B7
      (EW 2)
      (NS 7)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO A7 IF HACK-FLAG ELSE
"You emerge from the forest into an open area through which runs
a railroad track oriented north and south. Beyond the tracks, the
ground rises steeply.")
      (EAST TO C7 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SE TO C8 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SW SORRY
"You'd never make it up the cliff on the other side of the tracks.")
      (SOUTH TO B8 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
northwest to southeast. Behind the tracks, to the west and south, the
ground rises steeply.")
      (NORTH TO B6 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (NE TO C6 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (NW TO A6 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
more-or-less north and south. Behind the tracks, the ground rises
steeply.")
      (ACTION FOREST-ROOM-F)>

<ROOM B8
      (EW 2)
      (NS 8)
      (LOC ROOMS)
      (DESC "Railroad Tracks")
      (PATH 0)
      (WEST SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (EAST TO C8 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (SE TO C9 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards, and come to
a place where the tracks are met by a roadway, heading off to the northeast.
Both the tracks and the roadway enter a tunnel to the south.")
      (SW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (SOUTH SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (NORTH TO B7 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (NE TO C7 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (NW TO A7 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (FLAGS TRACKSBIT)
      (ACTION TRACKS-ROOM-F)>

<ROOM C3
      (EW 3)
      (NS 3)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO B3 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (EAST TO D3 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (SE TO D4 IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on through the forest.")
      (SW TO B4 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (SOUTH TO OUTSIDE-SHED IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest, until
you come to a small wooden shed.")
      (NORTH TO C2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (NE TO D2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (NW TO B2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible. Directly across the border zone is
the border crossing station.")
      (ACTION FOREST-ROOM-F)>

<ROUTINE SHED-MOVE ()
	 <COND (<NOT <FSET? ,SHED-DOOR ,OPENBIT>>
		<TELL
"You open the door and enter the shed, closing the door behind you
to keep out the cold and wind." CR CR>)>
	 ,INSIDE-SHED>

<ROOM OUTSIDE-SHED
      (EW 3)
      (NS 4)
      (LOC ROOMS)
      (DESC "Outside Shed")
      (PATH 0)
      (IN PER SHED-MOVE)
      (SE TO D5 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest and into a clearing. A small hut lies off the east, and
from the smoke from the chimney, it appears as though somebody's home.")
      (NE TO D3 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (NORTH TO C3 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (NW TO B3 IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest.")
      (SOUTH TO C5 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (SW TO B5 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (EAST TO D4 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (WEST TO B4 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (GLOBAL SHED-DOOR SHED-WINDOW SHED)
      (ACTION OUTSIDE-SHED-F)
      (WOODFCN OUTSIDE-SHED-WF)>

<ROUTINE OUTSIDE-SHED-WF (FRM)
	 <COND (<EQUAL? ,HERE ,OUTSIDE-SHED>
		<MAN-CATCHES>)
	       (<EQUAL? .FRM ,D5>
		<COND (<EQUAL? ,HERE ,INSIDE-SHED>
		       <BOLDTELL
"You hear heavy footsteps headed your way; looking through the
window, a man comes into sight from the southeast.">)>)>>   

<ROUTINE BOLDTELL (STR "OPTIONAL" (CR T))
	 <COND (.CR <CRLF>)>
	 <HLIGHT ,H-BOLD>
	 <TELL .STR>
	 <HLIGHT ,H-NORMAL>
	 <COND (.CR <CRLF>)>
	 <RTRUE>>

<ROUTINE OUTSIDE-SHED-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing outside of a small shed. Through a small window
you can see many stacks of cut wood.  The wooden door is ">
		<DOOR-TELL ,SHED-DOOR>
		<TELL ".
The forest surrounds you in all directions, though it appears that it
becomes less dense to the southeast." CR>
		<HUT-MAN-DESC
"|
You can see the owner of the hut">
		<RTRUE>)>>

<OBJECT SHED-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "shed door")
	(SYNONYM DOOR)
	(ADJECTIVE SHED)
	(FLAGS DOORBIT)>

<OBJECT WOOD-PILE
	(LOC INSIDE-SHED)
	(DESC "pile of wood")
	(SYNONYM PILE WOOD LOGS LOG)
	(ADJECTIVE WOOD)
	(FLAGS NDESCBIT)
	(ACTION WOOD-PILE-F)>

<ROUTINE WOOD-PILE-F ()
	 <COND (<VERB? TAKE>
		<TELL
"You don't need any wood at the moment." CR>)
	       (<VERB? MOVE>
		<TELL
"You move a few pieces of wood around, but nothing interesting turns up,
unless you've got an interest in entomology." CR>)
	       (<VERB? SEARCH>
		<PERFORM ,V?SEARCH ,ASSORTED-TOOLS>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"It's a large pile, from floor to ceiling; it's not very interesting
otherwise." CR>)
	       (<VERB? CUT>
		<COND (<EQUAL? ,PRSI ,WOOD-SAW>
		       <TELL
"You could certainly cut some logs that way, but it would only waste
time." CR>)
		      (T
		       <TELL
"Not with that, you won't." CR>)>)>> 

<OBJECT FAKE-GLOVES
	(LOC INSIDE-SHED)
	(DESC "gloves")
	(SYNONYM GLOVES)
	(ADJECTIVE RUBBER)
	(FLAGS NDESCBIT)
	(ACTION FAKE-TOOLS-F)>

<OBJECT FAKE-HAMMER
	(LOC INSIDE-SHED)
	(DESC "hammer")
	(SYNONYM HAMMER)
	(ADJECTIVE WOOD)
	(FLAGS NDESCBIT)
	(ACTION FAKE-TOOLS-F)>

<OBJECT FAKE-SAW
	(LOC INSIDE-SHED)
	(DESC "saw")
	(SYNONYM WOOD-SAW SAW)
	(ADJECTIVE WOOD)
	(FLAGS NDESCBIT)
	(ACTION FAKE-TOOLS-F)>

<OBJECT FAKE-CUTTERS
	(LOC INSIDE-SHED)
	(DESC "bolt cutters")
	(SYNONYM CUTTER BOLT-CUTTER CUTTERS)
	(ADJECTIVE BOLT)
	(FLAGS NDESCBIT)
	(ACTION FAKE-TOOLS-F)>

<ROUTINE FAKE-TOOLS-F ()
	 <TELL
"You can't see that out in the open, though it might be somewhere
among the wood and tools." CR>>  

<OBJECT ASSORTED-TOOLS
	(LOC INSIDE-SHED)
	(DESC "assorted tools")
	(SYNONYM TOOLS TOOL)
	(ADJECTIVE ASSORTED)
	(FLAGS NDESCBIT)
	(ACTION ASSORTED-TOOLS-F)>

<ROUTINE ASSORTED-TOOLS-F ()
	 <COND (<AND <VERB? EXAMINE SEARCH>
		     <NOT <FSET? ,PRSO ,PENBIT>>>
		<FSET ,PRSO ,PENBIT>
		<REMOVE ,FAKE-HAMMER>
		<REMOVE ,FAKE-GLOVES>
		<REMOVE ,FAKE-SAW>
		<REMOVE ,FAKE-CUTTERS>
		<REMOVE ,PRSO>
		<MOVE ,HAMMER ,HERE>
		<MOVE ,BOLT-CUTTER ,HERE>
		<MOVE ,WOOD-SAW ,HERE>
		<MOVE ,RUBBER-GLOVES ,HERE>
		<TELL
"You look around and find a hammer, a bolt-cutter, and a wood saw.
You also come across an old pair of rubber gloves." CR>)
	       (T
		<TELL
"You'll do better to look at the tools first, to see which one you
want." CR>)>>

<OBJECT HAMMER
	(DESC "hammer")
	(SYNONYM HAMMER TOOL TOOLS HANDLE)
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 10)
	(SCENARIO 2)
	(ACTION HAMMER-F)>

<ROUTINE HAMMER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's an ordinary hammer." CR>)>> 

<OBJECT WOOD-SAW
	(DESC "wood saw")
	(SYNONYM SAW TOOL TOOLS)
	(ADJECTIVE WOOD)
	(FLAGS TAKEBIT TOOLBIT)
	(SCENARIO 2)
	(SIZE 20)
	(ACTION WOOD-SAW-F)>

<ROUTINE WOOD-SAW-F ()
	<COND (<VERB? EXAMINE>
	       <TELL
"It's your average size wood saw, and it's probably used here to cut
up the larger logs." CR>)>> 

<OBJECT BOLT-CUTTER
	(DESC "bolt-cutter")
	(SYNONYM CUTTER BOLT-CUTTER CUTTERS TOOL TOOLS)
	(ADJECTIVE BOLT)
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 20)
	(SCENARIO 2)>	

<OBJECT SHED-WINDOW
	(LOC LOCAL-GLOBALS)
	(DESC "shed window")
	(SYNONYM WINDOW)
	(ADJECTIVE SHED)
	(ACTION SHED-WINDOW-F)>

<ROUTINE SHED-WINDOW-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,INSIDE-SHED>
		       <COND (<IN? ,HUT-MAN ,OUTSIDE-SHED>
			      <TELL
"You can't see much. Wait! There's a man, not far from the shed, heading ">
			      <COND (,WOOD-RETURNING
				     <TELL "southeast, toward the hut." CR>)
				    (T
				     <TELL "right toward you!" CR>)>)
			     (T
			      <TELL
"You can't see much outside, except for some ice which has formed on
the window pane." CR>)>)
		      (<IN? ,HUT-MAN ,INSIDE-SHED>
		       <TELL
"You can see piles of wood stacked inside;
disturbingly, you can see a man gathering a pile of wood for himself -
under his coat is a large revolver." CR>)
		      (T
		       <TELL
"You can see only piles of wood, though other things might be there." CR>)>)
	       (<VERB? OPEN>
		<TELL
"It can't be opened; it just provides some light to the inside." CR>)
	       (<VERB? MUNG>
		<TELL
"It would only make noise and call attention to yourself." CR>)>>

<ROOM INSIDE-SHED
      (EW 3)
      (NS 4)
      (LOC ROOMS)
      (DESC "Inside Shed")
      (PATH 0)
      (OUT PER LEAVE-SHED)
      (GLOBAL SHED-DOOR SHED-WINDOW SHED)
      (ACTION INSIDE-SHED-F)
      (WOODFCN INSIDE-SHED-WF)>

<ROUTINE LEAVE-SHED ()
	 <SETG P-WALK-DIR <>>
	 <PERFORM ,V?EXIT ,SHED>
	 <RFALSE>>

<OBJECT SHED
	(LOC LOCAL-GLOBALS)
	(DESC "shed")
	(SYNONYM SHED WOODSHED BUILDING HUT)
	(ADJECTIVE WOOD)
	(ACTION SHED-F)>

<ROUTINE SHED-F ()
	 <COND (<VERB? OPEN CLOSE>
		<PERFORM ,PRSA ,SHED-DOOR>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?LOOK-INSIDE ,SHED-WINDOW>
		<RTRUE>)
	       (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,OUTSIDE-SHED>
		       <GOTO <SHED-MOVE>>)
		      (T
		       <TELL "That doesn't make sense." CR>)>)
	       (<VERB? LEAVE EXIT>
		<COND (<EQUAL? ,HERE ,INSIDE-SHED>
		       <GOTO ,OUTSIDE-SHED>)
		      (T
		       <TELL "You're not in the shed." CR>)>)>> 

<GLOBAL WOOD-RETURNING <>>

<ROUTINE INSIDE-SHED-WF (FRM)
	 <SETG WOOD-RETURNING T>
	 >

<ROUTINE INSIDE-SHED-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The shed appears to be entirely for the storage of wood, although
some scattered tools are lying about. Snow can be seen falling through
a small window. The door leading back into the forest is ">
		<DOOR-TELL ,SHED-DOOR>
		<TELL "." CR>)>> 

<ROOM C5
      (EW 3)
      (NS 5)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO B5 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (EAST TO D5 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest and into a clearing. A small hut lies off the east, and
from the smoke from the chimney, it appears as though somebody's home.")
      (SE TO D6 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
south to east, with a narrow spur leading north.")
      (SW TO B6 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (SOUTH TO C6 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (NORTH TO OUTSIDE-SHED IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest, until
you come to a small wooden shed.")
      (NE TO D4 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (NW TO B4 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (ACTION FOREST-ROOM-F)>

<ROOM C6
      (EW 3)
      (NS 6)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO B6 IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on through the forest.")
      (EAST TO D6 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
south to east, with a narrow spur leading north.")
      (SE TO D7 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
north to south.")
      (SW TO B7 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (SOUTH TO C7 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (NORTH TO C5 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (NE TO D5 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest and into a clearing. A small hut lies off the east, and
from the smoke from the chimney, it appears as though somebody's home.")
      (NW TO B5 IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on through the forest.")
      (ACTION FOREST-ROOM-F)>

<ROOM C7
      (EW 3)
      (NS 7)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO B7 IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on through the forest.")
      (EAST TO D7 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
north to south.")
      (SE TO D8 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
north to southwest.")
      (SW TO B8 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
northwest to southeast. Behind the tracks, to the west and south, the
ground rises steeply.")
      (SOUTH TO C8 IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest.")
      (NORTH TO C6 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (NE TO D6 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
south to east, with a narrow spur leading north.")
      (NW TO B6 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (ACTION FOREST-ROOM-F)>

<ROOM C8
      (EW 3)
      (NS 8)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO B8 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
northwest to southeast. Behind the tracks, to the west and south, the
ground rises steeply.")
      (EAST TO D8 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
north to southwest.")
      (SE TO D9 IF HACK-FLAG ELSE
"You cross a roadway and come to the edge of a putrid swamp, which
runs off to the northeast.")
      (SW TO B8 IF HACK-FLAG ELSE
"You leave the forest and come to some railroad tracks, running
northwest to southeast. Behind the tracks, to the west and south, the
ground rises steeply.")
      (SOUTH TO C9 IF HACK-FLAG ELSE
"You emerge from the forest into an open area through which runs
a railroad track running to the northwest and a roadway running to the
northeast. Both lead south into a tunnel.")
      (NORTH TO C7 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (NE TO D7 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
north to south.")
      (NW TO B7 IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on through the forest.")
      (ACTION FOREST-ROOM-F)>

<ROOM C9
      (EW 3)
      (NS 9)
      (LOC ROOMS)
      (DESC "Mouth of Tunnel")
      (LDESC
"Both the road and the railroad tracks lead into a dark tunnel to the south.
If your memory from the train serves, this tunnel is miles long, and without
interruption. The tracks continue toward the border to the northwest, and
the road bends to the northeast. A dark forest stretches before you to the
north.")
      (PATH 0)
      (WEST SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (EAST TO D9 IF FALSE-FLAG ELSE
"You continue through the forest, coming finally to the edge of a putrid
swamp, which winds its way off to the northeast.")
      (SE TO D9 IF FALSE-FLAG ELSE
"You continue through the forest, coming finally to the edge of a putrid
swamp, which winds its way off to the northeast.")
      (SW SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (SOUTH SORRY
"It would take hours to get through the tunnel, and your mission would
undoubtably fail. You'd best find a way across the border.")
      (NORTH TO C8 IF HACK-FLAG ELSE
"You leave the side of the railroad tracks and head into the forest.
The darkness is deeper here, as less moonlight reaches the forest floor.
The snow crunches under your feet, and you pause after moving a hundred or
so yards into the forest.")
      (NE TO D8)
      (NW TO B8 IF HACK-FLAG ELSE
"You continue along the tracks for about a hundred yards.")
      (FLAGS TRACKSBIT ROADBIT)>

<ROOM D3
      (EW 4)
      (NS 3)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO C3 IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest.")
      (EAST TO E3 IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on through the forest.")
      (SE TO E4 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (SW TO OUTSIDE-SHED IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest, until you stop at
a small wooden shed.")
      (SOUTH TO D4 IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest.")
      (NORTH TO D2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (NE TO E2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (NW TO C2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (ACTION FOREST-ROOM-F)>

<ROOM D4
      (EW 4)
      (NS 4)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO OUTSIDE-SHED IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest, until
you come to a small wooden shed.")
      (EAST TO E4 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SE TO E5 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SW TO C5 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SOUTH TO NORTH-HUT IF HACK-FLAG ELSE
"You walk for a short while and come to a large clearing, to the east of
which lies a small hut. Concerned about the possibility of being seen,
you head toward a spot on the north side of the hut, where you can
check the situation out.")
      (NORTH TO D3 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (NE TO E3 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (NW TO C3 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (ACTION FOREST-ROOM-F)>

<ROOM D5
      (EW 4)
      (NS 5)
      (FLAGS VILLAGEBIT)
      (LOC ROOMS)
      (DESC "Clearing")
      (PATH 0)
      (WEST TO C5 IF HACK-FLAG ELSE
"You enter the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (EAST TO OUTSIDE-HUT IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you walk to the front door of the hut.")
      (SE TO SOUTH-HUT IF HACK-FLAG ELSE
"You walk around to the south side of the hut.")
      (SW TO C6 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you enter the
forest.")
      (SOUTH TO ROAD-END IF HACK-FLAG ELSE
"You continue until you come to the start of a roadway leading south.")
      (NORTH TO D4 IF HACK-FLAG ELSE
"You enter the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (NE TO NORTH-HUT IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on to the north side of the hut.")
      (NW TO OUTSIDE-SHED IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed into the forest, stopping as you come upon a
small wooden shed.")
      (ACTION D5-F)
      (WOODFCN D5-WF)
      (GLOBAL HUT CHIMNEY)
      (FIRE
"You continue along until you enter a clearing; to the east, before you,
lies a burning hut, sending plumes of black smoke and orange flame into
the sky.")>

<GLOBAL HUT-BURNING <>>

<ROUTINE D5-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing in a small clearing in the forest. To the east, there
is a small hut,">
		<COND (<NOT ,HUT-BURNING>
		       <TELL
" and it would seem that somebody is inside,
judging by the swirls of smoke that pour through the chimney and into
the night sky.">)
		      (T
		       <TELL
" engulfed in flame. Large plumes of black smoke rise into the night
sky.">)>
		<TELL
" To the south lies the start of a paved road which gently winds
its way through the trees and out of sight. The forest surrounds the
clearing in the other directions, though it appears that a poorly
defined path leads to the northwest." CR>
		<HUT-MAN-DESC
"|
You can see the owner of the hut">
		<RTRUE>)>>

<OBJECT HUT
	(LOC LOCAL-GLOBALS)
	(DESC "hut")
	(SYNONYM HUT HOUSE HOME BUILDING)
	(ADJECTIVE WOODEN WOOD)
	(ACTION HUT-F)>

<OBJECT CHIMNEY
	(LOC LOCAL-GLOBALS)
	(DESC "chimney")
	(SYNONYM CHIMNEY)
	(ACTION CHIMNEY-F)>

<ROUTINE CHIMNEY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Besides the smoke coming out, there's not much to tell." CR>)
	       (<VERB? ENTER CLIMB-DOWN CLIMB-UP CLIMB>
		<TELL
"You would be incinerated." CR>)>>

<ROUTINE HUT-F ("AUX" RM)
	 <COND (<VERB? EXAMINE>
		<COND (,HUT-BURNING
		       <TELL
"There's not much to tell; the entire wooden structure is now engulfed
in flames, and the heat and smoke make it hard to get much closer." CR>)
		      (T
		       <TELL
"The hut is small, perhaps no more than a few rooms. The exterior is a
dark wooden clapboard, worn and weaterbeaten. Some black smoke rises out
of a small chimney, swirling around in the cold breeze, and vanishing
into the night sky." CR>)>)
	       (<VERB? CLIMB CLIMB-OVER CLIMB-UP>
		<TELL
"There's nothing on top of the hut except for the chimney, so unless
you're Santa Claus it won't be of much use." CR>)
	       (<VERB? ENTER LEAVE>
		<COND (,HUT-BURNING
		       <TELL
"It's too late for that." CR>)
		      (<AND <VERB? ENTER>
			    <EQUAL? ,HERE ,BEHIND-HUT>>
		       <DO-WALK ,P?IN>
		       <RTRUE>)
		      (<AND <VERB? LEAVE>
			    <EQUAL? ,HERE ,HUT-STORAGE>>
		       <DO-WALK ,P?OUT>
		       <RTRUE>)
		      (T
		       <TELL
"You'll have to figure out how to do that." CR>)>)
	       (<AND <VERB? LOOK-INSIDE>
		     <GLOBAL-IN? ,HUT-WINDOW ,HERE>>
		<PERFORM ,PRSA ,HUT-WINDOW>
		<RTRUE>)
	       (<VERB? WALK-AROUND>
		<COND (<SET RM <LKP ,HERE ,HUT-WALKS>>
		       <COND (,HUT-BURNING
			      <TELL
"You cough from the smoke you've inhaled, but continue around the remains
of the burning hut..." CR CR>)>
		       <GOTO .RM>
		       <RTRUE>)
		      (T
		       <TELL
"You can only walk around the hut if you're standing just outside of it."
CR>)>)>>

<GLOBAL HUT-WALKS
	<PLTABLE OUTSIDE-HUT NORTH-HUT BEHIND-HUT SOUTH-HUT OUTSIDE-HUT 0>> 

<ROUTINE LKP (THING TBL "AUX" (SIZE <GET .TBL 0>) FROB)
	 <REPEAT ()
		 <COND (<EQUAL? <SET FROB <GET .TBL 1>> .THING>
			<RETURN <GET .TBL 2>>)
		       (<ZERO? .FROB>
			<RFALSE>)>
		 <SET TBL <REST .TBL 2>>>>

<ROUTINE D5-WF (FRM)
        <COND (<EQUAL? ,HERE ,D5>
	       <MAN-CATCHES>)
	      (<OR <EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT>
		   <EQUAL? ,HERE ,ROAD-END ,OUTSIDE-HUT>>
	       <COND (<EQUAL? .FRM ,OUTSIDE-SHED> ;"returning"
	       	      <COND (,HUT-BURNING
			     <REMOVE ,HUT-MAN>
			     <SETG WOOD-COUNT -10000>
			     ;"Turn off this interrupt the hard way"
			     <BOLDTELL
"The man, carrying a pile of wood, walks into the clearing and seeing that
his hut is on fire, runs off into the forest to the northeast.">)
			    (T
			     <BOLDTELL
"The man, carrying a large pile of wood in his arms, walks out of
the forest and into the clearing.">)>)
		     (T
		      <BOLDTELL
"The man walks from the front of the hut and into the clearing,
continuing to the northwest and out of sight.">)>)
	      (<AND <EQUAL? .FRM ,OUTSIDE-SHED> ,HUT-BURNING>
	       <SETG WOOD-COUNT -10000>)>>

<ROOM OUTSIDE-HUT
      (EW 4)
      (NS 5)
      (FLAGS VILLAGEBIT OUTHUTBIT)
      (PATH 0)
      (LOC ROOMS)
      (DESC "Outside Hut")
      (NORTH TO NORTH-HUT IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed to the north side of the house.")
      (SOUTH TO ROAD-END IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed to a point at which a road leading south
through the forest begins.")
      (NW TO D5 IF HACK-FLAG ELSE
"You enter the forest, breaking branches as you go, and
finally stop as you come into a clearing, to the east of which is a small
hut.")
      (SW TO ROAD-END IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed to a point at which a road leading south
through the forest begins.")
      (NE TO NORTH-HUT IF HACK-FLAG ELSE
"You walk around to the north side of the hut.")
      (SE TO SOUTH-HUT IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on to the south side of the hut.")
      (EAST TO HUT-LIVING IF HUT-FRONT-DOOR IS OPEN)
      (WEST TO D5 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk into the clearing.")
      (ACTION OUTSIDE-HUT-F)
      (WOODFCN OUTSIDE-HUT-WF)
      (GLOBAL HUT CHIMNEY HUT-FRONT-DOOR)
      (FIRE
"You continue until reaching the front of the blazing hut. The heat is so
extreme that you can't get within twenty feet of it.")>

<ROUTINE OUTSIDE-HUT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing outside of the ">
		<COND (,HUT-BURNING <TELL "blazing ">)>
		<TELL "hut, just a few feet away from the
front door. You could walk around the house to either the northeast
or southeast, or you could return to the clearing just west of here or the
road that starts just to the south. All other directions lead back into
the forest." CR>
		<HUT-MAN-DESC
"|
You can see the owner of the hut">
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>
		     <EQUAL? ,PRSO ,P?EAST ,P?IN>
		     ,HUT-BURNING>
		<SETG P-WALK-DIR <>>
		<PERFORM ,V?ENTER ,HUT>
		<RTRUE>)>>

<ROUTINE OUTSIDE-HUT-WF (FRM)
	 <COND (<EQUAL? ,HERE ,OUTSIDE-HUT>
		<MAN-CATCHES>)
	       (<AND <EQUAL? .FRM ,D5>
		     <EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT ,ROAD-END>>
		<COND (,HUT-BURNING
		       <REMOVE ,HUT-MAN>
		       <SETG WOOD-COUNT -10000>
		       ;"Turn off this interrupt the hard way"
		       <BOLDTELL
"The man, seeing that his hut is on fire, runs off into the forest to the
northeast.">)
		      (T
		       <BOLDTELL
"The man walks up to the front of the hut, and fumbles around with the
door, though his hands are full of logs.">)>)
	       (<OR <EQUAL? ,HERE ,NORTH-HUT ,SOUTH-HUT ,ROAD-END>
		    <EQUAL? ,HERE ,BEHIND-HUT>>
		<BOLDTELL
"The man walks out of the hut and heads toward the clearing.">)>>

<ROOM NORTH-HUT
      (EW 4)
      (NS 5)
      (FLAGS VILLAGEBIT OUTHUTBIT)
      (PATH 0)
      (LOC ROOMS)
      (DESC "North Side of Hut")
      (NE TO E4 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SE TO BEHIND-HUT IF HACK-FLAG ELSE
"You walk around the house to the back; a door here leads into the hut.")
      (EAST TO BEHIND-HUT IF HACK-FLAG ELSE
"You walk around the house to the back; a door here leads into the hut.")
      (WEST TO D5 IF HACK-FLAG ELSE
"You walk around the house and into the clearing.")
      (NW TO D4 IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest.")
      (SW TO OUTSIDE-HUT IF HACK-FLAG ELSE
"You walk around to the front of the house.")
      (NORTH TO D4 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (SOUTH SORRY
"There's no way into the hut from here.")
      (ACROSS HUT-LIVING)
      (ACTION NORTH-HUT-F)
      (GLOBAL HUT-WINDOW HUT CHIMNEY)
      (FIRE
"You continue until reaching the north side of a blazing
hut. With the extreme heat here, you can't get close at all.")>

<ROUTINE NORTH-HUT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER-DESC>
		<CAR-SEQ-TELL>
		<HUT-MAN-DESC
"|
You can see the owner of the hut">
		<RTRUE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are on the north side of the ">
		<COND (,HUT-BURNING <TELL "burning ">)>
		<TELL "hut, the front door and a small
clearing lying to your southwest and the rear of the hut to your southeast.">
		<COND (<NOT ,HUT-BURNING>
		       <TELL
" A small window looks into what appears to be the living room." CR>)>
		<CAR-SEQ-TELL>
		<RTRUE>)>>

<ROUTINE CAR-SEQ-TELL ()
	 <COND (,HUT-MAN-DIVERSION
		<TELL CR
"The man from the hut is standing out front, looking a bit confused. He
takes a few tentative steps in different directions, hoping perhaps to sense
better the source of the explosion.">)
	       (<G? ,CAR-SEQUENCE 0>
		<CRLF>
		<COND (<NOT <ZERO? <LOC ,SCOUT>>>
		       <TELL "Two">)
		      (T
		       <TELL "Three">)>
		<TELL 
" men, presumably from the automobile parked at the end of the roadway
south of the clearing, are ">
		<COND (<L? ,CAR-SEQUENCE 4>
		       <TELL
"walking toward the front door of the hut">)
		      (<EQUAL? ,CAR-SEQUENCE 4>
		       <TELL
"standing at the front door of the hut, talking quietly among themselves,
as if waiting for someone to answer the door">)
		      (T
		       <TELL
"in quiet conversation with a man, presumably the owner of the hut,
who stands leaning against the closed front door. They seem to be lecturing
him about something, for he speaks little and nods often">)>
		<TELL ".">
		<COND (<NOT <SCOUT-TELL>>
		       <CRLF>)>
		<RTRUE>)
	       (<IN? ,CAR ,ROAD-END>
		<TELL CR
"Three men have just returned to their automobile which was parked at the
end of the roadway just south of the clearing. The car has been started and is
preparing to depart." CR>)>>

<OBJECT HUT-WINDOW
	(LOC LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW)
	(ACTION HUT-WINDOW-F)>

<ROUTINE HUT-WINDOW-F ("AUX" (H <>))
	 <COND  (,HUT-BURNING
		 <TELL "It's engulfed in flame." CR>
		 <RTRUE>)
		(<VERB? EXAMINE LOOK-INSIDE>
		<COND (<AND <EQUAL? ,HERE ,HUT-STORAGE ,BEHIND-HUT>
			    <FSET? ,HUT-BACK-DOOR ,OPENBIT>>
		       <TELL
"The door's open, so the view isn't too interesting." CR>
		       <RTRUE>)>
		<TELL "You look through the window and see ">
		<COND (<EQUAL? ,HERE ,HUT-LIVING ,HUT-BEDROOM ,HUT-STORAGE>
		       <TELL "a wintry landscape.">
		       <COND (<AND <EQUAL? ,HERE ,HUT-STORAGE>
				   <IN? ,SCOUT ,BEHIND-HUT>>
			      <TELL
" A lone scout is walking toward the south side of the hut.">)>)
		      (<EQUAL? ,HERE ,NORTH-HUT>
		       <TELL "the living room, furnished sparsely.">
		       <SET H ,HUT-LIVING>)
		      (<EQUAL? ,HERE ,SOUTH-HUT>
		       <TELL "the bedroom, furnished sparsely.">
		       <SET H ,HUT-BEDROOM>)
		      (<EQUAL? ,HERE ,BEHIND-HUT>
		       <TELL "the storage room.">
		       <SET H ,HUT-STORAGE>)>
		<COND (<AND .H <IN? ,HUT-MAN .H>>
		       <TELL " A man is there!">)>
		<CRLF>)
	       (<VERB? OPEN CLOSE>
		<TELL
"The windows here don't open and close - not surprising, for an
inexpensively built hut like this." CR>)
	       (<VERB? KNOCK>
		<TELL
"Not smart; sombody might hear you." CR>)
	       (<VERB? MUNG KICK>
		<TELL
"Not smart. If somebody's home, you're in big trouble, and if nobody's
home, the broken window will just alert the owner to trouble when he
returns." CR>)>>

<ROOM SOUTH-HUT
      (EW 4)
      (NS 5)
      (FLAGS VILLAGEBIT OUTHUTBIT)
      (PATH 0)
      (LOC ROOMS)
      (DESC "South Side of Hut")
      (NE TO BEHIND-HUT IF HACK-FLAG ELSE
"You walk around the house to the back; the door is closed.")
      (SE TO E6 IF HACK-FLAG ELSE
"You reenter the forest and soon come to a roadway running from
east to west.")
      (EAST TO BEHIND-HUT IF HACK-FLAG ELSE
"You walk around the house to the back; the door is closed.")
      (WEST TO D5 IF HACK-FLAG ELSE
"You walk around the house and into the clearing.")
      (SW TO ROAD-END IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and move to a point in the forest at which a small
road leads south.")
      (NW TO OUTSIDE-HUT IF HACK-FLAG ELSE
"You walk around to the front of the house.")
      (NORTH SORRY
"There's no way into the hut from here.")
      (SOUTH TO ROAD-END IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and move to a point in the forest at which a small
road leads south.")
      (ACTION SOUTH-HUT-F)
      (GLOBAL HUT-WINDOW HUT CHIMNEY)
      (FIRE
"You reach the south side of a hut, now completely ablaze. The heat from
the flames makes it impossible to go any closer.")>

<ROUTINE SOUTH-HUT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER-DESC>
		<CAR-SEQ-TELL>
		<HUT-MAN-DESC
"|
You can see the owner of the hut">
		<RTRUE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<COND (<NOT ,HUT-BURNING>
		       <TELL
"You are on the south side of the hut. Northwest of here lies the front
of the hut, and beyond that a small clearing. To the northeast lies the
back side of the hut. Through a small window, you can see the bedroom." CR>)
		      (T
		       <TELL
"You are south of the burning hut. To the northwest is the front of the
hut, and beyond that a small clearing." CR>)>
		<CAR-SEQ-TELL>
		<RTRUE>)>>

<ROOM BEHIND-HUT
      (EW 4)
      (NS 5)
      (FLAGS VILLAGEBIT OUTHUTBIT)
      (PATH 0)
      (LOC ROOMS)
      (DESC "Behind Hut")
      (NW TO NORTH-HUT IF HACK-FLAG ELSE
"You walk around to the north side of the house.")
      (WEST TO HUT-STORAGE IF HUT-BACK-DOOR IS OPEN)
      (IN-DIR P?WEST)
      (SW TO SOUTH-HUT IF HACK-FLAG ELSE
"You walk around to the south side of the house.")
      (SOUTH TO SOUTH-HUT IF HACK-FLAG ELSE
"You walk around to the south side of the house.")
      (SE TO E6 IF HACK-FLAG ELSE
"You enter the forest, but soon emerge at a roadway running from
east to west.")
      (EAST TO E5 IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on into the forest.")
      (NE TO E4 IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue into the forest.")
      (NORTH TO NORTH-HUT IF HACK-FLAG ELSE
"You walk around to the north side of the hut.")
      (GLOBAL HUT-BACK-DOOR HUT-WINDOW HUT CHIMNEY)
      (ACTION BEHIND-HUT-F)
      (FIRE
"You continue until you reach the back side of a blazing hut.
Engulfed as it is in flames, you cannot possibly get closer.")>

<ROUTINE BEHIND-HUT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<NOT ,HUT-BURNING>
		       <TELL
"You are standing at the back door of the hut, which can be circled to
the northwest and the southwest. On all other sides lies the forest.">
		       <COND (<FSET? ,HUT-BACK-DOOR ,OPENBIT>
			      <TELL " The door stands open.">)
			     (T
			      <TELL " A small window in the door gives
a view into the house.">)>
		       <CRLF>)
		      (T
		       <TELL
"You are standing at the back of the blazing hut, which can be circled to
the northwest and southwest. The forest surrounds you on all other
sides." CR>)>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>
		     <EQUAL? ,PRSO ,P?WEST ,P?IN>
		     ,HUT-BURNING>
		<SETG P-WALK-DIR <>>
		<PERFORM ,V?ENTER ,HUT>
		<RTRUE>)>>
	       

<OBJECT HUT-BACK-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "back door")
	(SYNONYM DOOR HINGES HINGE)
	(ADJECTIVE BACK)
	(FLAGS DOORBIT)
	(ACTION HUT-BACK-DOOR-F)>

<GLOBAL DOOR-OILED <>>

<ROUTINE HUT-BACK-DOOR-F ()
	 <COND (,HUT-BURNING
		<TELL
"The door is completely in flames." CR>)
	       (<VERB? KNOCK>
		<TELL
"What, are you crazy? What if someone's home?" CR>)
	       (<AND <VERB? OPEN>
		     <NOT <FSET? ,PRSO ,OPENBIT>>
		     <NOT ,DOOR-OILED>>
		<TELL "The door squeaks loudly as you open it." CR>
		<COND (<EQUAL? <LOC ,HUT-MAN> ,HUT-LIVING ,HUT-BEDROOM>
		       <CRLF>
		       <JIGS-UP
"Unfortunately, someone was indeed home, and carrying a weapon at that.
He motions you to the door, and you follow him as he telephones for
the border police.">)>
		<FSET ,PRSO ,OPENBIT>)
	       (<OR <AND <VERB? OIL> <IN? ,OIL-CAN ,WINNER>>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,OIL-CAN>>>
		<COND (<EQUAL? ,HERE ,BEHIND-HUT>
		       <TELL
"A good idea, but the hinges are on the inside, so you'll have to do it
from there." CR>)
		      (T
		       <TELL
"The squeaky door gets the grease, or words to that effect. The door seems
quieter already." CR>
		       <SETG DOOR-OILED T>)>)
	       (<VERB? OIL>
		<TELL
"You aren't holding any oil." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The wooden door is chipped in places, but is otherwise
in pretty good shape. The hinges, though, are rusted badly">
		<COND (<NOT ,DOOR-OILED>
		       <TELL " - it'll make
some noise when it's opened">)>
		<TELL ,PERIOD-CR>)
	       (<AND <VERB? CLOSE>
		     <NOT ,DOOR-OILED>
		     <FSET? ,PRSO ,OPENBIT>>
		<TELL
"The door squeaks loudly as you start to pull it closed." CR>
		<FCLEAR ,PRSO ,OPENBIT>)>>

<OBJECT HUT-MAN
	(LOC HUT-LIVING)
	(DESC "man")
	(SYNONYM MAN)>	

<OBJECT HUT-FRONT-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "front door")
	(SYNONYM DOOR)
	(ADJECTIVE FRONT)
	(FLAGS DOORBIT)
	(ACTION HUT-FRONT-DOOR-F)>

<ROUTINE MAN-AT-HOME? ()
	 <COND (<EQUAL? <LOC ,HUT-MAN>
			,HUT-STORAGE ,HUT-LIVING ,HUT-BEDROOM>)>>

<ROUTINE HUT-FRONT-DOOR-F ()
	 <COND (,HUT-BURNING
		<TELL
"What's left of it is in flames." CR>)
	       (<AND <VERB? KNOCK>
		     <EQUAL? ,HERE ,HUT-LIVING>>
		<TELL
"That would be dangerous, particularly if anyone's outside." CR>)
	       (<AND <VERB? OPEN KNOCK> <MAN-AT-HOME?>>
		<JIGS-UP
"Unfortunately, somebody's home, though he isn't very hospitable looking with
his revolver in hand.">
		<RTRUE>)
	       (<VERB? OPEN>
		<COND (<IN? ,CAR ,ROAD-END>
		       <TELL
"That would be foolish, with guards standing just outside." CR>)
		      (T
		       <RFALSE>)>)>>

<ROUTINE HUT-STORAGE-EXIT ()
	 <COND (<FSET? ,HUT-BACK-DOOR ,OPENBIT>
		<FCLEAR ,HUT-BACK-DOOR ,OPENBIT>
		<TELL
"You walk out into the night air, closing the door behind you." CR CR>
		,BEHIND-HUT)
	       (T
		<TELL
"The door is closed." CR>
		<RFALSE>)>>

<ROOM HUT-STORAGE
      (EW 4)
      (NS 5)
      (FLAGS VILLAGEBIT HUTBIT)
      (PATH 0)
      (LOC ROOMS)
      (DESC "Storage Area")
      (EAST PER HUT-STORAGE-EXIT)
      (WEST TO HUT-LIVING)
      (OUT PER HUT-STORAGE-EXIT)
      (ACTION HUT-STORAGE-F)
      (WOODFCN HUT-STORAGE-WF)
      (GLOBAL HUT-WINDOW HUT CHIMNEY HUT-BACK-DOOR)>

<GLOBAL HUT-STORE-FLAG T>

<ROUTINE HUT-STORAGE-WF (FRM)
	 <COND (<EQUAL? ,HERE ,HUT-STORAGE>
		<MAN-CATCHES>)
	       (,HUT-STORE-FLAG
		;"Coming to get it"
		<SETG HUT-STORE-FLAG <>>
		<COND (<EQUAL? ,HERE ,NORTH-HUT>
		       <COND (<IN? ,PARKA ,HUT-STORAGE>
			      <MOVE ,PARKA ,HUT-MAN>)>
		       <BOLDTELL
"You watch through the window as the man walks out of sight toward the
back of the hut.">)
		      (<EQUAL? ,HERE ,BEHIND-HUT>
		       <HLIGHT ,H-BOLD>
		       <CRLF>
		       <TELL
"You watch through the window as the man enters the storage area and ">
		       <COND (<IN? ,PARKA ,HUT-STORAGE>
			      <MOVE ,PARKA ,HUT-MAN>
			      <TELL "puts
on the white parka which is lying there, then ">)
			     (T
			      <TELL "seems
to search for something; after a moment, he ">)>
		       <TELL "heads back toward the front
of the hut.">
		       <HLIGHT ,H-NORMAL>
		       <CRLF>)>)
	       (T
		<COND (<IN? ,PARKA ,HUT-MAN>
		       <MOVE ,PARKA ,HUT-STORAGE>)>
		<COND (<EQUAL? ,HERE ,NORTH-HUT>
		       <BOLDTELL
"Through the window, you watch as the man walks
out of sight toward the rear of the hut.">)
		      (<EQUAL? ,HERE ,BEHIND-HUT>
		       <COND (<IN? ,PARKA ,HUT-STORAGE>
			      <BOLDTELL
"The man, coat in hand, enters the storage area and throws the coat
onto the floor. After looking around for a moment, he returns whence
he came.">)
			     (T
			      <BOLDTELL
"The man enters the storage area, looks around for a moment, scratches his
balding head, and returns whence he came.">)>)>)>>

<ROUTINE HUT-STORAGE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The storage area connects to the main living area of the hut through an
open doorway to the west. A door which is ">
		<DOOR-TELL ,HUT-BACK-DOOR>
		<TELL " leads back into the forest." CR>)>>

<ROUTINE DOOR-TELL (D)
	 <COND (<FSET? .D ,OPENBIT> <TELL "open">)
	       (T <TELL "closed">)>>

<OBJECT HUT-WOOD
	(LOC HUT-LIVING)
	(DESC "wood pile")
	(SYNONYM PILE WOOD)
	(ADJECTIVE WOOD)
	(FLAGS NDESCBIT)
	(ACTION HUT-WOOD-F)>

<GLOBAL HUT-WOOD-ADDED <>>

<ROUTINE HUT-WOOD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The pile is sitting next to the wood stove, and has about ">
		<COND (,HUT-WOOD-ADDED
		       <TELL "twenty">)
		      (T
		       <TELL "a dozen">)>
		<TELL " pieces of wood on it." CR>)
	       (<VERB? TAKE>
		<TELL "It can't help you. Leave it alone." CR>)
	       (<VERB? CUT>
		<TOO-LATE>)>>

<ROOM HUT-LIVING
      (EW 4)
      (NS 5)
      (FLAGS VILLAGEBIT HUTBIT)
      (PATH 0)
      (LOC ROOMS)
      (DESC "Living Room")
      (WEST TO OUTSIDE-HUT IF HUT-FRONT-DOOR IS OPEN)
      (EAST TO HUT-STORAGE)
      (SOUTH TO HUT-BEDROOM)
      (OUT TO OUTSIDE-HUT IF HUT-FRONT-DOOR IS OPEN)
      (ACTION HUT-LIVING-F)
      (GLOBAL HUT-WINDOW HUT HUT-FRONT-DOOR)
      (WOODFCN HUT-LIVING-WF)>

<ROUTINE TAKEABLE? (OBJ "AUX" F)
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F> <RFALSE>)
		       (<FSET? .F ,TAKEBIT>
			<RTRUE>)
		       (T
			<SET F <NEXT? .F>>)>>>

<OBJECT GLOBAL-HUT-MAN
	(LOC GLOBAL-OBJECTS)
	(DESC "hut owner")
	(SYNONYM OWNER MAN)
	(ADJECTIVE HUT)
	(SCENARIO 2)
	(ACTION GLOBAL-HUT-MAN-F)>

<ROUTINE GLOBAL-HUT-MAN-F ()
	 <COND (<VERB? FOLLOW>
		<TELL
"Unwise; if he saw you, the results could be disastrous." CR>)
	       (<VERB? EXAMINE>
		<COND (<HUT-MAN-DESC> T)
		      (T
		       <TELL "You can't see him here." CR>)>)>>

<ROUTINE HUT-MAN-DESC ("OPTIONAL" (STR "He's"))
	 <COND (<AND <IN? ,HUT-MAN ,HUT-LIVING>
		     <NOT ,HUT-BURNING>
		     <EQUAL? ,HERE ,NORTH-HUT ,HUT-BEDROOM ,HUT-STORAGE>>
		<TELL .STR " in the living room, ">
		<COND (<OR ,WOOD-RETURNING <NOT <G? ,WOOD-COUNT 0>>>
		       <TELL "sitting in a chair">)
		      (<EQUAL? ,HUT-MAN-FROM ,OUTSIDE-HUT>
		       <TELL "heading toward the storage area">)
		      (T
		       <TELL "heading toward the front door">)>
		<TELL ,PERIOD-CR>)
	       (<AND <IN? ,HUT-MAN ,D5>
		     <OR <EQUAL? ,HERE ,OUTSIDE-HUT ,SOUTH-HUT ,NORTH-HUT>
			 <EQUAL? ,HERE ,ROAD-END>>>
		<TELL .STR " in the clearing, ">
		<COND (<EQUAL? ,HUT-MAN-FROM ,OUTSIDE-HUT>
		       <TELL "heading into the forest to the northwest">)
		      (T
		       <TELL "heading back toward the hut with an armful
of logs">)>
		<TELL ,PERIOD-CR>)
	       (<AND <IN? ,HUT-MAN ,INSIDE-SHED>
		     <EQUAL? ,HERE ,OUTSIDE-SHED>>
		<TELL .STR " inside the shed, collecting logs." CR>)
	       (<AND <IN? ,HUT-MAN ,HUT-STORAGE>
		     <EQUAL? ,HERE ,BEHIND-HUT ,HUT-LIVING>>
		<TELL .STR " in the storage area, ">
		<COND (,WOOD-RETURNING
		       <TELL "preparing to return to the living room">)
		      (T
		       <TELL "looking for his parka">)>
		<TELL ,PERIOD-CR>)
	       (<AND <IN? ,HUT-MAN ,OUTSIDE-HUT>
		     <OR <EQUAL? ,HERE ,ROAD-END ,D5 ,NORTH-HUT>
			 <EQUAL? ,HERE ,SOUTH-HUT>>
		     <G? ,WOOD-COUNT 0>>
		<TELL .STR " outside the hut, ">
		<COND (<EQUAL? ,HUT-MAN-FROM ,D5>
		       <TELL "heading inside with an armful of logs">)
		      (T
		       <TELL "heading off toward the clearing">)>
		<TELL ,PERIOD-CR>)>>

<ROUTINE HUT-LIVING-WF (FRM)
	 <COND (<EQUAL? ,HERE ,HUT-LIVING ,HUT-BEDROOM>
		<MAN-CATCHES T>)
	       (<EQUAL? .FRM ,OUTSIDE-HUT>
		<COND (,HUT-BURNING
		       <REMOVE ,HUT-MAN>
		       <SETG WOOD-COUNT -10000>
		       ;"Turn off this interrupt the hard way"
		       <BOLDTELL
"The man, seeing that his hut is on fire, runs off into the forest to the
northeast.">)
		      (<EQUAL? ,HERE ,SOUTH-HUT ,ROAD-END>
		       <BOLDTELL
"You watch the man, carrying a large pile of wood, reenter his hut.">)
		      (<EQUAL? ,HERE ,NORTH-HUT ,HUT-BEDROOM>
		       <SETG HUT-WOOD-ADDED T>
		       <BOLDTELL
"You watch as the man enters the hut, drops the pile of wood on the floor
near the wood stove, and heads toward the rear of the hut.">)
		      (<EQUAL? ,HERE ,HUT-STORAGE>
		       <BOLDTELL
"The owner of the hut returns with a pile of wood in his hands. Luckily,
he hasn't seen you yet.">)>)
	       (,WOOD-RETURNING
		;"Coming back from returning parka"
		<COND (<EQUAL? ,HERE ,NORTH-HUT>
		       <BOLDTELL
"Through the window, you watch the man return to the living room, throw
some logs into the wood stove, and return to his easy chair.">)
		      (<EQUAL? ,HERE ,HUT-BEDROOM>
		       <TELL
"You see the man return to the living room, then pass your line of sight.
Presumably, he has taken a seat there." CR>)
		      (<EQUAL? ,HERE ,BEHIND-HUT>
		       <MAN-TO-LIVING-ROOM>)>
		<OWNER-NOTICES?>
		<RTRUE>)
	       (<EQUAL? ,HERE ,NORTH-HUT>
		<CRLF>
		<HLIGHT ,H-BOLD>
		<TELL
"Through the window, you see the man enter the living room">
		<COND (<IN? ,PARKA ,HUT-MAN>
		       <TELL " wearing a white parka">)>
		<TELL
", and proceed to the front door, stopping for a moment to count the
logs sitting by the wood stove.">
		<HLIGHT ,H-NORMAL>
		<CRLF>)
	       (<EQUAL? ,HERE ,BEHIND-HUT>
		<MAN-TO-LIVING-ROOM>)>> 

<ROUTINE OWNER-NOTICES? ()
	 <COND (<AND <TAKEABLE? ,HUT-LIVING>
		     <FSET? ,HERE ,HUTBIT>>
		<CRLF>
		<HLIGHT ,H-BOLD>
		<MOVE ,HUT-MAN ,HERE>
		<JIGS-UP
"The owner, presumably alerted by something amiss in the living
room, has no trouble locating you. In a short time, the border
patrol has arrived.">)>>

<ROUTINE MAN-TO-LIVING-ROOM ()
	 <BOLDTELL
"The man returns to the living room, leaving your line of sight.">>

<ROUTINE MAN-CATCHES ("OPTIONAL" (HME? <>))
	 <MOVE ,HUT-MAN ,HERE>
	 <HLIGHT ,H-BOLD>
	 <CRLF>
	 <COND (.HME?
		<TELL
"The owner of the hut returns to the living room and spots you before
you can react. He">
		<JIGS-UP ,HAVE-A-SEAT>)
	       (<FSET? ,HERE ,HUTBIT>
		<TELL
"The owner of the hut spots you, and">
		<JIGS-UP ,HAVE-A-SEAT>)
	       (T
		<JIGS-UP ,HUT-MAN-HALT>)>
	 <RTRUE>>

<CONSTANT HAVE-A-SEAT
" reaches for a gun which he carries
under his belt. \"Have a seat,\" he advises, as he calls for the
authorities on his radio telephone. All you can do is wait until they
arrive.">

<ROUTINE HUT-LIVING-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The main living area in the hut is extremely simple, consisting of
a couch, a table, a few chairs, and a small kitchen area. A woodstove
in the corner keeps the room warm, and a small lightbulb dangling from the end
of a cord keeps the room lit. On a wall hangs what appears to be a map of
the local area. To the south, a doorway leads to the bedroom, and to the
east, a smaller doorway leads to what appears from here to
be a storage area. The front door, to the west, leads outside. At the moment,
it is ">
		<DOOR-TELL ,HUT-FRONT-DOOR>
		<TELL ,PERIOD-CR>)>> 

<OBJECT HUT-MAP
	(LOC HUT-LIVING)
	(SYNONYM MAP DIAGRAM)
	(DESC "map")
	(FLAGS READBIT NDESCBIT)
	(ACTION HUT-MAP-F)>

<ROUTINE HUT-MAP-F ()
	 <COND (<VERB? OPEN>
		<TELL
"It's framed on the wall, not folded up!" CR>)
	       (<VERB? READ EXAMINE>
		<TELL
"This is the map included in your BORDER ZONE package." CR>)>>

<OBJECT MISC-LIVING
	(LOC HUT-LIVING)
	(DESC "living room item")
	(SYNONYM COUCH TABLE CHAIR CHAIRS BULB LIGHTBULB STOVE WOODSTOVE)
	(ADJECTIVE WOOD LIGHT)
	(FLAGS NDESCBIT)
	(ACTION MISC-LIVING-F)>

<ROUTINE MISC-LIVING-F ()
	 <TELL
"There's nothing of interest here; you'd best get on with your more
pressing problems." CR>> 

<OBJECT NORMAL-SHOES
	(DESC "pair of everyday black shoes")
	(SYNONYM PAIR SHOES)
	(ADJECTIVE EVERYDAY BLACK)
	(FLAGS WEARBIT TAKEBIT WORNBIT)
	(SCENARIO 2)
	(GENERIC GENERIC-SHOES)
	(ACTION SHOES-F)
	(SPEED 50)>

<GLOBAL SHOES-WORN 0>

<OBJECT PARKA
	(LOC HUT-STORAGE)
	(DESC "white down parka")
	(SYNONYM PARKA COAT OVERCOAT)
	(ADJECTIVE WHITE DOWN)
	(FLAGS WEARBIT TAKEBIT)
	(SCENARIO 2)> 

<OBJECT OIL-CAN
	(LOC HUT-STORAGE)
	(DESC "can of household oil")
	(SYNONYM CAN OIL)
	(ADJECTIVE HOUSEHOLD OIL)
	(FLAGS TAKEBIT)
	(SCENARIO 2)
	(ACTION OIL-CAN-F)>

<ROUTINE OIL-CAN-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"It's your everyday oil can, and it's pretty full of oil. Out here in the
middle of nowhere, it probably comes in quite handy." CR>)>>

<OBJECT WORK-SHOES
	(LOC HUT-STORAGE)
	(DESC "pair of work shoes")
	(SYNONYM PAIR SHOES WORKSHOES)
	(ADJECTIVE WORK HEAVY)
	(FLAGS WEARBIT TAKEBIT)
	(SCENARIO 2)
	(ACTION SHOES-F)
	(GENERIC GENERIC-SHOES)
	(SPEED 30)
	(SIZE 15)>

<ROUTINE GENERIC-SHOES ()
	 <COND (<AND <VERB? TAKE-OFF REMOVE>
		     <FSET? ,WORK-SHOES ,WORNBIT>>
		,WORK-SHOES)
	       (<AND <VERB? TAKE-OFF REMOVE>
		     <FSET? ,NORMAL-SHOES ,WORNBIT>>
		,NORMAL-SHOES)>>

<OBJECT BOOTS
	(LOC HUT-STORAGE)
	(DESC "pair of knee-boots")
	(SYNONYM PAIR BOOTS KNEE-BOOTS)
	(ADJECTIVE KNEE)
	(FLAGS WEARBIT TAKEBIT)
	(SCENARIO 2)
	(ACTION SHOES-F)
	(SPEED 40)
	(SIZE 10)>

<OBJECT KNAPSACK
	(LOC HUT-STORAGE)
	(DESC "knapsack")
	(SYNONYM KNAPSACK SACK PACK)
	(ADJECTIVE LARGE)
	(FLAGS TAKEBIT WEARBIT CONTBIT OPENBIT SEARCHBIT)
	(SCENARIO 2)
	(CAPACITY 60)
	(ACTION KNAPSACK-F)>

<ROUTINE KNAPSACK-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL
"The knapsack has a cover which can't be fastened, which is just as
well, since you don't have to worry about opening or closing it." CR>)>>

<ROUTINE SHOES-F ()
	 <COND (<VERB? CLEAN>
		<COND (<FSET? ,PRSO ,MUNGEDBIT>
		       <TELL
"It's a good idea, but facilities around here are scarce." CR>)
		      (T
		       <TELL "They'll do just fine as is." CR>)>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,PRSO ,WORK-SHOES>
		       <TELL
"These shoes have rugged soles for traction; they're in good shape">)
		      (<EQUAL? ,PRSO ,BOOTS>
		       <TELL
"The boots are about knee high, with fairly slick soles. They've seen
better days, but at least they appear to be intact">)
		      (T
		       <TELL "They're just an ordinary " D ,PRSO>)>
		<COND (<FSET? ,PRSO ,MUNGEDBIT>
		       <TELL ", though they're covered inside and out in swamp muck, which will slow you down a bit when you're wearing them">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? TAKE-OFF>
		<COND (,IN-SWAMP?
		       <TELL
"Not in the swamp, you won't!" CR>)
		      (,SHOES-WORN
		       <COND (<NOT <EQUAL? ,SHOES-WORN ,PRSO>>
			      <TELL "You're not wearing those." CR>)
			     (T
			      <TELL "You take off the " D ,SHOES-WORN
				    " and put them on the ground." CR>
			      <SETG SHOES-WORN <>>
			      <MOVE ,PRSO ,HERE>
			      <FCLEAR ,PRSO ,WORNBIT>
			      <RTRUE>)>)
		      (T
		       <TELL "You're not wearing any shoes." CR>)>)
	       (<VERB? WEAR>
		<COND (<EQUAL? ,SHOES-WORN ,PRSO>
		       <TOO-LATE>)
		      (,IN-SWAMP?
		       <TELL
"Not in the swamp, you won't!" CR>)
		      (,SHOES-WORN
		       <TELL "You take off the " D ,SHOES-WORN
			     ", put them on the ground, and put on the "
			     D ,PRSO "." CR>
		       <MOVE ,SHOES-WORN ,HERE>
		       <FCLEAR ,SHOES-WORN ,WORNBIT>
		       <SETG SHOES-WORN ,PRSO>
		       <FSET ,SHOES-WORN ,WORNBIT>
		       <MOVE ,SHOES-WORN ,WINNER>)
		      (T
		       <TELL "You put on the " D ,PRSO "." CR>
		       <FSET ,PRSO ,WORNBIT>
		       <MOVE ,PRSO ,WINNER>
		       <SETG SHOES-WORN ,PRSO>)>)>>

<ROOM HUT-BEDROOM
      (EW 4)
      (NS 5)
      (FLAGS VILLAGEBIT HUTBIT)
      (PATH 0)
      (LOC ROOMS)
      (DESC "Bedroom")
      (LDESC
"The bedroom is a shambles, consisting in all of a bed and a chair, over which
are draped assorted clothes too numerous and jumbled to mention. A small 
window looks south to a snowy landscape.")
      (NORTH TO HUT-LIVING)
      (OUT TO HUT-LIVING)
      (GLOBAL HUT-WINDOW HUT)>

<OBJECT MISC-CLOTHING
	(LOC HUT-BEDROOM)
	(DESC "jumbled clothing")
	(SYNONYM CLOTHES CLOTHING)
	(ADJECTIVE JUMBLED ASSORTED)
	(FLAGS NDESCBIT)
	(ACTION MISC-CLOTHING-F)>

<ROUTINE MISC-CLOTHING-F ()
	 <COND (<VERB? SEARCH EXAMINE>
		<TELL
"There's nothing interesting in the clothes." CR>)
	       (T
		<TELL
"The clothing isn't of any interest." CR>)>>
	

<OBJECT MISC-FURNITURE
	(LOC HUT-BEDROOM)
	(DESC "furniture")
        (SYNONYM BED CHAIR)
	(FLAGS NDESCBIT)
	(ACTION MISC-FURNITURE-F)>

<ROUTINE MISC-FURNITURE-F ()
	 <TELL
"Never mind about the furniture. It's not important now." CR>>

<ROOM ROAD-END
      (EW 4)
      (NS 5)
      (FLAGS VILLAGEBIT)
      (PATH 0)
      (LOC ROOMS)
      (DESC "End of the Road")
      (NORTH TO SOUTH-HUT IF HACK-FLAG ELSE
"The clearing before you is large and open, and you are concerned about being
so exposed. Seeing the hut off to the east, you decide to play it safe by
taking a position just to its south, where you can better gauge the
situation.")
      (SOUTH TO D6 IF HACK-FLAG ELSE
"You continue down the road and come to the junction of a larger road
running from south to east.")
      (EAST TO E5 IF FALSE-FLAG ELSE
"You leave the side of the roadway, bear off slightly to the north to
avoid a thicket, and reenter the forest. A cold gust of wind chills you
to the bone.")
      (WEST TO C5 IF FALSE-FLAG ELSE
"You leave the side of the roadway and reenter the forest. A cold gust
of wind chills you to the bone.")
      (NE TO SOUTH-HUT IF FALSE-FLAG ELSE
"You walk around to the south side of the hut.")
      (NW TO C5 IF FALSE-FLAG ELSE
"You leave the side of the roadway and reenter the forest.")
      (SE TO E6 IF FALSE-FLAG ELSE
"You leave the roadway, and reenter the forest. After a few dozen yards,
you come to a roadway running east and west.")
      (SW TO C6 IF FALSE-FLAG ELSE
"You leave the side of the roadway and reenter the forest.")
      (GLOBAL HUT CHIMNEY)
      (ACTION ROAD-END-F)>

<ROUTINE ROAD-END-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER-DESC>
		<CAR-SEQ-TELL>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You're now at the end of a road (fortunately, not THE road) which starts
off to the south through the forest. Just north of here lies a small clearing
and east of that, a wooden hut">
		<COND (,HUT-BURNING
		       <TELL ", which is engulfed in flame">)>
		<TELL ,PERIOD-CR>
		<CAR-SEQ-TELL>
		<RTRUE>)>>

<ROOM D6
      (EW 4)
      (NS 6)
      (LOC ROOMS)
      (DESC "Road Spur")
      (PATH 0)
      (WEST TO C6 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (EAST TO E6 IF HACK-FLAG ELSE
"You continue along the roadway for about a hundred yards, to a point
where it bends to the northeast.")
      (SE TO E7 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp which runs from northeast to south. Putrid sulphurous vapors
fill your lungs as you step to the edge of the noisome waters.")
      (SW TO C7 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (SOUTH TO D7 IF HACK-FLAG ELSE
"You continue along the roadway for about a hundred yards.")
      (NORTH TO ROAD-END IF HACK-FLAG ELSE
"You walk onto the spur leading north, and continue until the road ends
just south of a clearing.")
      (NE TO E5 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (NW TO C5 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (FLAGS FORESTBIT ROADBIT)
      (ACTION ROAD-ROOM-F)>

<ROUTINE ROAD-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing on a piece of roadway that winds its way through the
forest. At this point, the road ">
		<COND (<EQUAL? ,HERE ,D6>
		       <TELL "bends, running to the south and east. In
addition, a narrow spur leads north and out of sight." CR>)
		      (<EQUAL? ,HERE ,D7>
		       <TELL "runs north and south." CR>)
		      (<EQUAL? ,HERE ,D8 ,F5>
		       <TELL "bends, running to the north and
southwest." CR>)
		      (<EQUAL? ,HERE ,E6>
		       <TELL "bends, running from west to
northeast." CR>)
		      (T
		       <TELL "bends, running from the south to
the northeast." CR>)>)>>

<ROOM D7
      (EW 4)
      (NS 7)
      (LOC ROOMS)
      (DESC "On the Roadway")
      (PATH 0)
      (WEST TO C7 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (EAST TO E7 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp which runs from northeast to south. Putrid sulphurous vapors
fill your lungs as you step to the edge of the noisome waters.")
      (SE TO E8 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp. Putrid sulphurous vapors fill your lungs as you step to
the edge of the noisome waters. The swamp's edge continues to the
north and southwest.")
      (SW TO C8 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (SOUTH TO D8 IF HACK-FLAG ELSE
"You continue along the roadway for about a hundred yards; the road
continues along here to the southwest.")
      (NORTH TO D6 IF HACK-FLAG ELSE
"You walk along the road for a hundred or so yards, snow swirling in your
face. The road bends to the east here, but a narrow spur continues north.")
      (NE TO E6 IF HACK-FLAG ELSE
"A brisk wind gives you a deep chill, but you reenter the forest. Soon,
you rejoint the road which now is running from east to west.")

      (NW TO C6 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (FLAGS FORESTBIT ROADBIT)
      (ACTION ROAD-ROOM-F)>

<ROOM D8
      (EW 4)
      (NS 8)
      (LOC ROOMS)
      (DESC "On the Roadway")
      (PATH 0)
      (WEST TO C8 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (EAST TO E8 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp. Putrid sulphurous vapors fill your lungs as you step to
the edge of the noisome waters. The swamp's edge continues to the
north and southwest.")
      (SE TO E8 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp. Putrid sulphurous vapors fill your lungs as you step to
the edge of the noisome waters. The swamp's edge continues to the
north and southwest.")
      (SW TO C9 IF HACK-FLAG ELSE
"You continue along the road as it heads south toward the mouth of a
tunnel. The road is joined here by railroad tracks which also lead into the
tunnel, but bend to the northwest alongside a steep ridge.")
      (SOUTH TO D9 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp, which continues northeast. Putrid sulphurous vapors fill your
lungs as you step to the edge of the noisome waters.")
      (NORTH TO D7 IF HACK-FLAG ELSE
"You continue along the roadway for about a hundred yards.")
      (NE TO E7 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp which runs from northeast to south. Putrid sulphurous vapors
fill your lungs as you step to the edge of the noisome waters.")
      (NW TO C7 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (FLAGS FORESTBIT ROADBIT)
      (ACTION ROAD-ROOM-F)>

<ROOM D9
      (EW 4)
      (NS 9)
      (LOC ROOMS)
      (DESC "Edge of Swamp")
      (PATH 0)
      (WEST TO C9)
      (EAST PER SWAMP-MOVE)
      (SE PER SWAMP-MOVE)
      (SW SORRY
"You can't move any farther in that direction.")
      (SOUTH SORRY
"You can't move any farther in that direction.")
      (NORTH TO D8 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby roadway,
running from the north to the southwest.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (NE PER E8-SWAMP)
      (NW TO C8 IF HACK-FLAG ELSE
"You leave the edge of the swamp and enter the forest; it is quite a
relief for your nose. You take some deep breaths, continue for a
hundred yards, and stop.")
      (FLAGS SWAMPBIT)
      (ACTION SWAMP-ROOM-F)>

<ROOM E3
      (EW 5)
      (NS 3)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO D3 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (EAST TO F3 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SE TO F4 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
northeast to south.")
      (SW TO D4 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (SOUTH TO E4 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (NORTH TO E2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (NE SORRY
"You can't move any farther in that direction.")
      (NW TO D2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (FLAGS FORESTBIT)
      (ACTION FOREST-ROOM-F)>

<ROOM E4
      (EW 5)
      (NS 4)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO D4 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (EAST TO F4 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
northeast to south.")
      (SE TO F5 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
north to southwest.")
      (SW TO NORTH-HUT IF HACK-FLAG ELSE
"You continue through the forest and come to the north side of
a small wooden hut. Smoke rises in black swirls from the chimney,
indicating that it's likely that somebody's home.")
      (SOUTH TO E5 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (NORTH TO E3 IF HACK-FLAG ELSE
"The blowing snow blinds you for a moment as you walk through the
forest.")
      (NE TO F3 IF HACK-FLAG ELSE
"A branch falls from a nearby tree, startling you briefly. You
turn back and press on through the forest.")
      (NW TO D3 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (FLAGS FORESTBIT)
      (ACTION FOREST-ROOM-F)>

<ROOM E5
      (EW 5)
      (NS 5)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO BEHIND-HUT IF HACK-FLAG ELSE
"A cold gust of wind swirls snow into your face, making it difficult
to see clearly, but you press on through the forest, finally coming to
the back door of a small wooden hut. Smoke rises from the chimney above.")
      (EAST TO F5 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
north to southwest.")
      (SE TO F6 IF HACK-FLAG ELSE
"You cross a road, leave the forest, and come to the edge of a dank area at
the edge of a swamp running from northeast to southwest. Putrid sulphurous
vapors fill your lungs as you step to the edge of the noisome waters.")
      (SW TO D6 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
south to east, with a narrow spur leading north.")
      (SOUTH TO E6 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
east to west.")
      (NORTH TO E4 IF HACK-FLAG ELSE
"A pile of snow falls on your head from a heavily laden branch
above. You shake it off, and continue through the forest.")
      (NE TO F4 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
northeast to south.")
      (NW TO D4 IF HACK-FLAG ELSE
"You continue through the forest for a hundred yards, and then
stop. Snowflakes fall softly around you - nearby, a small animal
scurries through the brush.")
      (FLAGS FORESTBIT)
      (ACTION FOREST-ROOM-F)>

<ROOM E6
      (EW 5)
      (NS 6)
      (LOC ROOMS)
      (DESC "On the Roadway")
      (PATH 0)
      (WEST TO D6 IF HACK-FLAG ELSE
"You continue along the roadway for about a hundred yards, to a point
where it curves to the left, heading south. A small spur of the road
leads north.")
      (EAST TO F6 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp running from northeast to southwest. Putrid sulphurous vapors
fill your lungs as you step to the edge of the noisome waters.")
      (SE TO F6 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp running from northeast to southwest. Putrid sulphurous vapors
fill your lungs as you step to the edge of the noisome waters.")
      (SW TO D7 IF HACK-FLAG ELSE
"You leave the road, walk through the forest, and then come upon the same
road again, now heading north-south.")
      (SOUTH TO E7 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp which runs from northeast to south. Putrid sulphurous vapors
fill your lungs as you step to the edge of the noisome waters.")
      (NORTH TO E5 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (NE TO F5 IF HACK-FLAG ELSE
"A brisk wind gives you a deep chill, but you continue along the road
to the point at which it bends to the north.")

      (NW TO SOUTH-HUT IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you come to the south side of a small hut. The
smoke from the chimney indicates that perhaps someone is home.")
      (FLAGS FORESTBIT ROADBIT)
      (ACTION ROAD-ROOM-F)>

<ROOM E7
      (EW 5)
      (NS 7)
      (LOC ROOMS)
      (DESC "Edge of Swamp")
      (PATH 0)
      (WEST TO D7 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby roadway,
which runs from north to south.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (EAST PER SWAMP-MOVE)
      (SE PER SWAMP-MOVE)
      (SW TO D8 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby roadway,
which runs from the north to the southwest.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (SOUTH PER E8-SWAMP)
      (NORTH TO E6 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby east-west roadway.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (NE PER F6-SWAMP)
      (NW TO D6 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby roadway.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once. The road leads east
and south, but a narrow spur heads to the north.")
      (FLAGS SWAMPBIT)
      (ACTION SWAMP-ROOM-F)>

<ROUTINE G4-SWAMP ()
	 <SWAMP-MOVE-TELL>
	 ,G4>

<ROUTINE E7-SWAMP ()
	 <SWAMP-MOVE-TELL>
	 ,E7>

<ROUTINE E8-SWAMP ()
	 <SWAMP-MOVE-TELL>
	 ,E8>

<ROUTINE D9-SWAMP ()
	 <SWAMP-MOVE-TELL>
	 ,D9>

<ROUTINE G5-SWAMP ()
	 <SWAMP-MOVE-TELL>
	  ,G5>

<ROUTINE F6-SWAMP ()
	 <SWAMP-MOVE-TELL>
	 ,F6>

<ROUTINE SWAMP-MOVE-TELL ()
	 <TELL
"You continue along the edge of the swamp, your feet ">
	 <COND (,IN-SWAMP?
		<TELL "sinking a foot or so into the mud">)
	       (T
		<TELL "leaving deep prints in the sticky mud">)>
	 <TELL ". The air remains stench-laden, and you're
eager to move quickly, but the ground is soft and progress slow." CR CR>>

<ROUTINE SWAMP-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing ">
		<COND (,IN-SWAMP?
		       <TELL "a few feet into the swamp, where the
muck rises a foot up your leg.">)
		      (T
		       <TELL "at the edge of a swamp.">)>
		<TELL
" You could follow along the edge of the swamp to the ">
		<COND (<EQUAL? ,HERE ,E7>
		       <TELL "south and northeast">)
		      (<EQUAL? ,HERE ,E8 ,G5>
		       <TELL "north and southwest">)
		      (<EQUAL? ,HERE ,D9>
		       <TELL "northeast">)
		      (<EQUAL? ,HERE ,F6>
		       <TELL "southwest and northeast">)
		      (T
		       <TELL "south">)>
		<TELL ". On the other hand, you could leave the
swamp and walk onto the roadway by going ">
		<COND (<EQUAL? ,HERE ,D9 ,E7 ,F6>
		       <TELL "west or north">)
		      (T ;<EQUAL? ,HERE ,E8 ,G5 ,G4>
		       <TELL "west">)>
		<TELL ,PERIOD-CR>)>>

<ROOM E8
      (EW 5)
      (NS 8)
      (LOC ROOMS)
      (DESC "Edge of Swamp")
      (PATH 0)
      (WEST TO D8 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
north to southwest.")
      (EAST PER SWAMP-MOVE)
      (SE PER SWAMP-MOVE)
      (SW PER D9-SWAMP)
      (SOUTH PER SWAMP-MOVE)
      (NORTH PER E7-SWAMP)
      (NE PER SWAMP-MOVE)
      (NW TO D7 IF HACK-FLAG ELSE
"You emerge from the swamp and come to a roadway running from
north to south.")
      (FLAGS SWAMPBIT FORESTBIT)
      (ACTION SWAMP-ROOM-F)>

<ROOM F3
      (EW 6)
      (NS 3)
      (LOC ROOMS)
      (DESC "Inside the Forest")
      (PATH 0)
      (WEST TO E3 IF HACK-FLAG ELSE
"You stumble through a three-foot snowdrift, but get back on your
feet quickly and proceed through the forest.")
      (EAST SORRY
"You'd be caught in a moment.")
      (SE TO G4 IF HACK-FLAG ELSE
"You leave the forest, crossing a roadway, and come to the edge of a dank
area at the edge of a swamp which continues to the south. Putrid sulphurous
vapors fill your lungs as you step to the edge of the noisome waters.")
      (SW TO E4 IF HACK-FLAG ELSE
"You walk through the forest, breaking branches as you go, and
finally stop after walking about a hundred yards.")
      (SOUTH TO F4 IF HACK-FLAG ELSE
"You emerge from the thick forest and come to a roadway running from
northeast to south.")
      (NORTH SORRY
"You scramble up a bit, but slide back down. It's just too steep.")
      (NE SORRY
"You can't move any farther in that direction.")
      (NW TO E2 IF HACK-FLAG ELSE
"You continue through the forest, until you come to the edge of a wide
clearing to the north - this is the border zone. From atop three guard
towers standing in a line from east to west, searchlights play across
the zone, brightly illuminating everything in their path. On either side
of the towers are tall fences, running parallel to the border, making a
direct assault all but impossible.")
      (FLAGS FORESTBIT)
      (ACTION FOREST-ROOM-F)>

<ROOM F4
      (EW 6)
      (NS 4)
      (LOC ROOMS)
      (DESC "On the Roadway")
      (PATH 0)
      (WEST TO E4 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (EAST TO G4 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp which continues to the south. Putrid sulphurous vapors fill your
lungs as you step to the edge of the noisome waters.")
      (SE TO G5 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp which runs from the north to the southwest. Putrid sulphurous
vapors fill your lungs as you step to the edge of the noisome waters.")
      (SW TO E5 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (SOUTH TO F5 IF HACK-FLAG ELSE
"You continue along the roadway for about a hundred yards to a point
where it bends to the southwest.")
      (NORTH TO F3 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (NE SORRY
"You start along the road, until you see a roadblock come into sight; you
duck back into the forest. It would never work to go that way.")
      (NW TO E3 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (FLAGS FORESTBIT ROADBIT)
      (ACTION ROAD-ROOM-F)>

<OBJECT ROADBLOCK
       (DESC "roadblock")
       (SYNONYM BLOCK ROADBLOCK)
       (ADJECTIVE ROAD)
       (LOC GLOBAL-OBJECTS)
       (SCENARIO 2)
       (ACTION ROADBLOCK-F)>

<ROUTINE ROADBLOCK-F ()
	 <COND (<EQUAL? ,HERE ,F4 ,G4>
		<TELL
"There's no roadblock here, but there is surely one lurking
in the darkness nearby." CR>)
	       (T
		<CANT-SEE ,ROADBLOCK>)>>

<ROOM F5
      (EW 6)
      (NS 5)
      (LOC ROOMS)
      (DESC "On the Roadway")
      (PATH 0)
      (WEST TO E5 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (EAST TO G5 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp which runs from the north to the southwest. Putrid sulphurous
vapors fill your lungs as you step to the edge of the noisome waters.")
      (SE SORRY
"You can't move any farther in that direction.")
      (SW TO E6 IF HACK-FLAG ELSE
"You walk along the road for a hundred or so yards, snow swirling in your
face. From here, the road continues to the west.")
      (SOUTH TO F6 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp running from northeast to southwest. Putrid sulphurous vapors
fill your lungs as you step to the edge of the noisome waters.")
      (NORTH TO F4 IF HACK-FLAG ELSE
"You walk along the road for a hundred or so yards, snow swirling in your
face, until you come to a point where the road bends to the northeast.")
      (NE TO G4 IF HACK-FLAG ELSE
"You leave the roadway and come to the edge of a dank area at the edge
of a swamp which continues to the south. Putrid sulphurous vapors fill your
lungs as you step to the edge of the noisome waters.")
      (NW TO E4 IF HACK-FLAG ELSE
"You leave the side of the roadway and enter the forest, proceeding a
hundred yards before you stop.")
      (FLAGS FORESTBIT ROADBIT)
      (ACTION ROAD-ROOM-F)>

<ROOM F6
      (EW 6)
      (NS 6)
      (LOC ROOMS)
      (DESC "Edge of Swamp")
      (PATH 0)
      (WEST TO E6 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby east-west roadway.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (EAST PER SWAMP-MOVE)
      (SE PER SWAMP-MOVE)
      (SW PER E7-SWAMP)
      (SOUTH PER SWAMP-MOVE)
      (NORTH TO F5 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby roadway,
which runs from north to southwest here.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (NE PER G5-SWAMP)
      (NW TO E5 IF HACK-FLAG ELSE
"You leave the edge of the swamp and enter the forest; it is quite a
relief for your nose. You take some deep breaths, continue for a
hundred yards, and stop.")
      (FLAGS SWAMPBIT)
      (ACTION SWAMP-ROOM-F)>

<ROOM G4
      (EW 7)
      (NS 4)
      (LOC ROOMS)
      (DESC "Edge of Swamp")
      (PATH 0)
      (WEST TO F4 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby roadway,
which runs from south to northeast.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (EAST PER SWAMP-MOVE)
      (SE PER SWAMP-MOVE)
      (SW TO F5 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby roadway,
which runs from north to southwest here.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (SOUTH PER G5-SWAMP)
      (NORTH SORRY
"You start onto the roadway, and find yourself facing a roadblock. Realizing
that you'd be caught in a moment continuing that way, you return to the edge
of the swamp.")
      (NE PER SWAMP-MOVE)
      (NW TO F3 IF HACK-FLAG ELSE
"You leave the edge of the swamp and enter the forest; it is quite a
relief for your nose. You take some deep breaths, continue for a
hundred yards, and stop.")
      (FLAGS SWAMPBIT)
      (ACTION SWAMP-ROOM-F)>

<ROOM G5
      (EW 7)
      (NS 5)
      (LOC ROOMS)
      (DESC "Edge of Swamp")
      (PATH 0)
      (WEST TO F5 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby roadway,
which runs from north to southwest here.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (EAST PER SWAMP-MOVE)
      (SE PER SWAMP-MOVE)
      (SW PER F6-SWAMP)
      (SOUTH PER SWAMP-MOVE)
      (NORTH PER G4-SWAMP)
      (NE PER SWAMP-MOVE)
      (NW TO F4 IF HACK-FLAG ELSE
"You leave the side of the swamp and walk onto the nearby roadway,
which runs from south to northeast.
The air is already fresher here, and you cannot help but cough a few
times, as if to purge the foul air all at once.")
      (FLAGS SWAMPBIT)
      (ACTION SWAMP-ROOM-F)>

<ROUTINE SWAMP-MOVE ()
	 <COND (<NOT ,IN-SWAMP?>
		<TELL
"You should simply enter the swamp, if that is indeed your intention." CR>
		<RFALSE>)
	       (T
		<TELL
"You're as far into the swamp as you can go." CR>
		<RFALSE>)>>

<OBJECT TRAIN
	(LOC GLOBAL-OBJECTS)
	(DESC "train")
	(SYNONYM TRAIN CHOO-CHOO)
	(ACTION TRAIN-F)>

<ROUTINE TRAIN-F ()
	 <COND (<EQUAL? ,SCENARIO 2>
		<TELL
"There's no train anywhere near here, as far as you can tell." CR>)
	       (<AND <EQUAL? ,SCENARIO 1>
		     <NOT <FSET? ,HERE ,PLATFORMBIT>>>
		<COND (<VERB? DISEMBARK TAKE-OFF LEAVE>
		       <COND (<EQUAL? ,HERE ,PASS-6>
			      <DO-WALK ,P?SOUTH>
			      <RTRUE>)
			     (T
			      <TELL
"You'll have to get to the exit, which is near the lavatory." CR>)>)
		      (<VERB? OFF OFF-2>
		       <TELL
"You might try the cord, but that would be the only way." CR>)
		      (<VERB? LOOK-INSIDE>
		       <PERFORM ,V?LOOK-INSIDE ,PASS-WINDOW>
		       <RTRUE>)>)>>

<OBJECT FOREST
	(LOC GLOBAL-OBJECTS)
	(DESC "forest")
	(SYNONYM FOREST)
	(SCENARIO 2)
	(ACTION FOREST-F)>

<ROUTINE FOREST-F ()
	 <COND (<VERB? FIND>
		<TELL
"You cannot see the forest for the trees." CR>)
	       (<VERB? SEARCH>
		<TELL
"That would take hours or days; you've got seconds or minutes." CR>)
	       (<VERB? ENTER LEAVE>
		<TELL
"You should use compass directions to do that." CR>)>>

<OBJECT GLOBAL-HUT
	(LOC GLOBAL-OBJECTS)
	(DESC "hut")
	(SYNONYM HUT)
	(SCENARIO 2)
	(ACTION GLOBAL-HUT-F)>

<ROUTINE GLOBAL-HUT-F ()
	 <COND (<NOT ,BEEN-AT-HUT?>
		<TELL
"You haven't seen any hut, but it would be a sight for sore eyes." CR>)
	       (<VERB? WALK-AROUND>
		<TELL
"You can't see the hut from here, but the smoke in the sky tells you that
it's off to the ">
		<TELL-DIRECTION ,HERE ,D5>
		<TELL ". As for walking around it, that's up to you." CR>)
	       (<VERB? WALK-TO FIND>
		<COND (<EQUAL? ,HERE ,INSIDE-SHED>
		       <TELL "Not from inside the shed." CR>
		       <RTRUE>)>
		<TELL
"You can't see the hut, but the smoke in the sky is coming from the ">
		<TELL-DIRECTION ,HERE ,D5>
		<TELL ", so you start to walk in that direction." CR CR>
		<DO-WALK <RET-DIRECTION ,HERE ,D5>>)>>

<OBJECT T-STATION
	(LOC GLOBAL-OBJECTS)
	(DESC "border station")
	(SYNONYM STATION)
	(ADJECTIVE BORDER)
	(TRANSIENT <PLTABLE A2 B2 C2 D2 E2>)
	(ACTION T-STATION-F)>

<GLOBAL TOO-FAR "You're too far away to do that.">

<ROUTINE T-STATION-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The border station, to the left of the three towers, consists of a
guards' station and a train platform. The station itself is heavily
guarded, so movement in that direction would be suicidal." CR>)
	       (T
		<TELL ,TOO-FAR CR>)>> 

<OBJECT GLOBAL-TUNNEL
	(LOC GLOBAL-OBJECTS)
	(SYNONYM TUNNEL)
	(DESC "tunnel")
	(SCENARIO 2)
	(ACTION GLOBAL-TUNNEL-F)>

<ROUTINE GLOBAL-TUNNEL-F ()
	 <COND (<VERB? EXAMINE WALK-TO WATCH>
		<COND (<EQUAL? ,HERE ,C9>
		       <TELL
"It's the tunnel you came through just before you jumped. It's a few
miles long and very, very dark." CR>)
		      (T
		       <CANT-SEE ,PRSO>)>)
	       (<VERB? FIND>
		<TELL
"If memory serves, it should be off to the ">
		<TELL-DIRECTION ,HERE ,C9>
		<TELL ,PERIOD-CR>)
	       (T
		<TELL ,TOO-FAR CR>)>>

<OBJECT GLOBAL-SNOW
	(LOC GLOBAL-OBJECTS)
	(DESC "snow")
	(SYNONYM SNOW ICE)
	(SCENARIO 2)
	(ACTION GLOBAL-SNOW-F)>

<ROUTINE GLOBAL-SNOW-F ()
	 <COND (<VERB? LEAP>
		<TELL
"This is no time for acrobatics." CR>)
	       (<OR <FSET? ,HERE ,HUTBIT>
		    <EQUAL? ,HERE ,INSIDE-SHED>>
		<CANT-SEE ,PRSO>)>>

<OBJECT GLOBAL-TREES
	(LOC GLOBAL-OBJECTS)
	(DESC "tree")
	(SYNONYM TREE TREES)
	(SCENARIO 2)
	(ACTION GLOBAL-TREES-F)>

<ROUTINE GLOBAL-TREES-F ()
	 <COND (<OR <FSET? ,HERE ,HUTBIT>
		    <EQUAL? ,HERE ,INSIDE-SHED>>
		<TELL
"There aren't any indoor trees here." CR>)
	       (<VERB? CUT>
		<TELL
"Chopping wood is an exhausting activity and won't help you." CR>)>>

<OBJECT GLOBAL-BORDER
	(LOC GLOBAL-OBJECTS)
	(DESC "border")
	(SYNONYM BORDER)
	(SCENARIO 2)
	(ACTION GLOBAL-BORDER-F)>

<ROUTINE GLOBAL-BORDER-F ()
	 <COND (<VERB? FIND WALK-TO>
		<TELL
"If memory serves, the border should be to the north." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It's just like any other military fortress border." CR>)
	       (T
		<CANT-SEE ,GLOBAL-BORDER>)>>


	