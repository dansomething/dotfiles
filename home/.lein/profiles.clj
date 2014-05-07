{:user {:aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :dependencies [[slamhound "1.5.4"]]
        :plugins [[jonase/eastwood "0.1.2"]
                  [lein-ancient "0.5.5"]
                  [lein-difftest "2.0.0"]
                  [lein-drip "0.1.1-SNAPSHOT"]
                  [lein-kibit "0.0.8"]
                  [lein-pprint "1.1.1"]
                  [lein-ring "0.8.10"]
                  [lein-try "0.4.1"]]
        :search-page-size 30
        :repl-options {:prompt (fn [ns] (str "[" ns "] " "your command, master? "))}}}
