(ns problems.problem-10
  (:require [clojure.string :as str]
            [common.helpers :refer [input]]))

(defn parse-line [line]
  (let [noop-match (re-matches #"noop" line)
        addx-match (re-matches #"addx (-?\d+)" line)]
    (cond
      (= false (nil? noop-match)) {:instruction :noop :data nil}
      (= false (nil? addx-match)) {:instruction :addx :data (read-string (addx-match 1))}
      :else {:instruction :fail :data nil})))

(defn parsed-input [file]
  (->> file
       input
       (map parse-line)))

(defn get-pixel [cycle register]
  (let [index (mod (dec cycle) 40)]
    (println "Cycle: " cycle " Mod: " index " Register: " register)
    (if (nil? (#{(dec register) register (inc register)} index))
      "."
      "#")))

(defn cycle-cpu [d]
  (let [cycle (d :cycle)
        print-out (d :print-out)
        register-x (d :register-x)
        pixel (get-pixel cycle register-x)]
    (if (not (nil? (#{20 60 100 140 180 220} cycle)))
      (let [results (d :results)]
        (assoc d :cycle (inc cycle) :results (conj results (* register-x cycle)) :print-out (conj print-out pixel)))
      (assoc d :cycle (inc cycle) :print-out (conj print-out pixel)))))

(defn addx [acc n]
  (-> acc
      cycle-cpu
      cycle-cpu
      ((fn [d]
         (let [register-x (acc :register-x)]
           (assoc d :register-x (+ register-x n)))))))

(defn process-instructions [instructions]
  (reduce (fn [acc instruction]
            (cond
              (= :noop (instruction :instruction)) (cycle-cpu acc)
              (= :addx (instruction :instruction)) (addx acc (instruction :data))
              :else acc))
          {:cycle 1 :results [] :register-x 1 :print-out []}
          instructions))

(defn print-result [characters]
  (let [rows (partition 40 characters)]
    (str "\n" (str/join "\n" (map #(str/join "" %) rows)))))

(defn answer-a [file]
  (->> file
       parsed-input
       process-instructions
       :results
       (apply +)))

(defn answer-b [file]
  (->> file
       parsed-input
       process-instructions
       :print-out
       print-result))

(defn answer []
  (println "10: A:" (answer-a "data/problem-10-input.txt"))
  (println "10: B:" (answer-b "data/problem-10-input.txt")))