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
contribDir <- "src/contrib/"
rVersion <- paste(unlist(getRversion())[1:2], collapse = ".")
dirgz <- "/media/maialen/work/WORK/GIT/"

binWin <- list(
  win.binary = file.path("bin/windows/contrib", rVersion)
)

binMac <- list(
  mac.binary = file.path("bin/macosx/contrib", rVersion),
  mac.binary.mavericks = file.path("bin/macosx/mavericks/contrib", rVersion),
  mac.binary.leopard = file.path("bin/macosx/leopard/contrib", rVersion)
)

# dir <- getwd()
# binPaths <- lapply(binPaths, function(x) file.path(dir,x))
# lapply(binPaths, function(path) {
#   dir.create(path, recursive = TRUE)
# })

binPkg <- function(contribDir, binPaths, type = c("win.binary", "mac.binary")){
  files <- list.files(contribDir, pattern = "tar.gz")
  files2 <- list.files(contribDir, pattern = "tar.gz", full.names = T)
  for(l in 1:length(files)){
    lapply(binPaths, function(path){
      file.copy(files2[[l]], path)
    })
  }
  lapply(binPaths, function(path) {
    tools::write_PACKAGES(path, subdirs = T, verbose = T, latestOnly = T, type = type)
})
}

binPkg(contribDir, binWin, "win.binary")

file.copy(
  list.files(file.path(dirgz), pattern = "tar.gz", full.names = T),
  file.path(binPaths, "sashimi_1.0.tar.gz")
)

tools::write_PACKAGES(contribDir, type = "source")
lapply(binPaths, function(path) {
  tools::write_PACKAGES(path, subdirs = T, verbose = T, latestOnly = T)
})

download.file("https://github.com/SantanderMetGroup/downscaleR/archive/v2.0.3.zip",
              destfile = "bin/windows/contrib/3.4/v2.0.3.zip")
write_PACKAGES("bin/windows/contrib/3.4/", type = "win.binary")
