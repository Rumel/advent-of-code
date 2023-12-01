(ns problems.problem-14-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-14
             :refer
             [answer-a
              answer-b
              update-horizontal-bounds
              update-vertical-bounds
              waterfall-graph]]))

(def waterfall-graph-with-data
  (assoc waterfall-graph :x1 2 :x2 5 :y1 2 :y2 5))
(deftest update-horizontal-bounds-test
  (is (= 5 ((update-horizontal-bounds waterfall-graph 5) :x1)))
  (is (= 5 ((update-horizontal-bounds waterfall-graph 5) :x2)))
  (is (= 1 ((update-horizontal-bounds waterfall-graph-with-data 1) :x1)))
  (is (= 5 ((update-horizontal-bounds waterfall-graph-with-data 1) :x2)))
  (is (= 2 ((update-horizontal-bounds waterfall-graph-with-data 3) :x1)))
  (is (= 5 ((update-horizontal-bounds waterfall-graph-with-data 3) :x2)))
  (is (= 2 ((update-horizontal-bounds waterfall-graph-with-data 6) :x1)))
  (is (= 6 ((update-horizontal-bounds waterfall-graph-with-data 6) :x2))))

(deftest update-vertical-bounds-test
  (is (= 5 ((update-vertical-bounds waterfall-graph 5) :y2)))
  (is (= 5 ((update-vertical-bounds waterfall-graph-with-data 1) :y2)))
  (is (= 5 ((update-vertical-bounds waterfall-graph-with-data 3) :y2)))
  (is (= 6 ((update-vertical-bounds waterfall-graph-with-data 6) :y2))))

(deftest answer-a-test
  (is (= 24 (answer-a "data/problem-14-a.txt"))))

(deftest answer-b-test
  (is (= 93 (answer-b "data/problem-14-a.txt"))))