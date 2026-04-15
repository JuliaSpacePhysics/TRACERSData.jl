# Ephemeris (EPH/EAD) data is currently only available on the team portal.
# Public ephemeris data is not yet released. This stub will be populated when data becomes public.
# Team portal URL pattern: /teams/flight/SOC/{PROBE}/ead/{datatype}/...

"""
    EPH

Ephemeris. Definitive and predictive orbit attitude data.

!!! warning "Team-only"
    Ephemeris data is not yet available on the public portal. Use the team portal for access.
"""
const EPH = TRACERSInstrument(
    "EPH",
    (;), # no public datasets yet
    (description = "Ephemeris — definitive and predictive orbit attitude data",),
    function (datasets; probe = "ts2", datatype = "def")
        error("Ephemeris data is not yet available on the public portal. Use the team portal for access.")
    end,
)
