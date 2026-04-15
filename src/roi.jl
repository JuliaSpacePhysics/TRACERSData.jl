using CSV: CSV
using DataFrames: DataFrame

struct TRACERSROIDataset{N, MD} <: AbstractDataSet
    name::N
    probe::Probe
    url::String
    metadata::MD
end

function (ds::TRACERSROIDataset)(; dir = "tracers_data", update::Bool = false)
    file = RemoteFile(ds.url; dir)
    output = file.path
    if !isfile(output) || update
        _download(file)
    end
    return isfile(output) ? DataFrame(CSV.File(output; comment="#", ntasks=1)) : DataFrame()
end

function _roi_url(probe)
    p = _probe(probe)
    return "$BASE_URL/ancillary/$(uppercase(p))/events/roi_intervals/$(p)_roi-list.csv"
end

"""
    TS1_ROI

TS1 Region of Interest event intervals. Returns a `DataFrame` when called.
"""
const TS1_ROI = TRACERSROIDataset(
    "TS1_ROI", TS1, _roi_url("ts1"),
    (description = "TS1 Region of Interest event intervals",),
)

"""
    TS2_ROI

TS2 Region of Interest event intervals. Returns a `DataFrame` when called.
"""
const TS2_ROI = TRACERSROIDataset(
    "TS2_ROI", TS2, _roi_url("ts2"),
    (description = "TS2 Region of Interest event intervals",),
)

