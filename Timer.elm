module Timer where

import Timestamp exposing (..)
import ViewHtml exposing (..)

import Time exposing (..)
import Html exposing(..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Graphics.Input exposing (dropDown)


--MODEL

type alias Model =
  { time: Int,
    counting: Bool,
    button: String,
    sessions: List Session,
    currentCategory: String
  }


type alias Session =
  { date: String,
    time: Int,
    category: String
  }


initialModel : Model
initialModel =
  let
    emptyModel =
      { time = 0,
        counting = False,
        button = "Start",
        sessions = [ ],
        currentCategory = "Reading"
      }
  in
    Maybe.withDefault emptyModel incoming


--UPDATE

type Action = NoOp | Count | Reset | Reading | Exercise | Walking

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
          , time = model.time
          , category = model.currentCategory
          }
      in
        if model.button == "Start"
          then { model | counting <- True
                       , button <- "Stop" }
          else { model | counting <- False
                       , sessions <- getSession :: model.sessions
                       , time <- 0
                       , button <- "Start" }
    Reset ->
      { model | sessions <- (filterSessionsRemove model) }
    Reading ->
      { model | currentCategory <- "Reading" }
    Exercise ->
      { model | currentCategory <- "Exercise" }
    Walking ->
      { model | currentCategory <- "Walking" }


--VIEW
filterSessions : Model -> List Session
filterSessions model =
  List.filter (\session -> session.category == model.currentCategory) model.sessions


filterSessionsRemove : Model -> List Session
filterSessionsRemove model =
  List.filter (\session -> session.category /= model.currentCategory) model.sessions


dd : Html
dd =
  dropDown (Signal.message catInbox.address)
    [ ("Reading", Reading)
    , ("Exercise", Exercise)
    , ("Walking", Walking)
    ] |> fromElement


view : Model -> Html
view model =
  div [] [
    div [ class "timer" ]
      [ div [ class "counter" ] [ text (timeRead model.time) ]
      , button [ class "start-button", onClick inbox.address Count ] [ text model.button ]
      ]
  , div [ class "sessions" ]
      [ h1 [] [ text "Sessions" ]
      , dd
      , button [ class "reset-button", onClick inbox.address Reset ] [ text "Reset" ]
      , div []
        [ tr [ class "sessions-table"]
          [ td [ class "cell" ]
            [ text ((sessionTimes (filterSessions model)) ++ " times") ]
          , td [ class "cell" ]
            [ text ((totalTime (filterSessions model)) ++ " in total") ]
          ]
        ]
      , div []
        (filterSessions model
          |> List.reverse
          |> List.map showSession
        )
      ]
  ]


--SIGNALS

inbox : Signal.Mailbox Action
inbox =
  Signal.mailbox NoOp

catInbox : Signal.Mailbox Action
catInbox =
  Signal.mailbox Reading

categories : Signal Action
categories =
  catInbox.signal

actions : Signal Action
actions =
  inbox.signal


combined =
  Signal.mergeMany
    [ (actions)
    , (Signal.map (\_ -> NoOp) (every second))
    , (categories)
    ]


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





