module Timer where

import Time exposing (every, second)
import Html exposing(..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


--MODEL

type alias Model =
  { time: Int,
    counting: Bool,
    button: String,
    total: Int
  }

initialModel : Model
initialModel =
  { time = 0,
    counting = False,
    button = "Start",
    total = 0
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
        else { model | counting <- False, total <- model.time, time <- 0, button <- "Start" }




--VIEW


view : Model -> Html
view model =
  div [ class "timer" ]
    [ div [ class "counter" ] [ text (toString model.time) ]
    , button [ onClick inbox.address Count ] [ text model.button ]
    , button [ onClick outbox.address model.total ] [ text "Send" ]
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


outbox : Signal.Mailbox Int
outbox =
  Signal.mailbox 0


port timerMessage : Signal Int
port timerMessage =
  outbox.signal


model : Signal Model
model =
  Signal.foldp update initialModel combined


main : Signal Html
main =
  Signal.map view model





