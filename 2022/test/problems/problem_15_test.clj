(ns problems.problem-15-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-15 :refer [answer-a answer-b]]))

(deftest answer-a-test
  (is (= 26 (answer-a "data/problem-15-a.txt" 10))
      (= 4961647 (answer-a "data/problem-15-input.txt" 2000000))))

(deftest answer-b-test
  (is (= 56000011 (answer-b "data/problem-15-a.txt" 0 20)))
  (is (= 12274327017867 (answer-b "data/problem-15-input.txt" 0 4000000))))