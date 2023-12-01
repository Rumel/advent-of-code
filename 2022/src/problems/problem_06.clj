(ns problems.problem-06
  (:require [common.helpers :refer [input]]))

(defn packet-index [n s]
  (reduce (fn [index value]
            (if (= n (count (set value)))
              (reduced index)
              (inc index)))
          n
          (partition n 1 s)))

(defn answer-a [file]
  (->> file
       input
       first
       (packet-index 4)))

(defn answer-b [file]
  (->> file
       input
       first
       (packet-index 14)))

(defn answer []
  (println "06: A:" (answer-a "data/problem-06-input.txt"))
  (println "06: B:" (answer-b "data/problem-06-input.txt")))