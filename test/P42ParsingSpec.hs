module P42ParsingSpec (main,spec) where

import Test.Hspec
import Test.Hspec.QuickCheck
import P42Parsing hiding (main)
 
testFile :: [String]
testFile = [ "Ling,Mai,55900"
           , "Johnson,Jim,56500"
           , "Jones,Aaron,46000"
           , "Jones,Chris,34500"
           , "Swift,Geoffrey,14200"
           , "Xiong,Fong,65000"
           , "Zarnecki,Sabrina,51500"
           ]
 
main :: IO ()
main = hspec spec

spec = do
  describe "lname" $ do
    it "extracts 1st field from a list" $ do
      lname ["a", "b", "c"] == "a"
  describe "fname" $ do
    it "extracts 2nd field from a list" $ do
      fname ["a", "b", "c"] == "b"
  describe "salary" $ do
    it "extracts 3rd field from a list" $ do
      salary ["a", "b", "c"] == "c"
  describe "mkSortTbl" $ do
    it "sorts correctly by salary and returns formatted results (head)" $ do
      (head . lines $ mkSortTbl 2 testFile) == "Xiong    Fong     65000 "
    it "sorts correctly by salary and returns formatted results (last)" $ do
      (last . lines $ mkSortTbl 2 testFile) == "Swift    Geoffrey 14200 "
    it "behaves the same as the Data.Csv implementation" $ do
      (lines $ mkSortTbl 2 testFile) == (lines $ mkSortTbl' 2 testFile)
  describe "mkSortTbl'" $ do
    it "sorts correctly by salary and returns formatted results (head)" $ do
      (head . lines $ mkSortTbl' 2 testFile) == "Xiong    Fong     65000 "
    it "sorts correctly by salary and returns formatted results (last)" $ do
      (last . lines $ mkSortTbl' 2 testFile) == "Swift    Geoffrey 14200 "
