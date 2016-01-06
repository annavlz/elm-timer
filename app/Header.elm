module Header where

import Types exposing (..)
import Styles
import Html exposing (..)
import Html.Attributes exposing (..)

showHeader : Html
showHeader =
  header [ Styles.header ]
    [ h1 [ Styles.logo ]
      [ text "TimeTracker"]
    , Html.form [ Styles.login ]
      [ input [ Styles.loginInput ]
        []
      , input [ Styles.loginInput ]
        []
      , button []
        [text "Login"]
      ]

    ]