(ns problems.problem-21
  (:require [common.helpers :refer [input]]))

(defn parse-line
  [line]
  (let [[fm fk f1 ff f2] (re-matches #"(....): (....) (\+|\-|\/|\*) (....)" line)
        [_ nk n1] (re-matches #"(....): (\d+)" line)]
    (if (not (nil? fm))
      [fk {:f (case ff
                "*" *
                "/" /
                "-" -
                "+" +)
           :n1 f1
           :n2 f2}]
      [nk {:f nil :n1 (read-string n1)}])))

(defn parse-input
  [file]
  (->> file
       input
       (map parse-line)
       (into {})))

(defn dfs
  [graph k]
  (let [cur (graph k)]
    ;; (println cur)
    (if (nil? (cur :f))
      (cur :n1)
      ((cur :f) (dfs graph (cur :n1)) (dfs graph (cur :n2))))))

(defn answer-a
  [file]
  (let [graph (-> file
                  parse-input)]
    (dfs graph "root")))

(answer-a "data/problem-21-a.txt")

(defn answer-b [file] "Not implemented yet")

(defn answer []
  (println "21: A:" (answer-a "data/problem-21-input.txt"))
  (println "21: B:" (answer-b "data/problem-21-input.txt")))