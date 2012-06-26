var/mode

mob
	proc
		Mode()
			switch(input("Do you want to allow spectators to enter words?") in list ("Yes", "No"))
				if("No")
					cwords = 1 // make them unable to enter words
			switch(input("Do you want to allow spectators to speak?") in list ("Yes", "No"))
				if("No")
					typing = 1
			switch(input("Which mode to play?") in list ("Singleplayer", "Two Player"))
				if("Singleplayer")
					mode = "Single Player"
				else
					mode = "Two Player"
			src.Game()
/**
			switch(input("Which difficulty of words?") in list ("Easy", "Medium", "Hard"))
				if("Easy")
					for(var/a in easy)
						ingame.Add(a)
//			world << "wtf?"

			src.Game()
**/

mob
	proc
		Game()
			if(mode == "Single Player")
				var/mob/Stick/S=new
				S.loc = locate(6,3,1)
				S.dir = "WEST"
				src.target = S  // make the comp the player's target
				S.target = src  // make the player the comp's target
				src.Comp_Choose()
				sleep(10)
				src << "<b>Ready</b>"
				sleep(20)
				src << "<b>Set</b>"
				sleep(20)
				src << "<b>FIGHT!</b>"
				src.Words()
				S.Comp_AI()
			else
				world << "Two Player mode selected!"
				for(var/mob/m in world)
					if(m.client)
						winset(m,"window.Join","is-disabled=false")





mob
	proc
		Words()
			if(length(ingame) >= 3)
				if(!word)    // if the word 1 is blank
					word = pick(ingame)      // pick from the list of in-use words
					while(word == word2 || word == word3)        // while its the same as other words,
						word = pick(ingame)                      // pick until different
						sleep(1)
				if(!word2)
					word2 = pick(ingame)
					while(word2 == word || word2 == word3)
						word2 = pick(ingame)
						sleep(1)

				if(!word3)
					word3 = pick(ingame)
					while(word3 == word2 || word3 == word)
						word3 = pick(ingame)
						sleep(1)
				for(var/mob/m in world)
					if(m.client)
						if(!m.stun)
							world << output("[word]","window.word")         //output to the label on the window
							world << output("[word2]","window.word2")
							world << output("[word3]","window.word3")
/**
			else
//				world << "Recycling words..."
				for(var/a in recycle)
					recycle.Remove(a)
					ingame.Add(a)
**/

