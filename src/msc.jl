"""
    TS1_L2_MSC_BAC

MSC Level 2 3-axis AC magnetic field waveforms for TS1. Sampled at 2048 S/s,
amplitude-calibrated at 100 Hz. Available in TSCS and FAC coordinates.
"""
const TS1_L2_MSC_BAC = TRACERSLogicalDataset(
    _level_pattern, "TS1_L2_MSC_BAC", TS1, "l2", "msc_bac",
    (description = "MSC Level 2 3-axis AC magnetic field waveforms in TSCS and FAC coordinates",);
    version = "1.1.0",
)

"""
    TS2_L2_MSC_BAC

MSC Level 2 3-axis AC magnetic field waveforms for TS2. Sampled at 2048 S/s,
amplitude-calibrated at 100 Hz. Available in TSCS and FAC coordinates.
"""
const TS2_L2_MSC_BAC = TRACERSLogicalDataset(
    _level_pattern, "TS2_L2_MSC_BAC", TS2, "l2", "msc_bac",
    (description = "MSC Level 2 3-axis AC magnetic field waveforms in TSCS and FAC coordinates",);
    version = "1.1.0",
)

"""
    MSC

Magnetic Search Coil. 3-axis AC magnetic field waveforms at 2048 S/s,
amplitude-calibrated at 100 Hz. Complex frequency response calibration included in CDFs.

# Datasets

- `TS1_L2_MSC_BAC`, `TS2_L2_MSC_BAC`: Level 2 AC magnetic field waveforms

# Usage

```julia
MSC(; probe="ts2")  # resolve dataset
```
"""
const MSC = TRACERSInstrument(
    "MSC",
    (;
        ts1_l2_bac = TS1_L2_MSC_BAC,
        ts2_l2_bac = TS2_L2_MSC_BAC,
    ),
    (description = "Magnetic Search Coil — 3-axis AC magnetic field waveforms at 2048 S/s, amplitude-calibrated at 100 Hz",),
    function (datasets; probe = "ts2", level = "l2", datatype = "bac")
        p = probe == "ts1" || probe == "1" ? "ts1" : "ts2"
        key = Symbol("$(p)_$(level)_$(datatype)")
        return getfield(datasets, key)
    end,
)
