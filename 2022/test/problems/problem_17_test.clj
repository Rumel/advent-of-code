(ns problems.problem-17-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-17
             :refer
             [answer-a
              answer-b]]))

(deftest answer-a-test
  (is (= 3068 (answer-a "data/problem-17-a.txt")))
  (is (= 3191 (answer-a "data/problem-17-input.txt"))))

(deftest answer-b-test
  (is (= "Not implemented yet" (answer-b "data/problem-17-a.txt"))))