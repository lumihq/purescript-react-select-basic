module React.Basic.ReactSelect where

import Prelude

import Data.Nullable (Nullable)
import Effect.Promise (Promise)
import Effect.Uncurried (EffectFn1)
import Prim.Row (class Union)
import React.Basic (JSX, Component)
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

type SingleChangeCallback additionalData =
  EffectFn1
    (Nullable (SelectOption additionalData))
    Unit

type MultiChangeCallback additionalData =
  EffectFn1
    (Nullable (Array (SelectOption additionalData)))
    Unit

-- | Basic single-select picker
foreign import singleSelect
  :: forall rest rest_ additionalData
   . Union rest rest_
       (SelectProps additionalData (onChange :: SingleChangeCallback additionalData))
  => Component
      { value :: String
      , options :: Array (SelectOption additionalData)
      | rest
      }

-- | Basic multi-select picker
foreign import multiSelect
  :: forall rest rest_ additionalData
   . Union rest rest_
      (SelectProps additionalData
        (onChange :: MultiChangeCallback additionalData))
  => Component
      { value :: Array String
      , options :: Array (SelectOption additionalData)
      | rest
      }

-- | Single-select picker which loads options asynchronously
foreign import asyncSingleSelect
  :: forall rest rest_ additionalData
   . Union rest rest_
      (SelectProps additionalData
        (onChange :: SingleChangeCallback additionalData))
  => Component
      { value :: String
      , loadOptions :: String -> Promise { options :: Array (SelectOption additionalData) }
      | rest
      }

-- | Multi-select picker which loads options asynchronously
foreign import asyncMultiSelect
  :: forall rest rest_ additionalData
   . Union rest rest_
      (SelectProps additionalData
        (onChange :: MultiChangeCallback additionalData))
  => Component
      { value :: Array String
      , loadOptions :: String -> Promise { options :: Array (SelectOption additionalData) }
      | rest
      }
