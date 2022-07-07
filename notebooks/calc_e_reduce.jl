# calc_e_reduce.jl
#
# This program calculates e using MPI.Reduce

using MPI
MPI.Init()

comm = MPI.COMM_WORLD  # Set the communicator

myRank = MPI.Comm_rank(comm)
nRanks = MPI.Comm_size(comm)
rootRank = 0
iAmRoot = myRank == rootRank

# Function for calculating a term
calculateTerm(i) = 1.0/factorial(i)

# Calculate my term
myTerm = calculateTerm(myRank)

# Add up the terms with MPI
e_estimate = MPI.Reduce(myTerm, +, rootRank, comm)

print("I am rank $(myRank) and reduce returned $(e_estimate)\n")

if iAmRoot
    print("The estimate for e is $(e_estimate)")
end