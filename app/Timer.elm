module Timer exposing (..)

--LIBS

import Date exposing (fromTime, year, month, day)
import Html exposing (..)
import Html.Events exposing (..)
import Time exposing (..)


--FILES

import Styles exposing (..)
import Types exposing (..)


--HELPERS


timeRead : Int -> String
timeRead time =
    let
        hour =
            time // 3600

        min =
            time `rem` 3600 // 60

        sec =
            time `rem` 60

        print digits =
            (if digits < 10 then
                "0"
             else
                ""
            )
                ++ toString digits
    in
        print hour ++ ":" ++ print min ++ ":" ++ print sec


makeDate : Time -> String
makeDate time =
    let
        yearT =
            time
                |> fromTime
                |> year
                |> toString

        monthT =
            time
                |> fromTime
                |> month
                |> toString

        dayT =
            time
                |> fromTime
                |> day
                |> toString
    in
        dayT ++ " " ++ monthT ++ " " ++ yearT



--VIEW


timerView : Model -> ModelMsg -> Html ModelMsg
timerView model msg =
    div [ Styles.timer ]
        [ div [ Styles.counter ] [ text (timeRead model.time) ]
        , button [ Styles.startButton, onClick msg ] [ text model.button ]
        ]
