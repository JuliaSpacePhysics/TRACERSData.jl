"""
    TRACERSData

Load data from the [TRACERS](https://tracers.physics.uiowa.edu/) (Tandem Reconnection and Cusp Electrodynamics Reconnaissance Satellites) mission.

# Available Instruments

- [`ACE`](@ref): Analyzer of Cusp Electrons (L2, L3)
- [`ACI`](@ref): Analyzer of Cusp Ions (L2)
- [`MSC`](@ref): Magnetic Search Coil (L2)
- [`MAGIC`](@ref): Magnetometer Demonstration (L2)
- [`TS1_ROI`](@ref), [`TS2_ROI`](@ref): Region of Interest event intervals

# Quick Example

```julia
using TRACERSData

# Load ACE L2 data for TS2
TS2_L2_ACE_DEF("2025-09-27", "2025-09-28")
```

# Data Portal

Public data is served from [https://tracers-portal.physics.uiowa.edu/](https://tracers-portal.physics.uiowa.edu/).
"""
module TRACERSData

using CDFDatasets
using CDFDatasets: CDFDataset, ConcatCDFDataset
using SpaceDataModel: AbstractInstrument, AbstractDataSet
using Downloads: request
using Dates
using Dates: format
using URIs: URI

export TS1, TS2
export TS1_L2_ACE_DEF, TS2_L2_ACE_DEF, TS1_L3_ACE_PITCH_ANGLE_DIST, TS2_L3_ACE_PITCH_ANGLE_DIST
export TS1_L2_ACI_IPD, TS2_L2_ACI_IPD
export TS1_L2_MSC_BAC, TS2_L2_MSC_BAC
export TS1_L2_MAGIC, TS2_L2_MAGIC
export TS1_ROI, TS2_ROI
export ACE, ACI, MSC, MAGIC

const BASE_URL = "https://tracers-portal.physics.uiowa.edu"
const DEFAULT_DATA_DIR = Ref{String}(joinpath(first(DEPOT_PATH), "JuliaSpacePhysics/tracers_data"))

@enum Probe begin
    TS1
    TS2
end

include("types.jl")
include("url_pattern.jl")
include("utils.jl")
include("ace.jl")
include("aci.jl")
include("msc.jl")
include("magic.jl")
include("roi.jl")
include("efi.jl")
include("eph.jl")

end
