module View exposing (view)

import Html exposing (Html, tr, td, text, div, br, button, input)
import Html.Attributes exposing (style, value)
import Html.Events exposing (onClick, onInput)

import List.Extra

import Functions exposing (historia)
import Styles exposing (buttonStyle, flexcontainer, textStyle, center)
import Types exposing (..)


view : Model -> Html Msg
view model =
  case model.eval of

      True ->
        div
        [ style "text-align" "center"
        , style "padding" "30px"
        ]
        [ button
          ( buttonStyle Add )
          [ text "Nuevo requisito" ]
        , div
          ( flexcontainer "row" )
          (List.indexedMap (historia model.eval) model.tareas)
        ]

      False ->
        div
          ( flexcontainer "column"
          ++ [ style "padding" "30px" ]
          )
          [ button
            ( buttonStyle Vuelta )
            [ text "Volver al trabajo" ]
          , div
            ([ style "padding" "50px"
            , style "text-decoration" "underline"
            ]
            ++ textStyle True "1.5em"
            )
            [ text "Prueba y evaluación" ]
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
          , input
            ([ onInput Input
            , style "width" "50%"
            , style "margin-bottom" "40px"
            , value model.str
            ]
            ++ center
            ++ textStyle False "0.75em"
            ) []
          , button
            ( buttonStyle NuevaTarea )
            [ text "Nueva tarea" ]
          ]
