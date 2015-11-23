module ImageOutput where
import Codec.Picture
import Codec.Picture.Types

createPngGreyscale :: (Int,Int) -> (Int -> Int -> Pixel8) -> IO()
createPngGreyscale size pixelRenderer= writePng "out_grey.png" $ uncurry (generateImage pixelRenderer) size

createPngColor :: (Int,Int) -> (Int -> Int -> PixelRGB8) -> IO()
createPngColor size pixelRenderer= writePng "out_color.png" $ uncurry (generateImage pixelRenderer) size

createImage :: Pixel a => (Int,Int) -> (Int -> Int -> a) -> Image a
createImage size pixelRenderer = uncurry (generateImage pixelRenderer) size

createGifColor :: [Image PixelRGB8]-> IO ()
createGifColor frames = a
    where Right a = writeGifAnimation "out_color.gif" 10 LoopingForever frames