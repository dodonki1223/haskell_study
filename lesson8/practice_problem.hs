-- Q8-1: リストの要素を逆順にするreverseを独自に実装してみましょう。
myReverse [] = []
myReverse (x:[]) = [x]
myReverse (x:xs) = myReverse xs ++ [x]

-- Q8-2: 再帰関数のもっとも一般的な例はおそらくフィボナッチ数の計算でしょう。もっとも単純な定義は次のようになります。
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fastFib _ _ 0 = 0
fastFib _ _ 1 = 1
fastFib _ _ 2 = 1
fastFib x y 3 = x + y
fastFib x y z = fastFib (x + y) x (z - 1)
