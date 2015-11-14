module Sessions where

import Html exposing(..)
import Html.Events exposing (..)
import Graphics.Element exposing (..)
import Mouse
import Window
import Keyboard
import Time exposing (..)


type alias Model =
  { sessions : List Session }

type alias Session =
  { date : String,
    time : Int
  }

initialSession : Session
initialSession =
  { date = "Today",
    time = 20
  }

initialModel : Model
initialModel =
  { sessions = [initialSession] }


newSession : Int -> Session
newSession total =
  { date = "today"
  , time = total}


update : Int -> Model -> List Session
update time model =
  model.sessions ++ [ newSession time ]


showSession : Session -> Html
showSession session =
  div []
    [ tr []
      [ td []
        [ text session.date]
      , td []
        [ text (toString session.time) ]
      ]
    ]


view : Model -> Html
view model =
  div [ ]
    [ ul []
      (List.map showSession model.sessions)
    ]

main : Html
main =
  view initialModel

--main : Signal Html
--main =
--  Signal.map view jsMessage

--port jsMessage : Signal Int
