import Html exposing(..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Graphics.Input exposing (..)

type alias Model =
  { currentCategory : String }

initialModel : Model
initialModel =
  { currentCategory = "Reading" }


update : String -> Model -> Model
update value model =
  { model | currentCategory <- value }



catInbox : Signal.Mailbox String
catInbox =
  Signal.mailbox "Reading"


categories : Signal String
categories =
  catInbox.signal


dd : Html
dd =
  dropDown (Signal.message catInbox.address)
    [ ("Reading", "Reading")
    , ("Exercise", "Exercise")
    , ("Walking", "Walking")
    ] |> fromElement


view : Model -> Html
view model =
  div [] [
    span [] [ text model.currentCategory ]
  , dd
  ]


model : Signal Model
model =
  Signal.foldp update initialModel categories


main : Signal Html
main =
  Signal.map view model



--, on "change" targetValue (Signal.message catInbox.address
