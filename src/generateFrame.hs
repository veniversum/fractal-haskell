import           Codec.Picture.Types
import           Coloring
import           ImageOutput
import           Mbrot               hiding (main)
import           System.Environment  (getArgs)

main :: IO()
main = do
    args <- getArgs
    -- Zooming animation at fixed point
    --createPngColorWithFileName ("frame"++(head args :: String)++".png") size (drawColorZoom (1.1**var) (-0.743643887037158704752191506114774,0.131825904205311970493132056385139))

    -- Zooming animation focused at moving point
    createPngColorWithFileName ("frame"++(head args :: String)++".png") size (drawColorZoom (2 * (1.07032027027074**(read $ head args :: Float))) (-1-((read $ head args :: Float)/21*0.31)),0)
