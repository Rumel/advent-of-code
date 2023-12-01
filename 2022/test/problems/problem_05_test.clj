(ns problems.problem-05-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-05 :refer
             [answer-a
              answer-b
              matcher
              update-crates]]))

(deftest update-crates-test
  (is (= [[\A] [\M] []] (update-crates [[] [] []] [\A \M \space])))
  (is (= [[] [] []] (update-crates [[] [] []] [\space \space \space])))
  (is (= [[\A \A] [\Z \M] [\D]] (update-crates [[\A] [\Z] []] [\A \M \D]))))

(deftest matcher-test
  (is (= ["move 1 from 2 to 1" "1" "2" "1"] (re-matches matcher "move 1 from 2 to 1")))
  (is (= ["move 15 from 3 to 9" "15" "3" "9"] (re-matches matcher "move 15 from 3 to 9"))))

(deftest answer-a-test
  (is (= "CMZ" (answer-a "data/problem-05-a.txt")))
  (is (= "CVCWCRTVQ" (answer-a "data/problem-05-input.txt"))))

(deftest answer-b-test
  (is (= "MCD" (answer-b "data/problem-05-a.txt")))
  (is (= "CNSCZWLVT" (answer-b "data/problem-05-input.txt"))))