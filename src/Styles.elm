module Styles exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)


fondo : String
fondo =
  --"#58D3F7"
  "#F3F781"

flexcontainer : String -> Attribute msg
flexcontainer rowcolumn =
  style
  [ ("display", "-webkit-flex")
  , ("display", "flex")
  , ("flex-direction", rowcolumn)
  ]

nonselect : Attribute msg
nonselect =
  style
  [ ("-webkit-user-select","none")
  , ("-khtml-user-select","none")
  , ("-moz-user-select","none")
  , ("-o-user-select","none")
  , ("user-select","none")
  , ("cursor", "pointer")
  ]

textStyle : Bool -> String -> Attribute msg
textStyle negrita tam =
  style
  [ ("text-align", "center")
  , ("font-size", tam)
  , ("font-family", "Courier New")--"courier")
  , ("font-weight", (if negrita then "bold" else "normal"))
  ]

center =
  style
  [ ("margin-left", "auto")
  , ("margin-right", "auto")
  ]
