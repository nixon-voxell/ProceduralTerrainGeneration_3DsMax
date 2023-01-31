timePassed = 0
runTimer = false
intervalTime = 50

rollout SimpleTimer "Simple Timer" (
	timer clock "Clock" interval:intervalTime
	label timePassedLabel "0"

	button startButton "Start"
	button pauseButton "Pause"
	button restartButton "Restart"

	on clock tick do (
		if runTimer == true do (
			timePassed += intervalTime
			timePassedLabel.text = timePassed as String
		)
	)
	
	on startButton pressed do (
		runTimer = true
	)
	
	on pauseButton pressed do (
		runTimer = false
	)
	
	on restartButton pressed do (
		timePassed = 0
		timePassedLabel.text = timePassed as String
	)
)

createdialog SimpleTimer width:200 height:200