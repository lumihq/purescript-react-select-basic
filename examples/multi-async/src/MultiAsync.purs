module MultiAsync where

import Prelude

import Data.Foldable (traverse_)
import Data.Nullable (toMaybe)
import Data.Time.Duration (Milliseconds(..))
import Effect.Promise (delay)
import Effect.Promise.Unsafe (undefer)
import Effect.Uncurried (mkEffectFn1)
import React.Basic as React
import React.Basic.ReactSelect (asyncMultiSelect)

component :: React.Component {}
component = React.component { displayName: "MultiAsyncExample", initialState, receiveProps, render }
  where
    initialState =
      { selectedValue: []
      }

    receiveProps _ _ _ =
      pure unit

    render _ state setState =
      React.element asyncMultiSelect
        { value: map _.value state.selectedValue
        , loadOptions
        , onChange: mkEffectFn1 $ toMaybe >>> traverse_ \newValue ->
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
