##########################################################################################
# Given a directory with filenames with same pattern, rename them all
##########################################################################################


startingDir<-"ehmt"
subdirName<-"ehmt"
oldNames<-list.files(startingDir)
newNames<-sub(pattern="rot-rot-",replacement="",oldNames)

file.rename(from = file.path(subdirName, oldNames), to = file.path(subdirName, newNames))
    
