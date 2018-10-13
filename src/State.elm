module State exposing (init, update, subscriptions)

import List.Extra

import Types exposing (..)

--"Grupo de folk dodecafónico flamenco"

--HISTORIA 1: INFORMACIÓN

   {- Después de varios años en el mundo de la música y haber llevado a cabo varios proyectos, este año hemos decidido experimentar un nuevo género, el "folk dodecafónico flamenco", en el cual tenemos mucha ilusión. Aún no sabemos por qué la cosa no va del todo bien y necesitamos una página web que nos permita darnos a conocer, de modo que más gente se interese por nuestro trabajo. -}

--HISTORIA 2: MUSICA

    {- Bueno, parece que la cosa está empezando a despegar, hemos recaudado suficiente para la primera maqueta. -}

--HISTORIA 3: DINEROS

    {- Al parecer el dinero no crece en los árboles -}


h1 : (String, List Tarjeta)
h1 =
  ("Queremos una web visualmente atractiva.",
  [ (Tarjeta 1 "Pestaña de información general" False)
  --, ("Pestaña de noticias", False)
  --, ("Pestaña de fotos", False)
  , (Tarjeta 2 "Pestaña sobre conciertos" False)
  ]
  )


h2 : (String, List Tarjeta)
h2 =
  ("Necesitamos dar a conocer nuestra obra.",
  [ (Tarjeta 1 "Pestaña con nuestra discografía" False)
  --, ("Subir música", False)
  , (Tarjeta 2 "Reproducir música mediante Spotify" False)
  , (Tarjeta 3 "Descargar música" False)
  ]
  )


h3 : (String, List Tarjeta)
h3 =
  ("Elaborar tienda online de entradas, merch...",
  [ (Tarjeta 1 "Métodos de pago: Tarjeta, Paypal" False)
  , (Tarjeta 2 "Catálogo de merchandising" False)
  , (Tarjeta 3 "Venta de entradas" False)
  ]
  )


init : () -> (Model, Cmd Msg)
init _ =
  (Model [ h1, h2, h3 ] [] True 0 "", Cmd.none)


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
                        |> Maybe.withDefault (Tarjeta 1 "" True)
                        |> (\t -> {t | done = not t.done})
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
                  |> List.all .done
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

    Evaluar h ->
      ( { model
          | numerito = h
          , eval = False
          , tareas =
              List.Extra.updateAt
              h
              ( Tuple.mapSecond List.reverse )
              model.tareas
        }
      , Cmd.none)

    Input str ->
      ( { model
          | str = str
        }
      , Cmd.none)

    NuevaTarea ->
      ( { model
          | tareas =
              ( List.Extra.updateAt
                model.numerito
                ( Tuple.mapSecond
                  ( \lista ->
                    lista ++
                    [ Tarjeta (List.length lista + 1) model.str False ]
                  )
                )
                model.tareas
              )
          , str = ""
        }
      , Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
