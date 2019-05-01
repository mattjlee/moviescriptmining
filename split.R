scripts <- file.info(list.files("parsed_data", full.names=T))
scripts$name <- rownames(scripts)
scripts <- scripts[,c("size", "name")]

scripts <- scripts[sample(1:nrow(scripts)),]
colnames(scripts) <- c("size", "name")

total <- sum(scripts$size)
index <- 0
split <- 0
for (i in seq(1, nrow(scripts))) {
    split <- split + scripts$size[i]
    if(split >= total*0.8) {
        index <- i
        break
    }
}

if(dir.exists("training"))
    unlink("training", recursive=T)
dir.create("training")
file.copy(from=scripts$name[1:index], to="training")
if(dir.exists("testing"))
    unlink("testing", recursive=T)
dir.create("testing")
file.copy(from=scripts$name[index+1:nrow(scripts)], to="testing")
warnings()
