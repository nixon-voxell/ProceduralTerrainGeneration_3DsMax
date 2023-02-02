fileIn "Geometry.ms"
fileIn "ObjectInstance.ms"

PlaneMesh = undefined

rollout ProceduralTerrainGenerator "Procedural Terrain Generator" (
    -- timer clock "Clock" interval:intervalTime

    -- GENERATE
    edittext resolutionTxt "Resolution:" fieldWidth:50 labelOnTop:false text:"100"
    edittext sizeTxt "Size:" fieldWidth:50 labelOnTop:false text:"5000"

    edittext maxHeightTxt "Max Height:" fieldWidth:50 labelOnTop:false text:"1000"
    edittext minHeightTxt "Min Height:" fieldWidth:50 labelOnTop:false text:"300"

    edittext noiseScale0Txt "Noise Scale 0:" fieldWidth:50 labelOnTop:false text:"3"
    edittext noiseScale1Txt "Noise Scale 1:" fieldWidth:50 labelOnTop:false text:"10"
    edittext noiseScale2Txt "Noise Scale 2:" fieldWidth:50 labelOnTop:false text:"100"

    edittext scrollTxt "Scroll:" fieldWidth:50 labelOnTop:false text:"0"

    button generateButton "Generate"

    -- POPULATE
    edittext populateResolutionTxt "Populate Resolution:" fieldWidth:50 labelOnTop:false text:"20"
    edittext populateNoiseScaleTxt "Populate Noise Scale:" fieldWidth:50 labelOnTop:false text:"4"
    edittext populateScrollTxt "Populate Scroll:" fieldWidth:50 labelOnTop:false text:"1"
    edittext populateThresholdTxt "Populate Threshold:" fieldWidth:50 labelOnTop:false text:"0.5"

    button populateButton "Populate"

    -- on clock tick do ()

    on generateButton pressed do (
        resolution = resolutionTxt.text as float
        size = sizeTxt.text as float
        maxHeight = maxHeightTxt.text as float
        minHeight = minHeightTxt.text as float
        noiseScale0 = noiseScale0Txt.text as float
        noiseScale1 = noiseScale1Txt.text as float
        noiseScale2 = noiseScale2Txt.text as float
        scroll = scrollTxt.text as float

        if (
            resolution != undefined and
            size != undefined and
            maxHeight != undefined and
            minHeight != undefined and
            noiseScale0 != undefined and
            noiseScale1 != undefined and
            noiseScale2 != undefined and
            scroll != undefined
        ) do (
            if (PlaneMesh != undefined) do (delete PlaneMesh)

            PlaneMesh = CreateTerrain resolution size maxHeight minHeight noiseScale0:noiseScale0 noiseScale1:noiseScale1 noiseScale2:noiseScale2 scroll:scroll
        )
    )

    on populateButton pressed do (
        resolution = populateResolutionTxt.text as float
        size = sizeTxt.text as float
        maxHeight = maxHeightTxt.text as float
        minHeight = minHeightTxt.text as float
        noiseScale0 = noiseScale0Txt.text as float
        noiseScale1 = noiseScale1Txt.text as float
        noiseScale2 = noiseScale2Txt.text as float
        scroll = scrollTxt.text as float
        populateNoiseScale = populateNoiseScaleTxt.text as float
        populateScroll = populateScrollTxt.text as float
        populateThreshold = populateThresholdTxt.text as float

        if (
            resolution != undefined and
            size != undefined and
            maxHeight != undefined and
            minHeight != undefined and
            noiseScale0 != undefined and
            noiseScale1 != undefined and
            noiseScale2 != undefined and
            scroll != undefined and
            populateNoiseScale != undefined and
            populateScroll != undefined and
            populateThreshold != undefined
        ) do (
            PopulateTerrain resolution size maxHeight minHeight noiseScale0:noiseScale0 noiseScale1:noiseScale1 noiseScale2:noiseScale2 scroll:scroll populateNoiseScale:populateNoiseScale populateScroll:populateScroll populateThreshold:populateThreshold
        )
    )
)

createdialog ProceduralTerrainGenerator width:200 height:350
-- PlaneMesh = CreateTerrain 100 5000 1000 300 noiseScale0:3 noiseScale1:10 noiseScale2:50
