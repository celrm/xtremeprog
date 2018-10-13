module Styles exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Types exposing (Msg)


fondo : String
fondo =
  --"#58D3F7"
  "#F3F781"

flexcontainer : String -> List (Attribute msg)
flexcontainer rowcolumn =
  [ style "display" "-webkit-flex"
  , style "display" "flex"
  , style "flex-direction" rowcolumn
  ]

nonselect : List (Attribute msg)
nonselect =
  [ style "-webkit-user-select" "none"
  , style "-khtml-user-select" "none"
  , style "-moz-user-select" "none"
  , style "-o-user-select" "none"
  , style "user-select" "none"
  , style "cursor" "pointer"
  ]

textStyle : Bool -> String -> List (Attribute msg)
textStyle negrita tam =
  [ style "text-align" "center"
  , style "font-size" tam
  , style "font-family" "Verdana"
  , style "font-weight" (if negrita then "bold" else "normal")
  ]

center : List (Attribute msg)
center =
  [ style "margin-left" "auto"
  , style "margin-right" "auto"
  ]

buttonStyle : msg -> List (Attribute msg)
buttonStyle function =
  [ onClick function
  , style "width" "250px"
  , style "cursor" "pointer"
  , style "padding" "auto"
  ]
  ++ textStyle False "0.75em"
  ++ center
