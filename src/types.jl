struct TRACERSLogicalDataset{N, MD, P} <: AbstractDataSet
    name::N
    probe::Probe
    level::String
    datatype::String
    url_pattern::P
    metadata::MD
end

function TRACERSLogicalDataset(f::Function, name, probe::Probe, level, datatype, metadata; kw...)
    url_pattern = f(probe, datatype, level; kw...)
    return TRACERSLogicalDataset(name, probe, level, datatype, url_pattern, metadata)
end

function (ds::TRACERSLogicalDataset)(t0, t1; kw...)
    files = download_pattern(ds.url_pattern, t0, t1; kw...)
    return isempty(files) ? nothing : ConcatCDFDataset(files)
end

(ds::TRACERSLogicalDataset)(trange::Union{Tuple, Vector, Pair}; kw...) = ds(trange...; kw...)

struct TRACERSInstrument{D, MD, F} <: AbstractInstrument
    name::String
    datasets::D
    metadata::MD
    _lookup::F
end

(inst::TRACERSInstrument)(; kw...) = inst._lookup(inst.datasets; kw...)
(inst::TRACERSInstrument)(args...; update = false, kw...) = inst(; kw...)(args...; update)
