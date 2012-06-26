/**


Type words into the box beat your opponent! Beat the stuffing out of the computer with 5 ai levels
or another player! Lengthier words result in more devasting attacks!


















**/
mob
	proc
		Help()
			var/text = {"
			<head><title>Blah</title></head><body>
			<center><font size = 6 face = 'VAGRounded BT'>Welcome to [world.name].</font></center>
			<font face = 'VAGRounded BT'> <br>
			<u>How to Play:</u><br> Type to beat the stuffing out of your opponent. Entering lengthier words
			 or creating combos by typing more than one word separated by a space results in more devasting attacks! When ready,
			 click the join button to
			select the mode or to join as the second player. <br><br>
			<font size = 4>Modes:</font><br><br><u>
			Single Player</u> <br> Test your scrapping skills and prove your fortitude against computer fighters of 6 varying difficulties.
			Beware, true masters of the art roam!<br><br>

			 <u>Two Player</u> <br> Scrap with another human for supremacy!<br><br>

			 Custom words: Allow spectators to enter words you can use to fight your opponent.<br>
			 <br>
			 Spectators: Allow/disallow them to chat
			 </font>
			 </body>
			 "}
			src << output("[text]","window.help")