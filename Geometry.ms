fileIn "NoiseUtil.ms"

fn FlattenIdx x y width = (
    return x + y * width
)

fn CreateTerrain resolution size maxHeight minHeight
    noiseScale0:3 noiseScale1:10 noiseScale2:100 scroll:0 = (
    vert_array = #()
    face_array = #()

    size = size as float

    for y = 0 to resolution - 1 do (
        for x = 0 to resolution - 1 do (
            xCoor = x as float / resolution
            yCoor = y as float / resolution

            xNoise = xCoor + scroll
            yNoise = yCoor

            zCoor = GradientNoise [xNoise, yNoise] scale:noiseScale0
            zCoor += (GradientNoise [xNoise, yNoise] scale:noiseScale1) * 0.2
            zCoor += (GradientNoise [xNoise, yNoise] scale:noiseScale2) * 0.02
            zCoor = amax (zCoor * maxHeight) (minHeight as float)

            vert = [xCoor * size, yCoor * size, zCoor]
            append vert_array vert
        )
    )

    for x = 0 to resolution - 2 do (
        for y = 0 to resolution - 2 do (
            -- vertices of a quad
            p0 = (FlattenIdx x y resolution) + 1
            p1 = (FlattenIdx (x + 1) y resolution) + 1
            p2 = (FlattenIdx x (y + 1) resolution) + 1
            p3 = (FlattenIdx (x + 1) (y + 1) resolution) + 1

            face0 = [p0, p3, p2]
            face1 = [p0, p1, p3]

            -- 2 triangles to created a quad
            append face_array face0
            append face_array face1
        )
    )

    m = mesh vertices:vert_array faces:face_array
    return m
)
