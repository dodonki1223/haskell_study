-- Q7-1: Haskellのtail関数は、空のリストが渡されたときにエラーを返します。myTailを書き換え、空のリストが
--       渡された場合はからのリストを返すようにしてみましょう。
myTail [] = []

-- Q7-1: パターンマッチング使ってmyGCDを書き換えてみましょう。
myGCD a 0 = a
myGCD a b = myGCD b (a `mod` b)
