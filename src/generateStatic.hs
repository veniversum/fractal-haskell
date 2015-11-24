import Mbrot
import System.Environment(getArgs)
import ImageOutput
import Coloring
import Codec.Picture.Types


main :: IO()
main = do 
    args <- getArgs
    draw (read $ head args :: Int)

draw :: Int -> IO()
draw 0 = createPngColorWithFileName "gradient.png" (fst size,50) (drawTestGradient) -- Outputs test gradient
draw 1 = createPngColor size (drawColorZoom 1 ((-0.743643887037158704752191506114774),(0.131825904205311970493132056385139)))  -- Create continuous colored static image
draw 2 = createPngColor size (drawColorZoom 1 (-0.75,0))
draw 3 = createPngGreyscale size (drawGreyscale True)  -- Create continuous greyscale static image
draw 4 = createGifColor [createImage size (drawColorZoom i (-0.75,0)) | i <- [1..100]] -- Create continuously colored zooming gif
draw 5 = createPngColor size (drawColorZoom  1345 ((-0.7435669),(0.1314023)))