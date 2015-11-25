import           Codec.Picture
import           Codec.Picture.Gif
import           ImageOutput
import           System.IO

main :: IO()
main = createGifColor =<< sequence[readImage ("./out/frame"++ show i ++".png") >>= decode | i <- [1..10]]

decode :: Either String DynamicImage -> IO (Image PixelRGB8)
decode (Right (ImageRGB8 image)) = return image
