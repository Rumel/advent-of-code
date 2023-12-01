(ns problems.problem-17
  (:require [clojure.string :as str]
            [common.helpers :refer [input]]))

(def board
  {:highest-point 0
   :rocks {[0 0] true
           [1 0] true
           [2 0] true
           [3 0] true
           [4 0] true
           [5 0] true
           [6 0] true
           [7 0] true}
   :jets []})

(defn parse-input
  [file]
  (let [split (-> file
                  input
                  first
                  (str/split #""))]
    (->> split
         (map #(if (= % "<") :left :right)))))

(def line [[0 0] [1 0] [2 0] [3 0]])
(def plus [[0 1] [1 0] [1 1] [1 2] [2 1]])
(def end [[0 0] [1 0] [2 0] [2 1] [2 2]])
(def tall-line [[0 0] [0 1] [0 2] [0 3]])
(def square [[0 0] [1 0] [0 1] [1 1]])
(def rock-cycle (cycle [line plus end tall-line square]))

(defn valid-rock?
  [board rock]
  (let [available-space (every? nil? (map (fn [point]
                                            (get-in board [:rocks point])) rock))
        in-bounds (every? (fn [[x _]]
                            (and (<= 1 x) (>= 7 x))) rock)]
    (and available-space in-bounds)))

(defn move-left
  [board rock]
  (let [new-rock
        (map (fn [[x y]]
               [(- x 1) y]) rock)]
    (if (valid-rock? board new-rock)
      new-rock
      rock)))

(defn move-right
  [board rock]
  (let [new-rock (map (fn [[x y]]
                        [(+ x 1) y]) rock)]
    (if (valid-rock? board new-rock)
      new-rock
      rock)))

(defn move-down
  [board rock]
  (let [new-rock (map (fn [[x y]]
                        [x (- y 1)]) rock)]
    (if (valid-rock? board new-rock)
      new-rock
      rock)))

(defn create-rock
  [board rock]
  (let [[x+ y+] [3 (+ 4 (board :highest-point))]]
    (map (fn [[x y]]
           [(+ x x+) (+ y y+)]) rock)))

(defn add-rock
  [board rock]
  (let [high-points (map #(second %) rock)
        m (apply max high-points)
        current-highest (get board :highest-point)
        new-max (max m current-highest)]
    (-> (reduce (fn [board point]
                  (assoc-in board [:rocks point] true)) board rock)
        (assoc :highest-point new-max))))

(defn drop-rock
  [board rock]
  (let [rock (create-rock board rock)]
    (loop [board board
           current-rock rock]
      (let [current-rock current-rock
            jets (get board :jets)
            direction (first jets)
            jet-rock (if (= direction :left)
                       (move-left board current-rock)
                       (move-right board current-rock))
            down-rock (move-down board jet-rock)
            resting-rock (= jet-rock down-rock)
            board (assoc board :jets (rest jets))]
        (if resting-rock
          (-> board
              (add-rock down-rock))
          (recur board down-rock))))))

(defn drop-rocks
  [board rocks]
  (loop [board board
         rocks rocks]
    (if (nil? (first rocks))
      board
      (recur
       (-> board
           (drop-rock (first rocks))) (rest rocks)))))

(defn print-board
  [board]
  (let [highest (get board :highest-point)
        values (for [y (reverse (range 1 (inc highest)))
                     x (range 1 8)]
                 (if (get-in board [:rocks [x y]])
                   "#"
                   "."))]
    (->> values
         (partition 7)
         (map #(str/join "" %))
         (str/join "\n")
         println)))

(defn answer-a
  [file]
  (let [jets (-> file
                 parse-input)
        board (-> board
                  (assoc :jets (cycle jets)))
        rock-drops 2022
        board (drop-rocks board (take rock-drops rock-cycle))
        highest-point (board :highest-point)]
    ;; (print-board board)
    highest-point))

(defn answer-b
  [file]
  "Not implemented yet")

(defn answer []
  (println "17: A:" (answer-a "data/problem-17-input.txt"))
  (println "17: B:" (answer-b "data/problem-17-input.txt")))