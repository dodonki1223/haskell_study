-- LESSON 7 再帰のルールとパターンマッチング
-- ・再帰関数の定義
-- ・再帰関数を記述するためのルール
-- ・ウォークスルー：再帰関数の定義
-- ・基本的なパターンマッチングを使った再帰関数の解決

-- 7-1
-- myGCD a b = if remainder == 0
--     then b
--     else myGCD b remainder
--  where remainder = a `mod` b

-- 7-2
-- 下の書き方で書き換える
-- sayAmount n = case n of
--     1 -> "one"
--     2 -> "two"
--     n -> "a bunch"

-- 7-3
sayAmount 1 = "one"
sayAmount 2 = "two"
sayAmount n = "a bunch"

-- 7-4
myHead (x:xs) =x
myHead [] =error "No head for empty list"

-- クイックチェック7-3
myTail(_:xs) = xs


-- 7.5 練習問題
-- Q7-1
myTail [] = []

-- Q7-2
myGCD a 0 = a
myGCD a b = myGCD b (a `mod` b)
