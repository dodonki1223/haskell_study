-- LESSON 7 再帰のルールとパターンマッチング
-- ・再帰関数の定義
-- ・再帰関数を記述するためのルール
-- ・ウォークスルー：再帰関数の定義
-- ・基本的なパターンマッチングを使った再帰関数の解決

-- 7.1 再帰
-- 7.2 再帰のルール
--   再帰関数を解く鍵は、次の単純なルールに従うこと
--   1. (１つ以上の)最終目標を特定する
--   2. 最終目標が達成されたらどうなるかを決める
--   3. 他の可能性をすべて洗い出す
--   4. 「繰り返し」のプロセスを決める
--   5. 繰り返しのたびに最終目標に近づくようにする

-- 7.3 最初の再帰関数：最大公約数
--   リスト 7-1
-- myGCD a b = if remainder == 0
--     then b
--     else myGCD b remainder
--  where remainder = a `mod` b

--   リスト 7-2
-- sayAmount n = case n of
--     1 -> "one"
--     2 -> "two"
--     n -> "a bunch"

--   リスト 7-3
sayAmount 1 = "one"
sayAmount 2 = "two"
sayAmount n = "a bunch"

--   リスト 7-4
myHead (x:xs) =x
myHead [] =error "No head for empty list"

-- クイックチェック7-3
myTail(_:xs) = xs
