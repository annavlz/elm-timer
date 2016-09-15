module Styles exposing (..)

--LIBS

import Html exposing (Attribute)
import Html.Attributes exposing (..)


timer : Html.Attribute a
timer =
    style
        [ ( "width", "300px" )
        , ( "margin-left", "100px" )
        , ( "border", "1px solid #b8bdc5" )
        , ( "border-radius", "10px" )
        , ( "background-color", "#bf512c" )
        , ( "margin-bottom", "20px" )
        , ( "font-family", "Verdana, Geneva, sans-serif" )
        , ( "box-shadow", "2px 2px 10px #c7ced6" )
        ]


counter : Html.Attribute a
counter =
    style
        [ ( "margin-top", "20px" )
        , ( "color", "#ece0c9" )
        , ( "text-align", "center" )
        , ( "font-size", "50px" )
        , ( "font-family", "Verdana, Geneva, sans-serif" )
        ]


startButton : Html.Attribute a
startButton =
    style
        [ ( "width", "80%" )
        , ( "height", "50px" )
        , ( "margin", "10%" )
        , ( "border-radius", "10px" )
        , ( "font-size", "30px" )
        ]


resetButton : Html.Attribute a
resetButton =
    style
        [ ( "margin-bottom", "15px" )
        , ( "font-size", "16px" )
        , ( "padding", "8px" )
        ]


sessions : Html.Attribute a
sessions =
    style
        [ ( "border", "1px solid #b8bdc5" )
        , ( "width", "500px" )
        , ( "text-align", "center" )
        , ( "font-family", "Verdana, Geneva, sans-serif" )
        , ( "border-radius", "10px" )
        , ( "box-shadow", "2px 2px 10px #c7ced6" )
        , ( "padding-bottom", "15px" )
        , ( "background-color", "#ffffff" )
        ]


sessionsTable : Html.Attribute a
sessionsTable =
    style
        [ ( "background-color", "#bf512c" )
        , ( "color", "#ece0c9" )
        , ( "padding", "5px" )
        ]


cell : Html.Attribute a
cell =
    style
        [ ( "border", "0px solid #b8bdc5" )
        , ( "width", "250px" )
        , ( "font-size", "16px" )
        , ( "font-family", "Verdana, Geneva, sans-serif" )
        , ( "padding", "5px 10px" )
        ]


float : Html.Attribute a
float =
    style
        [ ( "float", "left" )
        , ( "width", "50%" )
        ]
