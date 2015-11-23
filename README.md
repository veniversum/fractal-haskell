#Fractal Image Generator

##Functionality
+  Drawing mandelbrot set
  +  Integer escape time
  +  Real escape time
  +  Greyscale or colored renders
  +  Continuously colored
+  Outputing to .png
+  Animating to .gif
+  Variable zoom and focus renders

##Todo
+  Color interpolation based on color scheme
+  Rewrite functions to make changing parameters easier
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