
$Shaft.parent = $Fuselage
$Propeller.parent = $Shaft

path_constraint()
a = path_constraint()
$Fuselage.position.controller = a
rotate $Fuselage (EulerAngles 0 0 180)
a.path = $circle 
a.getweight 3
a.follow = true
a.bank = true

animate on 
(
	for t in 0 to 100 by 5 do
	(
		at time t about $Shaft
		(
		rotate $Propeller (angleaxis 720 [1,0,0])
		)
	)
)