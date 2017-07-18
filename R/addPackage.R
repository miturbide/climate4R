library(drat)

# BUILD THE MASTER VERSION OF THE PACKAGE IN LOCAL
# switch to branch master

# BUILD PACKAGES FROM TERMINAL
# R CMD build <pck>; R CMD check <pkg>

# ADD PACKAGE TO REPO
pkg <- "/media/maialen/work/WORK/GIT/transformeR_0.0.14.tar.gz"
pkg <- "/media/maialen/work/WORK/GIT/loadeR_1.1.0.tar.gz"
pkg <- "/media/maialen/work/WORK/GIT/downscaleR_2.0.3.tar.gz"

wd <- getwd()
drat::insertPackage(pkg,  # Path to src 
                    repodir = wd,                   # Location of git repo: not need if dratRepo set
                    action = "prune",                                  # Remove old package version
                    commit = T)                                      # Commit to repo

drat::pruneRepo(getwd(), pkg = c("loadeR", "downscaleR", "transformeR"))

#COMMIT AND PUSH TO GIT BRANCH gh-pages...

#INSTALL FROM REPO
install.packages("loadeR", repos = "http://miturbide.github.io/climate4R")

#CREATE WINDOWS PACKAGES
dir <- "/media/maialen/work/WORK/GIT/transformeR"
tools::write_PACKAGES(dir, type = "win.binary", verbose = T)

