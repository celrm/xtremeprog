module Main exposing (main)

import Browser

import Types exposing (Model, Msg)
import State exposing (init, update, subscriptions)
import View exposing (view)


main : Program () Model Msg
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }
