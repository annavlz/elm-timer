module Sessions exposing (..)

--LIBS

import Html exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Time exposing (..)


--FILES

import Styles exposing (..)
import Timer exposing (..)
import Types exposing (..)


--HELPERS


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


createSession : Time -> String -> Model -> Model
createSession timeStop catString model =
    let
        getSession =
            { date = makeDate timeStop
            , time = model.time
            , category = model.currentCategory
            }
    in
        { model
            | counting = False
            , sessions = getSession :: model.sessions
            , time = 0
            , button = "Start"
            , currentCategory = catString
        }


filterSessions : Model -> String -> List Session
filterSessions model cat =
    List.filter (\session -> session.category == cat) model.sessions


filterSessionsRemove : Model -> String -> List Session
filterSessionsRemove model cat =
    List.filter (\session -> session.category /= cat) model.sessions



--VIEW


showSession : Session -> Html Msg
showSession session =
    tr []
        [ td [ Styles.cell ]
            [ text (toString session.date) ]
        , td [ Styles.cell ]
            [ text (timeRead session.time) ]
        , td [ Styles.cell ]
            [ text session.category ]
        ]


onSelect : (String -> msg) -> Attribute msg
onSelect tagger =
    on "change" (Json.map tagger targetValue)


dDown : Model -> (String -> Msg) -> Html Msg
dDown model msg =
    let
        getCatList category =
            option [] [ text category ]
    in
        div []
            [ text "Sessions"
            , select [ onSelect msg ]
                (List.map getCatList model.catList)
            ]


sessionsView : Model -> (String -> Msg) -> Msg -> Html Msg
sessionsView model msg1 msg2 =
    div [ Styles.sessions ]
        [ h1 [] [ text "Sessions" ]
        , dDown model msg1
        , button [ Styles.resetButton, onClick msg2 ] [ text "Reset" ]
        , div []
            [ tr [ Styles.sessionsTable ]
                [ td [ Styles.cell ]
                    [ text
                        ((sessionTimes
                            (filterSessions model model.currentCategory)
                         )
                            ++ " times"
                        )
                    ]
                , td [ Styles.cell ]
                    [ text
                        ((totalTime
                            (filterSessions model model.currentCategory)
                         )
                            ++ " in total"
                        )
                    ]
                ]
            ]
        , div []
            (filterSessions model model.currentCategory
                |> List.reverse
                |> List.map showSession
            )
        ]
