(ns problems.problem-22
  (:require [common.helpers :refer [input debug]]
            [clojure.string :as str]))

(defn add-points
  [board split y]
  (reduce
   (fn [board [index value]]
     (if (= value " ")
       board
       (assoc-in board [:points [index y]] value)))
   board
   split))

(defn build-board
  [lines]
  (let [y (count lines)
        x (apply max (map count lines))
        board {:max-x x :max-y y :points {}}
        lines (map-indexed (fn [index item]
                             [(inc index) item]) lines)]
    (reduce
     (fn [board [y-index line]]
       (let [split (str/split line #"")
             split (concat split (take (- x (count split)) (cycle [" "])))
             split (map-indexed
                    (fn [index item]
                      [(inc index) item])
                    split)]
         (add-points board split y-index)))
     board
     lines)))

(defn print-board
  [board]
  (let [values (for [y (range 1 (inc (board :max-y)))
                     x (range 1 (inc (board :max-x)))]
                 (let [point (get-in board [:points [x y]])]
                   (if (nil? point)
                     " "
                     point)))]
    (->> values
         (partition (board :max-x))
         (map #(str/join "" %))
         (str/join "\n")
         println)
    board))

(defn parse-instructions
  [line]
  (let [matches (re-seq #"(\d+)|(L|R)" line)]
    (reduce
     (fn [acc [v _ _]]
       (conj acc
             (if (or (= v "L")
                     (= v "R"))
               {:turn v
                :distance nil}
               {:turn nil
                :distance (read-string v)})))
     []
     matches)))

(defn parse-input
  [file]
  (let [lines (-> file
                  input)
        board-lines (drop-last 2 lines)
        board (build-board board-lines)
        instruction-line (take-last 1 lines)
        instructions (parse-instructions (first instruction-line))]
    [instructions board]))

(defn starting-point
  [board]
  (let [m (->> (board :points)
               (filter #(= (second (first %)) 1))
               (map #(first (first %)))
               (apply min))]
    [m 1]))

(defn change-direction
  [current-direction turn]
  (case [current-direction turn]
    ["E" "L"] "N"
    ["E" "R"] "S"
    ["S" "L"] "E"
    ["S" "R"] "W"
    ["W" "L"] "S"
    ["W" "R"] "N"
    ["N" "L"] "W"
    ["N" "R"] "E"
    current-direction))

(defn next-valid-move
  [board [cur-x cur-y] [dir-x dir-y]]
  (let [points (board :points)]
    (loop [temp-x (+ cur-x dir-x)
           temp-y (+ cur-y dir-y)]
      (cond
        (= (points [temp-x temp-y]) ".") [temp-x temp-y]
        (= (points [temp-x temp-y]) "#") [cur-x cur-y]
        (< temp-x 1) (recur (board :max-x) temp-y)
        (< temp-y 1) (recur temp-x (board :max-y))
        (> temp-x (board :max-x)) (recur 1 temp-y)
        (> temp-y (board :max-y)) (recur temp-x 1)
        (= (points [temp-x temp-y]) nil) (recur (+ temp-x dir-x) (+ temp-y dir-y))
        :else [cur-x cur-y]))))

(defn apply-move
  [board [x y] direction]
  (let [points (board :points)
        [x2 y2] (case direction
                  "N" [0 -1]
                  "E" [1 0]
                  "S" [0 1]
                  "W" [-1 0]
                  [0 0])]
    (cond
      (= (points [(+ x x2) (+ y y2)]) ".") [(+ x x2) (+ y y2)]
      (= (points [(+ x x2) (+ y y2)]) "#") [x y]
      (= (points [(+ x x2) (+ y y2)]) nil) (next-valid-move board [x y] [x2 y2])
      :else [x y])))

(defn move
  [board current direction distance]
  (reduce
   (fn [cur _]
     (let [new-move (apply-move board cur direction)]
       (if (= new-move cur)
         (reduced cur)
         new-move)))
   current
   (range 0 distance)))

(defn process-instructions
  [board instructions starting-point direction]
  (reduce
   (fn [[current direction] instruction]
     (let [{distance :distance turn :turn} instruction]
       (if (nil? distance)
         (let [new-direction (change-direction direction turn)]
           [current new-direction])
         (let [new-current (move board current direction distance)]
           [new-current direction]))))
   [starting-point direction]
   instructions))

(defn answer-a
  [file]
  (let [[instructions board] (-> file
                                 parse-input)
        starting-point (starting-point board)
        [[ending-x ending-y] direction] (process-instructions board instructions starting-point "E")]
    (+ (* 1000 ending-y) (* 4 ending-x) (case direction
                                          "E" 0
                                          "S" 1
                                          "W" 2
                                          "N" 3
                                          0))))

(defn answer-b
  [file]
  "Not implemented yet")

(defn answer []
  (println "22: A:" (answer-a "data/problem-22-input.txt"))
  (println "22: B:" (answer-b "data/problem-22-a.txt")))