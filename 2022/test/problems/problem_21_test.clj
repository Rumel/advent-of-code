(ns problems.problem-21-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-21
             :refer
             [answer-a
              answer-b]]))

(deftest answer-a-test
  (is (= 152 (answer-a "data/problem-21-a.txt"))))

(deftest answer-b-test
  (is (= "Not implemented yet" (answer-b "Not implemented yet"))))