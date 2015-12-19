module Stats where

import Sessions exposing (..)
import Types exposing (..)
import Styles

import Html exposing (..)
import Html.Attributes exposing (..)

statsView model =
  div [ Styles.sessions ]
    [ h1 [] [ text "Stats" ]
    , div []
      [ tr [ Styles.sessionsTable ]
        [ td [ Styles.cell  ]
          [ text "Category" ]
        , td [ Styles.cell  ]
          [ text "Times" ]
        , td [ Styles.cell  ]
          [ text "Total" ]
        ]
      ]
    , div []
        (List.map (showStat model) model.catList)
    --  [ tr [ Styles.sessionsTable ]
    --    [ td [ Styles.cell  ]
    --      [ text ((sessionTimes (filterSessions model)) ++ " times") ]
    --    , td [ Styles.cell  ]
    --      [ text ((totalTime (filterSessions model)) ++ " in total") ]
    --    ]
    --  ]
    --, div []
    --  (filterSessions model
    --    |> List.reverse
    --    |> List.map showSession
    --  )
    ]

showStat : Model -> String -> Html
showStat model cat =
  tr [ ]
    [ td [ Styles.cell ]
      [ text cat ]
    , td [ Styles.cell  ]
      [ text (sessionTimes (filterSessions model cat)) ]
    , td [ Styles.cell  ]
      [ text (totalTime (filterSessions model cat)) ]
    ]