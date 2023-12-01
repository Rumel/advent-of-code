(ns problems.problem-08
  (:require [common.helpers :refer [input]]
            [clojure.string :as str]))

(defn parse-line [line]
  (map read-string (str/split line #"")))


(defn get-left [arr x y]
  (lazy-seq
   (if (= x 0) nil
       (cons (aget arr y (dec x)) (get-left arr (dec x) y)))))

(defn get-right [arr x y]
  (let [size (count (aget arr 0))]
    (lazy-seq
     (if (= x (dec size))
       nil
       (cons (aget arr y (inc x)) (get-right arr (inc x) y))))))

(defn get-up [arr x y]
  (lazy-seq
   (if (= y 0)
     nil
     (cons (aget arr (dec y) x) (get-up arr x (dec y))))))

(defn get-down [arr x y]
  (let [size (count arr)]
    (lazy-seq
     (if (= y (dec size))
       nil
       (cons (aget arr (inc y) x) (get-down arr x (inc y)))))))

(defn is-vible-side [item side]
  (if (empty? side)
    true
    (every? #(> item %) side)))

(defn is-visible [arr x y]
  (let [item (aget arr y x)
        left (get-left arr x y)
        right (get-right arr x y)
        up (get-up arr x y)
        down (get-down arr x y)]
    (or (is-vible-side item left)
        (is-vible-side item right)
        (is-vible-side item up)
        (is-vible-side item down))))

(defn visible-count [arr]
  (let [size (count arr)]
    (for [y (range 0 size)
          x (range 0 size)]
      (if (is-visible arr x y)
        1
        0))))

(defn visible-trees [elf-tree coll]
  (->> coll
       (reduce (fn [value t]
                 (cond
                   (< t elf-tree) (inc value)
                   (>= t elf-tree) (reduced (inc value))))
               0)))

(defn visible-score [arr x y]
  (let [item (aget arr y x)
        left (get-left arr x y)
        right (get-right arr x y)
        up (get-up arr x y)
        down (get-down arr x y)]
    (* (visible-trees item left)
       (visible-trees item right)
       (visible-trees item down)
       (visible-trees item up))))

(defn highest-view
  [arr]
  (let [size (count arr)]
    (for [y (range 0 size)
          x (range 0 size)]
      (visible-score arr x y))))

(defn parsed-input [file]
  (->> file
       input
       (map parse-line)))

(defn answer-a [file]
  (->> file
       parsed-input
       to-array-2d
       visible-count
       (reduce + 0)))

(defn answer-b [file]
  (->> file
       parsed-input
       to-array-2d
       highest-view
       (apply max)))

(defn answer []
  ;; Before lazy-seq
  ;; "Elapsed time: 3390.96475 msecs"
  ;; "Elapsed time: 4337.584125 msecs"
  ;; "Elapsed time: 4420.380708 msecs"
  ;; After lazy-seq
  ;; "Elapsed time: 850.893625 msecs"
  ;; "Elapsed time: 651.673083 msecs"
  ;; "Elapsed time: 716.397167 msecs"
  ;; 5.4x improvement
  (time (println "08: A:" (answer-a "data/problem-08-input.txt")))
  ;; Before lazy-seq
  ;; "Elapsed time: 4492.429333 msecs"
  ;; "Elapsed time: 6271.296375 msecs"
  ;; "Elapsed time: 6375.044709 msecs"
  ;; After lazy-seq
  ;; "Elapsed time: 702.930834 msecs"
  ;; "Elapsed time: 574.393375 msecs"
  ;; "Elapsed time: 696.346834 msecs"
  ;; 8.6x improvement
  (time (println "08: B:" (answer-b "data/problem-08-input.txt"))))