import Mbrot hiding (main)
import System.Environment(getArgs)
import ImageOutput
import Coloring
import Codec.Picture.Types

size :: (Int,Int)
size = (1400,800)

main :: IO()
main = do
    args <- getArgs
    createPngColorWithFileName ("frame"++(head args :: String)++".png") size (drawColorZoom (read $ head args :: Float) ((-0.743643887037158704752191506114774),(0.131825904205311970493132056385139)))