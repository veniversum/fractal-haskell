import Data.Complex
import Control.Arrow ((***))
import ImageOutput
import Coloring
import Codec.Picture.Types

-- Size parameters
size :: (Int,Int)
size = (3500,2000)

--Helpful calculated parameters
sizef :: (Float,Float)
sizef = (fromIntegral *** fromIntegral) size

maxIter :: Int 
maxIter = 200

mult :: Float
mult = 255 / fromIntegral maxIter

multg :: Float
multg = 400 / fromIntegral maxIter

-- Function for rendering pixels
drawGreyscale :: Bool -> Int -> Int -> Pixel8
drawGreyscale c x y 
    |c =  fromIntegral (round(float*mult))
    |otherwise = fromIntegral(int*(round mult))
    where int = mbrot maxIter (((x1/x2)-0.5) :+ (y1/y2))
          float = mbrotContinuous maxIter (((x1/x2)-0.5) :+ (y1/y2))
          x1 = 2 * (fromIntegral x - x2)
          y1 = 2 * (fromIntegral y - y2)
          x2 = fst sizef /2
          y2 = snd sizef /2

--drawColor :: Int -> Int -> PixelRGB8
--drawColor x y =  PixelRGB8 (0::Pixel8) (0::Pixel8) (fromIntegral (int*mult))
--    where int = mbrot maxIter (((x1/x2)-0.5) :+ (y1/y2))
--          x1 = 2 * (fromIntegral x - x2)
--          y1 = 2 * (fromIntegral y - y2)
--          x2 = fst sizef /2
--          y2 = snd sizef /2
----    |x < fst size = (writePixel image x y 255) >> draw image (x + 1) y
----    |y < snd size = (writePixel image x y 255) >> draw image 0 (y+1)
----    |otherwise = writePng "out.png" (freezeImage image)
---- (255 `mod` (mbrot maxIter (x :+ y)))
drawColorZoom :: Float -> (Float,Float) -> Int -> Int -> PixelRGB8
drawColorZoom zoom (fx, fy) x y =  colorToPixel $ color (float*multg)
    where float = mbrotContinuous maxIter (((x1/x2)+fx) :+ ((y1/y2)+fy))
          x1 = 1.75 * (fromIntegral x - x2) / zoom
          y1 = (fromIntegral y - y2) / zoom
          x2 = fst sizef /2
          y2 = snd sizef /2

drawTestGradient :: Int -> Int -> PixelRGB8
drawTestGradient x _ = colorToPixel $ color ((fromIntegral x)*400/1000)

mbrot :: RealFloat x => Int -> Complex x -> Int
mbrot n = mbrot' maxIter (0 :+ 0)
    where
        mbrot' :: RealFloat x => Int -> Complex x -> Complex x -> Int
        mbrot' n a c
            |magnitude newIter < 65535 && n > 0 = mbrot' (n-1) newIter c
            |otherwise = maxIter - n
                where 
                    newIter = a*a + c

mbrotContinuous :: RealFloat x => Int -> Complex x -> x
mbrotContinuous n = mbrot' maxIter (0 :+ 0)
    where
        mbrot' :: RealFloat x => Int -> Complex x -> Complex x -> x
        mbrot' n a c
            |magnitude newIter < 65535 && n > 0 = mbrot' (n-1) newIter c
            |otherwise = normalized
                where 
                    newIter = a*a + c
                    normalized =  if (n > 0) 
                                  then fromIntegral (maxIter - n +1) - (log (log (magnitude newIter)))/ log (2.0)
                                  else 0

main :: IO()
main = do 
            --createPngColor (1000,50) (drawTestGradient)
            --createPngColor size (drawColorZoom 1 ((-0.743643887037158704752191506114774),(0.131825904205311970493132056385139)))  -- Create continuous colored static image
            createPngColor size (drawColorZoom 1 (-0.75,0))
            --createPngGreyscale size (drawGreyscale True)  -- Create continuous greyscale static image
            --createGifColor [createImage size (drawColorZoom i) | i <- [1..100]] -- Create continuously colored zooming gif
