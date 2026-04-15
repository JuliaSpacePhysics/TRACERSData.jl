"""
    TS1_L2_ACE_DEF

ACE Level 2 default electron spectra for TS1. Contains raw measured counts and calibrated differential energy flux
as a function of anode angle and calibrated energy. 49 energy steps × 21 anodes, 50 ms cadence.
"""
const TS1_L2_ACE_DEF = TRACERSLogicalDataset(
    _level_pattern, "TS1_L2_ACE_DEF", TS1, "l2", "ace_def",
    (description = "ACE Level 2 default electron spectra (counts + differential energy flux)",);
    version = "1.1.0",
)

"""
    TS2_L2_ACE_DEF

ACE Level 2 default electron spectra for TS2. Contains raw measured counts and calibrated differential energy flux
as a function of anode angle and calibrated energy. 49 energy steps × 21 anodes, 50 ms cadence.
"""
const TS2_L2_ACE_DEF = TRACERSLogicalDataset(
    _level_pattern, "TS2_L2_ACE_DEF", TS2, "l2", "ace_def",
    (description = "ACE Level 2 default electron spectra (counts + differential energy flux)",);
    version = "1.1.0",
)

"""
    TS1_L3_ACE_PITCH_ANGLE_DIST

ACE Level 3 pitch-angle resolved electron distributions for TS1.
"""
const TS1_L3_ACE_PITCH_ANGLE_DIST = TRACERSLogicalDataset(
    _level_pattern, "TS1_L3_ACE_PITCH_ANGLE_DIST", TS1, "l3", "ace_pitch-angle-dist",
    (description = "ACE Level 3 pitch-angle resolved electron distributions",);
    version = "1.2.0",
)

"""
    TS2_L3_ACE_PITCH_ANGLE_DIST

ACE Level 3 pitch-angle resolved electron distributions for TS2.
"""
const TS2_L3_ACE_PITCH_ANGLE_DIST = TRACERSLogicalDataset(
    _level_pattern, "TS2_L3_ACE_PITCH_ANGLE_DIST", TS2, "l3", "ace_pitch-angle-dist",
    (description = "ACE Level 3 pitch-angle resolved electron distributions",);
    version = "1.2.0",
)

"""
    ACE

Analyzer of Cusp Electrons. Measures electron energy spectra and pitch-angle distributions.

# Datasets

- `TS1_L2_ACE_DEF`, `TS2_L2_ACE_DEF`: Level 2 default spectra (counts + differential energy flux)
- `TS1_L3_ACE_PITCH_ANGLE_DIST`, `TS2_L3_ACE_PITCH_ANGLE_DIST`: Level 3 pitch-angle distributions

# Usage

```julia
ACE(; probe="ts2", level="l2")  # resolve dataset
ACE("2025-09-27", "2025-09-28"; probe="ts2", level="l2")  # load data
```
"""
const ACE = TRACERSInstrument(
    "ACE",
    (;
        ts1_l2_def = TS1_L2_ACE_DEF,
        ts2_l2_def = TS2_L2_ACE_DEF,
        ts1_l3_pad = TS1_L3_ACE_PITCH_ANGLE_DIST,
        ts2_l3_pad = TS2_L3_ACE_PITCH_ANGLE_DIST,
    ),
    (description = "Analyzer of Cusp Electrons — measures electron energy spectra and pitch-angle distributions",),
    function (datasets; probe = "ts2", level = "l2", datatype = "def")
        key = _ace_key(probe, level, datatype)
        return getfield(datasets, key)
    end,
)

function _ace_key(probe, level, datatype)
    p = probe == "ts1" || probe == "1" ? "ts1" : "ts2"
    if level == "l2"
        return Symbol("$(p)_l2_def")
    elseif level == "l3"
        return Symbol("$(p)_l3_pad")
    else
        error("ACE: unsupported level '$level'. Supported: l2, l3")
    end
end
