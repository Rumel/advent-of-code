(ns problems.problem-12
  (:require [clojure.string :as str]
            [common.helpers :refer [debug input]]))

(defn get-value
  [s]
  (case s
    "S" 0
    "E" 25
    (-> s
        char-array
        first
        int
        (- 97))))

(defn get-edges
  [x y x-bound y-bound]
  (let [additions [[0 1] [0 -1] [1 0] [-1 0]]]
    (filter some?
            (map (fn [[add-x add-y]]
                   (let [new-x (+ x add-x)
                         new-y (+ y add-y)]
                     (if (and (< new-x x-bound)
                              (< new-y y-bound)
                              (>= new-x 0)
                              (>= new-y 0))
                       [new-x new-y]
                       nil)))
                 additions))))

(defn build-graph
  [lines]
  (let [y-size (count lines)
        x-size (count (first lines))]
    (reduce
     (fn [d y]
       (reduce
        (fn [d x]
          (let [value (nth (nth lines y) x)
                m {:visited false
                   :starting (= value "S")
                   :ending (= value "E")
                   :value (get-value value)
                   :original-value value
                   :edges (get-edges x y x-size y-size)}]
            (assoc d [x y] m)))
        d
        (range 0 x-size)))
     {}
     (range 0 y-size))))

(defn parse-input
  [file]
  (->> file
       input
       (map (fn [line] (str/split line #"")))
       build-graph))

(defn allowed-edges
  [points current-height edges]
  (filter
   (fn [edge]
     (let [p (points edge)
           visited (p :visited)
           value (p :value)]
       (if (and (not visited)
                (<= value (inc current-height)))
         true
         false))) edges))

(defn bfs-
  [g i]
  (let [queue (g :queue)
        points (g :points)]
    (if (empty? queue)
      points
      (let [result
            (reduce
             (fn
               [{:keys [points] :as d} point]
               (if (true? (get-in points [point :visited]))
                 d
                 (let [point-height (get-in d [:points point :value])
                       d (-> (assoc-in d [:points point :visited] true)
                             (assoc-in [:points point :steps] i))
                       point-edges (get-in points [point :edges])]
                   (update-in
                    d
                    [:next-queue]
                    concat
                    (allowed-edges (d :points) point-height point-edges)))))
             {:points points :next-queue []}
             queue)]
        (bfs- {:points (result :points) :queue (result :next-queue)} (inc i))))))

(defn bfs
  [graph]
  (let [starting-node (ffirst (filter #(true? ((second %) :starting)) graph))
        g {:queue [starting-node] :points graph}]
    (bfs- g 0)))

(defn print-ending
  [graph]
  (->> graph
       (filter (fn [[_k v]]
                 (v :ending)))
       first
       second
       :steps))

(defn answer-a
  [file]
  (-> file
      parse-input
      bfs
      print-ending))

(defn answer-b
  [file]
  "Not implemented yet")

(defn answer []
  (println "12: A:" (answer-a "data/problem-12-input.txt"))
  (println "12: B:" (answer-b "data/problem-12-input.txt")))