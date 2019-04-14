"SCENARIO for
			       BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROUTINE GOOD-SCENARIO-F (FLG "OPTIONAL" STUFF "AUX" LD)
	 <COND (<AND <EQUAL? .FLG ,M-BEG>
		     <VERB? WALK>
		     <NOT ,SHOES-WORN>
		     <EQUAL? ,SCENARIO 2>>
		<TELL "You're not going anywhere without shoes." CR>
		<RTRUE>)
	       (<AND <EQUAL? .FLG ,M-BEG>
		     <VERB? DROP>
		     <FSET? ,HERE ,SWAMPBIT>>
		<TELL
"You'd only get it filthy; try putting it down somewhere else." CR>)
	       (<EQUAL? .FLG ,M-ENTER> 
		<COND (<AND ,CUT-DETECTED <G? ,CLOCK-TIME ,CUT-DETECTED>>
		       <SETG CUT-VIGILANCE T>)>
		<COND (<OR <EQUAL? ,HERE ,OUTSIDE-HUT ,NORTH-HUT ,SOUTH-HUT>
			   <EQUAL? ,HERE ,D5 ,BEHIND-HUT ,ROAD-END>>
		       <SETG BEEN-AT-HUT? T>)>
		<COND (<AND <NOT <FSET? ,HERE ,SWAMPBIT>>
			    ,IN-SWAMP?>
		       <SETG IN-SWAMP? <>>)>
		<COND (<NOT ,IN-SWAMP?>
		       <PUTP ,HERE ,P?PATH 0>
		       <PUTP .STUFF ,P?PATH ,HERE>)>
		<SET LD <LOC ,DOGS>>
		<COND (<EQUAL? .LD ,HERE>
		       <CRLF>
		       <TELL
"You can hear the guard dogs within 50 yards! Their voices
reach a fevered pitch - a guard calls out - a muffled explosion - the
night sky is lit by a single red-orange flare. In the nick of time,
you retreat to your earlier position and remind yourself to take
the chase dogs more seriously in the future." CR>
		       <GOTO .STUFF <>>
		       <RTRUE>)
		      (<AND <IN? ,CAR ,HERE>
			    <NOT <EQUAL? ,HERE ,ROAD-END>>>
		       <CAR-NEARLY-HITS>
		       <RTRUE>)
		      (<IN? ,SCOUT ,HERE>
		       <TELL CR
"You walk a short ways, then catch a glimpse of a lone guard who appears to
be checking out the area around the hut. Rather than continue on, you retreat
to your previous location">
		       <COND (<EQUAL? .STUFF ,HUT-STORAGE>
			      <FCLEAR ,HUT-BACK-DOOR ,OPENBIT>
			      <TELL ", closing the door behind you.">)>
		       <TELL ,PERIOD-CR>
		       <GOTO .STUFF <>>
		       <RTRUE>)
		      (<AND <IN? ,CAR ,ROAD-END>
			    <EQUAL? ,HERE ,D5 ,OUTSIDE-HUT>>
		       <COND (<OR <EQUAL? .STUFF ,C5 ,C6>
				  <EQUAL? .STUFF ,D4 ,OUTSIDE-SHED>>
			      <TELL CR
"You just start to emerge from the forest when you notice an automobile
and some guards in front of a small hut to the east of the clearing.
You retreat back into the safety of the trees, thinking that perhaps
it would be safer approaching the hut from the other side." CR>
			      <GOTO .STUFF <>>
			      <RTRUE>)>
		       <GUARDS-SPOTTED>
		       <RTRUE>)
		      (<IN? ,HUT-MAN ,HERE>
		       <MAN-CATCHES>
		       <RTRUE>)>
		<COND (<NOT ,MOVE-FORCED>
		       <GONE-TO-THE-DOGS? <HOW-FAR .LD .STUFF>
					  <HOW-FAR .LD ,HERE>
					  ,DOGS
					  <>>)>
		<COND (<AND ,SL-WATCH <NOT <FSET? ,HERE ,SLVIEWBIT>>>
		       <CRLF>
		       <PERFORM ,V?OFF-2 ,TIMING-OBJECT ,SEARCHLIGHTS>)>
		<COND (<AND ,G-WATCH <NOT <FSET? ,HERE ,GVIEWBIT>>>
		       <CRLF>
		       <PERFORM ,V?OFF-2 ,TIMING-OBJECT ,GUARDS>)>
		<COND (,G-WATCH
		       <SCREEN-1>
		       <CURSET 3 <+ ,GUARD-MARGIN
				    </ <GETP .STUFF ,P?GPOS> 5>>>
		       <TELL " ">
		       <CURSET 3 <+ ,GUARD-MARGIN
				    </ <GETP ,HERE ,P?GPOS> 5>>>
		       <TELL "*">
		       <SCREEN-0>)>
		<RTRUE>)>>

<ROUTINE BAD-SCENARIO-F (FLG "OPTIONAL" STUFF)
	 <COND (<AND <EQUAL? .FLG ,M-BEG>
		     <VERB? WALK>
		     ,ON-THE-CAN
		     <NOT <EQUAL? ,PRSO ,P?UP>>>
		<TELL
"You'd best get off the can first." CR>)
	       (<EQUAL? .FLG ,M-ENTER>
		;"Hall objects"
		<COND (<FSET? .STUFF ,HUTBIT>
		       <MOVE-ALL .STUFF
				 <GETP .STUFF
				       <GET ,FLOOR-PROPS ,HALL-FLOOR>>>)>
		<COND (<AND <EQUAL? ,HERE ,HALL-1> <FSET? .STUFF ,PENBIT>>
		       <SETG HALL-FLOOR <GETP .STUFF ,P?SIZE>>)>
		<COND (<FSET? ,HERE ,HUTBIT>
		       <MOVE-ALL <GETP ,HERE
				       <GET ,FLOOR-PROPS ,HALL-FLOOR>>
				 ,HERE>)>
		;"Turn off Topaz spots you interrupt"
		<COND (<AND <NOT ,CHASE-FLAG>
			    <EQUAL? .STUFF ,BLDG-2>>
		       <DE-QUEUE ,I-TOPAZ-OFF>)>
		;"For chase scene"
		<PUTP ,HERE ,P?PATH 0>
		<PUTP .STUFF ,P?PATH ,HERE>
		<PUTP .STUFF ,P?PATH-TIME ,CLOCK-MOVE>
		<RFALSE>)
	       (T
		<RFALSE>)>>

<ROUTINE BYSTANDER-SCENARIO-F (FLG "OPTIONAL" STUFF)
	 <COND (<AND <EQUAL? .FLG ,M-BEG>
		     <VERB? DROP THROW EMPTY>
		     <FSET? ,HERE ,HUTBIT>>
		<TELL
"With the guards watching, it isn't a good idea to litter." CR>
		<RTRUE>)
	       (<AND <EQUAL? .FLG ,M-BEG>
		     <VERB? DROP>
		     ,BUMPER-FLAG>
		<SETG CLOCK-MOVE 50>
		<RFALSE>)
	       (<AND <EQUAL? .FLG ,M-BEG>
		     <VERB? WALK>
		    ,BAD-CONFINED
		    <EQUAL? ,PRSO ,P?EAST ,P?OUT>>
		<TELL
"You start to go through your compartment's door, but are stopped by
a uniformed guard. You return to your compartment, out of sight of the guard.
You'd might as well get comfortable here until you
reach the station." CR>
		<RTRUE>)
	       (<AND ,AT-STATION
		     <EQUAL? .FLG ,M-BEG>
		     <VERB? WALK>>
		<COND (<AND <EQUAL? ,HERE ,PASS-5>
			    <EQUAL? ,PRSO ,P?NORTH>>
		       <TELL
"The guard stops you, pointing toward the south and the other exit." CR>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,PASS-6>
			    <EQUAL? ,PRSO ,P?SOUTH>>
		       <TELL
"You move past the guard, down the stairs, and onto the station
platform." CR CR>
		       <PLATFORM-ROOM-F ,M-LOOK>
		       <GOTO ,PLATFORM-4 <>>
		       <SLOW-CLOCK-QUEUE ,I-PLATFORM 30>
		       <RTRUE>)>)>
	 <RFALSE>>