(ns problems.problem-09
  (:require [common.helpers :refer [input]]
            [clojure.string :as str]))

(defn point
  "Returns a point in the form of {:x 0 :y 0}"
  [x y]
  {:x x :y y})

(defn parsed-input
  [lines]
  (->> lines
       (map (fn [line]
              (let [split (str/split line #" ")]
                {:direction (split 0) :num (read-string (split 1))})))))

(defn move-direction
  "Move the head one space in the direction"
  [{:keys [knots] :as d} direction]
  (let [head (first knots)
        r (rest knots)
        new-head (case direction
                   "R" (point (inc (head :x)) (head :y))
                   "L" (point (dec (head :x)) (head :y))
                   "U" (point (head :x) (inc (head :y)))
                   "D" (point (head :x) (dec (head :y))))]
    (assoc d :knots (conj r new-head))))

(defn get-tail-position
  [diff {:keys [x y] :as current-tail}]
  (cond
    (= diff (point 2 0)) (point (inc x) y)
    (= diff (point 0 2)) (point x (inc y))
    (= diff (point -2 0)) (point (dec x) y)
    (= diff (point 0 -2)) (point x (dec y))
    (= diff (point 2 1)) (point (inc x) (inc y))
    (= diff (point 1 2)) (point (inc x) (inc y))
    (= diff (point -2 1)) (point (dec x) (inc y))
    (= diff (point 1 -2)) (point (inc x) (dec y))
    (= diff (point 2 -1)) (point (inc x) (dec y))
    (= diff (point -1 2)) (point (dec x) (inc y))
    (= diff (point -2 -1)) (point (dec x) (dec y))
    (= diff (point -1 -2)) (point (dec x) (dec y))
    (= diff (point -2 -2)) (point (dec x) (dec y))
    (= diff (point 2 2)) (point (inc x) (inc y))
    (= diff (point -2 2)) (point (dec x) (inc y))
    (= diff (point 2 -2)) (point (inc x) (dec y))
    :else current-tail))


(defn move-knot
  "Move the tail if necessary"
  [acc p]
  (if (empty? acc)
    (conj acc p)
    (let [prev (last acc)
          diff-x (- (prev :x) (p :x))
          diff-y (- (prev :y) (p :y))
          diff (point diff-x diff-y)]
      (conj acc (get-tail-position diff p)))))

(defn move-knots
  [{:keys [knots :tail-visited] :as d}]
  (let [knots (reduce move-knot [] knots)
        tail (last knots)
        tail-visited (conj tail-visited tail)]
    (assoc d :knots knots :tail-visited tail-visited)))

(defn process-instruction
  [d {:keys [direction num]}]
  (if (= num 0)
    d
    (-> d
        (move-direction direction)
        move-knots
        (process-instruction {:direction direction :num (dec num)}))))

(defn simulate
  "Simulate all the instructions"
  [knots instructions]
  (let [base (point 0 0)]
    (reduce
     process-instruction
     {:tail-visited #{base} :knots (take (inc knots) (cycle [base]))}
     instructions)))

(defn answer-a [file]
  (->> file
       input
       parsed-input
       (simulate 1)
       :tail-visited
       count))

(defn answer-b [file]
  (->> file
       input
       parsed-input
       (simulate 9)
       :tail-visited
       count))

(defn answer []
  (println "09: A:" (answer-a "data/problem-09-input.txt"))
  (println "09: B:" (answer-b "data/problem-09-input.txt")))