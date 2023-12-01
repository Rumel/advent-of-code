(ns problems.problem-06-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-06 :refer
             [answer-a
              answer-b
              packet-index]]))

(deftest packet-index-test
  (is (= 7 (packet-index 4 "mjqjpqmgbljsphdztnvjfqwrcgsmlb")))
  (is (= 5 (packet-index 4 "bvwbjplbgvbhsrlpgdmjqwftvncz")))
  (is (= 6 (packet-index 4 "nppdvjthqldpwncqszvftbrmjlhg")))
  (is (= 10 (packet-index 4 "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")))
  (is (= 11 (packet-index 4 "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")))
  (is (= 19 (packet-index 14 "mjqjpqmgbljsphdztnvjfqwrcgsmlb")))
  (is (= 23 (packet-index 14 "bvwbjplbgvbhsrlpgdmjqwftvncz")))
  (is (= 23 (packet-index 14 "nppdvjthqldpwncqszvftbrmjlhg")))
  (is (= 29 (packet-index 14 "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")))
  (is (= 26 (packet-index 14 "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"))))

(deftest answer-a-test
  (is (= 7 (answer-a "data/problem-06-a.txt")))
  (is (= 1093 (answer-a "data/problem-06-input.txt"))))

(deftest answer-b-test
  (is (= 19 (answer-b "data/problem-06-a.txt")))
  (is (= 3534 (answer-b "data/problem-06-input.txt"))))