(ns problems.problem-09-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-09
             :refer
             [answer-a
              answer-b
              move-direction
              point]]))

(def move-direction-starting {:knots [(point 1 1)]})
(deftest move-direction-test
  (is (= (point 2 1) (first ((move-direction move-direction-starting "R") :knots))))
  (is (= (point 0 1) (first ((move-direction move-direction-starting "L") :knots))))
  (is (= (point 1 2) (first ((move-direction move-direction-starting "U") :knots))))
  (is (= (point 1 0) (first ((move-direction move-direction-starting "D") :knots)))))

(deftest answer-a-test
  (is (= 13 (answer-a "data/problem-09-a.txt")))
  (is (= 5878 (answer-a "data/problem-09-input.txt"))))

(deftest answer-b-test
  (is (= 1 (answer-b "data/problem-09-a.txt")))
  (is (= 36 (answer-b "data/problem-09-b.txt")))
  (is (= 2405 (answer-b "data/problem-09-input.txt"))))