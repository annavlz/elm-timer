module Sessions (..) where

import Types exposing (..)
import Timer exposing (..)
import Styles

import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (..)
import Graphics.Input exposing (dropDown)
import Html.Events exposing (..)


sessionTimes : List Session -> String
sessionTimes sessionsList =
  List.length sessionsList |> toString


totalTime : List Session -> String
totalTime sessionsList =
  let
    getSessionTime =
      List.map (\session -> session.time) sessionsList
  in
    List.foldr (+) 0 getSessionTime |> timeRead


showSession : Session -> Html
showSession session =
  tr [ ]
    [ td [ Styles.cell ]
      [ text (toString session.date) ]
    , td [ Styles.cell  ]
      [ text (timeRead session.time) ]
    , td [ Styles.cell  ]
      [ text session.category ]
    ]


createSession : Time -> String -> Model -> Model
createSession timeStop catString model =
  let
    getSession =
      { date = makeDate timeStop
      , time = model.time
      , category = model.currentCategory
      }
  in
    { model | counting = False
            , sessions = getSession :: model.sessions
            , time = 0
            , button = "Start"
            , currentCategory = catString }



filterSessions : Model -> List Session
filterSessions model =
  List.filter (\session -> session.category == model.currentCategory) model.sessions


filterSessionsRemove : Model -> List Session
filterSessionsRemove model =
  List.filter (\session -> session.category /= model.currentCategory) model.sessions


dDown : Model -> Signal.Address Types.Action -> (String -> Action) -> Html
dDown model address action =
  let
    getCatList category =
      (category, action category)
  in
    div []
      [
        dropDown (Signal.message address)
                 (List.map getCatList model.catList)
                 |> fromElement
      ]

sessionsView model address action1 action2 =
  div [ Styles.sessions ]
    [ h1 [] [ text "Sessions" ]
    , dDown model address action1
    , button [ Styles.resetButton, onClick address action2 ] [ text "Reset" ]
    , div []
      [ tr [ Styles.sessionsTable ]
        [ td [ Styles.cell  ]
          [ text ((sessionTimes (filterSessions model)) ++ " times") ]
        , td [ Styles.cell  ]
          [ text ((totalTime (filterSessions model)) ++ " in total") ]
        ]
      ]
    , div []
      (filterSessions model
        |> List.reverse
        |> List.map showSession
      )
    ]
