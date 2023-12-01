(ns problems.problem-08-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-08
             :refer
             [answer-a
              answer-b
              get-down
              get-left
              get-right
              get-up
              visible-score
              visible-trees]]))

(def test-array
  (to-array-2d
   [[3, 0, 3, 7, 3],
    [2, 5, 5, 1, 2],
    [6, 5, 3, 3, 2],
    [3, 3, 5, 4, 9],
    [3, 5, 3, 9, 0]]))

(deftest get-left-test
  (is (= [5 6] (get-left test-array 2 2)))
  (is (= [] (get-left test-array 0 0))))
(deftest get-right-test
  (is (= [3 2] (get-right test-array 2 2)))
  (is (= [] (get-right test-array 4 0))))
(deftest get-down-test
  (is (= [5 3] (get-down test-array 2 2)))
  (is (= [] (get-down test-array 0 4))))
(deftest get-up-test
  (is (= [5 3] (get-up test-array 2 2)))
  (is (= [] (get-up test-array 0 0))))

(deftest visible-trees-test
  (is (= 1 (visible-trees 5 [3])))
  (is (= 1 (visible-trees 5 [5 2])))
  (is (= 2 (visible-trees 5 [1 2])))
  (is (= 2 (visible-trees 5 [3 5 3])))
  (is (= 2 (visible-trees 5 [3 5 3])))
  (is (= 2 (visible-trees 5 [3 3])))
  (is (= 1 (visible-trees 5 [3])))
  (is (= 2 (visible-trees 5 [4 9])))
  (is (= 1 (visible-trees 3 [3 5 6])))
  (is (= 2 (visible-trees 3 [1 7])))
  (is (= 1 (visible-trees 3 [2])))
  (is (= 1 (visible-trees 3 [4 9])))
  (is (= 4 (visible-trees 5 [2 4 3 5 9])))
  (is (= 0 (visible-trees 5 []))))

(deftest visible-score-test
  (is (= 4 (visible-score test-array 2 1)))
  (is (= 8 (visible-score test-array 2 3)))
  (is (= 2 (visible-score test-array 3 2))))

(deftest answer-a-test
  (is (= 21 (answer-a "data/problem-08-a.txt")))
  (is (= 1672 (answer-a "data/problem-08-input.txt"))))

(deftest answer-b-test
  (is (= 8 (answer-b "data/problem-08-a.txt")))
  (is (= 327180 (answer-b "data/problem-08-input.txt"))))