module Library where
-- reusable function used in more than one place
import Control.Monad (forM)
import System.Random (randomRIO)
import Data.Array.IO (writeArray, IOArray, readArray, newListArray)
import System.IO (hFlush, stdout)
import Data.Char (toUpper, toLower)
import Text.Printf (printf)

-- Randomly shuffle a list
-- /O(N)/ from: https://wiki.haskell.org/Random_shuffle
shuffle :: [a] -> IO [a]
shuffle xs = do
    ar <- newArray n xs
    forM [1..n] $ \i -> do
      j <- randomRIO (i,n)
      vi <- readArray ar i
      vj <- readArray ar j
      writeArray ar j vi
      return vj
  where
    n = length xs
    newArray :: Int -> [a] -> IO (IOArray Int a)
    newArray n' =  newListArray (1,n')

uc :: String -> String
uc = map toUpper

lc :: String -> String
lc = map toLower

showD :: Float -> String
showD = printf "%.2f"

showD8 :: Float -> String
showD8 = printf "%8.2f"

-- Prompt for a string, with a message
promptS :: String -> IO String
promptS m = putStr m >> hFlush stdout >> getLine

-- Prompt for a non-negative float, with message
-- Dies on no-parse
-- Numbers less than zero make it prompt again
promptNonNegFloat :: String -> IO Float
promptNonNegFloat m = do
    putStr m
    hFlush stdout
    x <- readLn :: IO Float
    if x<0
      then do
        putStrLn "Numbers must be non-negative"
        promptNonNegFloat m
      else
        return x

-- Prompt for a non-negative Int, with message
-- Dies on no-parse
-- Numbers less than zero make it prompt again
promptNonNegInt :: String -> IO Int
promptNonNegInt m = do
    putStr m
    hFlush stdout
    x <- readLn :: IO Int
    if x<0
      then do
        putStrLn "Numbers must be non-negative"
        promptNonNegInt m
      else
        return x
