(ns problems.problem-07-test
  (:require [clojure.test :as test :refer [deftest is]]
            [problems.problem-07
             :refer
             [add-file
              answer-a
              answer-b
              cd-dir
              directory-file-sizes
              get-directory-split
              matches-cd
              matches-file]]))


(deftest matches-cd-test
  (is (true? (matches-cd "$ cd /")))
  (is (true? (matches-cd "$ cd ..")))
  (is (true? (matches-cd "$ cd lemur")))
  (is (false? (matches-cd "126880 fmftdzrp.fwt"))))

(def starting-directory {:cwd "/tmp/lemur"})
(deftest cd-dir-test
  (is (= "/" ((cd-dir "$ cd /" {:cwd ""}) :cwd)))
  (is (= "/tmp/lemur/baseball" ((cd-dir "$ cd baseball" starting-directory) :cwd)))
  (is (= "/tmp" ((cd-dir "$ cd .." starting-directory) :cwd)))
  (is (= "/a" ((cd-dir "$ cd a" {:cwd "/"}) :cwd)))
  (is (= "/" ((cd-dir "$ cd .." {:cwd "/a"}) :cwd))))

(deftest matches-file-test
  (is (true? (matches-file "126880 fmftdzrp.fwt")))
  (is (true? (matches-file "173625 hhfqgzfj.qvt")))
  (is (false? (matches-file "$ cd /"))))

(deftest get-directory-split-test
  (is (= [""] (get-directory-split "/")))
  (is (= ["" "a"] (get-directory-split "/a")))
  (is (= ["" "a" "b"] (get-directory-split "/a/b"))))

(def root-dir {:cwd "/" :dirs {}})
(def a-dir {:cwd "/a" :dirs {}})
(def b-dir {:cwd "/a/b" :dirs {}})
(def file-arr [{:file "test.txt" :size 1}])
(deftest add-file-test
  (is (= {:cwd "/" :dirs {"/" file-arr}}
         (add-file "1 test.txt" root-dir)))
  (is (= {:cwd "/a" :dirs {"/" file-arr "/a" file-arr}}
         (add-file "1 test.txt" a-dir)))
  (is (= {:cwd "/a/b" :dirs {"/" file-arr "/a" file-arr "/a/b" file-arr}}
         (add-file "1 test.txt" b-dir))))

(deftest directory-file-sizes-test
  (is (= ["/tmp/lemur" 43] (directory-file-sizes ["/tmp/lemur" [{:file "test" :size 23} {:file "test2" :size 20}]])))
  (is (= ["/tmp/empty" 0] (directory-file-sizes ["/tmp/empty" []]))))

(deftest answer-a-test
  (is (= 95437 (answer-a "data/problem-07-a.txt")))
  (is (= 1644735 (answer-a "data/problem-07-input.txt"))))

(deftest answer-b-test
  (is (= 24933642 (answer-b "data/problem-07-a.txt")))
  (is (= 1300850 (answer-b "data/problem-07-input.txt"))))