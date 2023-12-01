(ns problems.problem-14
  (:require [clojure.string :as str]
            [common.helpers :refer [input]]))

(def waterfall-graph
  {:x1 nil
   :x2 nil
   :y1 0
   :y2 nil
   :finished false
   :sand-count 0
   :points {}})

(defn print-board
  [graph]
  (let [x1 (- (graph :x1) 1)
        x2 (+ 1 (graph :x2))
        y1 (- (graph :y1) 1)
        y2 (+ 1 (graph :y2))
        marks (for [y (range y1 (inc y2))
                    x (range x1 (inc x2))]
                (let [value (get-in graph [:points [x y]])]
                  (if (not (nil? value))
                    value
                    ".")))
        length (inc (- x2 x1))]
    (println "Board")
    (println (str "X: " x1 "-" x2))
    (println (str "Y: " y1 "-" y2))
    (println "Sand:" (graph :sand-count))
    (->> marks
         (partition length)
         (map #(str/join "" %))
         (str/join "\n")
         println)
    ;; Return graph so I can drop this in wherever 
    graph))

(defn parsed-input
  [file]
  (let [lines (->> file
                   input)
        lines (map #(str/split % #" -> ") lines)
        convert-to-x-y (fn [el]
                         (let [[x y] (str/split el #",")]
                           [(read-string x) (read-string y)]))
        lines (map #(map convert-to-x-y %) lines)]
    lines))

(defn update-horizontal-bounds
  [graph x]
  (let [x1 (graph :x1)
        x2 (graph :x2)]
    (cond
      (and (nil? x1) (nil? x2)) (assoc graph :x1 x :x2 x)
      (< x x1) (assoc graph :x1 x)
      (> x x2) (assoc graph :x2 x)
      :else graph)))

(defn update-vertical-bounds
  [graph y]
  (let [y2 (graph :y2)]
    (cond
      (nil? y2) (assoc graph :y2 y)
      (> y y2) (assoc graph :y2 y)
      :else graph)))

(defn add-rock
  [graph x y]
  (assoc-in graph [:points [x y]] "#"))

(defn add-horizontal-line
  [graph y x1 x2]
  (let [[lowx highx] (if (< x1 x2)
                       [x1 x2]
                       [x2 x1])]
    (reduce (fn [g x]
              (add-rock g x y)) graph (range lowx (inc highx)))))

(defn add-vertical-line
  [graph x y1 y2]
  (let [[lowy highy] (if (< y1 y2)
                       [y1 y2]
                       [y2 y1])]
    (reduce (fn [g y]
              (add-rock g x y)) graph (range lowy (inc highy)))))


(defn add-rock-part
  [graph [[ax ay] [bx by]]]
  (let [graph (-> graph
                  (update-horizontal-bounds ax)
                  (update-horizontal-bounds bx)
                  (update-vertical-bounds by)
                  (update-vertical-bounds by))]
    (if (= ax bx)
      (add-vertical-line graph ax ay by)
      (add-horizontal-line graph ay ax bx))))

(defn add-rocks
  "Add all rocks '#' to the graph"
  [graph line]
  (let [pairs (partition 2 1 line)]
    (reduce add-rock-part graph pairs)))

(defn build-graph
  [lines]
  (let [graph waterfall-graph]
    (reduce add-rocks graph lines)))

(defn drop-grain
  [graph]
  (let [result (loop [x 500
                      y 0]
                 (cond
                   (>= y (graph :y2))
                   (assoc graph :finished true)

                   (nil? (get-in graph [:points [x (inc y)]]))
                   (recur x (inc y))

                   (nil? (get-in graph [:points [(- x 1) (inc y)]]))
                   (recur (- x 1) (inc y))

                   (nil? (get-in graph [:points [(+ x 1) (inc y)]]))
                   (recur (+ x 1) (inc y))

                   (and (= x 500) (= y 0))
                   (-> graph
                       (update :sand-count inc)
                       (assoc :finished true)
                       (assoc-in [:points [x y]] "o"))

                   :else (-> graph
                             (update :sand-count inc)
                             (assoc-in [:points [x y]] "o"))))]
    ;; (if (= 0 (mod (result :sand-count) 50))
    ;;   (print-board result))
    result))

(update waterfall-graph :sand-count inc)

(defn fill-with-sand
  [graph]
  (loop [graph graph]
    (if (graph :finished)
      graph
      (recur (drop-grain graph)))))

(defn add-floor
  [graph]
  (let [y (graph :y2)
        yfloor (+ 2 y)
        x1 (- 500 yfloor)
        x2 (+ 500 yfloor)]
    (-> graph
        (update-horizontal-bounds x1)
        (update-horizontal-bounds x2)
        (update-vertical-bounds yfloor)
        (add-horizontal-line yfloor x1 x2))))

(defn answer-a
  [file]
  (->> file
       parsed-input
       build-graph
       fill-with-sand
      ;;  print-board
       :sand-count))

(defn answer-b
  [file]
  (->> file
       parsed-input
       build-graph
       add-floor
       fill-with-sand
      ;;  print-board
       :sand-count))

(defn answer []
  (println "14: A:" (answer-a "data/problem-14-input.txt"))
  (println "14: B:" (answer-b "data/problem-14-input.txt")))