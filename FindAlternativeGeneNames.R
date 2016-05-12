#######################################################################################
# To run this code make a directory named SGC and keep all the files with genenames
# it will extract genenames from the file names and find the alternative gene names
# from HGNC approved gene names site.
#######################################################################################


library(RCurl)
library("rvest")
library(XML)
library(stringr)

getAlternateGenes<-function(geneName){
  hgnc <- read.delim(url("http://www.genenames.org/cgi-bin/download?col=gd_app_sym&col=gd_aliases&col=md_eg_id&status=Approved&status=Entry+Withdrawn&status_opt=2&where=&order_by=gd_app_sym_sort&format=text&limit=&hgnc_dbtag=on&submit=submit"))
  print(geneName)
  index<-which(hgnc$Approved.Symbol==geneName)
  if(length(index)==0){
    index<-grep(paste(geneName,"\\S+",sep=""),hgnc$Synonyms)
  }
  if(length(index)==0){
    return()
  }
  df1<-hgnc$Entrez.Gene.ID.supplied.by.NCBI.[index]
  df<-unlist(str_split(hgnc$Synonyms[index],","))
  dat<-data.frame(GENE=geneName,alternateName=geneName,EntrezID=df1)
  dataNew<-data.frame(GENE=geneName,alternateName=df,EntrezID=df1)
  dataNew<-rbind(dat,dataNew)
  return(dataNew)
}

dataGenerator<-function(file){
  filename<- str_split(file,"_")[[1]][1]
  data<- read.csv(file,header=F)
  match<-regmatches(data$V1,gregexpr("^>(\\w+)", data$V1))
  match<-unlist(match)
  match<-gsub(">","",match)
  
  newDf<-data.frame(GENE=as.character(),alternateName=as.character())
  for(i in 1:length(match)){
    newDf<-rbind(newDf,getAlternateGenes(match[i]))
  }
  dataframe<-data.frame(HMT=filename,newDf)
  return(dataframe)
}

setwd("..")
TF<-"SGC"
SF <- list.files(TF,recursive=T)
setwd(TF)
results<-data.frame(HMT=as.character(),GENE=as.character(),alternateName=as.character())
for(i in 1:length(SF)){
  results<-rbind(results,dataGenerator(SF[i]))
}
copy<-results
copy<-copy[!(is.na(copy$alternateName) | copy$alternateName==""), ]

write.csv(copy,"GeneNames.csv",row.names = F)
uni<-unique(copy$EntrezID)
write(uni,"entrezID_list.txt",sep = "\n")



