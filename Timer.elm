module Timer where

import Timestamp exposing (makeDate)
import Transformer exposing (sessionTimes, totalTime)

import Time exposing (..)
import Html exposing(..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


--MODEL

type alias Model =
  { time: Int,
    counting: Bool,
    button: String,
    sessions: List Session
  }


type alias Session =
  { date: String,
    time: Int
  }


initialModel : Model
initialModel =
  let
    emptyModel =
      { time = 0,
        counting = False,
        button = "Start",
        sessions = [ ]
      }
  in
    Maybe.withDefault emptyModel incoming


--UPDATE

type Action = NoOp | Count | Reset

update : (Time, Action) -> Model -> Model
update (timeStop, action) model =
  case action of
    NoOp ->
      if model.counting
        then { model | time <- model.time + 1 }
        else { model | time <- 0 }
    Count ->
      let
        getSession =
          { date = makeDate timeStop
          , time = model.time }
      in
        if model.button == "Start"
          then { model | counting <- True
                       , button <- "Stop" }
          else { model | counting <- False
                       , sessions <- getSession :: model.sessions
                       , time <- 0
                       , button <- "Start" }
    Reset ->
      { model | sessions <- [ ] }


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
      , button [ class "start-button", onClick inbox.address Count ] [ text model.button ]
      ]
  , div [ class "sessions" ]
      [ h1 [] [ text "Sessions" ]
      , button [ class "reset-button", onClick inbox.address Reset ] [ text "Reset" ]
      , div []
        [ tr [ class "sessions-table"]
          [ td [ class "cell" ]
            [ text ((sessionTimes model.sessions) ++ " times") ]
          , td [ class "cell" ]
            [ text ((totalTime model.sessions) ++ " in total") ]
          ]
        ]
      , div []
        (List.map showSession (List.reverse model.sessions))
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


--PORTS

port incoming : Maybe Model


port outgoing : Signal Model
port outgoing =
  model


--WIRING

model : Signal Model
model =
  Signal.foldp update initialModel (timestamp combined)


main : Signal Html
main =
  Signal.map view model





