-- https://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_B57EA575_DCDE_42F5_9D30_88E3EB41F350_htm

fn CreateTerrainPlane side segs position:[0, 0, 0] = (
    Plane length:side width:side pos:[0, 0, 0] lengthsegs:segs widthsegs:segs
)

-- CreateTerrainPlane 100 100

fn norm_2 p = (
    length = sqrt (p.x * p.x + p.y * p.y)
    return p / length
)

fn lerp x y t = (
    return x + (y - x) * t
)

fn dot_2 p q = (
    return p.x * q.x + p.y * q.y
)

fn floor_2 p = (
    return [floor p.x, floor p.y]
)

fn frac x = (
    return x - floor x
)

fn frac_2 p = (
    return p - floor_2 p
)

fn sin_2 p = (
    return [sin p.x, sin p.y]
)

fn GradientNoiseDir i = (
    i = [mod i.x 289.0, mod i.y 289.0]
    x = (34.0 * i.x + 1.0) * (mod i.x 289.0) + i.y
    x = (34.0 * x + 1.0) * (mod x  289.0)
    x = frac (x / 41.0) * 2.0 - 1.0

    return norm_2 [x - floor (x + 0.5) as float, (abs x) as float - 0.5]
)

fn GradientNoise p scale:1.0 = (
    p = p * scale
    ip = floor_2 p;
    fp = frac_2 p;
    d00 = dot_2 (GradientNoiseDir ip) fp
    d01 = dot_2 (GradientNoiseDir (ip + [0.0, 1.0])) (fp - [0.0, 1.0])
    d10 = dot_2 (GradientNoiseDir (ip + [1.0, 0.0])) (fp - [1.0, 0.0])
    d11 = dot_2 (GradientNoiseDir (ip + [1.0, 1.0])) (fp - [1.0, 1.0])
    fp = fp * fp * fp * (fp * (fp * 6.0 - 15.0) + 10.0);

    return (lerp (lerp d00 d01 fp.y) (lerp d10 d11 fp.y) fp.x) + 0.5
)

fn SimpleNoiseRandomValue p = (
    return frac_2 (sin_2 (dot_2 p [12.9898, 78.233]) * 43758.5453)
)

fn SimpleNoiseInterpolate a b t = (
    return (1.0 - t) * a + (t * b)
)

fn SimpleValueNoise p = (
    
)

fn CreateBoxGrid x y z seed:[0.0, 0.0] scale:1.0 heightScale:1.0 location:[0, 0, 0] size:50 spacing:1 = (
    for _x = 0 to x-1 do (
        for _y = 0 to y-1 do (
            for _z = 0 to z-1 do (
                vec = [_x as float, _y as float, _z as float]
                noiseInput = [(_x as float / x as float) as float, (_y as float / y as float) as float]
                noiseValue = (GradientNoise (noiseInput + seed) scale:scale)
                sz = size + noiseValue * heightScale
                Box pos:(location + vec * (size + spacing)) width:size length:size height:sz
            )
        )
    )
)
