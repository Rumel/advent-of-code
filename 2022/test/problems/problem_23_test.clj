(ns problems.problem-23-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-23 :refer [answer-a answer-b]]))

(deftest answer-a-test
  (is (= 110 (answer-a "data/problem-23-a.txt")))
  (is (= 4181 (answer-a "data/problem-23-input.txt"))))

(deftest answer-b-test
  (is (= 20 (answer-b "data/problem-23-a.txt")))
  (is (= 973 (answer-b "data/problem-23-input.txt"))))