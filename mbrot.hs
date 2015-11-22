import Data.Complex
import Codec.Picture
import Codec.Picture.Types
import Control.Monad.Primitive
import Data.Word

size :: (Int,Int)
size = (1920,1080)

maxIter :: Int 
maxIter = 20


draw :: Int -> Int -> Word8
draw x y =  fromIntegral (int*mult)
    where int = mbrot maxIter (((x1/x2)-0.5) :+ (y1/y2))
          x1 = 2 * (fromIntegral x - x2)
          y1 = 2 * (fromIntegral y - y2)
          x2 = fromIntegral (fst size)/2
          y2 = fromIntegral (snd size)/2
          mult = 255`div`maxIter
--    |x < fst size = (writePixel image x y 255) >> draw image (x + 1) y
--    |y < snd size = (writePixel image x y 255) >> draw image 0 (y+1)
--    |otherwise = writePng "out.png" (freezeImage image)
-- (255 `mod` (mbrot maxIter (x :+ y)))

mbrot :: RealFloat x => Int -> Complex x -> Int
mbrot n = mbrot' maxIter (0 :+ 0)
    where
        mbrot' :: RealFloat x => Int -> Complex x -> Complex x -> Int
        mbrot' n a c
            |magnitude newIter < 2 && n > 0 = mbrot' (n-1) newIter c
            |otherwise = maxIter - n
                where 
                    --newIter :: Complex a
                    newIter = a*a + c

iter :: Int -> Complex a -> Complex a
iter = undefined

main :: IO()
main = do
    image <- uncurry createMutableImage size (100::Pixel8)
    writePng "out.png" $ uncurry (generateImage draw) size
