module State exposing (init, update, subscriptions)

import List.Extra

import Types exposing (Model, Msg(Cambiar,Vuelta,Add))


h1 : (String, List (String, Bool))
h1 =
  ("hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola",
  [ ("hola hola hola hola", False)
  , ("hola hola hola hola hola", False)
  , ("hola hola hola hola hola hola", False)
  ]
  )


h2 : (String, List (String, Bool))
h2 =
  ("hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola",
  [ ("hola hola hola hola", False)
  , ("hola hola hola hola hola", False)
  , ("hola hola hola hola hola hola", False)
  ]
  )


h3 : (String, List (String, Bool))
h3 =
  ("hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola",
  [ ("hola hola hola hola", False)
  , ("hola hola hola hola hola", False)
  , ("hola hola hola hola hola hola", False)
  ]
  )


h4 : (String, List (String, Bool))
h4 =
  ("hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola",
  [ ("hola hola hola hola", False)
  , ("hola hola hola hola hola", False)
  , ("hola hola hola hola hola hola", False)
  ]
  )


init : (Model, Cmd Msg)
init =
  (Model [ h2, h3, h4 ] [ h1 ] True 0, Cmd.none)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    Cambiar b h i ->
      let nuevasTareas =
            List.Extra.updateAt
              h
              ( \(encabezado, lista) ->
                ( encabezado
                , ( List.Extra.removeAt i lista
                  ++
                    [ lista
                        |> List.Extra.getAt i
                        |> Maybe.withDefault ("", True)
                        |> Tuple.mapSecond not
                    ]
                  )
                )
              )
              model.tareas
      in
        ( { model
            | tareas = nuevasTareas
            , eval =
                if nuevasTareas
                  |> List.Extra.getAt h
                  |> Maybe.withDefault ("",[])
                  |> Tuple.second
                  |> List.all Tuple.second
                then False else model.eval
            , numerito = h
          }
        , Cmd.none)

    Add ->
      ( { model
          | todo = List.drop 1 model.todo
          , tareas = model.tareas ++ (List.take 1 model.todo)
        }
      , Cmd.none)

    Vuelta ->
        ( { model
            | tareas =
                ( List.Extra.updateAt
                  model.numerito
                  ( Tuple.mapSecond List.reverse )
                  model.tareas
                )
            , eval = True
          }
        , Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
