module UnitfulCooking

export VOL_DATA, volume_to_mass, mass_to_volume

using DataFrames, Query
using CSV
using Unitful

function read_volume_data()
  parse_euro_num(s) = parse(Float64, replace(s, r"\." => ""))
  path = joinpath(dirname(@__FILE__), "..", "data", "volume-weight-conversion-v2.csv")
  vd = CSV.read(path, DataFrame)[3:end,:] |>
    @map({ingredient=_.Column16, grams_per_liter=parse_euro_num(_[Symbol(" l ")])}) |>
    DataFrame
end

const VOL_DATA = read_volume_data()

function grams_per_liter(ingredient)
  matches = VOL_DATA |> @filter(occursin(ingredient, _.ingredient[])) |> DataFrame
  if length(Tables.rows(matches)) == 0
    error("404 Ingredient not found")
  end
  gpl = matches[1,:grams_per_liter]
end

function volume_to_mass(ingredient, vol, output_units=u"g")
  vol_in_liters = convert(Float64, vol / u"l")
  mass = grams_per_liter(ingredient) * vol_in_liters * u"g"
  uconvert(output_units, mass)
end

function mass_to_volume(ingredient, mass, output_units=u"l")
  mass_in_grams = convert(Float64, mass / u"g")
  vol = (mass_in_grams / grams_per_liter(ingredient)) * u"l"
  uconvert(output_units, vol)
end

end # module
