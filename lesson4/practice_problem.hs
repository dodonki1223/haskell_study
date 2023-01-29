-- Q4-1: Haskellで比較できるもの（nameタプルの名前で使用した[Char]など）はすべて、compare
--       という関数で比較できます。この関数はGT、LT、EQのいずれかを返します。compare を使って
--       compareLastNames関数を書き換えてみましょう。
import Data.List

compareLastNames2 name1 name2 = if lastNameResult == EQ
                                then firstNameResult
                                else lastNameResult
 where lastNameResult = compare (snd name1) (snd name2)
       firstNameResult = compare (fst name1) (fst name2)

-- names2 = [("Fugahoge", "Sumner"), ("Ian", "Curtis"), ("Bernard", "Sumner"), ("Peter", "Hook"), ("Hogefuga", "Sumner"), ("Stephen", "Morris")]
-- ghci> sortBy compareLastNames2 names2
-- [("Ian","Curtis"),("Peter","Hook"),("Stephen","Morris"),("Bernard","Sumner"),("Fugahoge","Sumner"),("Hogefuga","Sumner")]

-- Q4-2: Washington, DC用の新しい住所関数を定義し、getLocationFunctionに追加してみましょう。
--       このDC関数では、メンバーの名前の最後にEsqを追加しなければなりません。
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

dcOffice name = nameText ++ ", Esq"
 where nameText = (fst name) ++ " " ++ (snd name)

getLocationFunction location = case location of -- locationの値を調べるcase
-- locationがnyの場合はnyOfficeを返す
 "ny" -> nyOffice
--locationがsfの場合はsfOfficeを返す
 "sf" -> sfOffice
--locationがrenoの場合はrenoOfficeを返す
 "reno" -> renoOffice
--locationがdcの場合はdcOfficeを返す
 "dc" -> dcOffice
--その他の場合(_はワイルドカード)は汎用的な解を返す
 _ -> (\name -> (fst name) ++ " " ++ (snd name))

addressLetter2 name location = locationFunction name
 where locationFunction = getLocationFunction location

-- ghci> addressLetter2 ("Bob", "Smith") "dc"
-- "Bob Smith, Esq"
