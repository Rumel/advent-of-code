(ns problems.problem-02-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-02 :refer
             [answer-a
              answer-b
              get-hand-score-a
              get-hand-score-b
              get-score-a
              get-score-b]]))

(def hands
  [["A" "Y"]
   ["B" "X"]
   ["C" "Z"]])

(deftest get-hand-score-a-test
  (is (= 8 (get-hand-score-a (hands 0))))
  (is (= 1 (get-hand-score-a (hands 1))))
  (is (= 6 (get-hand-score-a (hands 2)))))

(deftest get-hand-score-b-test
  (is (= 4 (get-hand-score-b (hands 0))))
  (is (= 1 (get-hand-score-b (hands 1))))
  (is (= 7 (get-hand-score-b (hands 2)))))

(deftest get-score-a-test
  (is (= 15 (get-score-a hands))))

(deftest get-score-b-test
  (is (= 12 (get-score-b hands))))

(deftest answer-a-test
  (is (= (answer-a "data/problem-02-a.txt") 15)))

(deftest answer-b-test
  (is (= (answer-b "data/problem-02-a.txt") 12)))