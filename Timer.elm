module Timer where

import Time exposing (every, second)
import Html exposing(..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


--MODEL

type alias Model =
  { time: Int,
    counting: Bool,
    button: String
  }

initialModel : Model
initialModel =
  { time = 0,
    counting = False,
    button = "Start"
  }


--UPDATE

type Action = NoOp | Count

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      if model.counting
        then { model | time <- model.time + 1 }
        else { model | time <- 0 }
    Count ->
      if model.button == "Start"
        then { model | counting <- True, button <- "Stop" }
        else { model | counting <- False, time <- 0, button <- "Start" }



--VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div [ class "timer" ]
    [ div [ class "counter" ] [ text (toString model.time) ]
    , button [ onClick address Count ] [ text model.button ]
    ]

--SIGNALS

inbox : Signal.Mailbox Action
inbox =
  Signal.mailbox NoOp


actions : Signal Action
actions =
  inbox.signal


combined =
  Signal.merge
    (actions)
    (Signal.map (\_ -> NoOp) (every second))

model : Signal Model
model =
  Signal.foldp update initialModel combined

main : Signal Html
main =
  Signal.map (view inbox.address) model
