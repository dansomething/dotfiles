{:user
 {:plugins
  [[lein-ring "0.9.7" :exclusions [org.clojure/clojure]]
   [lein-difftest "2.0.0"]
   [lein-kibit "0.1.2"]
   [lein-try "0.4.3"]
   [cider/cider-nrepl "0.11.0"]
   [lein-drip "0.1.1-SNAPSHOT"]
   [lein-pprint "1.1.2" :exclusions [org.clojure/clojure]]
   [lein-cljfmt "0.4.1"]
   [codox "0.9.4" :exclusions [leinjacker]]
   [venantius/ultra "0.4.1"]
   [lein-kibit "0.1.2" :exclusions [org.clojure/clojure org.clojure/tools.cli org.clojure/tools.namespace]]
   [jonase/eastwood "0.2.3" :exclusions [org.clojure/clojure]]
   [lein-ancient "0.6.8" :exclusions [com.fasterxml.jackson.dataformat/jackson-dataformat-smile org.clojure/clojure org.clojure/data.xml com.fasterxml.jackson.core/jackson-core]]
   [lein-ns-dep-graph "0.1.0-SNAPSHOT"]
   [lein-plz "0.3.3" :exclusions [rewrite-clj ancient-clj]]
   [lein-droid "0.4.3" :exclusions [org.clojure/clojure]]
   [lein-cooper "1.2.1" :exclusions [org.clojure/clojure]]
   [lein-typed "0.3.5" :exclusions [org.clojure/clojure]]
   [lein-shell "0.5.0" :exclusions [org.clojure/clojure]]]

  :dependencies
  [[org.clojure/tools.namespace "0.2.10"]
   [slamhound "1.5.5"]
   [jonase/eastwood "0.2.3" :exclusions [org.clojure/clojure]]]

  :ultra {:color-scheme :solarized_dark}

  :aliases
  {"slamhound" ["run" "-m" "slam.hound"]}}}
