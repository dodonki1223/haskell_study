-- LESSON 6 リスト
-- ・リストを構成するパーツの識別
-- ・リストを構築する方法
-- ・関数型プログラミングでのリストの役割
-- ・リストでの一般的な関数の使用
-- ・遅延評価の基礎

-- 6.1 リストの構造
--   リストはhead要素とtailリストで構成され、headは１つの要素であり、tailは別のリスト。

-- 6.2 リストと遅延評価
--   無限のリストの長さを持つリストを定義してもそれが実行されなければHaskellとしてはコンパイルが成功する。
--   これはHaskellが「遅延評価」と呼ばれる特別な評価を使用するため。

-- 6.3 リストの一般的な関数
--   6-2: isPalindrome関数
isPalindrome word = word == reverse word
-- ghci> isPalindrome "cheease"
-- False
-- ghci> isPalindrome "racecar"
-- True

--   6-3: respond関数
respond phrase = if '!' `elem` phrase
            then "wow!"
            else "uh..okay"
-- ghci> respond "hello"
-- "uh..okay"
-- ghci> respond "hello!"
-- "wow!"

--   6-4: takeLast関数
takeLast n aList = reverse (take n (reverse aList))
-- ghci> takeLast 10 [1 .. 100]
-- [91,92,93,94,95,96,97,98,99,100]

--   6-5: cycle関数
ones n = take n (cycle [1])
-- ghci> ones 2
-- [1,1]
-- ghci> ones 4
-- [1,1,1,1]

--   6-6: assignToGroups関数
assignToGroups n aList = zip groups aList
 where groups = cycle [1 .. n]

-- ghci> assignToGroups 3 ["file1.txt","file2.txt","file3.txt","file4.txt","file5.txt","file6.txt","file7.txt","file8.txt"]
-- [(1,"file1.txt"),(2,"file2.txt"),(3,"file3.txt"),(1,"file4.txt"),(2,"file5.txt"),(3,"file6.txt"),(1,"file7.txt"),(2,"file8.txt")]
-- ghci> assignToGroups 2 ["Bob","Kathy","Sue","Joan","Jim","Mike"]
-- [(1,"Bob"),(2,"Kathy"),(1,"Sue"),(2,"Joan"),(1,"Jim"),(2,"Mike")]
