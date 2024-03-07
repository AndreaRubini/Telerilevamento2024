# First R script

#R as a calculator
A <- 6 * 7
B<-5 * 8
A+B

# Arrays 
flowers <- c(3, 6, 8, 10, 15, 18)
flowers

insects<-c(10, 16, 25, 42, 61, 70)
insects

plot(flowers, insects)

#changin plot parameters

#symbols 
plot(flowers,insects,phc=19)

#symbol dimension
plot(flowers,insects,phc=19, cex=0.5)

#color 
plot(flowers,insects,phc=19, cex=0.5, col="chocolate1")
