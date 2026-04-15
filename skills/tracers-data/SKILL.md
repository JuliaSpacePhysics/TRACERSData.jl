---
name: tracers-data
description: |
  Load TRACERS satellite mission data. Use when the user asks about TRACERS (Cusp Electrodynamics) data, instruments.
---

## Quick Start

```julia
using TRACERSData
using DimensionalData

ds = TS2_L2_ACE_DEF("2025-09-30", "2025-10-01")  # load ACE L2
keys(ds)          # list variables
flux = DimArray(ds["ts2_l2_ace_def"])
size(flux)        # (49, 21, N) → (energy_steps, anode_angles, epochs)
```

## Instruments

| Instrument                           | Measures                                            | Dataset names                                           | Cadence |
| ------------------------------------ | --------------------------------------------------- | ------------------------------------------------------- | ------- |
| **ACE** — Analyzer of Cusp Electrons | Electron energy spectra, 49 bins, 8 eV–20 keV       | `TS{1,2}_L2_ACE_DEF`, `TS{1,2}_L3_ACE_PITCH_ANGLE_DIST` | 50ms    |
| **ACI** — Analyzer of Cusp Ions      | Ion pitch-angle dists, 47 energies, 8 eV/e–20 keV/e | `TS{1,2}_L2_ACI_IPD`                                    | 312ms   |
| **MSC** — Magnetic Search Coil       | AC mag field in TSCS + FAC coords                   | `TS{1,2}_L2_MSC_BAC`                                    | —       |

## Key Variables

### ACE L2

- `ts2_l2_ace_def` — differential energy flux (DEF) (**negative values valid** — background subtraction)
  - Dimensions: `ts2_l2_ace_energy` (49, eV) × `ts2_l2_ace_TSCS_anode_angle` (21, look direction angles) × `Epoch`
- `ts2_l2_ace_counts` / `ts2_l2_ace_background_counts` — raw + background counts

### ACE L3

- `ts2_l3_ace_pitch_def`
  - Dimensions: `ts2_l3_ace_energy` (49, eV) × `ts2_l3_ace_pitch_angle` (18, pitch angles) × `Epoch`

### ACI L2

- `ts2_l2_aci_tscs_def` — ion DEF in TSCS frame
- `ts2_l2_aci_tscs_def_sorted_counts` / `ts2_l2_aci_tscs_def_errors` — counts + errors
- `ts2_l2_aci_tscs_pitch_angle` — pitch angle per measurement
- `ts2_l2_aci_energy` / `ts2_l2_aci_tscs_anode_angle` — 47 energies, 16 anode angles

### MSC L2

- `ts2_l2_bac_tscs` / `ts2_l2_bac_fac` — AC mag field in TSCS/FAC (1024 samples × 3 components × epochs)

## Notes

- Datasets follow ISTP-CDF convention.
- **ROI** — Region of Interest (full cadence); **BOR** — Back Orbit (lower cadence)
- References: [Website](https://tracers.physics.uiowa.edu/), [TRACERS Data Portal](https://tracers-portal.physics.uiowa.edu/)
  - [L3 Public Data Products](https://tracers.physics.uiowa.edu/l3-public-data-products)
