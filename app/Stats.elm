module Stats exposing (..)

--LIBS

import Html exposing (..)


--FILES

import Sessions exposing (..)
import Styles exposing (..)
import Types exposing (..)


--VIEW


showStat : Model -> String -> Html ModelMsg
showStat model cat =
    tr []
        [ td [ Styles.cell ]
            [ text cat ]
        , td [ Styles.cell ]
            [ text (sessionTimes (filterSessions model cat)) ]
        , td [ Styles.cell ]
            [ text (totalTime (filterSessions model cat)) ]
        ]


statsView : Model -> Html ModelMsg
statsView model =
    div [ Styles.sessions ]
        [ h1 [] [ text "Stats" ]
        , div []
            [ tr [ Styles.sessionsTable ]
                [ td [ Styles.cell ]
                    [ text "Category" ]
                , td [ Styles.cell ]
                    [ text "Times" ]
                , td [ Styles.cell ]
                    [ text "Total" ]
                ]
            ]
        , div []
            (List.map (showStat model) model.catList)
        ]
