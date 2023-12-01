(ns problems.problem-04-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-04 :refer
             [answer-a
              answer-b
              contained?
              convert
              overlap?]]))

(deftest contained?-test
  (is (= false (contained? [[2 4] [6 8]])))
  (is (= true (contained? [[6 6] [4 6]]))))

(deftest overlap?-test
  (is (= false (overlap? [[2 4] [6 8]])))
  (is (= true (overlap? [[6 6] [4 6]]))))

(deftest convert-test
  (is (= [[2 4] [6 8]] (convert "2-4,6-8")))
  (is (= [[2 3] [4 5]] (convert "2-3,4-5")))
  (is (= [[5 7] [7 9]] (convert "5-7,7-9"))))

(deftest answer-a-test
  (is (= 2 (answer-a "data/problem-04-a.txt"))))

(deftest answer-b-test
  (is (= 4 (answer-b "data/problem-04-a.txt"))))