import           Codec.Picture.Types
import           Coloring
import           ImageOutput
import           Mbrot
import           System.Environment  (getArgs)


main :: IO()
main = do
    args <- getArgs
    draw (read $ head args :: Int)

draw :: Int -> IO()
draw 0 = createPngColorWithFileName "gradient.png" (fst size,50) drawTestGradient -- Outputs test gradient
-- Test reference images
draw 1 = createPngColor size (drawColorZoom 1 (-0.75,0))-- Create continuous colored static image
draw 2 = createPngGreyscale size (drawGreyscale True)  -- Create continuous greyscale static image
-- Interesting zoom patterns
draw 3 = createPngColorWithFileName "zoom1.png" size (drawColorZoom 1345 (-0.7435669,0.1314023)) --zoom 1
draw 4 = createPngColorWithFileName "zoom2.png" size (drawColorZoom 4169 (-0.74364990,0.13188204)) --zoom 2
draw 5 = createPngColorWithFileName "zoom3.png" size (drawColorZoom 25497 (-0.74364085,0.13182733)) --zoom 3

-- Run with high bailout! at least maxIter = 5000
draw 6 = createPngColorWithFileName "zoom4.png" size (drawColorZoom 210350 (-0.743643135,0.131825963)) --zoom 4
draw 7 = createPngColorWithFileName "zoom5.png" size (drawColorZoom 1048800 (-0.743644786,0.1318252536)) --zoom 5

--Spiral
draw 8 = createPngColorWithFileName "zoom6.png" size (drawColorZoom 1792 (-0.771139525,-0.115216065)) --zoom 6
