module Types exposing (Model, Msg(Cambiar,Vuelta,Add))


type alias Model =
  { todo : List (String, List (String, Bool))
  , tareas : List (String, List (String, Bool))
  , eval : Bool
  , numerito : Int
  }


type Msg
  = Cambiar Bool Int Int
  | Vuelta
  | Add
