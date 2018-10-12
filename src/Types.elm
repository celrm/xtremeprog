module Types exposing (..)


type alias Model =
  { todo : List (String, List Tarjeta)
  , tareas : List (String, List Tarjeta)
  , eval : Bool
  , numerito : Int
  , str : String
  }

type alias Tarjeta =
  { number : Int
  , description : String
  , done : Bool
  }

type Msg
  = Cambiar Bool Int Int
  | Vuelta
  | Add
  | Evaluar Int
  | Input String
  | NuevaTarea
