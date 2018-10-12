module Types exposing (Model, Tarjeta, Msg(Cambiar,Vuelta,Add,Evaluar))


type alias Model =
  { todo : List (String, List Tarjeta)
  , tareas : List (String, List Tarjeta)
  , eval : Bool
  , numerito : Int
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
