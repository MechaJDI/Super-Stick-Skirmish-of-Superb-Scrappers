world
	hub = "MechaDestroyerJD.SuperStickSkirmishofSuperbScrappers"
	name = "Super Stick Skirmish of Superb Scrappers"
	hub_password = "dragon1215"
	map_format = TILED_ICON_MAP
	New()
		..()
		var/texts = file2text("L.txt")        // makes a text string from the txt file
		var/list/test2 = params2list(texts)      // puts the string into a list
		for(var/a in test2)
			ingame.Add(a)

	Del()
//		var/a = list2params(words)         // convert the list to text
//		if(fexists("Words.txt"))
//			var/b = file2text("Words.txt")
//			if(length(a) == length(b))
//				return
//		if(a)                              // if there is text
//			text2file(a,"Words.txt")       // convetr the text to a text file
		..()


var/list/words[0]



var
	time
	word
	word2
	word3
	mob/player1
	mob/player2
	cwords = 0  // disable/enable spectator words
	typing = 0 // disable/allow typing of words
	notype = 0  // disallow player typing

mob
	var
		hp = 100
		level = 0
		mob/target   // who the person will attack
		wlength // length of typed word
		out = 0 // check to see if logging out
		ai = 0 // level of the computer ai
		stun = 0 // not stunned from failed combo
		comboed = 0 //whether or not a combo was used




mob
	Stat()
		if(player1)
			world<<output("Health: [player1.hp]","window.hp")
		if(mode && player2)
			world<<output("Health: [player1.target.hp]","window.hp2")
			world<<output("[player1] vs. [player1.target]","window.vs")


	Move()
		return

proc
	Players()
		world << output(null,"window.who")
		world << output("<u>Players</u>:","window.who")
		world << output("Player 1: [player1]","window.who")
		world << output("Player 2: [player2]","window.who")
		world << output("","window.who")
		for(var/mob/m in world)
			if(m.client)
				if(m != player1 || player2)
					if(!m.out) // if they aren't logging out
						world << output("[m.key]","window.who")


mob
	proc
		Medals()
			if(src.client)
				if(src.target.name == "Foomer")
					src << "Wow, you actually had the guts to face Foomer! You're a Brave Soul."
					world.SetMedal("Brave Soul",src)
					if(src.target.hp <= 0)
						src << "Unbelievable, you've beaten the great Foomer. You're a Scrapping Master!"
						world.SetMedal("Scrapping Master",src)
				if(src.target.hp >= 50)
					src << "Wow, you got the stuffing beat out of ya..."
					world.SetMedal("Punching Bag",src)
				if(src.target.hp <= 20)
					src << "You almost beat your opponent, but you STILL LOST!"
					world.SetMedal("Less of a Loser", src)
				if(!src.comboed)
					src << "You successfully won a fight without using any combos! You're an Agile Striker."
					world.SetMedal("Agile Striker",src)
				if(src.hp == 1)
					src << "You won the fight with 1 health remaining! You're a True Survivor!"
					world.SetMedal("True Survivor",src)
				if(src.hp == 10)
					src << "You were almost down, but you were not out!"
					world.SetMedal("Down But Not Out",src)
				if(src.target.client)
					src << "Congratulations, you're the more Superb Scrapper"
					world.SetMedal("Superb Scrapper",src)
				if(src.hp >= 1)
					src << "Congratulations, you're a Winner!"
					world.SetMedal("Winner",src)

mob
	Login()
		winset(src,"window.input","text=TypeHere")
		src.loc = locate(5,3,1)
		src.dir = "EAST"
		Players()
		src.Help()
//		for(var/a in easy)
//			ingame.Add(a)
//		for(var/a in medium)
//			ingame.Add(a)
//		for(var/a in hard)
//			ingame.Add(a)
//		usr.Mode()
//		usr.Words()
//		src.Time()

//run win procs for logout

mob
	Logout()
		src.out = 1 // logging out
		src.hp = 0
		src.Scoring()
		src.target.Scoring()
		if(notype) // if they can type, signifying game still going on
			if(src == player1)
				world << "[src] forfeits the battle!"
				world << "[player2] wins!"
			if(src == player2)
				world << "[src] forfeits the battle!"
				world << "[player1] wins!"
		src.target.Actions() // run the actions proc again
		Players()  // update who window
		del(src)

mob
	verb
		Join()
			if(!player1)
				player1 = usr
				usr.icon = 'Stick_FIgures.dmi'
				Players()
				for(var/mob/m in world)
					if(m.client)
						winset(m,"window.Join","is-disabled=true")   // disable join button
				usr.Mode()
			else
				if(mode == "Two Player")
					usr.ai = 7 // set ai to 7 for fortitude
					if(!player2)       // if no player 2
						if(player1 != usr)  // if player one isn't their key
							player2 = usr   // make player 2 their key
							usr.icon = 'Stick_FIgures.dmi'
							usr.loc = locate(6,3,1)
							usr.dir = "WEST"
							usr.target = player1
							Players()
							for(var/mob/m in world)
								if(m.client)
									winset(m,"window.Join","is-disabled=true")   // disable join button
								if(m == player1)
									m.target = usr
							usr.Words() // start game


proc/text2list(message, divider = " ")
    if(!message) return
    message += divider
    var/list/L = list()
    while(findtext(message, divider))
        var/position = findtext(message, divider)
        L += copytext(message, 1, position)
        message = copytext(message, position+length(divider))
    return L



mob
	verb
		s(msg as text)  // type word using this
			if(player1 == usr || player2 == usr)
				if(!notype) // if they can type
					if(msg)
//					if(ingame.Find("[msg]"))  // if they find the message in the word list
	//					var/b = 10*length(msg)
	//					usr.points += b
						var/list/combo = text2list(msg)
						var/c = 0  // combo meter
						for(var/a in combo)    // for each word in list, check if a word
							if(a == word)
								c++
							if(a == word2)
								c++
							if(a == word3)
								c++
						if(c == 2 || 3)   // if its a combo
							usr.comboed = 1
							for(var/a in combo)
								if(a == word)    // search for each separate word
									word = null
									usr.wlength = length(a)
									usr.Actions() // make the on screen char attack
									ingame.Remove(a)
//										recycle.Add(a)
									usr.Words()           // add new words to the screen
									sleep(5)
								if(a == word2)
									word2 = null
									usr.wlength = length(a)
									usr.Actions() // make the on screen char attack
									ingame.Remove(a)
//										recycle.Add(a)
									usr.Words()           // add new words to the screen
									sleep(5)
								if(a == word3)
									word3 = null
									usr.wlength = length(a)
									usr.Actions() // make the on screen char attack
									ingame.Remove(a)
//										recycle.Add(a)
									usr.Words()           // add new words to the screen
									sleep(5)
						if(c < 1)   // if the combo is less than or = 1 word
							usr.stun = 1
							usr << output("???","window.word")
							usr << output("???","window.word2")
							usr << output("???","window.word3")
							sleep(20)
							usr.stun = 0
							usr << output("[word]","window.word")
							usr << output("[word2]","window.word2")
							usr << output("[word3]","window.word3")
						else // if its not a combo attempt
							if(ingame.Find("[msg]"))   // if its actually in the game
								if("[msg]" == word)        // if the typed word = word
									word = null           // nullify it
								if("[msg]" == word2)
									word2 = null
								if("[msg]" == word3)
									word3 = null
								usr.wlength = length(msg)
								usr.Actions() // make the on screen char attack
								ingame.Remove("[msg]")
//								recycle.Add("[msg]")
								usr.Words()           // add new words to the screen
	//				ingame.Remove("[msg]")      // remove the word from the list
			else  // if they aren't playing, world say
				if(!typing) // allow spectators to talk
					msg = SGuard(msg)
					if(length(msg))
						world << "[usr] : [msg]"
					else
						var/random = rand(0,1)
						if(!random)
							alert("Do not spam. Next time you may be booted.")
						else
							src.Logout()
				else
					usr << "Talking is currently disabled."
		//				var/b = 10*length(msg)
		//				usr.points -=b

/**
mob
	verb
		s(msg as text)  // type word using this
			if(player1 == usr || player2 == usr)
				if(!notype) // if they can type
					if(msg)
//					if(ingame.Find("[msg]"))  // if they find the message in the word list
	//					var/b = 10*length(msg)
	//					usr.points += b
						if(findText("[msg]",";"))  // detects semicolons to make list
							var/list/combo = params2list(msg)
							var/c = 0  // combo meter
							for(var/a in combo)    // for each word in list, check if a word
								if(a == word)
									c++
								if(a == word2)
									c++
								if(a == word3)
									c++
							if(c == 2 || 3)   // if its a combo
								for(var/a in combo)
									if(a == word)    // search for each separate word
										word = null
										usr.wlength = length(a)
										usr.Actions() // make the on screen char attack
										ingame.Remove(a)
//										recycle.Add(a)
										usr.Words()           // add new words to the screen
										sleep(5)
									if(a == word2)
										word2 = null
										usr.wlength = length(a)
										usr.Actions() // make the on screen char attack
										ingame.Remove(a)
//										recycle.Add(a)
										usr.Words()           // add new words to the screen
										sleep(5)
									if(a == word3)
										word3 = null
										usr.wlength = length(a)
										usr.Actions() // make the on screen char attack
										ingame.Remove(a)
//										recycle.Add(a)
										usr.Words()           // add new words to the screen
										sleep(5)
							if(c <= 1)   // if the combo is less than or = 1 word
								usr.stun = 1
								usr << output("???","window.word")
								usr << output("???","window.word2")
								usr << output("???","window.word3")
								sleep(20)
								usr.stun = 0
								usr << output("[word]","window.word")
								usr << output("[word2]","window.word2")
								usr << output("[word3]","window.word3")

						else // if its not a combo attempt
							if(ingame.Find("[msg]"))   // if its actually in the game
								if("[msg]" == word)        // if the typed word = word
									word = null           // nullify it
								if("[msg]" == word2)
									word2 = null
								if("[msg]" == word3)
									word3 = null
								usr.wlength = length(msg)
								usr.Actions() // make the on screen char attack
								ingame.Remove("[msg]")
//								recycle.Add("[msg]")
								usr.Words()           // add new words to the screen
	//				ingame.Remove("[msg]")      // remove the word from the list
			else  // if they aren't playing, world say
				if(!typing) // allow spectators to talk
					msg = SGuard(msg)
					if(length(msg))
						world << "[usr] : [msg]"
					else
						var/random = rand(0,1)
						if(!random)
							alert("Do not spam. Next time you may be booted.")
						else
							src.Logout()
				else
					usr << "Talking is currently disabled."
		//				var/b = 10*length(msg)
		//				usr.points -=b
**/

mob
	verb
		Say(msg as text)
			if(!notype) // if they can type
				msg = SGuard(msg)
				if(length(msg))
					world << "[usr] : [msg]"
				else
					var/random = rand(0,1)
					if(!random)
						alert("Do not spam. Next time you may be booted.")
					else
						src.Logout()
			else
				usr << "Talking is currently disabled."
	/*
mob
	verb
		Test()
			var/texts = file2text("Test.txt")        // makes a text string from the txt file
			var/list/test2 = params2list(texts)      // puts the string into a list
			for(var/a in test2)
				world << "[a]"
/**
			if(findtext("[texts]"," "))
				world << "Found"
			else
				world << "nope"
**/

		test2()
			var/texts = file2text("Test2.txt")
			if(findtext("[texts]","hah"))
				texts = texts -"hah"
			world << "[texts]"
/**
			var/list/test2 = params2list(texts)
			for(var/b in test2)
				world << "[b]"
**/

**/

mob
	proc
		SGuard(T as text)
			T = html_encode(T)
			if(length(T) >= 250)
				T = null
			return	T


// find spaces in text string and replace with ;

mob
	verb
		Enter_Word()
			if(!cwords)
				var/msg = input("Input a word")
				if(msg)
					if(!ingame.Find(msg))
						ingame.Add(msg)
						usr << "Word added."
					else
						usr << "Word not added"
			else
				usr << "Custom words are currently disabled."
/**
		View_Words()
//			for(var/a in words)
//				world << "[a] length = [length(a)]"
//			var/a = list2params(words)
//			var/b = file2text("Words.txt")
//			var/a = file2text("Test.txt")
//			var/list/b = params2list(a)
			for(var/a in ingame)
				world << "[a]"
**/



turf
	World
		icon = 'turf.dmi'
		icon_state = "wall"