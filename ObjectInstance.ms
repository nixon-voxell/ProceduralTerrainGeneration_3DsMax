fileIn "NoiseUtil.ms"

fn PopulateTerrain resolution size maxHeight minHeight
    noiseScale0:3 noiseScale1:10 scroll:0
    populateNoiseScale:5 populateScroll:1 populateThreshold:0.5 = (
    size = size as float
    rotationScroll = populateScroll + 1

    if (selection.count != 4) do return 0
    sel = (selection as array)

    for y = 1 to resolution - 1 do (
        for x = 1 to resolution - 1 do (
            xCoor = x as float / resolution
            yCoor = y as float / resolution

            xGNoise = xCoor + scroll
            yGNoise = yCoor

            zCoor = GradientNoise [xGNoise, yGNoise] scale:noiseScale0
            zCoor += (GradientNoise [xGNoise, yGNoise] scale:noiseScale1) * 0.2
            zCoor = amax (zCoor * maxHeight) (minHeight as float)

            xPNoise = xCoor + populateScroll
            yPNoise = yCoor + populateScroll

            xRNoise = xCoor + rotationScroll
            yRNoise = yCoor + rotationScroll

            -- populateNoiseVal = GradientNoise [xPNoise, yPNoise] scale: populateNoiseScale
			populateNoiseVal = random 0.0 1.0
            rotationNoiseVal = random 0.0 1.0
			scaleNoiseVal = random 0.4 1.0

            if (populateNoiseVal > populateThreshold) do (
                index = 4
                if (rotationNoiseVal > 0.75) then (index = 1)
                else if (rotationNoiseVal > 0.5) then (index = 2)
                else if (rotationNoiseVal > 0.25) then (index = 3)
                maxOps.cloneNodes sel[index] cloneType:#instance newNodes:&nnl #nodialog

                nnl[1].pos = [xCoor * size, yCoor * size, zCoor]
                nnl[1].transform = (rotateZmatrix (rotationNoiseVal * 360 * 3)) * nnl[1].transform
                nnl[1].scale *= lerp 0.4 1.0 scaleNoiseVal
            )
        )
    )
)

-- clone the selected objects
-- maxOps.cloneNodes (selection as array) cloneType:#instance newNodes:&nnl #nodialog

-- Loop through the array of object it returns
-- for i = 1 to nnl.count do (
--     -- rename the objects to a unique name
--     nnl[i].name = uniqueName "Tree" numDigits:1
--     nnl[i].pos = [0, 0, 0]
-- )
