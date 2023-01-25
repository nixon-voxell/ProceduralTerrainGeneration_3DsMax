fileIn "Geometry.ms"

cls()
planeMesh = CreateTerrain 100 10 4 noiseScale:3
print planeMesh.vertices[3][1]
