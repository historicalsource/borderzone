
"ONCE for
		      		BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<ROUTINE START-SCENARIO-1 ("OPTIONAL" (INT? <>))
         <SETG START-HOUR 17>
	 <SETG START-MINUTE 26>
	 <SETG CLOCK-TBL ,CLOCK-TBL-1>
	 <SETG CLOCK-INTS ,CLOCK-INTS-1>
	 <SETG MAX-WEIGHT 150>
	 <SETG SCENARIO ,S-BYSTANDER>
	 <SETG HERE ,COMP-5>
	 <SETG WINNER ,PROTAGONIST>
	 <REMOVE ,CLOTHES>
	 <MOVE ,BYSTANDER-WATCH ,WINNER>
	 <MOVE ,BYSTANDER-CLOTHES ,WINNER>
	 <MOVE ,DOCUMENT ,WINNER>
	 <MOVE ,WINNER ,HERE>
	 <SLOW-CLOCK-QUEUE ,I-BAD-SPY 20>
	 <RT-QUEUE ,I-BAD-TUNNEL 900>
	 <INIT-STATUS-LINE 3>
	 <STATUS-LINE>
	 <UPDATE-TIME>
	 <SETG CONTACT <PICK-ONE ,BUMPERS>>
	 <TELL "|
|
It is always a pleasure to leave Frobnia, and the ride is never over too
soon. Sure, a plane would be faster, but as far as reliability goes,
well ... better late than never, that's the best rule.|
|
The train ride from Frzi to Vienna is into its sixth hour, and the train
is fast approaching the border of neutral Litzenburg. You can breathe a lot
easier there, just knowing that you're out from behind the Iron Curtain. It's
even worth the border crossing - guards everywhere, suitcases searched -
horrible, really, but there's no use complaining. There are worse countries
to be importing goods from - you should know, you've been in most of
them.|
|
Just here, a few miles from the border, night is falling, and the lights of
the small villages flicker into existence. You're drifting off into sleep
when there is a knock on your compartment door, and a man, clutching his
left arm, staggers inside. Drops of blood on his sleeve leave no doubt
as to the cause.|
|
\"Don't be frightened,\" he begins, \"I'm all right.\" Before you can speak,
he begins his story. He is, it seems, an American agent who has just learned
of a sinister plot to assassinate a top-ranking American diplomat tomorrow
morning in Ostnitz, the town your train is
fast approaching. He hands you a document, which he says must be passed to
his contact at the train station there. You look through it, but it's all
in Frobnian, and you know barely a handful of words - that's why you always
carry your combination tourist guide and phrase book with you on your trips
here.|
|
\"You must deliver this. I do not know who the contact is - he was supposed
to find me. I was to wear this white carnation.\" He pulls out the rumpled
flower and pins it onto your jacket. \"He will bump into you and greet you
with the words '">
	 <TELL <GET <GETP ,CONTACT ,P?FROBNIAN> 1>>
	 <TELL "' to which you should reply 'It
is my fault.' Then, hand him the document and earn our country's thanks.\"|
|
He looks quickly over his shoulder - an instinct, perhaps. \"I must be going.
You understand.\" And with that, he disappears from the compartment." CR CR>
	 <COND (.INT? <V-LOOK>)>
	 <RTRUE>>

<ROUTINE START-SCENARIO-2 ("OPTIONAL" (INT? <>))
	 <PUT <GETPT ,ME ,P?SYNONYM> 3 ,W?TOPAZ>
	 <SETG READ-CLOCK 10> ;"FAST"
	 <SETG CLOCK-TIME 0>
	 <REMOVE ,BYSTANDER-CLOTHES>
	 <REMOVE ,BYSTANDER-WATCH>
	 <SETG START-HOUR 17>
	 <SETG START-MINUTE 49>
	 <SETG CLOCK-TBL ,CLOCK-TBL-2>
	 <SETG CLOCK-INTS ,CLOCK-INTS-2>
	 <SETG MAX-WEIGHT 40>
	 <SETG SCENARIO ,S-GOOD>
	 <SETG HERE ,B8>
	 <SETG WINNER ,PROTAGONIST>
	 <MOVE ,EXPLODING-PEN ,WINNER>
	 <MOVE ,NORMAL-SHOES ,WINNER>
	 <MOVE ,TIMING-OBJECT ,WINNER>
	 <MOVE ,CLOTHES ,WINNER>
	 <MOVE ,WINNER ,HERE>
	 <SETG SHOES-WORN ,NORMAL-SHOES>
	 <REMOVE ,LEFT-ARM>
	 <MOVE ,WOUNDED-LEFT-ARM ,PROTAGONIST>
	 <INIT-STATUS-LINE 3>
	 <STATUS-LINE>
	 <UPDATE-TIME>
	 <SETG CHRONOGRAPH-ON T>
	 <UPDATE-CHRONOGRAPH 0 T>
	 <SETG CHRONOGRAPH-ON <>>
	 <TELL
"|
|
Cold. Pain.|
|
What happened? I wasn't even active ... just making one of my monthly
excursions to Vienna, keeping up the front ... George Bonnard, Vice President
- Eastern Europe, IC Cola ... \"Drink It Up, Frobnia!\" What a laugh.|
|
The train, yes ... of course ... Just past Yinsli, I spotted my
archenemy \"Viper,\" only it wasn't him, it was a priest.
But it ">
	 <HLIGHTELL "was">
	 <TELL " him.|
|
He vanished, lost in the crowd ... tourists, a honeymoon couple, something ...
moonlight, thank God for that ... pitch black otherwise. OK, stop and
think. You found him, his compartment, but he wasn't there. He left
the briefcase, not as smart as his reputation, but that's not it. Wait.|
|
Found the document, the assassination of - who? It's here, isn't it?
No? Well, where the hell is it? But he came back, yes, Viper, and then
the fight. And a shot, and Christ it hurts but at least it's not my ">
	 <HLIGHTELL "right">
	 <TELL " arm...|
|
Don't know how I got away ... must have done some damage myself. \"Border
Stop! We will be arriving at the border in five minutes!\" But, the
document... Oh, yes, the real McCoy ... the real businessman, the one in
the dining car -  gave it to him knowing I'd be caught. He's got it,
that is if ">
	 <HLIGHTELL "they">
	 <TELL " haven't got ">
	 <HLIGHTELL "him">
	 <TELL "...|
|
It's clearer now. We went into a tunnel, and it was then that I knew
... the only chance, the only escape ... jumping off the train! The fall
must have knocked me out cold for a few moments, but I seem alive
enough. It can't be too far to the border, just a little to the north. If
I don't die first.|
|
">
	 <COND (.INT? <V-LOOK>)>
	 <RTRUE>>

<ROUTINE START-SCENARIO-3 ("OPTIONAL" (INT? <>))
         <PUT <GETPT ,ME ,P?SYNONYM> 3 ,W?VIPER>
	 <SETG G-WATCH <>>
	 <SETG SL-WATCH <>>
	 <SETG CHRONOGRAPH-ON <>>
	 <SETG VERBOSE-CLOCK <>>
	 <SETG CLOCK-TIME 0>
	 <SETG READ-CLOCK 10> ;"FAST"
	 <SETG START-HOUR 11>
	 <SETG START-MINUTE 47>
	 <SETG CLOCK-TBL ,CLOCK-TBL-3>
	 <SETG CLOCK-INTS ,CLOCK-INTS-3>
	 <SETG MAX-WEIGHT 100>
	 <SETG SCENARIO ,S-BAD>
	 <SETG HERE ,SQUARE-NW>
	 <SETG WINNER ,PROTAGONIST>
	 <SNIPER-INIT>
	 <RT-QUEUE ,I-CUSTOMER-LEAVES 265>
	 <REMOVE ,CLOTHES>
	 <MOVE ,BUSINESS-CARD ,WINNER>
	 <MOVE ,BAD-WATCH ,WINNER>
	 <MOVE ,BAD-GUN ,WINNER>
	 <MOVE ,CIGARETTE ,WINNER>
	 <MOVE ,MATCHES ,WINNER>
	 <MOVE ,BAD-CLOTHES ,WINNER>
	 <REMOVE ,CARNATION>
	 <REMOVE ,WOUNDED-LEFT-ARM>
	 <MOVE ,LEFT-ARM ,PROTAGONIST>
	 <MOVE ,WINNER ,HERE>
	 <INIT-STATUS-LINE 3>
	 <STATUS-LINE>
	 <UPDATE-TIME>
	 <TELL "|
|
\"Vipna homitz, nimso klamitz.\" \"A rotten fish will turn up
eventually.\" The American \"Murphy\" puts it better, perhaps, but your
Frobnian expression seems to fit the circumstances.|
|
Not that it started out that way. No, the Kremlin decided to assassinate
the American ambassador to Litzenburg, and it's
naturally a very sensitive affair, so they chose you to supervise - that is,
keep it clean, keep the KGB and the Kremlin from appearing to be involved.
That part wasn't hard - it didn't take long for your Litzenburger friends
to find an angry, young Iranian who was more than willing to perform God's
work...|
|
No, your problem isn't keeping the job clean ... it's preventing it from
happening, without blowing your cover. And you haven't spent the last ten
years working your way up the KGB hierarchy just to start taking stupid
chances now. Nobody said it would be easy being a double agent. So, coded
cable in hand and dressed as a clergyman, you boarded the train to Ostnitz.|
|
Enter a headstrong, street-smart American agent code-named Topaz - didn't
have the slightest clue who you were. But smart enough to know that
something was up, so he waylaid you, and took the cable. You smile that
disturbing smile of yours at nobody in particular - if only he knew the code,
he could have done your work for you!|
|
Your first priority was retrieving the document, so the priest's garb had
to go - the local authorities would respond better to the trench coat
than to the cloth. But Topaz must have jumped - poor guy, doesn't have a
chance. And that American businessman... something not quite right there,
but nothing solid.|
|
So now your job's doubly hard - knowing only that the assassination is
in the Ostnitz town square, a little after noon. Fortunately, the KGB's
local man is a good friend of yours, an antique dealer named Riznik. He
probably even arranged the plan, so you can get the details from him.
But even with the plan in hand, you'll still have your hands full - security
is tight here, and some of the local police would find your presence here
more than a little disturbing. You take a deep breath, and plunge into the
milling crowd.|
|
">
	 <COND (.INT? <V-LOOK>)>
	 <RTRUE>>

<ROUTINE OPENING-SCREEN ("AUX" CHR)
	 <CLEAR -1>
	 <HLIGHT ,H-BOLD>
	 <V-VERSION>
	 <TELL
"|
Welcome to Border Zone. This story of international intrigue has
three chapters, each telling a different piece of the story from a different
point of view. You can play each chapter independently, but you will enjoy
the story more if you play them in the proper order. If at any time you
need to \"pause\" the game and cause the real-time clock to stop running
(to get a sandwich or to read a long bit of
text), use the PAUSE command.|
|
The chapters are:|
|
   Chapter 1: The Train|
   Chapter 2: The Border|
   Chapter 3: The Assassination|
">
	 <REPEAT ()
		 <TELL CR
"Which chapter would you like to play: 1, 2, 3, or (R)estore? >">
		 <SET CHR <INPUT 1>>
		 <COND (<EQUAL? .CHR %<ASCII !\1>>
			<START-SCENARIO-1>
			<RTRUE>)
		       (<EQUAL? .CHR  %<ASCII !\2>>
			<START-SCENARIO-2>
			<RTRUE>)
		       (<EQUAL? .CHR %<ASCII !\3>>
			<START-SCENARIO-3>
			<RTRUE>)
		       (<AND <EQUAL? .CHR %<ASCII !\R> %<ASCII !\r>>
			     <CRLF>
			     <V-RESTORE>>)
		       (T
			<TELL CR CR
"Just press \"1\", \"2\", \"3\", or \"R\" to start the game." CR>)>>>