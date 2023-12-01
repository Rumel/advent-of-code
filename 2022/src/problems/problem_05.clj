(ns problems.problem-05
  (:require [common.helpers :refer [input]]
            [clojure.string :as str]))

(def matcher #"move (\d+) from (\d+) to (\d+)")

(defn update-crates [crates values]
  (reduce (fn [crates [stack value]]
            (if (= value \space)
              (conj crates stack)
              (conj crates (conj stack value)))) [] (map vector crates values)))

(defn input->crates [input]
  (let [reversed (reverse input)
        parsed (map (fn [line]
                      (take-nth 4 (drop 1 line))) reversed)
        crate-count (count (first parsed))
        crates (take crate-count (cycle [[]]))
        current-stack (drop 1 parsed)]
    (reduce (fn [crates stack]
              (update-crates crates stack))
            crates current-stack)))

(defn input->instructions [input]
  (map (fn [s]
         (let [[_ num from to] (re-matches matcher s)]
           (map read-string [num from to]))) input))

(defn parse-input [input]
  (let [crates (input->crates (take-while not-empty input))
        instructions (input->instructions (rest (drop-while not-empty input)))]
    [crates instructions]))

(defn execute-instruction
  [rev]
  (fn
    [crates instruction]
    (let [[times from to] instruction
          items (take-last times (crates (dec from)))
          items (if rev (reverse items) items)
          old-stack (drop-last times (crates (dec from)))
          new-stack (concat (crates (dec to)) items)]
      (reduce (fn [crates [index stack]]
                (if reverse
                  (assoc crates (dec index) stack)
                  (assoc crates (dec index) stack)))
              crates [[from old-stack] [to new-stack]]))))

(defn answer-a [file]
  (let [[crates instructions] (->> file
                                   input
                                   parse-input)]
    (->> (reduce (execute-instruction true) crates instructions)
         (map #(last %))
         (str/join))))

(defn answer-b [file]
  (let [[crates instructions] (->> file
                                   input
                                   parse-input)]
    (->> (reduce (execute-instruction false) crates instructions)
         (map #(last %))
         (str/join))))

(defn answer []
  (println "05: A:" (answer-a "data/problem-05-input.txt"))
  (println "05: B:" (answer-b "data/problem-05-input.txt")))