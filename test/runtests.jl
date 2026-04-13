using TRACERSData
using Test
using Aqua

@testset "TRACERSData.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(TRACERSData)
    end
    # Write your tests here.
end
