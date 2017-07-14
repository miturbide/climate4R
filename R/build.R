
# Install drat and git2r
# install.packages(c("drat","git2r"))

## Create an empty repository
# drat::initRepo(name = "datarepo", basepath = "/media/")
# 
# # Store the basepath + name
options(dratRepo = "/media/maialen/work/WORK/prueba/datarepo/")
# # Using this will disable the need to enter "repoDir"
# # I've left it in just to illustrate...

# Add a package to it
drat::insertPackage("/media/maialen/work/WORK/GIT/transformeR_0.0-14.tar.gz",  # Path to src 
                    repodir = "/media/maialen/work/WORK/prueba/datarepo/",                   # Location of git repo: not need if dratRepo set
                    action="prune",                                  # Remove old package version
                    commit = T)                                      # Commit to repo

# (Optional) Remove old packages from repo at a later time
# pruneRepo()

## Push Repository onto GitHub

# Open repository
repo = git2r::repository("/media/maialen/work/WORK/prueba/datarepo/")

# Authorize (not secure, need SSH key)
cred = git2r::cred_user_pass("miturbide", "lukinvela9&9")

# Push changes in local repository to GitHub
git2r::push(repo, "origin", "refs/heads/master", credentials = cred)

# Add the repository to local R session for use with install.packages()
drat::addRepo("datarepo","http://miturbide.github.io/datarepo")
drat::addRepo("datarepo","http://github.com/miturbide/datarepo")

# ~$ git pull 
# ~$ git checkout master
# ~$ git merge devel
# ~$ git push origin master

setRepositories()
install.packages("downscaleR")
install.packages("transformeR")
library(transformeR)
install.packages("face")
setRepositories()

?install.packages


setwd("/media/maialen/work/WORK/GIT/mopa/")
tools::write_PACKAGES(".", type="win.binary")
