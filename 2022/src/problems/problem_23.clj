(ns problems.problem-23
  (:require [clojure.set :as set]
            [clojure.string :as str]
            [common.helpers :refer [input]]))

(defn map-item [index item] [index item])

(defn map-elves
  [elves [y line]]
  (let [split (str/split line #"")
        indexed-split (map-indexed map-item split)]
    (reduce (fn [elves [x item]]
              (if (= item "#")
                (assoc elves [x y] true)
                elves)) elves indexed-split)))

(defn parse-input
  [file]
  (->> file
       input
       (map-indexed map-item)
       (reduce map-elves {})))

(def all-directions [[-1 -1] [0 -1] [1 -1] [-1 0] [1 0] [-1 1] [0 1] [1 1]])

(defn empty-all-directions?
  [elves [x y] directions]
  (->> directions
       (map (fn [[x2 y2]]
              (nil? (elves [(+ x x2) (+ y y2)]))))
       (every? true?)))

(def directions
  (cycle
   [["N" [0 -1] [[-1 -1] [0 -1] [1 -1]]] ;; N
    ["S" [0 1]  [[-1 1] [0 1] [1 1]]] ;; S
    ["W" [-1 0] [[-1 -1] [-1 0] [-1 1]]] ;; W
    ["E" [1 0] [[1 -1] [1 0] [1 1]]]])) ;; E


(defn get-proposed-direction
  [elves [elf-x elf-y :as elf] directions]
  (if (or (nil? elf) (nil? (elves elf)))
    [nil nil nil]
    (reduce
     (fn [result [named-direction [move-x move-y] directions]]
       (if (empty-all-directions? elves elf directions)
         (reduced [named-direction [(+ elf-x move-x) (+ elf-y move-y)] [(+ elf-x (* 2 move-x)) (+ elf-y (* 2 move-y))]])
         result))
     ["X" elf nil]
     directions)))

(defn elf-movement
  [{:keys [current-elves directions] :as d} [elf _]]
  (let [should-move (not (empty-all-directions? current-elves elf all-directions))]
    (if (not should-move)
      (do (comment (println "Not moving: " elf))
          (update d :non-moving-elves conj elf))
      (let [[named-direction proposed-point elf-check] (get-proposed-direction current-elves elf directions)
            elf-check-point (if (and elf-check (not (empty-all-directions? current-elves elf-check all-directions)))
                              (let [[_ elf-check-point _] (get-proposed-direction current-elves elf-check directions)]
                                elf-check-point)
                              nil)]
        ;; (println elf named-direction proposed-point elf-check-point)
        (if (= elf-check-point proposed-point)
          (update d :non-moving-elves conj elf)
          (assoc-in d [:next-elves proposed-point] true))))))

(defn execute-round
  [elves round]
  ;; (println "Round: " (inc round))
  (let [directions (take 4 (drop round directions))
        {:keys [next-elves non-moving-elves] :as d}
        (reduce
         elf-movement
         {:current-elves elves
          :next-elves {}
          :non-moving-elves #{}
          :directions directions}
         elves)
        ;; _ (println "Non-moving: " non-moving-elves)
        next-elves (reduce conj next-elves (zipmap non-moving-elves (cycle [true])))
        no-movement (= (set (keys elves)) (set (keys next-elves)))]
    [next-elves no-movement]))

(defn answer-a
  [file]
  (let [elves (-> file
                  parse-input)
        elves-count (count elves)
        final-elves (reduce
                     (fn [elves round]
                       (let [[elves _]
                             (execute-round elves round)]
                         elves))
                     elves
                     (range 0 10))
        elves-keys (keys final-elves)
        elves-x (map #(first %) elves-keys)
        elves-y (map #(second %) elves-keys)
        min-x (reduce min elves-x)
        max-x (inc (reduce max elves-x))
        min-y (reduce min elves-y)
        max-y (inc (reduce max elves-y))
        area (* (- max-x min-x) (- max-y min-y))]
    (println "min-max X:" min-x max-x)
    (println "min-max Y:" min-y max-y)
    (println "Area:" area)
    (println "Elves:" elves-count)
    (- area elves-count)))

(defn answer-b
  [file]
  (let [elves (-> file
                  parse-input)
        last-round (reduce
                    (fn [elves round]
                      (let [[elves no-movement]
                            (execute-round elves round)]
                        (if no-movement
                          (reduced round)
                          elves)))
                    elves
                    (iterate inc 0))]
    (inc last-round)))

(defn answer []
  (println "23: A:" (answer-a "data/problem-23-input.txt"))
  (println "23: B:" (answer-b "data/problem-23-input.txt")))