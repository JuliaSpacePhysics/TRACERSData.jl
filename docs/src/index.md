```@meta
CurrentModule = TRACERSData
```

# TRACERSData

```@docs
TRACERSData
```

## Installation

```julia
using Pkg
Pkg.add("TRACERSData")
```

An [agent skill](https://agentskills.io) is included for using `TRACERSData.jl` with natural language. To install it using [`skills`](https://github.com/vercel-labs/skills), run:

```sh
npx skills add JuliaSpacePhysics/TRACERSData.jl
```

## Quick Start

The examples below walk through the typical workflow: discover an instrument's datasets, load data for a specified time range, and access variables.

```@example quick_start
using TRACERSData

# Inspect the ACE instrument's datasets
ACE.datasets
```

From the Julia REPL you can also type `?ACE` to view the [ACE](@ref) documentation.

```@example quick_start
# Resolve a dataset by name
TS2_L2_ACE_DEF
```

Then call it with a time range to download and load CDF data:

```julia
# Download + load CDF data for a time range
ds = TS2_L2_ACE_DEF("2025-09-30", "2025-10-01")
```

Access individual variables from the loaded CDF dataset using bracket indexing:

```julia
ds["ts2_l2_ace_def"]  # differential energy flux [49 energies × 21 anodes × Epoch]
```

## Quick Plots

```@example quick_plot
using TRACERSData
using Dates
using TRACERSData
using DimensionalData
using NaNStatistics: nanmean
using SpacePhysicsMakie, WGLMakie
using SpaceDataModel: setmeta
using Bonito # hide
Page() # hide

t0 = DateTime("2025-09-30T09:40")
t1 = DateTime("2025-09-30T10:10")

ace_ds = TS2_L2_ACE_DEF(t0, t1)
eflux  = DimArray(ace_ds["ts2_l2_ace_def"])
counts = DimArray(ace_ds["ts2_l2_ace_counts"])

eflux.metadata["VAR_NOTES"]
# "ACE electron differential energy flux as a function of epoch, energy (49 bins) and look angle (21 directions). Note that small negative values are allowed, due to background subtraction."
eflux[eflux .<= 0] .= 0
counts = setmeta(counts, :colorscale => log10)

# Average over anodes (dim 2) → energy-time, same as IDL: total(def, 2) / 21
en_eflux  = nanmean(eflux; dim=2)
en_counts = nanmean(counts; dim=2)

# Average over energies (dim 1) → anode-time, same as IDL: total(def, 1) / 49
an_eflux  = nanmean(eflux; dim=1)
an_counts = nanmean(counts; dim=1)

tplot([en_eflux, an_eflux, en_counts, an_counts], t0, t1)
```

Reproduce the 4-panel TS2 ACE L3 pitch-angle distribution plot from https://tracers.physics.uiowa.edu/l3-public-data-products

```@example quick_plot
ds = TS2_L3_ACE_PITCH_ANGLE_DIST("2025-09-30", "2025-10-01")
da = DimArray(ds["ts2_l3_ace_pitch_def"])
da[da .<= 0] .= 0

# Apply log10 colorscale metadata
da = setmeta(da, :colorscale => log10, "UNITS" => "eV / (eV cm² sr s)")

# Energy-averaged
en_avg = setmeta(nanmean(da; dim = 1), "CATDESC" => "Energy-Averaged Flux")

# Pitch-angle-averaged
pa_avg = setmeta(nanmean(da; dim = 2), "CATDESC" => "Pitch Angle-Averaged Flux")

# Fixed energy 198.9 eV
# Energy dim is ReverseOrdered (descending), index 36 ≈ 198.9 eV
e_slice = setmeta(da[X(Near(198.9f0))], "CATDESC" => "Energy Channel: 198.9 eV")

# Fixed pitch angle bin 10-20° (center 15°)
pa_slice = setmeta(da[Y(Near(15.0f0))], "CATDESC" => "Pitch Angle Bin: 10-20°")

fig = tplot([en_avg, pa_avg, e_slice, pa_slice], t0, t1; add_title = true)
```

### ROI — Region of Interest

Event interval lists in CSV format. Returns a `DataFrame`.

Call it to download and parse the CSV:

```@example quick_start
roi_df = TS2_ROI();  # returns DataFrame
first(roi_df, 5)
```

## API

### Instruments

```@docs
ACE
ACI
MSC
MAGIC
EFI
EPH
```

### Datasets

```@autodocs
Modules = [TRACERSData]
Filter = t -> t isa TRACERSData.TRACERSLogicalDataset || t isa TRACERSData.TRACERSROIDataset
```

### Functions and Types

```@autodocs
Modules = [TRACERSData]
Private = false
Order   = [:function, :type]
```
