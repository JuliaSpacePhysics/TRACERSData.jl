# MAGIC data is under /MAGIC/ on the portal (separate from /L2/)
# URL pattern: /MAGIC/{PROBE}/{yyyy}/{mm}/{dd}/{probe}_l2_magic_{YYYYMMDD}_v{ver}.cdf
# Note: exact MAGIC filename convention needs verification when data appears on portal.
# Currently /MAGIC/ directory is empty on the public portal.

function _magic_pattern(probe, datatype, level; version)
    probe, version = _probe(probe), _version(version)
    return Pattern("$BASE_URL/MAGIC/$(uppercase(probe))/{Y}/{M:02d}/{D:02d}/$(probe)_l2_$(datatype)_{YMD}_$version.cdf")
end

"""
    TS1_L2_MAGIC

MAGIC Level 2 3-axis DC magnetic field for TS1. Available in instrument frame,
GEI2000, and NEC coordinates. 128 S/s (ROI) / 16 S/s (back orbit).
"""
const TS1_L2_MAGIC = TRACERSLogicalDataset(
    _magic_pattern, "TS1_L2_MAGIC", TS1, "l2", "magic",
    (description = "MAGIC Level 2 3-axis DC magnetic field in instrument frame, GEI2000, and NEC coordinates",);
    version = "1.0.0",
)

"""
    TS2_L2_MAGIC

MAGIC Level 2 3-axis DC magnetic field for TS2. Available in instrument frame,
GEI2000, and NEC coordinates. 128 S/s (ROI) / 16 S/s (back orbit).
"""
const TS2_L2_MAGIC = TRACERSLogicalDataset(
    _magic_pattern, "TS2_L2_MAGIC", TS2, "l2", "magic",
    (description = "MAGIC Level 2 3-axis DC magnetic field in instrument frame, GEI2000, and NEC coordinates",);
    version = "1.0.0",
)

"""
    MAGIC

Magnetometer Demonstration. 3-axis DC magnetic field measurements at 128 S/s (ROI) / 16 S/s (back orbit).
Calibrated against IGRF scalar magnitude. Available in instrument frame, GEI2000, and NEC coordinates.

# Datasets

- `TS1_L2_MAGIC`, `TS2_L2_MAGIC`: Level 2 DC magnetic field

# Usage

```julia
MAGIC(; probe="ts2")  # resolve dataset
MAGIC("2025-09-27", "2025-09-28"; probe="ts2")  # load data
```
"""
const MAGIC = TRACERSInstrument(
    "MAGIC",
    (;
        ts1_l2 = TS1_L2_MAGIC,
        ts2_l2 = TS2_L2_MAGIC,
    ),
    (description = "Magnetometer Demonstration — 3-axis DC magnetic field at 128 S/s (ROI) / 16 S/s (back orbit)",),
    function (datasets; probe = "ts2", level = "l2")
        p = probe == "ts1" || probe == "1" ? "ts1" : "ts2"
        key = Symbol("$(p)_$(level)")
        return getfield(datasets, key)
    end,
)
