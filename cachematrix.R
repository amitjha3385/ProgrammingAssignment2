## The following functions take advantage of the lexical scoping of R-language to 
## create R-Objects that can preserve state of some values inside the object
## this prevents possibly costly re-computation.
## In particular we leverage the above principles to create an R- object that can 
## cache the matrix inverse values so that they need not be recomputed 
## if the matrix has not been changed.

## makeCacheMatrix function is a list of 4 functions that provide the following
## 1) get - fetches the matrix, 2) set -reset the matrix (also resets inverse to NULL)
## 3) getinverse - to get the inverse of the matrix (NULL if not already computed)
## 4) setinverse - sets the value of the inverse.

makeCacheMatrix <- function(x = matrix()) {
        # Initialize the inverse matrix to special value NULL
        inv <- NULL
        
        # set -  provide value to the makeCacheMatrix, utilized to change the matrix
        # Utilizes <<- operator to change values in the outer scope
        set <- function(y) {
                x <<- y
                # Resets the inverse value to NULL upon change to the matrix
                inv <<- NULL
        }
        # get - returns the current matrix 
        get <- function() {x}
        # sets the cache for the inverse value. Again utilizes the <<- operator
        setinv <- function(inv.matrix) {inv <<- inv.matrix }
        # extracts the inverse of the matrix 
        getinv <- function() {inv}
        
        # list definition
        list(set = set, get = get,
             setinv = setinv, getinv = getinv)
}


## cacheSolve function assumes that the input is a square invertible matrix
## It checks for precomputed cached value of the matrix inverse and returns 
## that value if not NULL, if cached value is NULL, it computes the inverse and 
## sets that value as cache prior to returning the value.

# Takes instance of the R object makeCacheMatrix as input
cacheSolve <- function(x, ...) {
        # Extract the inverse value from makeCacheMatrix
        inv <- x$getinv()
        # If value is not NULL return cached value
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        
        # This part is computed in case value is NULL
        # data takes the matrix from makeCacheMatrix object
        data <- x$get()
        # Computation of inverse - assumes square invertible matrix
        # inv.matrix takes the inverted matrix
        inv.matrix <- solve(data, ...)
        # set the newly computed value as cache in the makeCacheMatrix object
        x$setinv(inv.matrix)
        # return the compouted value
        inv.matrix
} 
