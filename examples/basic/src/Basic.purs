module Basic where

import Prelude

import Data.Maybe (Maybe(Nothing), maybe)
import Data.Nullable (toMaybe)
import Effect.Uncurried (mkEffectFn1)
import React.Basic as React
import React.Basic.ReactSelect (singleSelect)

component :: React.Component {}
component = React.component { displayName: "BasicExample", initialState, receiveProps, render }
  where
    initialState =
      { selectedValue: Nothing
      }

    receiveProps _ =
      pure unit

    render { state, setState } =
      React.element singleSelect
        { value: maybe "" _.value state.selectedValue
        , options
        , onChange: mkEffectFn1 $ \newValue ->
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
