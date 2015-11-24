#Fractal Image Generator

**fractal-haskell** is a tool written in haskell (duh!) that draws Mandelbrot fractals. 
It is capable of generating stunning high resolution renders, both stills and animated, 
of the Mandelbrot set fractal featuring smooth colorful gradients.

This is just an example of what it can do!
<p align="center"><img src=https://cloud.githubusercontent.com/assets/6357330/11373480/65881446-92ca-11e5-9f82-35cc851e660c.gif></p>

##Functionality
+ Drawing mandelbrot set
  + Integer escape time
  + Real escape time
  + Greyscale or colored renders
  + Continuously colored with gradient
  + Customizable color scheme
+ Variable zoom and focus renders
+ Outputing to .png
+ Animating to .gif
  + Animation generation with linear or exponential zoom
  + Stationary or moving focal point
+ Render individual frames of zoom animation
  + Bash script to render multiple frames in parallel, leverages multiple cores (tested up to 40 cores)
  + Combine individual images of frames into animated .gif, variable delay between frames
  
##Examples
[See examples here!](EXAMPLES.md)
Images and animated gifs rendered on UoE Informatics computing servers.

##Libraries
The following third party libraries/packages were used to help with low level image manipulation
###JuicyPixels
JuicyPixels is the library used to draw output into image files.    
>     cabal update
>     cabal install juicypixels

###colour
colour (not color!) package is used to represent colors as well as switching between colorspaces.
>     cabal update
>     cabal install colour

##Usage
**Note:** It is important to run commands from project root to ensure relative file paths are correct.

You may need to `chmod +x` executables and shell script in order to run them.

### Generating animated images
There are 2 ways of generating animated images.
+ Generate entire .gif at once
  + Use `createGifColor` function provided in `ImageOutput` function, by passing a list of `Image`   
  >     createGifColor [createImage size (drawColorZoom i (-0.75,0)) | i <- [1..10]]
  
  + Not recommended for high resolutions or high frame count
  
+ Generate individual frames then combine them
  0. `cd` to root of project folder
  1. Modify `src/generateFrames.sh` to change number of desired frames
  2. Modify `src/generateFrame.hs` to change pixel rendering function
  3. Compile `src/generateFrame.hs` with `ghc -O2 -isrc -outputdir tmp -o generateFrame src/generateFrame.hs`
  4. Run `./generateFrames.sh` **Warning:** very CPU intensive operation
  5. Edit `src/imagesToGif.hs` to change number of frames
  6. Compile `src/imagesToGif.hs` with ` ghc -O2 -isrc -outputdir tmp -o imagesToGif src/imagesToGif.hs`
  7. Run `./imagesToGif`
  
The second method is preferred and much faster as it renders all frames concurrently, leveraging all CPU cores.

### Generating static images
See examples provided in `src/generateStatic.hs`, modify source to add your own render functions.
  
  0. `cd` to root of project folder 
  1. Compile `src/generateStatic.hs` with ` ghc -O2 -isrc -outputdir tmp -o imagesToGif src/generateStatic.hs`
  2. Run `./generateStatic i` where `i` is number for fractal as defined in source.


##Todo
+ Write more documentation
+ Generate more example outputs
+ Rewrite functions to make changing parameters easier
+ Optimizations to reduce runtime

##License
[BSD3](LICENSE.md)
