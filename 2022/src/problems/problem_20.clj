(ns problems.problem-20
  (:require [common.helpers :refer [input]]))

(def decryption-key 811589153)

(defn hash-values
  [values use-decryption-key?]
  (map-indexed
   (fn [index item]
     (let [item (if use-decryption-key?
                  (* item decryption-key)
                  item)]
       [(hash (str index "-" item)) item]))
   values))

(defn mix-values
  [hashed-values times]
  (let [al (java.util.ArrayList. hashed-values)
        c (dec (.size al))]
    (doseq [_ (range 0 times)]
      (doseq [hv hashed-values]
        (let [index (.indexOf al hv)
              new-index (mod (+ index (second hv)) c)]
          (.remove al hv)
          (.add al new-index hv))))
    (map second al)))

(defn compute-answer
  [values]
  (let [index (.indexOf values 0)
        c (count values)
        x (mod (+ index 1000) c)
        y (mod (+ index 2000) c)
        z (mod (+ index 3000) c)]
    (+ (nth values x)
       (nth values y)
       (nth values z))))

(defn parsed-input
  [file]
  (->> file
       input
       (map read-string)))

(defn answer-a
  [file]
  (-> file
      parsed-input
      (hash-values false)
      (mix-values 1)
      compute-answer))

(defn answer-b
  [file]
  (-> file
      parsed-input
      (hash-values true)
      (mix-values 10)
      compute-answer))


(defn answer []
  (time
   (println "20: A:" (answer-a "data/problem-20-input.txt")))
  (time
   (println "20: B:" (answer-b "data/problem-20-input.txt"))))