library(drat)
# Install drat and git2r
# install.packages(c("drat","git2r"))

## Create an empty repository
# drat::initRepo(name = "datarepo", basepath = "/media/")
# 
# # Store the basepath + name
options(dratRepo = getwd())
# # Using this will disable the need to enter "repoDir"
# # I've left it in just to illustrate...

# Create packages from terminal: R CMD build <pck>; R CMD check <pkg>

# Add a package to it
drat::insertPackage("/media/maialen/work/WORK/GIT/loadeR_1.0.9.tar.gz",  # Path to src 
                    repodir = "/media/maialen/work/WORK/GIT/climate4R/",                   # Location of git repo: not need if dratRepo set
                    action = "prune",                                  # Remove old package version
                    commit = T)                                      # Commit to repo

# (Optional) Remove old packages from repo at a later time
# pruneRepo()

## Push Repository onto GitHub

# Open repository
repo = git2r::repository("/media/maialen/work/WORK/GIT/climate4R/")

# Authorize (not secure, need SSH key)
cred = git2r::cred_user_pass("miturbide", "lukinvela9&9")

# Push changes in local repository to GitHub
git2r::push(repo, "origin", "refs/heads/master", credentials = cred)

# Add the repository to local R session for use with install.packages()
drat::addRepo("climate4R","http://miturbide.github.io/climate4R")
drat::addRepo("datarepo","http://github.com/miturbide/datarepo")

# ~$ git pull 
# ~$ git checkout master
# ~$ git merge devel
# ~$ git push origin master

setRepositories()

install.packages("downscaleR", repos = climate4R)
install.packages("transformeR")
library(transformeR)
install.packages("face")
setRepositories()

?install.packages

#create package for windows
setwd("/media/maialen/work/WORK/GIT/mopa/")
tools::write_PACKAGES(".", type="win.binary")
