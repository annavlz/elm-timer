module Main where

import Timer exposing (..)
import Sessions exposing (main)
import StartApp.Simple as StartApp
import Time
import Graphics.Element exposing (..)

main =
  StartApp.start { model = initialModel, view = view, update = update }
--  --Signal.map show (Time.every Time.second)

----secondsSoFar : Signal Int
----secondsSoFar =
----  Signal.foldp (\_ count -> count + 1) 0 (Time.every Time.second)

----main : Signal Element
----main =
----  Signal.map show secondsSoFar
