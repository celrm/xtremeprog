module Functions exposing (historia)

import Html exposing (Html, table, tr, td, text, div, br, p)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

import List.Extra

import Types exposing (Model,Tarjeta,Msg(..))
import Styles exposing (fondo, flexcontainer, nonselect, textStyle, center)


emptycell : Html Msg
emptycell =
  td [ style "background" fondo ] [ text " " ]


tarjeta : Int -> Int -> Tarjeta -> Html Msg
tarjeta h i t =
  table
    [ style "border-collapse" "collapse"
    , style "border" "3px solid black"
    , style "margin-left" (if t.done && i /= 0 then "50px" else "0px")
    , style "margin-rigth" (if t.done then "50px" else "0px")
    , style "margin-bottom" "10%"
    , style "width" "275px"
    , style "height" "275px"
    ]
    [ tr
      [ style "height" "12.5%" ]
      [ emptycell
      , td
          (
          [ onClick (Cambiar t.done h i)
          , style "width" "12.5%"
          , style "background" (if t.done then "#01DF01" else "red")
          , style "border" "2px solid black"
          ]
          ++ textStyle True "90%"
          ++ nonselect
          )
          [ text (if t.done then "✔" else "✗") ]
      ]

    , tr
      [ style "height" "17.5%" ]
      [ td
          (
          [ style "background" fondo
          , style "padding" "0px 0px 0px 12.5%"
          , style "text-decoration" "underline"
          ]
          ++ textStyle True "1.25em"
          )
          [ text ("Tarea " ++ Debug.toString t.number) ]
      , emptycell
      ]

    , tr
      [ style "height" "70%" ]
      [ td
          (
          [ style "background" fondo
          , style "text-align" "center"
          , style "padding" "0px 0px 0px 12.5%"
          ]
          ++ textStyle False "1em"
          )
          [ text t.description ]
       , emptycell
       ]
    ]


historia : Bool -> Int -> (String, List Tarjeta) -> Html Msg
historia b h (descripcion, lista) =
    div
    (
    [ style "width" (if b then "275px" else "100%") ]
    ++
    flexcontainer "column"
    ++ center
    )
    [ div
      (
      [ style "margin-bottom" "20px" ]
      ++ center
      )
      [ p
        (
        [ onClick (Evaluar h) ]
        ++ nonselect
        ++ textStyle False "1.5em"
        )
        [ text ("Historia " ++ Debug.toString (h + 1) ++ ":") ]
      , p
        ( textStyle False "1em" ++
        [ style "text-align" "justify"
        --, style "width" "auto"
        --, style "margin" "auto"
        ]
        )
        [ text descripcion ]
      ]

    , div
      ([ style "flex-wrap" "wrap"
      --, style "margin-bottom" "20px"
      --, style "justify-content" "center"
      ]
      ++ flexcontainer (if b then "column" else "row")
      ++ center
      )
      ( List.indexedMap
        ( \i tarea ->
          div
            []
            [ tarjeta h i tarea ]
        )
        ( List.filter
          ( \t -> xor b (.done t) )
          lista
        )
      )
    ]
