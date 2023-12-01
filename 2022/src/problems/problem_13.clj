(ns problems.problem-13
  (:require [common.helpers :refer [input]]))

(defn parsed-input
  "Transforms the input to something like this:
([0 ([1 1 3 1 1] [1 1 5 1 1])]
 [1 ([[1] [2 3 4]] [[1] 4])]
 [2 ([9] [[8 7 6]])]
 [3 ([[4 4] 4 4] [[4 4] 4 4 4])]
 [4 ([7 7 7 7] [7 7 7])]
 [5 ([] [3])]
 [6 ([[[]]] [[]])]
 [7 ([1 [2 [3 [4 [5 6 7]]]] 8 9] [1 [2 [3 [4 [5 6 0]]]] 8 9])])
"
  [file]
  (->> file
       input
       (map #(if (empty? %) nil %))
       (filter #((comp not nil?) %))
       (map read-string)))

(defn is-long?
  [l]
  (= java.lang.Long (class l)))

(defn is-list?
  [l]
  (= clojure.lang.PersistentVector (class l)))

(defn correct-packets?
  [a b]
  (loop [af (first a)
         ar (rest a)
         bf (first b)
         br (rest b)]
    (cond
      (and (nil? af)
           (nil? bf))
      :next

      (nil? af)
      true

      (nil? bf)
      false

      (and (true? (is-long? af))
           (true? (is-long? bf)))
      (if (= af bf)
        (recur (first ar) (rest ar) (first br) (rest br))
        (if (< af bf)
          true
          false))

      (and (true? (is-long? af))
           (true? (is-list? bf)))
      (let [result (correct-packets? [af] bf)]
        (if (= result :next)
          (recur (first ar) (rest ar) (first br) (rest br))
          result))


      (and (true? (is-list? af))
           (true? (is-long? bf)))
      (let [result (correct-packets? af [bf])]
        (if (= result :next)
          (recur (first ar) (rest ar) (first br) (rest br))
          result))


      (and (true? (is-list? af))
           (true? (is-list? bf)))
      (if (and (= af [])
               (= bf []))
        (recur (first ar) (rest ar) (first br) (rest br))
        (let [result (correct-packets? af bf)]
          (if (= result :next)
            (recur (first ar) (rest ar) (first br) (rest br))
            result))))))


(defn indices-sum
  [lines]
  (reduce
   (fn [sum line]
     (let [index (inc (first line))
           [packet-a packet-b] (second line)]
       (if (correct-packets? packet-a packet-b)
         (+ sum index)
         sum)))
   0
   lines))

(defn find-indices
  [lines]
  (let [indexed (map-indexed
                 (fn [i line]
                   [(inc i) line])
                 lines)
        finder (fn [x]
                 (filter #(= x (second %)) indexed))
        two-index (ffirst (finder [[2]]))
        six-index (ffirst (finder [[6]]))]
    (* two-index six-index)))

(defn answer-a
  [file]
  (->> file
       parsed-input
       (partition 2)
       (map-indexed #(identity [%1 %2]))
       indices-sum))

(defn sorter
  [a b]
  (let [result (correct-packets? a b)]
    (if (= result :next)
      true
      result)))

(defn answer-b
  [file]
  (->> file
       parsed-input
       (concat [[[2]]] [[[6]]])
       (sort sorter)
       (find-indices)))

(defn answer []
  (println "13: A:" (answer-a "data/problem-13-input.txt"))
  (println "13: B:" (answer-b "data/problem-13-input.txt")))