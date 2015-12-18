module Timer where

import Types exposing (..)

import Html exposing(..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Date exposing (fromTime, year, month, day)
import Time exposing (..)
import String
import Styles



timeRead : Int -> String
timeRead time =
  let
    hour = time // 3600
    min = time `rem` 3600 // 60
    sec = time `rem` 60

    print digits = (if digits < 10 then "0" else "") ++ toString digits
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


timerView : Model -> Signal.Address Types.Action -> Action -> Html
timerView model address action =
  div [ Styles.timer ]
  [ div [ Styles.counter ] [ text (timeRead model.time) ]
  , button [ Styles.startButton, onClick address action ] [ text model.button ]
  ]





