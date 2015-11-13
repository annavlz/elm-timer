module Sessions where

import Html exposing(..)
import Html.Events exposing (..)
import Graphics.Element exposing (..)
import Mouse
import Window
import Keyboard
import Time exposing (..)
--type alias model =
--  {

--  }


view : Html
view =
  div []
    [ tr []
      [ td [] [ text "Hello !" ]
      , td [] [ text "50" ]
      ]
    ]

main : Signal Element
main =
  Signal.map show (every second)
