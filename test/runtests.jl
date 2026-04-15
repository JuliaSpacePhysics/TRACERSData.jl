using TRACERSData
using Test
using Aqua
using Dates

@testset "Code quality (Aqua.jl)" begin
    Aqua.test_all(TRACERSData)
end

@testset "Enums" begin
    @test string(TS1) == "TS1"
    @test string(TS2) == "TS2"
end

@testset "URL Pattern" begin
    dt = DateTime("2025-09-27")

    # ACE L2
    url = TS2_L2_ACE_DEF.url_pattern(dt)
    @test occursin("L2/TS2/2025/09/27/ts2_l2_ace_def_20250927_v1.1.0.cdf", url)

    url = TS1_L2_ACE_DEF.url_pattern(dt)
    @test occursin("L2/TS1/2025/09/27/ts1_l2_ace_def_20250927_v1.1.0.cdf", url)

    # ACE L3
    url = TS2_L3_ACE_PITCH_ANGLE_DIST.url_pattern(dt)
    @test occursin("L3/TS2/2025/09/27/ts2_l3_ace_pitch-angle-dist_20250927_v1.2.0.cdf", url)

    # ACI L2
    url = TS2_L2_ACI_IPD.url_pattern(dt)
    @test occursin("L2/TS2/2025/09/27/ts2_l2_aci_ipd_20250927_v1.0.0.cdf", url)

    # MSC L2
    url = TS2_L2_MSC_BAC.url_pattern(dt)
    @test occursin("L2/TS2/2025/09/27/ts2_l2_msc_bac_20250927_v1.1.0.cdf", url)

    # MAGIC L2
    url = TS2_L2_MAGIC.url_pattern(dt)
    @test occursin("MAGIC/TS2/2025/09/27/ts2_l2_magic_20250927_v1.0.0.cdf", url)

    # ROI
    @test occursin("ancillary/TS2/events/roi_intervals/ts2_roi-list.csv", TS2_ROI.url)
    @test occursin("ancillary/TS1/events/roi_intervals/ts1_roi-list.csv", TS1_ROI.url)
end

@testset "Instrument lookup" begin
    @test ACE(; probe = "ts2", level = "l2") === TS2_L2_ACE_DEF
    @test ACE(; probe = "ts1", level = "l2") === TS1_L2_ACE_DEF
    @test ACE(; probe = "ts2", level = "l3") === TS2_L3_ACE_PITCH_ANGLE_DIST
    @test ACE(; probe = "ts1", level = "l3") === TS1_L3_ACE_PITCH_ANGLE_DIST

    @test ACI(; probe = "ts2") === TS2_L2_ACI_IPD
    @test ACI(; probe = "ts1") === TS1_L2_ACI_IPD

    @test MSC(; probe = "ts2") === TS2_L2_MSC_BAC
    @test MSC(; probe = "ts1") === TS1_L2_MSC_BAC

    @test MAGIC(; probe = "ts2") === TS2_L2_MAGIC
    @test MAGIC(; probe = "ts1") === TS1_L2_MAGIC
end
