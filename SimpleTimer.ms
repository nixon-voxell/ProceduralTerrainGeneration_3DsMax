delete objects		--delete all the available objects on scene
parentBox = undefined
function Tree currentHeight maxHeight parentBox:undefined branchingChance: 0.15=
(
	branchColor = [random 0 255, random 0 255, random 0 255]
	firstBox = undefined
	for i in currentHeight to maxHeight do
	(
		newBox = box()
		if firstBox == undefined then
			firstBox = newBox
		if parentBox != undefined then 
		(
			newBox.parent = parentBox
			newBox.wirecolor = branchColor
			in coordsys parent newBox.scale = [0.95, 0.95, 0.95]
			in coordsys parent newBox.pos = [0, 0, 30]
				
			rotX = random -0.0 10.0
			rotY = random -10.0 10.0
			rotZ = random -10.0 10.0
			about newBox.parent rotate newBox (eulerAngles rotX rotY rotZ)
			
			branchRoll = random 0.0 1.0
			
			if branchRoll <= branchingChance then
			(
				branchColor = [random 0 255, random 0 255, random 0 255]
				-- Create a new branch
				branchBox = Tree i maxHeight parentBox: newBox
			
				-- Stretch out the branches
				rotBranchX = random -45.0 45.0
				rotBranchY = random -45.0 45.0
				rotBranchZ = random -180.0 180.0
				
				about newBox rotate branchBox (eulerAngles rotBranchX rotBranchY rotBranchZ)
			)
		)
		parentBox = newBox
	)
	firstBox		-- return the first box back to its caller
)

function AnimateTree treeBox currentFrame: 0 frameIncrement: 3 =
(
	for i in 1 to treeBox.children.count do
	(
		nextFrame = currentFrame + frameIncrement
		animateTree treeBox.children[i] currentFrame: nextFrame
	)
	
	currentScale = treeBox.scale
	
	with animate on
	(
		at time 0 treeBox.scale = [0, 0, 0]
		at time currentFrame treeBox.scale = currentScale
	)
)

myTree = tree 1 30 branchingChance:0.2
animatetree mytree
