module Main where

import Timer exposing (..)
import Sessions exposing (..)
import Types exposing (..)
import Stats exposing (..)
import Styles

import Time exposing (..)
import Html exposing(..)



--MODEL


initialModel : Model
initialModel =
  let
    emptyModel =
      { time = 0,
        counting = False,
        button = "Start",
        sessions = [ ],
        currentCategory = "Reading",
        catList = ["Reading", "Exercise", "Walking"]
      }
  in
    Maybe.withDefault emptyModel incoming


--UPDATE


update : (Time, Action) -> Model -> Model
update (timeStop, action) model =
  case action of
    NoOp ->
      if model.counting
        then { model | time = model.time + 1 }
        else { model | time = 0 }

    Count ->
      if model.button == "Start"
        then { model | counting = True
                     , button = "Stop" }
        else createSession timeStop model.currentCategory model

    Reset ->
      { model | sessions = (filterSessionsRemove model) }

    ChangeCategory catString ->
      if model.button == "Start"
        then { model | currentCategory = catString }
        else createSession timeStop catString model




view : Model -> Html
view model =
  div []
    [ div [ Styles.float ] [
        timerView model inbox.address Count
      , sessionsView model inbox.address ChangeCategory Reset
      ]
    , div [ Styles.float ] [
      statsView model
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
  Signal.mergeMany
    [ (actions)
    , (Signal.map (\_ -> NoOp) (every second))
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





