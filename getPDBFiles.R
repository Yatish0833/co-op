#given pdb ids download pdb files

library(RCurl)

dir.create(file.path("pdbFiles"), showWarnings = FALSE)
setwd(file.path("pdbFiles"))

df <- read.table("names.txt",stringsAsFactors = F,header=F)

downloadStructureFiles<- function(names){
  url<-paste("http://www.rcsb.org/pdb/files/",names,".pdb",sep="")
  dest<-paste(names,".pdb",sep="")
  data<-getURL(url)
  write(data,file=dest)
}

sapply(df$V1,function(x) downloadStructureFiles(x))


downloadSequenceFiles<- function(names){
  url<-paste("http://www.rcsb.org/pdb/files/fasta.txt?structureIdList=",names,sep="")
  dest<- paste(names,".fasta",sep="")
  data<-getURL(url)
  write(data,file=dest)
}

sapply(df$V1,function(x) downloadSequenceFiles(x))
