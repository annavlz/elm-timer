module Login where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Styles
import StartApp
import ElmFire.Auth exposing (..)
import ElmFire exposing (..)
import Http exposing (..)
import Task
import Effects exposing (Effects, Never)
import Json.Encode exposing (null)
import Date

loc : Location
loc = fromUrl "https://timetrackerelm.firebaseio.com"


type alias Model =
  { email : String
  , pass : String
  , uid : Authentication
  }


type Action = Login | SaveEmail String | SavePass String | Logged Authentication


app =
  StartApp.start
    {init = init
    , view = view
    , update = update
    , inputs = []
    }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks


init : (Model, Effects Action)
init =
  (Model "" "" initAuth
  , Effects.none)


initAuth : Authentication
initAuth =
    { auth = null
    , expires = Date.fromTime(0)
    , provider = ""
    , specifics = null
    , token = ""
    , uid = ""
    }


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    SaveEmail email ->
      ({model| email = email}, Effects.none)
    SavePass pass ->
      ({model | pass = pass}, Effects.none)
    Login ->
      ( model
      , getLoggedIn model.email model.pass)
    Logged maybeAuth ->
      ({model | uid = maybeAuth}
      , Effects.none
      )


getLoggedIn : String -> String -> Effects Action
getLoggedIn email pass =
  authenticate loc [] (withPassword email pass)
    |> Task.toResult
    |> Task.map Logged
    |> Effects.task


view address model =
  div [ Styles.header ]
    [ h1 [ Styles.logo ]
      [ text "TimeTracker"]
    , Html.form
      [ Styles.login
      , onSubmit address Login
      ]
      [ input
        [ Styles.loginInput
        , type' "text"
        , placeholder "email"
        , value model.email
        , on "input" targetValue (Signal.message address << SaveEmail )
        , required True
        ]
        []
      , input
        [ Styles.loginInput
        , type' "text"
        , placeholder "password"
        , value model.pass
        , on "input" targetValue (Signal.message address << SavePass )
        , required True
        ]
        []
      , button [ onClick address Login ]
        [text "Login"]
      ]
    , div []
      [ text model.email
      , text model.pass
      , text model.uid.uid
      ]
    ]

