(ns problems.problem-01
  "Day 1: Calorie Counting
   
   Problem: https://adventofcode.com/2022/day/1"
  (:require [clojure.string :as str]))

(defn get-calorie-totals
  "Take the elves calories and get the total per elf"
  [calories]
  (map #(reduce + %) calories))

(defn max-calories
  "Return the max calories"
  [calories]
  (apply max calories))

(defn str->int
  "Convert string to num or return nil if empty"
  [s]
  (if (empty? s)
    nil
    (read-string s)))

(defn s->seq
  "Convert string to sequence"
  [s]
  (let [split (str/split s #"\n")]
    (->> split
         (map str->int)
         (partition-by nil?)
         (take-nth 2))))

(defn top-three-calories
  "Return a vector of the top 3 calorie counts"
  [calorie-counts]
  (take 3 (sort > calorie-counts)))

(defn answer-a
  "Read the elves' calories and return the max elf's calories"
  [file]
  (-> file
      slurp
      s->seq
      get-calorie-totals
      max-calories))

(defn answer-b
  "Read the elves' calories and return the max elf's calories"
  [file]
  (-> file
      slurp
      s->seq
      get-calorie-totals
      top-three-calories
      (as-> calories (reduce + calories))))

(defn answer []
  (println "01: A:" (answer-a "data/problem-01-input.txt"))
  (println "01: B:" (answer-b "data/problem-01-input.txt")))