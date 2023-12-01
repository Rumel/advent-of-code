(ns problems.problem-20-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-20
             :refer
             [answer-a
              answer-b]]))

(deftest answer-a-test
  (is (= 3 (answer-a "data/problem-20-a.txt")))
  (is (= 10763 (answer-a "data/problem-20-input.txt"))))

(deftest answer-b-test
  (is (= 1623178306 (answer-b "data/problem-20-a.txt")))
  (is (= 4979911042808 (answer-b "data/problem-20-input.txt"))))