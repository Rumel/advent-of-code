(ns problems.problem-03-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-03 :refer
             [answer-a
              answer-b
              char-value
              duplicate-char]]))

(deftest duplicate-char-test
  (is (= \p (duplicate-char "vJrwpWtwJgWrhcsFMMfFFhFp")))
  (is (= \L (duplicate-char "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL")))
  (is (= \P (duplicate-char "PmmdzqPrVvPwwTWBwg")))
  (is (= \v (duplicate-char "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn")))
  (is (= \t (duplicate-char "ttgJtRGJQctTZtZT")))
  (is (= \s (duplicate-char "CrZsJsPPZsGzwwsLwLmpwMDw"))))

(deftest char-value-test
  (is (= 1 (char-value \a)))
  (is (= 26 (char-value \z)))
  (is (= 27 (char-value \A)))
  (is (= 52 (char-value \Z))))

(deftest answer-a-test
  (is (=  157 (answer-a "data/problem-03-a.txt"))))

(deftest answer-b-test
  (is (=  "Not implemented yet" (answer-b "data/problem-03-a.txt"))))