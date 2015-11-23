#Fractal Image Generator

##Functionality
+ Drawing mandelbrot set
  + Integer escape time
  + Real escape time
  + Greyscale or colored renders
  + Continuously colored
+ Outputing to .png
+ Animating to .gif
+ Variable zoom and focus renders
+ Render individual frames of zoom animation
  + Bash script to render multiple frames in parallel
  + Combine individual images of frames into animated .gif

##Todo
+ Write documentation
+ Generate example outputs
+ ewrite functions to make changing parameters easier
+  Optimization to reduce runtime

##Libraries
###JuicyPixels
JuicyPixels is the library used to draw output into image files.    
>     cabal update
>     cabal install juicypixels

###colour
colour (not color!) package is used to represent colors as well as switching between colorspaces.
>     cabal update
>     cabal install colour