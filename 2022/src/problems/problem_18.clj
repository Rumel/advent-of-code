(ns problems.problem-18
  (:require [clojure.set :as set]
            [clojure.string :as str]
            [common.helpers :refer [debug input]]))

(def lava {:points {}})

(defn parse-input
  [file]
  (->> file
       input
       (map #(str/split % #","))
       (map (fn [s]
              (map read-string s)))))

(defn adjacent-points
  [[x y z]]
  (map
   (fn [[x1 y2 z2]]
     [(+ x x1) (+ y y2) (+ z z2)])
   [[1 0 0],[-1 0 0],[0 1 0],[0 -1 0],[0 0 1],[0 0 -1]]))

(defn reduce-visibility
  [lava point adjacent]
  (reduce (fn [lava ap]
            (if (get-in lava [:points ap])
              (-> lava
                  (update-in [:points ap :visibility] dec)
                  (update-in [:points point :visibility] dec))
              lava)) lava adjacent))

(defn build-lava
  [lava input]
  (reduce
   (fn [lava cube]
     (let [lava (assoc-in lava [:points cube] {:visibility 6})
           adjacent-points (adjacent-points cube)]
       (reduce-visibility lava cube adjacent-points)))
   lava
   input))

(defn answer-a
  [file]
  (let [lava-graph (->> file
                        parse-input
                        (build-lava lava))]
    ;; (pprint lava-graph)
    (reduce + (map #((second %) :visibility) (lava-graph :points)))))

(defn max-distance
  [graph]
  (->> (get graph :points)
       keys
       flatten
       (apply max)
       inc))

(defn min-distance
  [graph]
  (->> (get graph :points)
       keys
       flatten
       (apply min)
       dec))

(defn visit-point
  [graph point visited ff]
  (let [points (adjacent-points point)
        points (filter ff points)
        unvisited-points (set (filter #(not (visited %)) points))
        in-graph (set (filter #(get-in graph [:points %]) unvisited-points))]
    [#{point} (count in-graph) (clojure.set/difference unvisited-points in-graph)]))

(defn bfs
  [graph point]
  (let [max-d (max-distance graph)
        min-d (min-distance graph)
        filter-func (fn [[x y z]]
                      (and (>= x min-d)
                           (>= y min-d)
                           (>= z min-d)
                           (<= x max-d)
                           (<= y max-d)
                           (<= z max-d)))]
    (loop [visited #{}
           queue #{point}
           total 0]
      (if (empty? queue)
        total
        (let [[new-visited add-total add-queue] (visit-point graph (first queue) visited filter-func)]
          (recur
           (set/union visited new-visited)
           (set/union (set (rest queue)) add-queue)
           (+ total add-total)))))))

(defn answer-b
  [file]
  (let [lava-graph (->> file
                        parse-input
                        (build-lava lava))]
    (bfs lava-graph [0 0 0])))

(defn answer []
  (println "18: A:" (answer-a "data/problem-18-input.txt"))
  (println "18: B:" (answer-b "data/problem-18-input.txt")))