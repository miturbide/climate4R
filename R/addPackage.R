library(drat)

# https://rstudio.github.io/packrat/custom-repos.html

# BUILD THE MASTER VERSION OF THE PACKAGE IN LOCAL
# switch to branch master

# BUILD PACKAGES FROM TERMINAL
# Go to the temporary directory and build 'sashimi'
pkgnames0 <- c("loadeR", "downscaleR", "transformeR")
pkgdir <- "/media/maialen/work/WORK/GIT"
pkgdirs <- file.path(pkgdir, pkgnames0)

owd <- getwd()
setwd(tempdir())
lapply(pkgdirs, function(dirs){
  a <- paste0("R CMD build ", dirs)
  system(a)
})
setwd(owd)

# ADD PACKAGES TO REPO
pkgnames <- c("transformeR_0.0.14.tar.gz", "loadeR_1.1.0.tar.gz", "downscaleR_2.0.3.tar.gz")
repodir <- getwd()
pkgs <- file.path(tempdir(), pkgnames)

lapply(pkgs, function(path){
  drat::insertPackage(path,  # Path to src 
                      repodir = repodir,                   # Location of git repo: not need if dratRepo set
                      action = "prune",                                  # Remove old package version
                      commit = T)                                      # Commit to repo
})


drat::pruneRepo(getwd(), pkg = pkgnames0)

#COMMIT AND PUSH TO GIT BRANCH gh-pages...

#INSTALL FROM REPO
install.packages("loadeR", repos = "http://miturbide.github.io/climate4R")


#CREATE WINDOWS PACKAGES
contribDir <- "src/contrib/"
rVersion <- paste(unlist(getRversion())[1:2], collapse = ".")

binPaths <- list(
  win.binary = file.path("bin/windows/contrib", rVersion),
  mac.binary = file.path("bin/macosx/contrib", rVersion),
  mac.binary.mavericks = file.path("bin/macosx/mavericks/contrib", rVersion),
  mac.binary.leopard = file.path("bin/macosx/leopard/contrib", rVersion)
)

# dir <- getwd()
# binPaths <- lapply(binPaths, function(x) file.path(dir,x))
# lapply(binPaths, function(path) {
#   dir.create(path, recursive = TRUE)
# })


# tools::write_PACKAGES(contribDir, type = "source")
lapply(binPaths, function(path) {
  tools::write_PACKAGES(path)
})


