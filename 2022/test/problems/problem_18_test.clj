(ns problems.problem-18-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-18 :refer [answer-a answer-b]]))

(deftest answer-a-test
  (is (= 64 (answer-a "data/problem-18-a.txt")))
  (is (= 3364 (answer-a "data/problem-18-input.txt"))))

(deftest answer-b-test
  (is (= 58 (answer-b "data/problem-18-a.txt")))
  (is (= 2006 (answer-b "data/problem-18-input.txt"))))