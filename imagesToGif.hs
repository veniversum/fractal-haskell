import Codec.Picture
import Codec.Picture.Gif
import System.IO
import ImageOutput

main :: IO()
main = createGifColor =<< sequence[readImage ("./animation/frame"++ show i ++".png") >>= decode | i <- [1..10]]

decode :: Either String DynamicImage -> IO (Image PixelRGB8)
decode (Right (ImageRGB8 (image))) = return image