(ns problems.problem-22-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-22
             :refer
             [answer-a
              answer-b]]))

(deftest answer-a-test
  (is (= 6032 (answer-a "data/problem-22-a.txt")))
  (is (= 123046 (answer-a "data/problem-22-input.txt"))))

(deftest answer-b-test
  (is (= "Not implemented yet" (answer-b "Not implemented yet"))))