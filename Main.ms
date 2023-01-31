fileIn "Geometry.ms"

planeMesh = CreateTerrain 100 5000 1000 300 noiseScale0:3 noiseScale1:10 noiseScale2:50
print planeMesh.vertices[3][1]
