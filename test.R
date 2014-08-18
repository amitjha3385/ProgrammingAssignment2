# Arbitrary square invertible matrix
x = matrix (c(1:3, 5,8,13, 9:11), 3,3)

# Test functions line by line
source('cachematrix.R')
mat = makeCacheMatrix() # Initialized with empty matrix
mat$get()
mat$set(x) # pass x as parameter to reset mat
mat$get()
mat$getinv()# inv value received as null
cacheSolve(mat) # pass instance of R object 
cacheSolve(mat)
x = matrix (c(1:3, 5,8,13, 9:11), 3,3, byrow = T)
mat$set(x) # reset matrix
mat$get()
mat$getinv() # inv value reset to NULL
cacheSolve(mat) # pass instance of R object 
cacheSolve(mat)
