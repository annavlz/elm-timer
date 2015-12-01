module ViewHtml (showSession) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Timestamp exposing (timeRead)


type alias Session =
  { date: String,
    time: Int,
    category: String
  }


showSession : Session -> Html
showSession session =
  tr [ ]
    [ td [ class "cell" ]
      [ text (toString session.date) ]
    , td [ class "cell" ]
      [ text (timeRead session.time) ]
    , td [ class "cell" ]
      [ text session.category ]
    ]



