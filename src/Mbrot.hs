module Mbrot where
import           Codec.Picture.Types
import           Coloring
import           Control.Arrow       ((***))
import           Data.Complex
import           ImageOutput

-- |Size parameters
size :: (Int,Int)
size = (1400,800)

-- |Floating point size, calculated
sizef :: (Float,Float)
sizef = (fromIntegral *** fromIntegral) size

-- |Maximum iterations
maxIter :: Int
maxIter = 1000

-- |Color step for integer esacpe coloring
mult :: Float
mult = 255 / fromIntegral maxIter

-- |Color step for continuously colored
multg :: Float
multg = 400 / fromIntegral maxIter

-- |Function for rendering pixel in greyscale
drawGreyscale :: Bool    -- ^Continuously colored
              -> Int
              -> Int
              -> Pixel8
drawGreyscale c x y
    |c =  fromIntegral (round(float * mult))
    |otherwise = fromIntegral(int * round mult)
    where int = mbrot maxIter (((x1/x2)-0.5) :+ (y1/y2))
          float = mbrotContinuous maxIter (((x1/x2)-0.5) :+ (y1/y2))
          x1 = 2 * (fromIntegral x - x2)
          y1 = 2 * (fromIntegral y - y2)
          x2 = fst sizef /2
          y2 = snd sizef /2

-- |Deprecated. Use 'drawColorZoom' instead
drawColor :: Int -> Int -> PixelRGB8
drawColor x y =  colorToPixel $ color (fromIntegral (int*400)/1000)
    where int = mbrot maxIter ((x1/x2) :+ (y1/y2))
          x1 = 1.75 * (fromIntegral x - x2)
          y1 = fromIntegral y - y2
          x2 = fst sizef /2
          y2 = snd sizef /2

-- |Function for rendering pixel in color, with zoom level and focus
drawColorZoom :: Float         -- ^ Zoom level
              -> (Float,Float) -- ^ Focus point (x,y)
              -> Int
              -> Int
              -> PixelRGB8
drawColorZoom zoom (fx, fy) x y =  colorToPixel $ color (float*multg)
    where float = mbrotContinuous maxIter (((x1/x2)+fx) :+ ((y1/y2)+fy))
          x1 = 1.75 * (fromIntegral x - x2) / zoom
          y1 = (fromIntegral y - y2) / zoom
          x2 = fst sizef /2
          y2 = snd sizef /2

-- |Function for drawing color gradient. Tests for correct linear interpolation of color
drawTestGradient :: Int -> Int -> PixelRGB8
drawTestGradient x _ = colorToPixel $ color (fromIntegral x *400/1000)

-- |Function for integer escape time of mbrot set of Re(x) + Im(y)
mbrot :: RealFloat x
     => Int           -- ^ Maximum iterations
     -> Complex x     -- ^ Re(x) + Im(y)
     -> Int
mbrot n = mbrot' maxIter (0 :+ 0)
    where
        mbrot' :: RealFloat x => Int -> Complex x -> Complex x -> Int
        mbrot' n a c
            |magnitude newIter < 65535 && n > 0 = mbrot' (n-1) newIter c
            |otherwise = maxIter - n
                where
                    newIter = a*a + c

-- |Function for real floating escape time of mbrot set of Re(x) + Im(y)
mbrotContinuous :: RealFloat x
                => Int           -- ^ Maximum iterations
                -> Complex x     -- ^ Re(x) + Im(y)
                -> x
mbrotContinuous n = mbrot' maxIter (0 :+ 0)
    where
        mbrot' :: RealFloat x => Int -> Complex x -> Complex x -> x
        mbrot' n a c
            |magnitude newIter < 65535 && n > 0 = mbrot' (n-1) newIter c
            |otherwise = normalized
                where
                    newIter = a*a + c
                    normalized =  if n > 0
                                  then
                                    fromIntegral(maxIter - n +1) - logBase 2 ( logBase 2 (magnitude newIter ^ 2) / 2 )
                                    --fromIntegral (maxIter - n +1) - (log (log (magnitude newIter)))/ log (2.0)
                                  else fromIntegral maxIter
