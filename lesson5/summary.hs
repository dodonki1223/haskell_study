-- LESSON 5 クロージャーと部分適用
-- ・ラムダ式での値の補足
-- ・クロージャを使って新しい関数を作成する方法
-- ・部分適用を使ってクロージャを単純化する方法

-- 5.1 クロージャー：関数を使って関数を作成する

--   5-1: ifEvenInc関数、ifEvenDouble関数、ifEvenSquare関数

ifEven f x = if even x
    then f x
    else x

inc n = n + 1
double n = n * 2
square n = n ^ 2

genIfEven f = (\x -> ifEven f x)
-- f               : 引数fは ifEven で使用したい関数、引数fはラムダ関数でキャプチャされる
-- \x -> ifEven f x: このラムダ関数全体を返す
-- x               : 新しい関数はやはり引数を持っている

-- genIfEven関数を利用すれば、ifEvenX 関数を簡単に構築できる
-- したがって、関数を渡すとラムダ関数が返されます。引数として渡される関数fは、ラムダ関数の中でキャプチャされます。
-- ラムダ関数の中で値をキャプチャすると、クロージャーと呼ばれるものになります。

-- genIfEven inc 4
-- genIfEven double 4
-- genIfEven square 4

--   クイックチェック5-1
--     genIfXEven関数を作成してみましょう。この関数は、xを使ってクロージャを作成し、新しい関数を返します。
--     返された関数はxが偶数の場合にxに適用する関数として渡すことができます。
--       既に上で定義ずみだがこちらがあることが前提となっています。
--       ifEven f x = if even x
--           then f x
--           else x
genIfXEven x = (\f -> ifEven f x)

-- 5.2 例：APIで使用するURLの生成
--   5-2: getRequestUrl関数
--   しかしこの関数は汎用的ではない。引数の順番通りにかならずしもURLが作成されるわけではないため。
getRequestUrl host apikey resource id = host ++
                            "/" ++
                            resource ++
                            "/" ++
                            id ++
                            "?token=" ++
                            apikey
-- ghci> getRequestUrl "http://example.com" "1137hAsk3II" "book" "1234"
-- "http://example.com/book/1234?token=1137hAsk3II"

--   5-3: exampleUrlBuilder関数のバージョン1
--   汎用的に作成させるために以下のようにhost値のみをキャプチャした無名関数を作成できるようします。
getHostRequestBuilder host = (\apikey resource id ->
                                getRequestUrl host apikey resource id)
-- ghci> exampleUrlBuilder = getHostRequestBuilder "http://example.com"
-- ghci> exampleUrlBuilder "1337hAsk3II" "book" "1234"

--   5-4: getApiRequestBuilder関数
genApiRequestBuilder hostBuilder apiKey = (\resource id ->
                                hostBuilder apiKey resource id)
--   5-5: myExampleUrlBuilder関数のバージョン1
-- ghci> exampleUrlBuilder = getHostRequestBuilder "http://example.com"
-- ghci> myExampleUrlBuilder = genApiRequestBuilder exampleUrlBuilder "1337hAsk3III"
-- ghci> myExampleUrlBuilder "book" "1234"
-- "http://example.com/book/1234?token=1337hAsk3III"

--   クイックチェック5-2
--     genApiRequestBuilderを書き換え、引数としてリソースも受け取るバージョンを作成してみましょう。
genApiRequest2Builder hostBuilder apiKey resource = (\id ->
                                hostBuilder apiKey resource id)
-- ghci> exampleUrlBuilder = getHostRequestBuilder "http://example.com"
-- ghci> myExampleUrlBuilder = genApiRequest2Builder exampleUrlBuilder "1337hAsk3III" "book"
-- ghci> myExampleUrlBuilder "1234"
-- "http://example.com/book/1234?token=1337hAsk3III"

-- 部分適用：クロージャの単純化

add4 a b c d = a + b + c + d

addXto3 x= (\b c d ->
            add4 x b c d)

addXYto2 x y = (\c d ->
                add4 x y c d)

-- 引数が足りない場合はエラーとならずに新しい関数が定義される
-- 以下のような感じで実行が可能である
-- mystery 関数は、渡された３つの引数に３を足します。必要なパラメータ数よりも少ない引数を使って関数を
-- を呼び出すと、残りの引数を待機する新しい関数が作成されます。この機能を「部分適用」と呼ばれます。
mystery = add4 3
-- ghci> mystery 3 4 5
-- 15

anotherMystery = add4 2 3
-- ghci> anotherMystery = add4 2 3
-- ghci> anotherMystery 1 2
-- 8
-- ghci> anotherMystery 4 5
-- 14

--   5-6: exampleUrlBuilder関数とmyExampleUrlBuilder関数のバージョン２
--   部分適用を使用したバージョン
-- ghci> exampleUrlBuilder = getRequestUrl "http://example.com"
-- ghci> myExampleUrlBuilder = exampleUrlBuilder "1337hAsk3ll"
-- ghci> myExampleUrlBuilder "book" "1234"
-- "http://example.com/book/1234?token=1337hAsk3ll"

--   クイックチェック5-3
--     URLがhttp://example.com、APIキーが1337hAsk3II、リソースがbookのビルダー関数を作成してみましょう。
--     この関数に必要なのは本のIDだけであり、それをもとに完全なURLが生成されます。
exampleBuilder = getRequestUrl "http://example.com" "1337hAsk3ll" "books"
-- ghci> exampleBuilder = getRequestUrl "http://example.com" "1337hAsk3ll" "books"
-- ghci> exampleBuilder "1234"
-- "http://example.com/books/1234?token=1337hAsk3ll"

-- 5.3 すべてを1つにまとめる
--   部分適用は、「引数はもっとも一般的なものから順に並ばなければならない」というルールを作成した理由でもあります。
--   部分適用を使用する際には、引数が最初から順番に適用されるからです。
sfOffice name = if lastName < "L"
    then nameText
        ++ " - PO Box 1234 - San Francisco, CA, 94111"
    else nameText
        ++ " - PO Box 1010 - San Francisco, CA, 94109"
 where lastName = snd name
       nameText = (fst name) ++ " " ++ lastName

nyOffice name = nameText ++ " : PO Box 789 - New York, NY, 10013"
 where nameText = (fst name) ++ " " ++ (snd name)

renoOffice name = nameText ++ " - PO Box 456 - Reno, NV 89523"
 where nameText = snd name

getLocationFunction location = case location of
 "ny" -> nyOffice
 "sf" -> sfOffice
 "reno" -> renoOffice
 _ -> (\name -> (fst name) ++ " " ++ (snd name))

addressLetter name location = locationFunction name
  where locationFunction = getLocationFunction location

--   5-7: addressLetterV2関数
--     以下の関数を変更する
--     引数の順番に依存しているためこれをなflipBinaryArgを使って変更する
-- addressLetterV2 location name = addressLetter name location
flipBinaryArgs binaryFunction = (\x y -> binaryFunction y x)

addressLetterV2 = flipBinaryArgs addressLetter
addressLetterNY = addressLetterV2 "ny"
-- ghci> addressLetterNY ("Bob", "Smith")
-- "Bob Smith : PO Box 789 - New York, NY, 10013"

-- クイックチェック5-4
--     flipと部分適用を使ってsubstract2という関数を作成してみましょう。この関数は渡された
--     数値から2を引くものとします。
subtract2 x = flip (-) 2 x
-- 以下のように省略しても問題ない
-- subtract2 = flip (-) 2
