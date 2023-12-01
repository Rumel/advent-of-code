(ns problems.problem-13-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-13
             :refer
             [answer-a
              answer-b
              correct-packets?
              sorter]]))

(deftest correct-packets?-test
  (is (= true (correct-packets?
               [1 1 3 1 1]
               [1 1 5 1 1])))
  (is (= true (correct-packets?
               [[1] [2 3 4]]
               [[1] 4])))
  (is (= false (correct-packets?
                [9]
                [[8 7 6]])))
  (is (= true (correct-packets?
               [[4 4] 4 4]
               [[4 4] 4 4 4])))
  (is (= false (correct-packets?
                [7 7 7 7]
                [7 7 7])))
  (is (= true (correct-packets?
               []
               [3])))
  (is (= false (correct-packets?
                [[[]]]
                [[]])))
  (is (= false (correct-packets?
                [1 [2 [3 [4 [5 6 7]]]] 8 9]
                [1 [2 [3 [4 [5 6 0]]]] 8 9])))
;; Copying from input file
  (is (= false (correct-packets?
                [[7],[[[5,3,3,4],[0],[1,7,2,4,2],4,[10,8,3,1]],1,9,8]]
                [[],[[],8],[]])))
  (is (= true (correct-packets?
               [[[3,6,9],8,2]]
               [[8,0,7],[7,[[8,8,1,4,5],9]],[9,9]])))
  (is (= false (correct-packets?
                [[[[2,3,9,10]],3,4,7]]
                [[],[4,5,7,[4,10],[]]])))
  (is (= false (correct-packets?
                [[],[6]]
                [[],[5]])))
  (is (= false (correct-packets?
                [[6] [[[9 8 7] 2 [2 1 7 7 8] [0 7 7]] 9 5 7]]
                [[6]])))
  (is (= true (correct-packets?
               [[6]]
               [[6] [[[9 8 7] 2 [2 1 7 7 8] [0 7 7]] 9 5 7]])))
  (is (= :next (correct-packets?
                [[6]]
                [[6]])))
  (is (= true (sorter
               [[2]]
               [[[2] [7] 6 9 0]])))
  (is (= false (sorter
                [[[2] [7] 6 9 0]]
                [[2]]))))


(deftest answer-a-test
  (is (= 13 (answer-a "data/problem-13-a.txt"))
      (= 6478 (answer-a "data/problem-13-input.txt"))))

(deftest answer-b-test
  (is (= 140 (answer-b "data/problem-13-a.txt"))
      (= 21922 (answer-b "data/problem-13-input.txt"))))