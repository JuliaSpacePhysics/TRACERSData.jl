# EFI (Electric Field Instrument)
# Public L2 EFI data not released, currently only available on the team portal.
# Team portal URL pattern: /teams/flight/EFI/{probe}/l2/{datatype}/{yyyy}/{mm}/{dd}/...

"""
    EFI

Electric Field Instrument. DC-coupled probe potentials (VDC), electric field (EDC),
AC waveforms (EAC), and high-frequency snapshots (EHF).

!!! warning "Team-only"
    EFI data is not yet available on the public portal. Use the team portal for access.
"""
const EFI = TRACERSInstrument(
    "EFI",
    (;), # no public datasets yet
    (description = "Electric Field Instrument — DC-coupled probe potentials (VDC), electric field (EDC), AC waveforms (EAC), and high-frequency snapshots (EHF)",),
    function (datasets; probe = "ts2", level = "l2", datatype = "edc")
        error("EFI data is not yet available on the public portal. Use the team portal for access.")
    end,
)
