mob
	proc
		Scoring()
			if(src.client)
				var/list/records
				var/scores = world.GetScores(src.key, "") // retrieve scores of player
				if(!isnull(scores)) // if hub is accessible
					records = params2list(scores)
					var/list/newScores = new
					if(!text2num(records["Level of Fortitude"]))
						newScores["Level of Fortitude"] = 0
					if(!text2num(records["Wins"]))
						newScores["Wins"] = 0
					if(!text2num(records["Losses"]))
						newScores["Losses"] = 0

					var/number = text2num(records["Level of Fortitude"])+src.target.ai
					newScores["Level of Fortitude"] = round(number/2)
					if(src.hp >= 1) // if they have hp left, add to their wins
						newScores["Wins"] = text2num(records["Wins"])+1
					else
						newScores["Losses"] = text2num(records["Losses"])+1
					if(world.SetScores(src.key, list2params(newScores)))
						src << "Your statistics have been recorded."
					else
						src << "Unable to record statistics."
				src.Medals()



var
	mins = 0
	secs = 0

mob
	proc
		Time()
//			if(mode == "Single Player")
			mins = 3
			secs = 0
			while(mins)
				secs = 59
				mins --
				sleep(10)
				while(secs)
					secs --
					if(secs < 10)
						secs = "09"
						sleep(10)
						secs = "08"
						sleep(10)
						secs = "07"
						sleep(10)
						secs = "06"
						sleep(10)
						secs = "05"
						sleep(10)
						secs = "04"
						sleep(10)
						secs = "03"
						sleep(10)
						secs = "02"
						sleep(10)
						secs = "01"
						sleep(10)
						secs = "00"
					sleep(10)
					if(secs == "00")
						secs = 0
				sleep(10)


/**

mob
	proc
		Time()
			if(mode == "Single Player")
				secs = 1800
				while(secs)
					mins = secs/60
					secs --
					sleep(10)



**/
