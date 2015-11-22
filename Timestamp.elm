module Timestamp (makeDate) where

import Time exposing (..)
import Date exposing (fromTime, year, month, day)


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



