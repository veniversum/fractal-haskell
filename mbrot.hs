import Data.Complex
import Control.Arrow ((***))
import ImageOutput
import Codec.Picture.Types


-- Size parameters
size :: (Int,Int)
size = (800,800)

sizef :: (Float,Float)
sizef = (fromIntegral *** fromIntegral) size

maxIter :: Int 
maxIter = 20

-- Function for rendering pixel
drawGreyscale :: Int -> Int -> Pixel8
drawGreyscale x y =  fromIntegral (int*mult)
    where int = mbrot maxIter (((x1/x2)-0.5) :+ (y1/y2))
          x1 = 2 * (fromIntegral x - x2)
          y1 = 2 * (fromIntegral y - y2)
          x2 = fst sizef /2
          y2 = snd sizef /2
          mult = 255`div`maxIter

drawColor :: Int -> Int -> PixelRGB8
drawColor x y =  PixelRGB8 (0::Pixel8) (0::Pixel8) (fromIntegral (int*mult))
    where int = mbrot maxIter (((x1/x2)-0.5) :+ (y1/y2))
          x1 = 2 * (fromIntegral x - x2)
          y1 = 2 * (fromIntegral y - y2)
          x2 = fst sizef /2
          y2 = snd sizef /2
          mult = 255`div`maxIter
--    |x < fst size = (writePixel image x y 255) >> draw image (x + 1) y
--    |y < snd size = (writePixel image x y 255) >> draw image 0 (y+1)
--    |otherwise = writePng "out.png" (freezeImage image)
-- (255 `mod` (mbrot maxIter (x :+ y)))
drawColor2 :: Float -> Int -> Int -> PixelRGB8
drawColor2 zoom x y =  PixelRGB8 (0::Pixel8) (0::Pixel8) (fromIntegral ((maxIter-int)*mult))
    where int = mbrot maxIter (((x1/x2)-0.743643887037158704752191506114774) :+ ((y1/y2)+0.131825904205311970493132056385139))
          x1 = 2 * (fromIntegral x - x2) / zoom
          y1 = 2 * (fromIntegral y - y2) / zoom
          x2 = fst sizef /2
          y2 = snd sizef /2
          mult = 255`div`maxIter

mbrot :: RealFloat x => Int -> Complex x -> Int
mbrot n = mbrot' maxIter (0 :+ 0)
    where
        mbrot' :: RealFloat x => Int -> Complex x -> Complex x -> Int
        mbrot' n a c
            |magnitude newIter < 2 && n > 0 = mbrot' (n-1) newIter c
            |otherwise = maxIter - n
                where 
                    newIter = a*a + c

main :: IO()
main = createPngColor size (drawColor2 2)
