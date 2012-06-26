mob
	Stick
		icon = 'Stick_FIgures.dmi'
		dir = WEST
		New()
			src.name = pick(Sticks)
			..()


var/list/Sticks = list("Sticksta","Killa","Chopsta", "StickFu Masta", "Ryu","Tom","Dan","You Die")

mob
	proc
		Actions()
			if(src.wlength == 3)
				flick("Punch",src)
				src.target.hp -= 3
				world << sound('1.wav')
			if(src.wlength == 4)
				flick("Kick",src)
				src.target.hp -= 3
				world << sound('2.wav')
			if(src.wlength == 5)
				flick("Jump Kick",src)
				src.target.hp -= 4
				world << sound('3.wav')
			if(src.wlength == 6)
				flick("Low Kick",src)
				src.target.hp -= 4
				world << sound('4.wav')
			if(src.wlength == 7)
				flick("Uppercut",src)
				src.target.hp -= 5
				world << sound('5.wav')
			if(src.wlength >= 8)
				flick("Crotch Punch",src)
				src.target.hp -= 5
				world << sound('6.wav')
			if(src.target.hp <= 0)
				src.target.hp = 0
				notype = 1   // disallow further player typing
				world << sound('7.wav')
				for(var/mob/m in world)
					if(m.client)
						winset(m,"window.word","is-visible=false")     // take away the boxes
						winset(m,"window.word2","is-visible=false")
						winset(m,"window.word3","is-visible=false")
				src.icon_state = "Victory"
				world << "[src] wins!"
				sleep(10)
				target.Death()
				//src.Medals() // award Medals
				src.Scoring()
				target.Scoring()
				world << "Reboot in 10 seconds."
				sleep(100)
				world.Reboot()


		Death()
			src.icon_state = "Death"

		Comp_Choose()
			switch(input("Which level ai to challenge?") in list ("Very Easy", "Easy", "Medium", "Hard", "Very Hard", "Insane", "Foomer", "Random"))
				if("Very Easy")
					src.target.ai = 0
				if("Easy")
					src.target.ai = 1
				if("Medium")
					src.target.ai = 2
				if("Hard")
					src.target.ai = 3
				if("Very Hard")
					src.target.ai = 4
				if("Insane")
					src.target.ai = 7
				if("Foomer")
					src.target.ai = 10
					src.target.name = "Foomer"
				if("Random")
					src.target.ai = 9

		Comp_AI()      // fight ai for computer
			var/random = src.ai
			if(src.ai == 9)
				random = rand(0,10)  // 6 different ai levels
			if(!random) // very easy
				while(src.hp >= 1 && src.target.hp >= 1)
					src.wlength = rand(3,8)
					src.Actions()
					sleep(40)
			if(random == 1) // easy
				while(src.hp >= 1 && src.target.hp >= 1)
					src.wlength = rand(3,8)
					src.Actions()
					sleep(30)
			if(random == 2) // medium
				while(src.hp >= 1 && src.target.hp >= 1)
					src.wlength = rand(4,8)
					src.Actions()
					sleep(20)
			if(random == 3) // hard
				while(src.hp >= 1 && src.target.hp >= 1)
					src.wlength = rand(4,8)
					src.Actions()
					sleep(10)
			if(random == 4 || 5 || 6) // very hard
				while(src.hp >= 1 && src.target.hp >= 1)
					src.wlength = rand(5,8)
					src.Actions()
					sleep(5)
			if(random == 7 || 8 || 9) // near impossible
				while(src.hp >= 1 && src.target.hp >= 1)
					src.wlength = rand(5,8)
					src.Actions()
					sleep(4)
			if(random == 10) // Foomer
				while(src.hp >= 1 && src.target.hp >= 1)
					src.wlength = rand(3,5)
					src.Actions()
					sleep(2)