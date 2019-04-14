
"MISC for
		      		BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"tell macro and friends"

<TELL-TOKENS (CRLF CR)		<CRLF>
	     (NUM N) *		<PRINTN .X>
	     (CHAR CHR C) *	<PRINTC .X>
	     S *:STRING		<PRINT .X>
	     D *		<DPRINT .X>
	     CD ,PRSO		<CDPRINT-PRSO>
	     CD ,PRSI		<CDPRINT-PRSI>
	     CD *		<CDPRINT .X>
	     THE ,PRSO		<THE-PRINT-PRSO>
	     THE ,PRSI		<THE-PRINT-PRSI>
	     THE *		<THE-PRINT .X>
	     CTHE ,PRSO		<CTHE-PRINT-PRSO>
	     CTHE ,PRSI		<CTHE-PRINT-PRSI>
	     CTHE *		<CTHE-PRINT .X>
	     (A AN) ,PRSO	<PRINTA-PRSO>
	     (A AN) ,PRSI	<PRINTA-PRSI>
	     (A AN) *		<PRINTA .X>
	     A *	 <APRINT .X>
	     T ,PRSO 	 <TPRINT-PRSO>
	     T ,PRSI	 <TPRINT-PRSI>
	     T *	 <TPRINT .X>
	     AR *	 <ARPRINT .X>
	     TR *	 <TRPRINT .X>
>

<ROUTINE TELL-OPEN-CLOSED ("OPTIONAL" (OBJ <>))
	 <COND (.OBJ <TELL CTHE .OBJ>)
	       (ELSE
		<SET OBJ ,PRSO>
		<TELL THE ,PRSO>)>
	 <IS-ARE .OBJ>
	 <TELL " ">
	 <OPEN-CLOSED .OBJ>>

<ROUTINE OPEN-CLOSED (OBJ)
	 <COND (<FSET? .OBJ ,OPENBIT>
		<TELL "open">)
	       (ELSE
		<TELL "closed">)>
	 <TELL ,PERIOD>>

<ROUTINE IS-ARE (OBJ)
	 <COND ;(<PLURAL? .OBJ> <TELL " are">)
	       (ELSE <TELL " is">)>>

<ROUTINE CTHE-PRINT-PRSO ()
	 <THE-PRINT ,PRSO T>>

;<ROUTINE CTHE-PRINT-PRSI ()
	 <THE-PRINT ,PRSI T>>

<ROUTINE CTHE-PRINT (O)
	 <THE-PRINT .O T>>

<ROUTINE THE-PRINT-PRSO ()
	 <THE-PRINT ,PRSO>>

<ROUTINE THE-PRINT-PRSI ()
	 <THE-PRINT ,PRSI>>

<ROUTINE THE-PRINT (O "OPTIONAL" (CAP? <>))
	 <DPRINT .O .CAP? <NOT <FSET? .O ,NOTHEBIT>>>>

<ROUTINE PRINTA-PRSO ()
	 <PRINTA ,PRSO>>

<ROUTINE PRINTA-PRSI ()
	 <PRINTA ,PRSI>>

<ROUTINE PRINTA (O)
	 <COND (<FSET? .O ,THE> <PRINTI "the ">)
	       (<NOT <FSET? .O ,NOABIT>>
		<COND (<FSET? .O ,AN> <PRINTI "an ">)
		      (ELSE <PRINTI "a ">)>)>
	 <IPRINT .O>>

;<ROUTINE CDPRINT-PRSO ()
	 <DPRINT ,PRSO T>>

;<ROUTINE CDPRINT-PRSI ()
	 <DPRINT ,PRSI T>>

;<ROUTINE CDPRINT (O)
	 <DPRINT .O T>>

;<ROUTINE PRSO-NOTHING-SPECIAL ()
	 <TELL S "You see nothing special about ">
	 <THE-PRSO>>

;<ROUTINE THE-PRSO () <TELL THE ,PRSO ,PERIOD>>

<ROUTINE DPRINT (O "OPTIONAL" (CAP? <>) (THE? <>) "AUX" S)
	 <COND (<OR .THE? <FSET? .O ,THE>>
		<COND (.CAP? <PRINTI "The ">)
		      (T <PRINTI "the ">)>)>
	 <IPRINT .O>>

<ROUTINE IPRINT (O)
	 <PRINTD .O>>

<ROUTINE NSPRINT (NUM STR)
	 <PRINTN .NUM>
	 <TELL " ">
	 <PRINT .STR>
	 <COND (<NOT <EQUAL? .NUM 1>>
		<TELL "s">)>>

<ROUTINE APRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (<FSET? .OBJ ,VOWELBIT>
		<TELL " an ">)
	       (T
		<TELL " a ">)>
	 <DPRINT .OBJ>>

<ROUTINE TPRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (T
		<TELL " the ">)>
	 <DPRINT .OBJ>>

<ROUTINE TPRINT-PRSO ()
	 <TPRINT ,PRSO>>

<ROUTINE TPRINT-PRSI ()
	 <TPRINT ,PRSI>>

<ROUTINE ARPRINT (OBJ)
	 <APRINT .OBJ>
	 <TELL ,PERIOD-CR>>

<ROUTINE TRPRINT (OBJ)
	 <TPRINT .OBJ>
	 <TELL ,PERIOD-CR>>

;"macros"

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <CHTYPE <COND (<==? .X PRSA>
						    <PARSE
						     <STRING "V?"
							     <SPNAME .ATM>>>)
						   (ELSE .ATM)> GVAL>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O
				      (<FORM EQUAL? <CHTYPE .X GVAL> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (<EQUAL? .X FSET?> <FORM OR !.O>)
				       (ELSE <FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <FORM GVAL .ATM>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 8> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

;<ROUTINE PICK-ONE (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

;"this new PICK-ONE won't begin repeating any of the items in the table until
  they've all been used."

<ROUTINE PICK-ONE (TBL "AUX" LENGTH CNT RND MSG RFROB)
	 <SET LENGTH <GET .TBL 0>>
	 <SET CNT <GET .TBL 1>>
	 <SET LENGTH <- .LENGTH 1>>
	 <SET TBL <REST .TBL 2>>
	 <SET RFROB <REST .TBL <* .CNT 2>>>
	 <SET RND <RANDOM <- .LENGTH .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .LENGTH> 
		<SET CNT 0>)>
	 <PUT .TBL 0 .CNT>
	 .MSG>

<DEFINE PSEUDO ("TUPLE" V)
	<MAPF ,PLTABLE
	      <FUNCTION (OBJ)
		   <COND (<N==? <LENGTH .OBJ> 3>
			  <ERROR BAD-THING .OBJ>)>
		   <MAPRET <COND (<NTH .OBJ 2>
				  <VOC <SPNAME <NTH .OBJ 2>> NOUN>)>
			   <COND (<NTH .OBJ 1>
				  <VOC <SPNAME <NTH .OBJ 1>> ADJECTIVE>)>
			   <3 .OBJ>>>
	      .V>>

;"MAIN-LOOP and associated routines"

<CONSTANT M-BEG 1>
<CONSTANT M-ENTER 2>
<CONSTANT M-LOOK 3>
<CONSTANT M-FLASH 4>
<CONSTANT M-OBJDESC 5>
<CONSTANT M-END 6>
<CONSTANT M-SMELL 7>
<CONSTANT M-FATAL 8>
<CONSTANT M-OBJDESC? 9>
<CONSTANT M-ENTER-DESC 10>

<ZSTART GO> ;"else, ZIL gets confused between verb-word GO and routine GO"

<GLOBAL SCENARIO 0>
<CONSTANT S-BYSTANDER 1>
<CONSTANT S-GOOD 2>
<CONSTANT S-BAD 3>

<GLOBAL SCENARIO-TBL <PLTABLE BYSTANDER-SCENARIO-F
			      GOOD-SCENARIO-F
			      BAD-SCENARIO-F>>

<CONSTANT MINUS-ONE -1>

<GLOBAL MAX-WEIGHT 40>

<ROUTINE GO () ;"NOTE: this routine CANNOT have any local variables" 
	 <OPENING-SCREEN>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>

<ROUTINE MAIN-LOOP ("AUX" TRASH)
	 <REPEAT ()
		 <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP)
  <SET CNT 0>
  <SET OBJ <>>
  <SET PTBL T>
  <COND (<SETG P-WON <PARSER>>
	 <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	 <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	 <COND (<AND ,P-IT-OBJECT
		     <ACCESSIBLE? ,P-IT-OBJECT>>
		<SET TMP <>>
		<REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
			<RETURN>)
		       (T
			<COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
			       ;<COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
			       <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
			       <SET TMP T>
			       <RETURN>)>)>>
		<COND (<NOT .TMP>
		       <SET CNT 0>
		       <REPEAT ()
			<COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
			       <RETURN>)
			      (T
			       <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
				      ;<COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
				      <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
				      <RETURN>)>)>>)>
		<SET CNT 0>)>
	 <SET NUM <COND (<0? .OCNT>
			 .OCNT)
		        (<G? .OCNT 1>
			 <SET TBL ,P-PRSO>
			 <COND (<0? .ICNT>
				<SET OBJ <>>)
			       (T
				<SET OBJ <GET ,P-PRSI 1>>)>
			 .OCNT)
		        (<G? .ICNT 1>
			 <SET PTBL <>>
			 <SET TBL ,P-PRSI>
			 <SET OBJ <GET ,P-PRSO 1>>
			 .ICNT)
		        (T
			 1)>>
	 <COND (<AND <NOT .OBJ>
		     <1? .ICNT>>
		<SET OBJ <GET ,P-PRSI 1>>)>
	 <COND (<AND <EQUAL? ,PRSA ,V?WALK> ,PRSO>
		;"Was just <EQUAL? ,PRSA ,V?WALK>, to fix RUN WATER"
		<SET V <PERFORM-PRSA ,PRSO>>)
	       (<0? .NUM>
		<COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
		       <SET V <PERFORM-PRSA>>
		       <SETG PRSO <>>)
		      ;(<NOT ,LIT>
		       <TELL ,TOO-DARK CR>
		       <STOP>)
		      (T
		       <TELL "There isn't anything to ">
		       <SET TMP <GET ,P-ITBL ,P-VERBN>>
		       <COND (<VERB? TELL>
			      <TELL "talk to">)
			     (<OR ,P-OFLAG ,P-MERGED>
			      <PRINTB <GET .TMP 0>>)
			     (T
			      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
		       <TELL "!" CR>
		       <SET V <>>
		       <STOP>)>)
	       (T
		<SETG P-NOT-HERE 0>
		<SETG P-MULT <>>
		<COND (<G? .NUM 1>
		       <SETG P-MULT T>)>
		<SET TMP <>>
		<REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			<COND (<G? ,P-NOT-HERE 0>
			       <TELL "[The ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
				      <TELL "other ">)>
			       <TELL "object">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "s">)>
			       <TELL " that you mentioned ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "are">)
				     (T
				      <TELL "is">)>
			       <TELL "n't here.]" CR>)
			      (<NOT .TMP>
			       <REFERRING>)>
			<RETURN>)
		       (T
			<COND (.PTBL
			       <SET OBJ1 <GET ,P-PRSO .CNT>>)
			      (T
			       <SET OBJ1 <GET ,P-PRSI .CNT>>)>
			<SETG PRSO <COND (.PTBL
					  .OBJ1)
					 (T
					  .OBJ)>>
			<SETG PRSI <COND (.PTBL
					  .OBJ)
					 (T
					  .OBJ1)>>
			<COND (<OR <G? .NUM 1>
				   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0>
					,W?ALL
					,W?EVERYTHING>>
			       <COND (<DONT-ALL .OBJ1>
				      <AGAIN>)
				     (T
				      <COND (<EQUAL? .OBJ1 ,IT>
					     <TELL D ,P-IT-OBJECT>)
					    (<EQUAL? .OBJ1 ,HIM>
					     <TELL D ,P-HIM-OBJECT>)
					    (<EQUAL? .OBJ1 ,HER>
					     <TELL D ,P-HER-OBJECT>)
					    (T
					     <TELL D .OBJ1>)>
				      <TELL ": ">)>)>
			<SET TMP T>
			<SET V <PERFORM-PRSA ,PRSO ,PRSI>>
			<COND (<EQUAL? .V ,M-FATAL>
			       <RETURN>)>)>>)>
	 <COND (<EQUAL? .V ,M-FATAL>
		<SETG P-CONT <>>)>
	 <COND (<AND <CLOCKER-VERB?>
		     <NOT <VERB? TELL>>
		     ,P-WON ;"fake YOU CANT SEE responses set P-WON to false">
		<SET V <APPLY <GETP ,HERE ,P?ACTION> ,M-END>>)>)
	(T
	 <SETG P-CONT <>>)>
  <COND (,P-WON
	 <COND (<CLOCKER-VERB?>
		<SET V <CLOCKER>>)>
	 <SETG P-PRSA-WORD <>>
	 ;"else, when input is just a direction, P-PRSA-WORD will remain
	   whatever it was for the previous turn"
	 <SETG PRSA <>>
	 <SETG PRSO <>>
	 <SETG PRSI <>>)>
  <COND (<AND ,AWAITING-FAKE-ORPHAN
	      <NOT ,P-OFLAG>>
	 <ORPHAN-VERB>)>>

<GLOBAL AWAITING-FAKE-ORPHAN <>>

;<ROUTINE TOO-DARK-FOR-IT? ()
	 <COND (<AND <NOT ,LIT>
		     <NOT <ULTIMATELY-IN? ,P-IT-OBJECT ,WINNER>>
		     <NOT <IN? ,WINNER ,P-IT-OBJECT>>>
		<TELL ,TOO-DARK CR>
		<RTRUE>)>>

<ROUTINE DONT-ALL (OBJ1 "AUX" (L <LOC .OBJ1>))
	 ;"RFALSE if OBJ1 should be included in the ALL, otherwise RTRUE"
	 <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		<SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
		<RTRUE>)
	       (<AND <VERB? TAKE> ;"TAKE prso FROM prsi and prso isn't in prsi"
		     ,PRSI
		     <NOT <IN? ,PRSO ,PRSI>>>
		<RTRUE>)
	       (<NOT <ACCESSIBLE? .OBJ1>> ;"can't get at object"
		<RTRUE>)
	       (<EQUAL? ,P-GETFLAGS ,P-ALL> ;"cases for ALL"
		<COND (<AND ,PRSI
			    <PRSO? ,PRSI>>
		       <RTRUE>)
		      (<VERB? TAKE> 
		       ;"TAKE ALL and object not accessible or takeable"
		       <COND (<AND <NOT <FSET? .OBJ1 ,TAKEBIT>>
				   <NOT <FSET? .OBJ1 ,TRYTAKEBIT>>>
			      <RTRUE>)
			     (<AND <NOT <EQUAL? .L ,WINNER ,HERE ,PRSI>>
				   <NOT <EQUAL? .L <LOC ,WINNER>>>>
			      <COND (<AND <FSET? .L ,SURFACEBIT>
				     	  <NOT <FSET? .L ,TAKEBIT>>> ;"tray"
				     <RFALSE>)
				    (T
				     <RTRUE>)>)
			     (<AND <NOT ,PRSI>
				   <ULTIMATELY-IN? ,PRSO>> ;"already have it"
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<AND <VERB? DROP PUT PUT-ON GIVE SGIVE>
			    ;"VERB ALL, object not held"
			    <NOT <IN? .OBJ1 ,WINNER>>>
		       <RTRUE>)
		      (<AND <VERB? DROP PUT PUT-ON GIVE SGIVE>
			    <FSET? .OBJ1 ,WORNBIT>>
		       <RTRUE>)
		      (<AND <VERB? PUT PUT-ON>
			    ;"PUT ALL IN X,obj already in x"
			    <NOT <IN? ,PRSO ,WINNER>>
			    <ULTIMATELY-IN? ,PRSO ,PRSI>>
		       <RTRUE>)>)>>

<ROUTINE CLOCKER-VERB? ()
	 <COND (<VERB? VERSION SAVE RESTORE RESTART QUIT SCRIPT UNSCRIPT
		       BRIEF SUPER-BRIEF VERBOSE HINT $ISL>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<GLOBAL P-WON <>>

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>

<ROUTINE FAKE-ORPHAN ("OPTIONAL" (IT-WAS-USED <>) "AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <TELL "[Be specific: Wh">
	 <COND (.IT-WAS-USED
		<TELL "at object">)
	       (T
		<TELL "o">)>
	 <TELL " do you want to ">
	 <COND (<EQUAL? .TMP 0>
		<TELL "tell">)
	       (<0? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <PREP-PRINT <GETB ,P-SYNTAX ,P-SPREP1>>
	 <TELL "?]" CR>>

<ROUTINE PERFORM-PRSA ("OPTIONAL" (O <>) (I <>))
	 <PERFORM ,PRSA .O .I>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI)
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<AND <EQUAL? ,IT .O .I>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<VISIBLE? ,P-IT-OBJECT>
		      <COND (<EQUAL? ,IT .O>
			     <SET O ,P-IT-OBJECT>)
			    (T
			     <SET I ,P-IT-OBJECT>)>)
		     (T
		      <COND (<NOT .I>
			     <FAKE-ORPHAN T>)
			    (T
			     <REFERRING>)>
		      <RFATAL>)>)>
	<COND (<AND <EQUAL? ,HIM .O .I>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<VISIBLE? ,P-HIM-OBJECT>
		      <COND (<EQUAL? ,HIM .O>
			     <SET O ,P-HIM-OBJECT>)
			    (T
			     <SET I ,P-HIM-OBJECT>)>)
		     (T
		      <COND (<NOT .I>
			     <FAKE-ORPHAN>)
			    (T
			     <REFERRING T>)>
		      <RFATAL>)>)>
	<COND (<AND <EQUAL? ,HER .O .I>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<VISIBLE? ,P-HER-OBJECT>
		      <COND (<EQUAL? ,HER .O>
			     <SET O ,P-HER-OBJECT>)
			    (T
			     <SET I ,P-HER-OBJECT>)>)
		     (T
		      <COND (<NOT .I>
			     <FAKE-ORPHAN>)
			    (T
			     <REFERRING T>)>
		      <RFATAL>)>)>
	<SETG PRSO .O>
	<SETG PRSI .I>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>
	       T)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <THIS-IS-IT ,PRSI>
	       <THIS-IS-IT ,PRSO>
	       <COND (<SET V <D-APPLY "Actor" <GETP ,WINNER ,P?ACTION>>>
		      T)
		     (<SET V <D-APPLY "M-Beg" <GET ,SCENARIO-TBL ,SCENARIO>
				       ,M-BEG>>
		      T)
		     (<SET V <D-APPLY "M-Beg" <GETP ,HERE ,P?ACTION> ,M-BEG>>
		      T)
		     (<SET V <D-APPLY "Preaction" <GET ,PREACTIONS .A>>>
		      T)
		     (<AND .I <SET V <D-APPLY "PRSI" <GETP .I ,P?ACTION>>>>
		      T) 
		     (<AND .O
			   <ZERO? ,P-WALK-DIR>
			   ;<NOT <EQUAL? .A ,V?WALK>>
			   <SET V <D-APPLY "PRSO" <GETP .O ,P?ACTION>>>>
		      T)
		     (<SET V <D-APPLY <> <GET ,ACTIONS .A>>>
		      T)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       ;<COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL "  Default ->" CR>)
			    (T
			     <TELL "  " .STR " -> ">)>)>
	       <SET RES <COND (.FOO
			       <APPLY .FCN .FOO>)
			      (T
			       <APPLY .FCN>)>>
	       ;<COND (<AND ,DEBUG
			   .STR>
		      <COND (<EQUAL? .RES ,M-FATAL>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

;"CLOCKER and related routines"

;<GLOBAL C-TABLE %<COND (<GASSIGNED? ZILCH>
			'<ITABLE NONE 30>)
		       (T
			'<ITABLE NONE 60>)>>

<GLOBAL CLOCK-WAIT <>>

;<GLOBAL C-INTS 60>

;<GLOBAL C-MAXINTS 60>

;<GLOBAL CLOCK-HAND <>>

<CONSTANT C-TABLELEN 60>
<CONSTANT C-INTLEN 4>	;"length of an interrupt entry"
<CONSTANT C-RTN 0>	;"offset of routine name"
<CONSTANT C-TICK 1>	;"offset of count"

;<ROUTINE DEQUEUE (RTN)
	 <COND (<SET RTN <QUEUED? .RTN>>
		<PUT .RTN ,C-RTN 0>)>>

;<ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-TICK>>
			       <RFALSE>)
			      (T
			       <RETURN .C>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

;<ROUTINE RUNNING? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<OR <ZERO? <GET .C ,C-TICK>>
				   <G? <GET .C ,C-TICK> 1>>
			       <RFALSE>)
			      (T
			       <RTRUE>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

;<ROUTINE QUEUE (RTN TICK "AUX" C E (INT <>)) ;"automatically enables as well"
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<COND (.INT
			       <SET C .INT>)
			      (T
			       <COND (<L? ,C-INTS ,C-INTLEN>
				      <TELL "**Too many ints!**" CR>)>
			       <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			       <COND (<L? ,C-INTS ,C-MAXINTS>
				      <SETG C-MAXINTS ,C-INTS>)>
			       <SET INT <REST ,C-TABLE ,C-INTS>>)>
			<PUT .INT ,C-RTN .RTN>
			<RETURN>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<SET INT .C>
			<RETURN>)
		       (<ZERO? <GET .C ,C-RTN>>
			<SET INT .C>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <COND (%<COND (<GASSIGNED? ZILCH>
			'<G? .INT ,CLOCK-HAND>)
		       (T
			'<L? <LENGTH .INT> <LENGTH ,CLOCK-HAND>>)>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 .INT>

<GLOBAL CLOCK-MOVE 12>
<CONSTANT CLOCK-DEFAULT 12>

<ROUTINE NOISY-VERB? ()
	 <COND (<OR <VERB? MUNG YELL>
		    <VERB? ALARM KNOCK KICK>
		    <VERB? KILL HIT CALL>>
		<RTRUE>)>>

<ROUTINE QUIET-VERB? ()
	 <COND (<OR <NOT <CLOCKER-VERB?>>
		    <VERB? EAT DRINK>
		    <VERB? LOOK EXAMINE WATCH>
		    <VERB? INVENTORY FIND HIDE>
		    <VERB? LOOK-INSIDE LOOK-UP LOOK-DOWN>
		    <VERB? SMELL COUNT READ>
		    <VERB? WAVE WAIT>
		    <VERB? SAVE RESTORE RESET>
		    <VERB? TAKE DROP PUT>
		    <VERB? OIL OPEN FAST-TIME>
		    <VERB? SLOW-TIME>
		    <AND <VERB? PUSH> <ULTIMATELY-IN? ,PRSO ,WINNER>>>
		<RTRUE>)>>

<ROUTINE CLOCKER ("AUX" E TICK RTN (FLG <>) (Q? <>) OWINNER)
	 <COND (<AND ,CUT-DETECTED
		     <G? ,CLOCK-TIME ,CUT-DETECTED>
		     <NOT ,CUT-VIGILANCE>>
		<SETG CUT-VIGILANCE T>)
	       (<AND <EQUAL? ,HERE ,HUT-STORAGE ,HUT-BEDROOM>
		     <IN? ,HUT-MAN ,HUT-LIVING>
		     <NOT <VERB? WALK>>
		     <NOT <QUIET-VERB?>>>
		<HLIGHT ,H-BOLD>
		<CRLF>
		<JIGS-UP
"That last action of yours has alerted the owner of your presence.
He calmly walks in, gun in hand, and places a call to the border patrol
who quickly arrive to take you into custody.">
		<RTRUE>)
	       (<AND <FSET? ,HERE ,GVIEWBIT>
		     <NOT <VERB? WALK>>>
		<SET TICK <GUARD-DISTANCE>>
		;<COND (,DEBUG
		       <TELL "[GUARD-DISTANCE = " N .TICK "]" CR>)>
		<COND (<AND <OR ,VIGILANCE ,CUT-VIGILANCE>
			    <OR ,TOWER-DESTROYED <PROB 30>>
			    <NOT ,GUARD-CHASE>>
		       <CRLF>
		       <TELL "One of the guards, more alert due">
		       <COND (,VIGILANCE
			      <TELL" to the recent explosion">)
			     (T
			      <TELL ", perhaps, to the belated
detection of voltage loss in the fence">)>
		       <TELL ", notices
you, and calls out to the other guards, who rapidly surround you and take you
into custody.">
		       <JIGS-UP " ">
		       <RTRUE>)
		      (<AND <OR <AND <NOISY-VERB?> <L? .TICK 40>>
				<AND <VERB? CUT> <L? .TICK 25>>>
			    <NOT ,GUARD-CHASE>>
		       ;<COND (,SL-DEBUG
			      <TELL "[GUARDS: Facing ">
			      <COND (<NOT <GUARDS-FACING-PLAYER?>>
				     <TELL "Away">)>
			      <TELL ", Distance: ">
			      <TELL N .TICK "]" CR>)>
		       <CRLF>
		       <JIGS-UP
"You've made enough noise to attract the guard's attention! He fires a
warning shot, alerting the other guards, who rapidly approach with
their weapons drawn...">
		       <RTRUE>)
		      (<AND <NOT <QUIET-VERB?>>
			    <GUARDS-FACING-PLAYER?>
			    <L? .TICK 70>
			    <PROB </ <- 100 .TICK> 4>>
			    <NOT ,GUARD-CHASE>>
		       ;<COND (,SL-DEBUG
			      <TELL "[GUARDS: Facing ">
			      <COND (<NOT <GUARDS-FACING-PLAYER?>>
				     <TELL "Away">)>
			      <TELL ", Distance: ">
			      <TELL N .TICK " (probabilistic)" CR>)>
		       <CRLF>
		       <JIGS-UP
"One of the guards notices you and fires a warning shot. An alarm
sounds, and you are rapidly surrounded by border guards...">
		       <RTRUE>)>)>
	 <I-CLOCKER ,CLOCK-MOVE>
	 ;"Formerly, only for WAIT"
	 <COND (<OR ,SL-WATCH ,G-WATCH>
		<UPDATE-CHRONOGRAPH 0 T>
		<UPDATE-TIME>)>
	 <SETG CLOCK-MOVE ,CLOCK-DEFAULT>
	 <RTRUE>>

<ROUTINE ABS (N)
	 <COND (<NOT <L? .N 0>> .N)
	       (T <- 0 .N>)>>

;<ROUTINE NEW-VERB (V)
	 <PERFORM .V ,PRSO ,PRSI>>

;<ROUTINE SWAP-VERB (V)
	 <PERFORM .V ,PRSI ,PRSO>>

;<ROUTINE NEW-PRSO (O)
	 <PERFORM-PRSA .O ,PRSI>>

;<ROUTINE NEW-PRSI (I)
	 <PERFORM-PRSA ,PRSO .I>>

;<ROUTINE NEW-WINNER-PRSO (A "OPT" (O <>) (I <>) "AUX" OW)
	 <SET OW ,WINNER>
	 <SETG WINNER ,PRSO>
	 <PERFORM .A .O .I>
	 <SETG WINNER .OW>>

;<ROUTINE REDIRECT (FROM TO "AUX" O I)
	 <SET O <COND (<PRSO? .FROM> .TO) (ELSE ,PRSO)>>
	 <SET I <COND (<PRSI? .FROM> .TO) (ELSE ,PRSI)>>
	 <PERFORM-PRSA .O .I>
	 <RTRUE>>

<ROUTINE TOO-LATE ()
	 <TELL "That's already been done." CR>>