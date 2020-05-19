A <- read.csv(file="1589822415397-manifest.csv")
dim(A)

B <- read.table(file="metadata_20200313.txt")
dim(B)

head(A)
head(B)

grep(strsplit(toString(A[1,2]), "_")[[1]][1],toString(B[,2]))

which(strsplit(toString(B[,2]), ", ")[[1]] == strsplit(toString(A[,2]), "_")[[1]][1])


length(strsplit(toString(B[40,1]), "_")[[1]])

tmp=rep(0,dim(A)[1])
tmp2=cbind(tmp,tmp)
tmp2=cbind(tmp2,tmp2)
A=cbind(A,tmp)
A=cbind(A,tmp2)
colnames(A)[4:8]=c("Patient ID", "Cell Type", "Passage Number", "Days in Culture","Data Type")

filter <- function(x) 
{
  return (which(strsplit(toString(B[,2]), ", ")[[1]] == strsplit(toString(x), "_")[[1]][1]))
}
s <- as.numeric(lapply(A[,2],filter))

temp = strsplit(strsplit(toString(B[s[c(1:length(s))],1]),",")[[1]], "_")
A[c(1:length(s)),4:8] = t(matrix(unlist(temp), 5,88))

write.csv(A,"1589822415397-manifest-updated.csv")