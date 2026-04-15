"""
    TS1_L2_ACI_IPD

ACI Level 2 ion pitch-angle distributions for TS1. Differential energy flux as a function of epoch,
energy (47 bins), and look angle (16 directions). 312 ms cadence.
"""
const TS1_L2_ACI_IPD = TRACERSLogicalDataset(
    _level_pattern, "TS1_L2_ACI_IPD", TS1, "l2", "aci_ipd",
    (description = "ACI Level 2 ion pitch-angle distributions (differential energy flux)",);
    version = "1.0.0",
)

"""
    TS2_L2_ACI_IPD

ACI Level 2 ion pitch-angle distributions for TS2. Differential energy flux as a function of epoch,
energy (47 bins), and look angle (16 directions). 312 ms cadence.
"""
const TS2_L2_ACI_IPD = TRACERSLogicalDataset(
    _level_pattern, "TS2_L2_ACI_IPD", TS2, "l2", "aci_ipd",
    (description = "ACI Level 2 ion pitch-angle distributions (differential energy flux)",);
    version = "1.0.0",
)

"""
    ACI

Analyzer of Cusp Ions. Toroidal top-hat electrostatic analyzer providing ion flux and
pitch-angle distributions. 47 energy steps (8 eV/e – 20 keV/e), 312 ms cadence.

# Datasets

- `TS1_L2_ACI_IPD`, `TS2_L2_ACI_IPD`: Level 2 ion pitch-angle distributions

# Usage

```julia
ACI(; probe="ts2")  # resolve dataset
ACI("2025-09-27", "2025-09-28"; probe="ts2")  # load data
```
"""
const ACI = TRACERSInstrument(
    "ACI",
    (;
        ts1_l2_ipd = TS1_L2_ACI_IPD,
        ts2_l2_ipd = TS2_L2_ACI_IPD,
    ),
    (description = "Analyzer of Cusp Ions — toroidal top-hat electrostatic analyzer for ion flux and pitch-angle distributions",),
    function (datasets; probe = "ts2", level = "l2", datatype = "ipd")
        p = probe == "ts1" || probe == "1" ? "ts1" : "ts2"
        key = Symbol("$(p)_$(level)_$(datatype)")
        return getfield(datasets, key)
    end,
)
