#################################################################################
# This code reads the csv file with pdbs Ids, download them, splits them into 
# their respective chains and then convert them into .prop files.
##################################################################################

data<- read.csv("HMT_filtered.csv",header=T,sep=",",stringsAsFactors = F)
data$names<-gsub("\\/","\\.",data$names)
names<- paste(data$names,"_",data$PDBWithChain,sep="")
writer<-"HMT"
dest2<-paste(writer,"/",sep="")

downloadFasta<-function(names){
  for (i in 1:length(names)){
    name=substr(names[i],nchar(names[i])-5,nchar(names[i])-2)
    url<-paste("http://www.rcsb.org/pdb/files/fasta.txt?structureIdList=",name,"",sep="")
    dest<-paste("HMT/",names[i],".fasta",sep="")
    download.file(url,dest)
  }
  
}
downloadFasta(names)


TF<-"HMT"
SF <- list.files(TF,recursive=T)
for( i in 1:length(SF)){
  file<-paste("HMT/",SF[i],sep="")
  r<-readLines(file)
  name<-substr(SF[i],nchar(SF[i])-11,nchar(SF[i])-6)
  name<-gsub("\\_","\\:",name)
  index1<-grep(name,r)
  index2<-grep(">",r)
  if(index1[1]==index2[length(index2)]){
    seq<-r[index1:length(r)]
  }else{
    seq<-r[index1:(index2[which(index1==index2)+1]-1)]
  }
  dest<-paste("updatedHMT/",SF[i],sep="")
  write(seq,dest)
}


TF<-"updatedHMT"
SF <- list.files(TF,recursive=T)
for( i in 1:length(SF)){
  file<-paste("updatedHMT/",SF[i],sep="")
  r<-readLines(file)
  r<-r[-1]
  r<-paste(r,collapse = "")
  seq<-paste("seq=",r,sep="")
  newName<-substr(SF[i],1,nchar(SF[i])-6)
  dest<-paste("updatedHMT/new/",newName,".prop",sep="")
  write(seq,dest)
}

