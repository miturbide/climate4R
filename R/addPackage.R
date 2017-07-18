library(drat)
# BUILD PACKAGES FROM TERMINAL
# R CMD build <pck>; R CMD check <pkg>

# ADD PACKAGE TO REPO
pkg <- "/media/maialen/work/WORK/GIT/transformeR_0.0.14.tar.gz"
wd <- getwd()
drat::insertPackage(pkg,  # Path to src 
                    repodir = wd,                   # Location of git repo: not need if dratRepo set
                    action = "prune",                                  # Remove old package version
                    commit = T)                                      # Commit to repo

#COMMIT AND PUSH TO GIT BRANCH gh-pages

install.packages("loadeR", repos = "http://miturbide.github.io/climate4R")
