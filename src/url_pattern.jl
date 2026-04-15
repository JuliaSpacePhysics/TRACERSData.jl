_probe(s) = startswith(s, "ts") ? s : "ts$(s)"
_probe(probe::Probe) = lowercase(string(probe))
_version(s) = startswith(s, "v") ? s : "v$(s)"
_version(i::Integer) = "v$(i)"

struct Pattern
    pattern::String
end

function (p::Pattern)(date)
    return replace(
        p.pattern,
        "{Y}" => format(date, "yyyy"),
        "{M:02d}" => format(date, "mm"),
        "{D:02d}" => format(date, "dd"),
        "{YMD}" => format(date, "yyyymmdd")
    )
end

# Unified pattern: /L{level}/{PROBE}/{yyyy}/{mm}/{dd}/{probe}_l{level_num}_{datatype}_{YYYYMMDD}_v{ver}.cdf
# datatype encodes instrument+product, e.g. "ace_def", "aci_ipd", "msc_bac"
# level_num is just the number: "2" for L2, "3" for L3
function _level_pattern(probe, datatype, level; version, format = "cdf")
    probe, version = _probe(probe), _version(version)
    level_num = level[2]  # "l2" → "2", "l3" → "3"
    return Pattern("$BASE_URL/$(uppercase(level))/$(uppercase(probe))/{Y}/{M:02d}/{D:02d}/$(probe)_l$(level_num)_$(datatype)_{YMD}_$version.$format")
end
