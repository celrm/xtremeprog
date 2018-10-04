module View exposing (view)

import Html exposing (Html, tr, td, text, div, br, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

import List.Extra

import Functions exposing (historia)
import Styles exposing (flexcontainer, textStyle)
import Types exposing (Model, Msg(Vuelta,Add))


view : Model -> Html Msg
view model =
  case model.eval of

      True ->
        div [ style [("text-align","center")] ]
        [ button
          [ onClick Add
          , style
            [ ("width", "375px")
            , ("margin-left", "auto")
            , ("margin-right", "auto")
            , ("margin-top", "45px")
            ]
          , textStyle False "0.75em"
          ]
          [ text "Nuevo requisito" ]
        , div
          [ flexcontainer "row"
          , style
            [ ("padding", "40px") ]
          ]
          (List.indexedMap (historia model.eval) model.tareas)
        ]

      False ->
        div
          [ flexcontainer "column"
          , style
            [ ("padding", "45px") ]
          ]
          [ div
            [ style
              [ ("margin-bottom", "40px")
              , ("text-decoration", "underline")
              ]
            , textStyle True "1.5em"
            ]
            [ text "Prueba y evaluación" ]
          , button
            [ onClick Vuelta
            , style
              [ ("width", "345px")
              , ("margin-left", "auto")
              , ("margin-right", "auto")
              , ("margin-bottom", "45px")
              ]
            , textStyle False "0.75em"
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
