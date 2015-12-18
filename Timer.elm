module Timer where

import Types exposing (..)

import Html exposing(..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Date exposing (fromTime, year, month, day)
import Time exposing (..)



timeRead : Int -> String
timeRead time =
  let
    hour = time // 3600 |> toString
    min = time `rem` 3600 // 60 |> toString
    sec = time `rem` 60 |> toString

  in
    if time < 60  then sec ++ " sec"
    else if time < 3600 then min ++ " min " ++ sec ++ " sec"
    else hour ++ " h " ++ min ++ " min " ++ sec ++ " sec"


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
  div [ class "timer" ]
  [ div [ class "counter" ] [ text (timeRead model.time) ]
  , button [ class "start-button", onClick address action ] [ text model.button ]
  ]





