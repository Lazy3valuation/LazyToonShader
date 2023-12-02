# LazyToonShader
Toon water shader for unity!
Check out more at https://www.senfinecogames.com/ or https://twitter.com/senfinecogames!

Works **ONLY** in **URP!** Forward+ compatible! Tested on Unity 2022.3
Works **ONLY** with terrain mesh that has smooth normals! **Coming soon** the shader that works in a plane (with waves that goes to random directions).

**HOW TO USE:**
1) Grab your terrain to your scene.
2) Create another child gameobject attached to the terrain, call it "Water". Set its position to (0, 0, 0) and scale to (1, 1, 1).
3) Add a MeshFilter and MeshRenderer to the Water gameobject.
4) Copy the terrain mesh from the terrain to the Water gameobject (they must have the same mesh!)
5) Create a new "Water" material and set its shader to ShaderGraph/ToonWater.
6) Add material to "Water" GameObject.
7) Adjust the "WaterHeight" in the material properties to match your preferred water height.

Enjoy!
There are a ton of settings in the shader, be careful which one you use! Shader is easy to break.


Huge thanks to:
Cyan (https://twitter.com/cyanilux), helped me with Forward+ and some graphic effects!
NedMakesGames (https://twitter.com/NedMakesGames), its toon shader tutorials have been very useful!
