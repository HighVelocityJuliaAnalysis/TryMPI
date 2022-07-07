# calc_e_gather.jl
#
# This program simply displays the rank number
using MPI
MPI.Init()  # Every MPI program has to have this to initialize MPI

comm = MPI.COMM_WORLD  # Set the communicator

myRank = MPI.Comm_rank(comm)
nRanks = MPI.Comm_size(comm)
rootRank = 0
iAmRoot = myRank == rootRank

# Function for calculating a term
calculateTerm(i) = 1.0/factorial(i)

# Calculate my term
myTerm = calculateTerm(myRank)

# Gather terms to the Root rank
terms = MPI.Gather(myTerm, rootRank, comm)

print("I am rank $(myRank) and terms are $(terms)\n")

if iAmRoot
    e_estimate = sum(terms)
    print("Estimate of e with $(nRanks) terms is $(e_estimate)\n")
end
