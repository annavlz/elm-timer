port module Main exposing (..)

--LIBS

import Html exposing (..)
import Html.App as App exposing (map)
import Task exposing (..)
import Time exposing (..)


--FILES

import Sessions exposing (..)
import Stats exposing (..)
import Styles exposing (..)
import Types exposing (..)
import Timer exposing (..)


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetTimeAndThen msg' ->
            ( model
            , Task.perform (\err -> Debug.crash err) (GotTime msg') Time.now
            )

        GotTime msg' time ->
            let
                ( newModel, cmd ) =
                    updateModel msg' time model
            in
                ( newModel, Cmd.map GetTimeAndThen cmd )


updateModel : ModelMsg -> Time -> Model -> ( Model, Cmd ModelMsg )
updateModel msg time model =
    case msg of
        NoOp ->
            if model.counting then
                ( { model | time = model.time + 1 }, outgoing model )
            else
                ( { model | time = 0 }, outgoing model )

        Count ->
            if model.button == "Start" then
                ( { model
                    | counting = True
                    , button = "Stop"
                  }
                , outgoing model
                )
            else
                ( createSession
                    time
                    model.currentCategory
                    model
                , outgoing model
                )

        Reset ->
            ( { model
                | sessions =
                    (filterSessionsRemove model model.currentCategory)
              }
            , outgoing model
            )

        ChangeCategory catString ->
            if model.button == "Start" then
                ( { model | currentCategory = catString }, outgoing model )
            else
                ( createSession time catString model, outgoing model )



--VIEW


view : Model -> Html Msg
view model =
    App.map GetTimeAndThen (viewModel model)


viewModel : Model -> Html ModelMsg
viewModel model =
    div []
        [ div [ Styles.float ]
            [ timerView model Count
            , sessionsView model ChangeCategory Reset
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
        [ Time.every Time.second (\_ -> (GetTimeAndThen NoOp))
        ]
