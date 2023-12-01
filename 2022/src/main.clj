(ns main
  (:require
   [problems.problem-01]
   [problems.problem-02]
   [problems.problem-03]
   [problems.problem-04]
   [problems.problem-05]
   [problems.problem-06]
   [problems.problem-07]
   [problems.problem-08]
   [problems.problem-09]
   [problems.problem-10]
   [problems.problem-11]
   [problems.problem-12]
   [problems.problem-13]
   [problems.problem-14]
   [problems.problem-15]
   [problems.problem-16]
   [problems.problem-17]
   [problems.problem-18]
   [problems.problem-19]
   [problems.problem-20]
   [problems.problem-21]
   [problems.problem-22]
   [problems.problem-23]
   [problems.problem-24]
   [problems.problem-25]))

(def problems [problems.problem-01/answer
               problems.problem-02/answer
               problems.problem-03/answer
               problems.problem-04/answer
               problems.problem-05/answer
               problems.problem-06/answer
               problems.problem-07/answer
               problems.problem-08/answer
               problems.problem-09/answer
               problems.problem-10/answer
               problems.problem-11/answer
               problems.problem-12/answer
               problems.problem-13/answer
               problems.problem-14/answer
               problems.problem-15/answer
               problems.problem-16/answer
               problems.problem-17/answer
               problems.problem-18/answer
               problems.problem-19/answer
               problems.problem-20/answer
               problems.problem-21/answer
               problems.problem-22/answer
               problems.problem-23/answer
               problems.problem-24/answer
               problems.problem-25/answer])

(defn run-specific-problem [problem]
  (let [index (->> problem
                   read-string
                   dec)]
    ((problems index))))

(defn run-all-problems []
  (doseq [problem problems]
    (problem)))

(defn -main [& args]
  (if args
    (run-specific-problem (first args))
    (run-all-problems)))