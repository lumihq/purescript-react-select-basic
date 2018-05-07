module React.Basic.ReactSelect where

import Prelude

import Control.Monad.Eff.Uncurried (EffFn1)
import Control.Monad.Promise (Promise)
import Data.Nullable (Nullable)
import React.Basic (JSX, ReactComponent)

type SelectOption additionalData =
  { value :: String
  , label :: String
  | additionalData
  }

-- | Basic single-select picker
foreign import singleSelect
  :: forall rest rest_ eff additionalData
   . Union rest rest_
       ( className :: String
       , searchable :: Boolean
       , name :: String
       , onChange :: EffFn1 eff (Nullable (SelectOption additionalData)) Unit
       )
  => ReactComponent
       { value :: String
       , options :: Array (SelectOption additionalData)
       | rest
       }

-- | Basic multi-select picker
foreign import multiSelect
  :: forall rest rest_ eff additionalData
   . Union rest rest_
       ( className :: String
       , searchable :: Boolean
       , name :: String
       , onChange :: EffFn1 eff (Nullable (Array (SelectOption additionalData))) Unit
       )
  => ReactComponent
       { value :: Array String
       , options :: Array (SelectOption additionalData)
       | rest
       }

-- | Single-select picker which loads options asynchronously
foreign import asyncSingleSelect
  :: forall rest rest_ eff additionalData
   . Union rest rest_
       ( className :: String
       , searchable :: Boolean
       , name :: String
       , noResultsText :: String
       , placeholder :: String
       , optionRenderer :: SelectOption additionalData -> JSX
       , filterOptions :: Array (SelectOption additionalData) -> Array (SelectOption additionalData)
       , onChange :: EffFn1 eff (Nullable (SelectOption additionalData)) Unit
       )
  => ReactComponent
       { value :: String
       , loadOptions :: String -> Promise eff { options :: Array (SelectOption additionalData) }
       | rest
       }

-- | Multi-select picker which loads options asynchronously
foreign import asyncMultiSelect
  :: forall rest rest_ eff additionalData
   . Union rest rest_
       ( className :: String
       , searchable :: Boolean
       , name :: String
       , noResultsText :: String
       , placeholder :: String
       , optionRenderer :: SelectOption additionalData -> JSX
       , filterOptions :: Array (SelectOption additionalData) -> Array (SelectOption additionalData)
       , onChange :: EffFn1 eff (Nullable (Array (SelectOption additionalData))) Unit
       )
  => ReactComponent
       { value :: Array String
       , loadOptions :: String -> Promise eff { options :: Array (SelectOption additionalData) }
       | rest
       }
