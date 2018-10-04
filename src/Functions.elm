module Functions exposing (historia)

import Html exposing (Html, table, tr, td, text, div, br, p)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

import List.Extra

import Types exposing (Model, Msg(Cambiar))
import Styles exposing (fondo, flexcontainer, nonselect, textStyle)


emptycell : Html Msg
emptycell =
  td [ style [ ("background", fondo) ] ] [ text " " ]


tarjeta : Int -> Int -> (String, Bool) -> Html Msg
tarjeta h i (str, hecho) =
  table
    [ style
      [ ("border-collapse", "collapse")
      , ("border", "3px solid black")
      , ("margin-left", "20px")
      , ("margin-right", "20px")
      ]
    ]
    [ tr [ style [ ("height", "45px") ] ]
      [ emptycell
      , td
        [ onClick (Cambiar hecho h i)
        , style
          [ ("width", "45px")
          , ("background", (if hecho then "#01DF01" else "red"))
          , ("border", "3px solid black")
          , ("cursor", "pointer")
          ]
        , textStyle True "30px"
        , nonselect
        ]
        [ text (if hecho then "✔" else "✗") ]
      ]
    , tr [ style [ ("height", "60px") ] ]
      [ td
        [ style
          [ ("width", "300px")
          , ("background", fondo)
          , ("padding", "0px 0px 0px 45px")
          , ("text-decoration", "underline")
          ]
        , textStyle True "1.25em"
        ]
        [ text ("Tarea " ++ toString (i + 1)) ]
      , emptycell
      ]
    , tr [ style [ ("height", "250px") ] ]
      [ td
        [ style
          [ ("background", fondo)
          , ("text-align", "center")
          , ("padding", "0px 0px 0px 45px")
          ]
        , textStyle False "1em"
        ]
        [ text str ]
      , emptycell
      ]
    ]


historia : Bool -> Int -> (String, List (String, Bool)) -> Html Msg
historia b h tareas =
  let (descripcion, lista) = tareas
  in
    div
    [ flexcontainer "column"
    , style
      [ ("margin-left", "auto")
      , ("margin-right", "auto")
      , ("margin-bottom", "45px")
      ]
    ]
    [ div
      [ style
        [ ("margin-left", "auto")
        , ("margin-right", "auto")
        , ("margin-bottom", "20px") ]
      ]
      [ p [textStyle False "1.5em"] [text ("Historia " ++ toString (h + 1) ++ ":")]
      , p [ textStyle False "1em", style
            [ ("width", (if b then "375px" else "auto"))
            --, ("padding", "5%")
            , ("text-align", "justify")
            ]
          ]
          [text descripcion]
      ]
    , div
      [ flexcontainer (if b then "column" else "row")
      , style
        [ ("margin-left", "auto")
        , ("margin-right", "auto")
        , ("margin-bottom", "45px")
        , ("justify-content", "center")
        , ("flex-wrap", "wrap")
        ]
      ]
      ( List.indexedMap
        ( \i tarea ->
          div
            []
            [ tarjeta h i tarea
            , br [] []
            ]
        )
        ( List.filter
          ( \t -> xor b (Tuple.second t) )
          lista
        )
      )
    ]
