module Timer where

import Sessions
import Time exposing (every, second)
import Html exposing(..)
import Html.Events exposing (onClick)




--MODEL

type alias Model =
  { time: Int,
    counting: Bool
  }

initialModel : Model
initialModel =
  { time = 0,
    counting = False
  }


--UPDATE

type Action = Start | Stop | NoOp

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      if model.counting
        then { model | time <- model.time + 1 }
        else { model | time <- 0 }
    Stop ->
      { model | counting <- False, time <- 0 }
    Start ->
      { model | counting <- True }


--VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ div [] [ text (toString model.time) ]
    , button [ onClick address Start ] [ text "Start" ]
    , button [ onClick address Stop ] [ text "Stop" ]
    ]

--SIGNALS

inbox : Signal.Mailbox Action
inbox =
  Signal.mailbox NoOp


actions : Signal Action
actions =
  inbox.signal

updates =
  Signal.merge
    (actions)
    (Signal.map (\_ -> NoOp) (every second))

model : Signal Model
model =
  Signal.foldp update initialModel updates

main : Signal Html
main =
  Signal.map (view inbox.address) model
