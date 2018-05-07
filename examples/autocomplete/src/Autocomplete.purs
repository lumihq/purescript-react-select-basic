module Autocomplete where

import Prelude

import Control.Monad.Eff.Uncurried (mkEffFn1)
import Data.Maybe (Maybe(Nothing), maybe)
import Data.Nullable (toMaybe)
import React.Basic (ReactComponent, createElement, react)
import React.Basic.ReactSelect (singleSelect)

component :: ReactComponent {}
component = react { displayName: "Counter", initialState, receiveProps, render }
  where
    initialState =
      { selectedValue: Nothing
      }

    receiveProps _ _ _ =
      pure unit

    render _ state setState =
      createElement singleSelect
        { value: maybe "" _.value state.selectedValue
        , options
        , onChange: mkEffFn1 $ \newValue ->
            setState _ { selectedValue = toMaybe newValue }
        }

    options =
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
