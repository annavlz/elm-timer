module Timer where

import Time exposing (..)
import Html exposing(..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Date exposing (fromTime, dayOfWeek, Day)
import Mouse


--MODEL

type alias Model =
  { time: Int,
    counting: Bool,
    button: String,
    sessions: List Session
  }

type alias Session =
  { date: Day,
    time: Int
  }


initialModel : Model
initialModel =
  { time = 0,
    counting = False,
    button = "Start",
    sessions = [ ]
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
      let
        getSession =
          {date =
            Time.millisecond
              |> fromTime
              |> dayOfWeek
          , time = model.time
          }
      in
        if model.button == "Start"
          then { model | counting <- True, button <- "Stop" }
          else { model | counting <- False,
                         sessions <- getSession :: model.sessions,
                         time <- 0,
                         button <- "Start" }

--VIEW
showSession : Session -> Html
showSession session =
  tr [ class "sessions-table"]
    [ td [ class "cell" ]
      [ text (toString session.date) ]
    , td [ class "cell" ]
      [ text (toString session.time) ]
    ]


view : Model -> Html
view model =
  div [] [
    div [ class "timer" ]
      [ div [ class "counter" ] [ text (toString model.time) ]
      , button [ onClick inbox.address Count ] [ text model.button ]
      ],
    div [ class "sessions" ]
      [ h1 [] [ text "Sessions" ]
      , div [] (List.map showSession (List.reverse model.sessions))
      ]
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





