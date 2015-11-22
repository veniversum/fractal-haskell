module ImageOutput (Pixel8, createPngGreyscale) where
import Codec.Picture
import Codec.Picture.Types

createPngGreyscale :: (Int,Int) -> (Int -> Int -> Pixel8) -> IO()
createPngGreyscale size pixelRenderer= writePng "out.png" $ uncurry (generateImage pixelRenderer) size