-- Q6-1: Haskellには、指定された値を永遠に繰り返すrepeatという関数があります。このレッスンで取り上げた
--       関数を使って、repeatを独自に実装してみましょう。
repeatFunc x = cycle [x]

-- Q6-2: subseqという関数を作成してみましょう。次に示すように、この関数は開始位置、終了位置、リストの３つの引数
--       を受け取り、開始位置と終了位置の間にあるサブシーケンスを返します。
subseq start end aList = take difference (drop start aList)
  where difference = end - start

-- Q6-3: inFirstHalfという関数を作成してみましょう。この関数は要素がリストの前半分に含まれている場合はTrueを返し、
--       そうでない場合はFalseを返します。
-- div は 除算の結果をかえす
--   div 5 3 -> 1
--   div 6 2 -> 3
inFirstHalf x myList = x `elem` firstHalf
  where midpoint = (length myList) `div` 2
        firstHalf = take midpoint myList
