(ns common.helpers
  (:require [clojure.string :as str]
            [clojure.pprint :as p]))

(defn input
  "Retrieve the files input in split lines"
  [file]
  (str/split-lines (slurp file)))

(defn debug
  "Prints a value and returns the value"
  [value]
  (p/pprint value)
  value)