fn CreatePlaneWithResolution resolution size = (
    vert_array = #()
    face_array = #()

    size = size as float

    for x = 0 to resolution do (
        for y = 0 to resolution do (
            append vert_array [
                x / resolution * size,
                y / resolution * size,
                0
            ]
        )
    )

    m = mesh vertices:vert_array faces:face_array
    return m
)
