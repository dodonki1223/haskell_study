-- LESSON 8 再帰関数の記述
--  ・再帰のルールを適用するときの共通パターン
--  ・再帰をリストで使用する方法
--  ・GHCiで関数の実行にかかった時間を計る方法
--  ・再帰の5つのルールに対するエッジケース

import System.Console.Terminfo (restoreDefaultColors)

-- 8.1 複数：再帰のルール
--   1. (１つ以上の)最終目標を特定する
--   2. 最終目標が達成されたらどうなるかを決める
--   3. 他の可能性をすべて洗い出す
--   4. 「繰り返し」のプロセスを決める
--   5. 繰り返しのたびに最終目標に近づくようにする

-- 8.2 リストでの再帰
-- リスト8-1: myLength関数
myLength [] = 0
-- myLength xs = 1 + myLength (tail xs)
myLength (x:xs) = 1 + myLength xs

-- リスト 8-2: myTake関数
myTake _ [] = []
myTake 0 _ = []
myTake n (x:xs) = x:rest
 where rest = myTake (n - 1) xs

-- リスト 8-3: myCycle関数
firstmyCycle (first:rest) =  first:rest ++ [first]
myCycle (first:rest) = firstmyCycle (rest++[first])

-- 8.3 再帰の問題点：アッカーマン関数とコラッツ予想
-- アッカーマン関数
ackermann 0 n = n + 1
ackermann m 0 = ackermann (m-1) 1
ackermann m n = ackermann (m-1) (ackermann m (n-1))

-- コラッツ予想
collatz 1 = 1
collatz n = if even n
            then 1 + collatz (n `div` 2)
            else 1 + collatz (n*3 +1)
