module Types exposing (..)

import Time exposing (Time)


type alias Model =
    { time : Int
    , counting : Bool
    , button : String
    , sessions : List Session
    , currentCategory : String
    , catList : List String
    }


type alias Session =
    { date : String
    , time : Int
    , category : String
    }


type Msg
    = GetTimeAndThen ModelMsg
    | GotTime ModelMsg Time


type ModelMsg
    = NoOp
    | Count
    | Reset
    | ChangeCategory String
