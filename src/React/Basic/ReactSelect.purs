module React.Basic.ReactSelect where

import Prelude

import Control.Monad.Eff.Uncurried (EffFn1)
import Control.Monad.Promise (Promise)
import Data.Nullable (Nullable)
import React.Basic (JSX, ReactComponent)
import React.Basic.DOM (CSS)

type SelectOption additionalData =
  { value :: String
  , label :: String
  | additionalData
  }

type SelectProps additionalData props =
  ( className :: String
  , style :: CSS
  , searchable :: Boolean
  , id :: String
  , name :: String
  , noResultsText :: String
  , placeholder :: String
  , optionRenderer :: SelectOption additionalData -> JSX
  , filterOptions :: Array (SelectOption additionalData) -> Array (SelectOption additionalData)
  | props
  )

type SingleChangeCallback eff additionalData =
  EffFn1
    eff
    (Nullable (SelectOption additionalData))
    Unit

type MultiChangeCallback eff additionalData =
  EffFn1
    eff
    (Nullable (Array (SelectOption additionalData)))
    Unit

-- | Basic single-select picker
foreign import singleSelect
  :: forall rest rest_ eff additionalData
   . Union rest rest_
       (SelectProps additionalData (onChange :: SingleChangeCallback eff additionalData))
  => ReactComponent
      { value :: String
      , options :: Array (SelectOption additionalData)
      | rest
      }

-- | Basic multi-select picker
foreign import multiSelect
  :: forall rest rest_ eff additionalData
   . Union rest rest_
      (SelectProps additionalData
        (onChange :: MultiChangeCallback eff additionalData))
  => ReactComponent
      { value :: Array String
      , options :: Array (SelectOption additionalData)
      | rest
      }

-- | Single-select picker which loads options asynchronously
foreign import asyncSingleSelect
  :: forall rest rest_ eff additionalData
   . Union rest rest_
      (SelectProps additionalData
        (onChange :: SingleChangeCallback eff additionalData))
  => ReactComponent
      { value :: String
      , loadOptions :: String -> Promise eff { options :: Array (SelectOption additionalData) }
      | rest
      }

-- | Multi-select picker which loads options asynchronously
foreign import asyncMultiSelect
  :: forall rest rest_ eff additionalData
   . Union rest rest_
      (SelectProps additionalData
        (onChange :: MultiChangeCallback eff additionalData))
  => ReactComponent
      { value :: Array String
      , loadOptions :: String -> Promise eff { options :: Array (SelectOption additionalData) }
      | rest
      }
