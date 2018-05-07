module MultiAsync where

import Prelude

import Control.Monad.Eff.Uncurried (mkEffFn1)
import Control.Monad.Promise (delay)
import Control.Monad.Promise.Unsafe (undefer)
import Data.Foldable (traverse_)
import Data.Nullable (toMaybe)
import Data.Time.Duration (Milliseconds(..))
import React.Basic (ReactComponent, createElement, react)
import React.Basic.ReactSelect (asyncMultiSelect)

component :: ReactComponent {}
component = react { displayName: "Counter", initialState, receiveProps, render }
  where
    initialState =
      { selectedValue: []
      }

    receiveProps _ _ _ =
      pure unit

    render _ state setState =
      createElement asyncMultiSelect
        { value: map _.value state.selectedValue
        , loadOptions
        , onChange: mkEffFn1 $ toMaybe >>> traverse_ \newValue ->
            setState _ { selectedValue = newValue }
        }

    loadOptions searchTxt =
      undefer $ delay (Milliseconds 500.0)
        { options:
            [ { label: "A"
              , value: "a"
              }
            , { label: "B"
              , value: "b"
              }
            , { label: "C"
              , value: "c"
              }
            ]
        }
