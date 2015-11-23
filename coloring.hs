module Coloring where
import           Data.Colour              (Colour)
import           Data.Colour.RGBSpace     (uncurryRGB)
import           Data.Colour.RGBSpace.HSV (hsv, hsvView)
import           Data.Colour.SRGB         (sRGB, toSRGB)
import           Data.List                (minimumBy)
import           Data.Ord                 (comparing)
import           Codec.Picture.Types

type ColorPoint = (Float, String)

colorScheme :: [ColorPoint]
colorScheme = [(28,"#000764")]

color :: Float -> PixelRGB8
color index = undefined
    where min = last $ (head colorScheme) : (filter (\a -> fst a < index) colorScheme)
          max = head $ (filter (\a -> fst a > index) colorScheme) ++ [last colorScheme]

hsvBlend :: RealFloat n => n -> Colour n -> Colour n -> Colour n
hsvBlend t c1 c2 = uncurryRGB sRGB . hsv3
                 $ (lerpWrap h1 h2 360 t, lerp' s1 s2 t, lerp' v1 v2 t)
  where
    [(h1,s1,v1), (h2,s2,v2)] = map (hsvView . toSRGB) [c1,c2]
    hsv3 (h,s,v) = hsv h s v

lerpWrap :: (RealFrac n) => n -> n -> n -> n -> n
lerpWrap a b m t = lerp' a b' t `dmod` m
  where
    b' = minimumBy (comparing (abs . subtract a)) [b - m, b, b + m]

lerp' :: Num n => n -> n -> n -> n
lerp' a b t = (1 - t) * a + t * b

dmod :: RealFrac n => n -> n -> n
dmod a m = a - m * fromInteger (floor (a/m))