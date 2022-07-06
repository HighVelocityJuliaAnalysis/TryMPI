# displayRank.jl
#
# This program simply displays the rank number
using MPI
MPI.Init()  # Every MPI program has to have this to initialize MPI

comm = MPI.COMM_WORLD  # Set the communicator

myRank = MPI.Comm_rank(comm)
nRanks = MPI.Comm_size(comm)

print("I am rank #$(myRank) of $(nRanks)\n")

MPI.Barrier(comm)