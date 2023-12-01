(ns problems.problem-02
  (:require [clojure.string :as str]))

(defn read-file
  [file]
  (->> file
       slurp
       str/split-lines
       (map #(str/split % #" "))))

(def throw-score {"X" 1 "Y" 2 "Z" 3})

(def hand-result
  {"A" {"X" 3 "Y" 6 "Z" 0}
   "B" {"X" 0 "Y" 3 "Z" 6}
   "C" {"X" 6 "Y" 0 "Z" 3}})

;; X need to lose
;; Y need to draw
;; Z need to win
(def needed-throw
  {"A" {"X" "Z" "Y" "X" "Z" "Y"}
   "B" {"X" "X" "Y" "Y" "Z" "Z"}
   "C" {"X" "Y" "Y" "Z" "Z" "X"}})

(defn get-hand-score-a
  [[h1 h2]]
  (+ (throw-score h2) (get-in hand-result [h1 h2])))

(defn get-hand-score-b
  [[h1 h2]]
  (let [thrown (get-in needed-throw [h1 h2])]
    (+ (throw-score thrown) (get-in hand-result [h1 thrown]))))

(defn get-score-a
  [hands]
  (->> hands
       (map get-hand-score-a)
       (reduce + 0)))

(defn get-score-b
  [hands]
  (->> hands
       (map get-hand-score-b)
       (reduce + 0)))

(defn answer-a
  [file]
  (-> file
      read-file
      get-score-a))

(defn answer-b
  [file]
  (-> file
      read-file
      get-score-b))

(defn answer []
  (println "02: A:" (answer-a "data/problem-02-input.txt"))
  (println "02: B:" (answer-b "data/problem-02-input.txt")))