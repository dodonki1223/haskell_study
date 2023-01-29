import Data.List

-- LESSON 4 ファーストクラス関数
-- ・ファーストクラスの定義
-- ・関数を他の関数への引数として使用する方法
-- ・関数の計算を抽象化する方法
-- ・関数を値として返す方法

-- ファーストクラス関数は通常の引数と同じで関数に対して引数として関数を渡せることができる関数のことを指す
-- 第一級関数とも呼ばれている

-- 4.1 引数としての関数

--   4-1: ifEvenInc関数
--     even は偶数ならば true を奇数ならば false を返す
ifEvenlnc n = if even n
    then n + 1
    else n

--   4-2: ifEvenDouble関数とifEvenSquare関数
ifEvenDouble n = if even n
    then n * 2
    else n
ifEvenSquare n = if even n
    then n ^ 2
    else n

--   4-3: ifEven関数
ifEven myFunction x = if even x
    then myFunction x
    else x

inc n = n + 1
double n = n * 2
square n = n ^ 2

-- ファーストクラス関数を使うことでシンプルにすることができす。

ifEvenlnc2 n = ifEven inc n
ifEvenDouble2 n = ifEven double n
ifEvenSquare2 n = ifEven square n

--   クイックチェック4-1
--     xを3乗してifEvenにわたすラムダ関数を作成してみましょう。
ifEvenTriple n = ifEven (\x -> x^3) n

--   4-4: names タプル
--     予め import Data.List を宣言しておく
names = [("Ian", "Curtis"), ("Bernard", "Sumner"), ("Peter", "Hook"), ("Stephen", "Morris")]
--     sort names を実行する
--       ghci> sort names
--       [("Bernard","Sumner"),("Ian","Curtis"),("Peter","Hook"),("Stephen","Morris")]

--   4-5: compareLastNames関数
--     GT: より大きい, LT: より小さい, EQ: 等しい
compareLastNames name1 name2 = if lastName1 > lastName2
                                then GT
                                else if lastName1 < lastName2
                                    then LT
                                    else EQ
 where lastName1 = snd name1
       lastName2 = snd name2
--     sortBy でカスタムソートを試してる
--       ghci> sortBy compareLastNames names
--       [("Ian","Curtis"),("Peter","Hook"),("Stephen","Morris"),("Bernard","Sumner")]

--   クイックチェック4-2
--     compareLastNames関数では、ラストネームが同じでファーストネームが異なるという
--     ケースには対処してません。compareLastNames関数を書き換えて、ファーストネーム
--     を比較するようにしてみましょう。
names2 = [("Fugahoge", "Sumner"), ("Ian", "Curtis"), ("Bernard", "Sumner"), ("Peter", "Hook"), ("Hogefuga", "Sumner"), ("Stephen", "Morris")]
compareLastNames2 name1 name2 = if lastName1 > lastName2
                                then GT
                                else if lastName1 < lastName2
                                    then LT
                                    else if firstName1 > firstName2
                                        then GT
                                        else if firstName1 < firstName2
                                            then LT
                                            else EQ
 where lastName1 = snd name1
       lastName2 = snd name2
       firstName1 = fst name1
       firstName2 = fst name2

-- 4.2 戻り値としての関数

--   4-6: addressLetter関数バージョン1
addressLetter name location = nameText ++ " " ++ location
 where nameText = (fst name) ++ " " ++ (snd name)
--     ghci> addressLetter ("Bob", "Smith") "PO Box 1234 - San Francisco, CA, 94111"
--     "Bob Smith PO Box 1234 - San Francisco, CA, 94111"

--   4-7: sfOffice関数, nyOffice関数, renoOffice関数
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

--   4-8: getLocationFunction関数
getLocationFunction location = case location of -- locationの値を調べるcase
-- locationがnyの場合はnyOfficeを返す
 "ny" -> nyOffice
--locationがsfの場合はsfOfficeを返す
 "sf" -> sfOffice
--locationがrenoの場合はrenoOfficeを返す
 "reno" -> renoOffice
--その他の場合(_はワイルドカード)は汎用的な解を返す
 _ -> (\name -> (fst name) ++ " " ++ (snd name))

--   4-9: addressLetter関数バージョン2
addressLetter2 name location = locationFunction name 
 where locationFunction = getLocationFunction location
--     ghci> addressLetter2 ("Bob", "Smith") "ny"
--     "Bob Smith : PO Box 789 - New York, NY, 10013"
--
--     ghci> addressLetter2 ("Bob", "Jones") "ny"
--     "Bob Jones : PO Box 789 - New York, NY, 10013"
--
--     ghci> addressLetter2 ("Samantha", "Smith") "sf"
--     "Samantha Smith - PO Box 1010 - San Francisco, CA, 94109"
--
--     ghci> addressLetter2 ("Bob", "Smith") "reno"
--     "Smith - PO Box 456 - Reno, NV 89523"
--
--     ghci> addressLetter2 ("Bob", "Smith") "la"
--     "Bob Smith"
