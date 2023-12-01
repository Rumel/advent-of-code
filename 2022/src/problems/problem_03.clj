(ns problems.problem-03
  (:require [clojure.string :as str]
            [clojure.set :as set]))

(defn lines
  "Returns the lines of the file"
  [file]
  (->> (slurp file)
       (str/split-lines)))

(defn duplicate-char
  "Takes a string and returns the duplicate of the split of the string"
  [line]
  (let [n (/ (count line) 2)
        a (take n line)
        b (drop n line)]
    (first (set/intersection (set a) (set b)))))

(defn char-value
  "Converts a char to the value needed by the problem"
  [char]
  (let [value (int char)]
    (if (> value 90)
      (- value 96)
      (- value 38))))

(defn answer-a [file]
  (->> file
       lines
       (map #(duplicate-char %))
       (map #(char-value %))
       (reduce + 0)))

(defn common-item
  "Takes 3 strings and finds the common char"
  [[a b c]]
  (first (set/intersection (set a) (set b) (set c))))

(defn answer-b [file]
  (->> file
       lines
       (partition 3)
       (map #(common-item %))
       (map #(char-value %))
       (reduce + 0)))

(defn answer []
  (println "03: A:" (answer-a "data/problem-03-input.txt"))
  (println "03: B:" (answer-b "data/problem-03-input.txt")))