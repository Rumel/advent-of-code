(ns problems.problem-11-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-11
             :refer
             [answer-a
              answer-b
              execute-rounds]]))

(deftest execute-rounds-test
  (is (= '(2 4 3 6) (execute-rounds "data/problem-11-a.txt" 1 false)))
  (is (= '(99 97 8 103) (execute-rounds "data/problem-11-a.txt" 20 false)))
  (is (= '(5204 4792 199 5192) (execute-rounds "data/problem-11-a.txt" 1000 false)))
  (is (= '(10419 9577 392 10391) (execute-rounds "data/problem-11-a.txt" 2000 false)))
  (is (= '(15638 14358 587 15593) (execute-rounds "data/problem-11-a.txt" 3000 false)))
  (is (= '(20858 19138 780 20797) (execute-rounds "data/problem-11-a.txt" 4000 false)))
  (is (= '(26075 23921 974 26000) (execute-rounds "data/problem-11-a.txt" 5000 false)))
  (is (= '(31294 28702 1165 31204) (execute-rounds "data/problem-11-a.txt" 6000 false)))
  (is (= '(36508 33488 1360 36400) (execute-rounds "data/problem-11-a.txt" 7000 false)))
  (is (= '(41728 38268 1553 41606) (execute-rounds "data/problem-11-a.txt" 8000 false)))
  (is (= '(46945 43051 1746 46807) (execute-rounds "data/problem-11-a.txt" 9000 false)))
  (is (= '(52166 47830 1938 52013) (execute-rounds "data/problem-11-a.txt" 10000 false))))

(deftest answer-a-test
  (is (= 10605 (answer-a "data/problem-11-a.txt")))
  (is (= 54253 (answer-a "data/problem-11-input.txt"))))

(deftest answer-b-test
  (is (= 2713310158 (answer-b "data/problem-11-a.txt")))
  (is (= 13119526120 (answer-b "data/problem-11-input.txt"))))