(ns problems.problem-07
  (:require
   [clojure.string :as str]
   [common.helpers :refer [input]]))

(def base-map {:cwd "" :dirs {}})

(def cd-regex #"\$ cd (.+)")
(defn matches-cd [line] (not (nil? (re-matches cd-regex line))))
(defn cd-dir
  "Change :cwd in the map to the directory requested"
  [line d]
  (let [cwd (d :cwd)
        [_ dir] (re-matches cd-regex line)]
    (cond
      (= "/" dir) (assoc d :cwd "/")
      (= ".." dir) (let [new-dir (->> (str/split cwd #"/")
                                      drop-last
                                      (str/join "/"))]
                     (if (= new-dir "")
                       (assoc d :cwd "/")
                       (assoc d :cwd new-dir)))
      :else (if (= cwd "/")
              (assoc d :cwd (str cwd dir))
              (assoc d :cwd (str cwd "/" dir))))))

(defn get-directory-split [dir]
  (let [split (str/split dir #"/")]
    (if (empty? split)
      [""]
      split)))
(def file-regex #"(\d+) (.*)")
(defn matches-file [line] (not (nil? (re-matches file-regex line))))
(defn add-file
  "Add file to the directory and all super directories"
  [line d]
  (let [[_ size-str filename] (re-matches file-regex line)
        size (read-string size-str)
        cwd (d :cwd)
        dir-split (get-directory-split cwd)]
    (-> (reduce (fn [[cwd d] new-dir]
                  (if (empty? new-dir)
                    [cwd (update-in d [:dirs "/"] conj {:size size :file filename})]
                    (let [updated-dir (str cwd "/" new-dir)]
                      [updated-dir (update-in d [:dirs updated-dir] conj {:size size :file filename})])))
                ["" d]
                dir-split)
        second)))

(defn create-directory-structure
  "Creates the directory structure with files"
  [lines]
  (reduce (fn [d line]
            (cond
              (matches-cd line) (cd-dir line d)
              (matches-file line) (add-file line d)
              :else d))
          base-map lines))

(defn directory-file-sizes
  "Returns a vector of the directories with their sizes
   Input looks like [\"/dir/lemur\" [{:file \"test\" :size 23} {:file \"test2\" :size 45}]]
   Returns: [\"/dir/lemur\" 68]
   "
  [[dir files]]
  (let [file-sizes (map #(% :size) files)
        total (reduce + 0 file-sizes)]
    [dir total]))

(defn answer-a [file]
  (-> file
      input
      create-directory-structure
      (get :dirs)
      vec
      (->> (map directory-file-sizes)
           (map #(second %))
           (filter #(<= % 100000))
           (reduce + 0))))

(defn answer-b [file]
  (let [dirs-vec (-> file
                     input
                     create-directory-structure
                     :dirs
                     vec)
        dir-sizes (->> dirs-vec
                       (map directory-file-sizes)
                       (map second)
                       sort
                       reverse)
        unused-space (- 70000000 (first dir-sizes))
        needed-space (- 30000000 unused-space)]
    (->> dir-sizes
         reverse
         (drop-while #(< % needed-space))
         first)))

(defn answer []
  (println "07: A:" (answer-a "data/problem-07-input.txt"))
  (println "07: B:" (answer-b "data/problem-07-input.txt")))