(ns problems.problem-11
  (:require [common.helpers :refer [input]]
            [clojure.string :as str]))

(defn parse-monkey-index
  [line]
  (-> (re-matches #"Monkey (\d+):" line)
      (get 1)
      read-string))

(defn parse-items
  [line]
  (-> line
      (str/split #":")
      (get 1)
      (str/split #",")
      (->> (map read-string))))

(defn operation-func
  [[x y z] divide-by-three]
  (let [operator (case y
                   "*" *
                   "+" +
                   :else (throw (Exception. "Not + or *")))]
    (fn [old]
      (let [result (operator
                    (if (= x "old")
                      old
                      (read-string x))
                    (if (= z "old")
                      old
                      (read-string z)))]
        (if divide-by-three
          (int (/ result 3))
          result)))))

(defn parse-operation
  [line divide-by-three]
  (-> line
      (str/split #"=")
      (get 1)
      str/triml
      (str/split #" ")
      (operation-func divide-by-three)))

(defn parse-last-num
  [line]
  (-> line
      (str/split #" ")
      last
      read-string))

(defn create-monkey [lines divide-by-three]
  (let [lines (vec lines)
        index (parse-monkey-index (lines 0))
        items (parse-items (lines 1))
        operation (parse-operation (lines 2) divide-by-three)
        test-num (parse-last-num (lines 3))
        true-monkey (parse-last-num (lines 4))
        false-monkey (parse-last-num (lines 5))]
    {:index index
     :items items
     :operation operation
     :test-num test-num
     :test-fn (fn [item]
                (= 0 (mod item test-num)))
     :true-monkey true-monkey
     :false-monkey false-monkey
     :inspections 0}))

(defn parse-input [file divide-by-three]
  (->> file
       input
       (filter (comp not empty?))
       (partition 6)
       (map #(create-monkey % divide-by-three))))

(defn execute-monkey
  [d i]
  (let [monkey ((d :monkeys) i)
        items (monkey :items)
        transformed-items (map #(mod % (d :mod-num)) items)
        transformed-items (map (monkey :operation) transformed-items)
        d (assoc-in d [:monkeys (monkey :index) :items] '())]
    (reduce
     (fn [d item]
       (let [throw-monkey ((monkey :test-fn) item)
             monkey-index (if throw-monkey
                            (monkey :true-monkey)
                            (monkey :false-monkey))]
         (-> d
             (update-in [:monkeys monkey-index :items] conj item)
             (update-in [:monkeys i :inspections] inc))))
     d
     transformed-items)))

(defn execute-round
  [d _round]
  (let [result (reduce execute-monkey d (map :index (d :monkeys)))]
    result))

(defn execute-rounds
  [file rounds divide-by-three]
  (let [monkeys (vec (-> file
                         (parse-input divide-by-three)))
        mod-num (apply * (map :test-num monkeys))
        result (reduce execute-round {:monkeys monkeys :mod-num mod-num} (range 1 (inc rounds)))]
    (map :inspections (result :monkeys))))

(defn answer-a [file]
  (->> (execute-rounds file 20 true)
       sort
       reverse
       (take 2)
       (apply *)))

(defn answer-b [file]
  (->> (execute-rounds file 10000 false)
       sort
       reverse
       (take 2)
       (apply *)))

(defn answer []
  (println "11: A:" (answer-a "data/problem-11-input.txt"))
  (println "11: B:" (answer-b "data/problem-11-input.txt")))