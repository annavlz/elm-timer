port module Main exposing (..)

--LIBS

import Html exposing (..)
import Html.App as App
import Task exposing (..)
import Time exposing (..)


--FILES

import Sessions exposing (..)
import Stats exposing (..)
import Styles exposing (..)
import Timer exposing (..)
import Types exposing (..)


main : Program (Maybe Model)
main =
    App.programWithFlags
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



--MODEL


initialModel : Model
initialModel =
    { time = 0
    , counting = False
    , button = "Start"
    , sessions = []
    , currentCategory = "Reading"
    , catList = [ "Reading", "Exercise", "Walking" ]
    }


init : Maybe Model -> ( Model, Cmd Msg )
init model =
    case model of
        Just model ->
            ( model, Cmd.none )

        Nothing ->
            ( initialModel, Cmd.none )



--UPDATE


getTimeAndThen : (Time -> Msg) -> Cmd Msg
getTimeAndThen msg =
    Task.perform (\err -> Debug.crash err) msg Time.now


count : Msg
count =
    GetTimeAndThen
        (\time -> Count time)


changeCategory : String -> Msg
changeCategory cat =
    GetTimeAndThen (\time -> ChangeCategory cat time)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            if model.counting then
                ( { model | time = model.time + 1 }, outgoing model )
            else
                ( { model | time = 0 }, outgoing model )

        GetTimeAndThen msg' ->
            ( model, getTimeAndThen msg' )

        Count timeStop ->
            if model.button == "Start" then
                ( { model
                    | counting = True
                    , button = "Stop"
                  }
                , outgoing model
                )
            else
                ( createSession timeStop model.currentCategory model, outgoing model )

        Reset ->
            ( { model
                | sessions = (filterSessionsRemove model model.currentCategory)
              }
            , outgoing model
            )

        ChangeCategory catString timeStop ->
            if model.button == "Start" then
                ( { model | currentCategory = catString }, outgoing model )
            else
                ( createSession timeStop catString model, outgoing model )



--VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [ Styles.float ]
            [ timerView model count
            , sessionsView model changeCategory Reset
            ]
        , div [ Styles.float ]
            [ statsView model
            ]
        ]



--PORTS


port outgoing : Model -> Cmd msg



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every Time.second (\_ -> NoOp)
        ]
