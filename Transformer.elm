module Transformer (sessionTimes, totalTime, timeRead) where

type alias Session =
  { date: String,
    time: Int
  }

sessionTimes : List Session -> String
sessionTimes sessionsList =
  List.length sessionsList |> toString


totalTime : List Session -> String
totalTime sessionsList =
  List.foldr (+) 0 (List.map (\session -> session.time) sessionsList) |> timeRead


timeRead : Int -> String
timeRead time =
  let
    hour = time // 3600 |> toString
    min = time `rem` 3600 // 60 |> toString
    sec = time `rem` 60 |> toString

  in
    if | time < 60   -> sec ++ " sec"
       | time < 3600 -> min ++ " min " ++ sec ++ " sec"
       | otherwise   -> hour ++ " h " ++ min ++ " min " ++ sec ++ " sec"
