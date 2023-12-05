# LazyToonShader

Toon water shader for unity!

Check out more at https://www.senfinecogames.com/ or https://twitter.com/senfinecogames!


Works **ONLY** in **URP!** Forward+ compatible! Tested on Unity 2022.3  
Works **ONLY** with terrain mesh that has smooth normals!  

**Coming soon** Shader that works in a plane, with waves that goes in random or fixed directions.


**HOW TO USE:**
1) Download and install the package: on this repo, select "Clone repository", copy the link. Go to Unity, "Window/Package Manager", in the upper-left corner there's a "+". Click it, select "Add package from GIT URL", paste the link you copied, and confirm.
2) Add your terrain to your scene.
3) Create another child gameobject attached to the terrain, call it "Water". Set its position to (0, 0, 0) and scale to (1, 1, 1).
4) Add a MeshFilter and MeshRenderer to the Water gameobject.
5) Copy the terrain mesh from the terrain to the Water gameobject (they must have the same mesh!)
6) Create a new "Water" material and set its shader to ShaderGraph/ToonWater.
7) Add material to "Water" GameObject.
8) Adjust the "WaterHeight" in the material properties to match your preferred water height.
9) 

Enjoy!

There are a ton of settings in the shader, be careful which one you use! Shader is easy to break.


Huge thanks to: 

Cyan (https://twitter.com/cyanilux), helped me with Forward+ and some graphic effects! 

NedMakesGames (https://twitter.com/NedMakesGames), its toon shader tutorials have been very useful!


https://ko-fi.com/senfinecogames
