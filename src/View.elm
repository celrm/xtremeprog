module View exposing (view)

import Html exposing (Html, tr, td, text, div, br, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

import List.Extra

import Functions exposing (historia)
import Styles exposing (flexcontainer, textStyle, center)
import Types exposing (Model, Msg(Vuelta,Add))


view : Model -> Html Msg
view model =
  case model.eval of

      True ->
        div [ style [ ("text-align","center"), ("padding", "30px") ] ]
        [ button
          [ onClick Add
          , style
            [ ("width", "250px")
            , ("margin-bottom", "20px")
            ]
          , textStyle False "0.75em"
          , center
          ]
          [ text "Nuevo requisito" ]
        , div
          [ flexcontainer "row" ]
          (List.indexedMap (historia model.eval) model.tareas)
        ]

      False ->
        div
          [ flexcontainer "column"
          , style
            [ ("padding", "100px") ]
          ]
          [ div
            [ style
              [ ("margin-bottom", "100px")
              , ("text-decoration", "underline")
              ]
            , textStyle True "1.5em"
            ]
            [ text "Prueba y evaluación" ]
          , button
            [ onClick Vuelta
            , style
              [ ("width", "250px")
              , ("margin-bottom", "40px")
              ]
            , textStyle False "0.75em"
            , center
            ]
            [ text "Volver al trabajo" ]
          , historia
              model.eval
              model.numerito
              ( Maybe.withDefault
                ("",[])
                ( List.Extra.getAt
                    model.numerito
                    model.tareas
                )
              )
          ]
