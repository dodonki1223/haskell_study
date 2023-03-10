-- Q3-1: ラムダ関数を記述する練習としてLESSON2で取り上げた各関数をラムダ式として書き換えてみましょう。
simple = (\x -> x)
inc = (\x -> x +1)
double = (\x -> x*2)
square=(\x -> x^2)


-- Q3-2: let式を使用することとラムダ関数を使用することは、内部ではまったくおなじことではありません。例えば次のコードを実行しようとするとエラーになります。
--   counter x = let x = x + 1
--       in
--           let x = x + 1
--           in
--               x
-- letとラムダが同じものではないことを証明するために、counter関数を書き換えてみましょう。内容は同じままで、letの代わりに入れ子のラムダを使用します。
-- ヒント：終わりから始める。
counter x = (\x -> x + 1)
    ((\x -> x + 1) 
        ((\x -> x) x))
