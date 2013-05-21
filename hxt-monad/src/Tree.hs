{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeSynonymInstances  #-}

module Tree
{- just for testing
    ( Tree
    , isNull
    , isFail
    , fromList
    , toList
    )
-- -}
where

import           Control.Applicative
import           Control.Monad
import           Control.Monad.Arrow
import           Control.Monad.ArrowExc
import           Control.Monad.ArrowIf
import           Control.Monad.ArrowIO
import           Control.Monad.ArrowList
import           Control.Monad.ArrowState
import           Control.Monad.Error
import           Control.Monad.MonadSequence
import           Control.Monad.State.Strict
-- import           Data.List                   (partition)
import           Data.List.IOList
import           Data.List.IOSequence
import           Data.List.IOTree
import           Data.List.List
import           Data.List.StateSequence
import           Data.List.Tree
import           Data.Monoid

-- ----------------------------------------

type LA      a b = a -> List            b
type SLA   s a b = a -> StateSequence List s b
type IOLA    a b = a -> IOList          b

type LA'     a b = a -> Tree            b
type SLA'  s a b = a -> StateSequence Tree s b
type IOLA'   a b = a -> IOTree          b

type StateIOTree s a = StateT s IOTree a

type SIOLA s a b = a -> StateIOTree s b

type IntSLA a b = SLA' Int a b

mk2 :: a -> a -> Tree a
mk2 x y = Bin (Tip x) (Tip y)

tt1,tt7,tt8 :: Tree Integer
tt1 = fromList [1]
tt7 = fromList [1..7]
tt8 = fromList [1..8]

st1 :: (Sequence s) => [Int] -> StateSequence s Int Int
st1 = fromList >>> (this <+> arr (+10)) >>> arr (+1) >>> perform (changeState (+) . const 1)

st1' :: SLA Int [Int] Int
st1' = st1

st1'' :: SLA' Int [Int] Int
st1'' = st1


