-- Q5-1: 部分適用を理解したので、genIfEvenXを使用する必要はなくなりました。ifEvenと部分適用を
--       を使ってifEvenInc, ifEvenDouble, ifEvenSquareを再び定義してみましょう。
ifEven f x = if even x
    then f x
    else x

inc n = n + 1
double n = n * 2
square n = n ^ 2

ifEvenInc x = ifEven inc x
ifEvenDouble x = ifEven double x
ifEvenSquare x = ifEven square x

-- Q5-2: Haskellに部分適用が無かった無かったとしても、何らかの概算を行うことが可能です。flipBinaryArgs
--       のシンプルなパターンにしたがって、binaryPartialApplicationという関数を作成してみましょう。この関数
--       は二項関数と引数を１つ受け取り、不明な引数を待機する新しい関数を返します。
binaryPartialApplication binaryFunc arg = (\x -> binaryFunc arg x)
takeFromFour x = binaryPartialApplication (-) 4 x
