# UnitfulCooking.jl
Volume/Mass conversion for common ingredients

## Usage

``` julia
\> using Unitful,UnitfulUS,UnitfulCooking

\> volume_to_mass("flour", 2u"cup_us")
255.98 g

\> mass_to_volume("raspberries", 40u"kg", u"tbsp_us")
5202.15 tbspᵘˢ
```

## Credit

The data for this comes from [](https://khymos.org/2014/01/23/volume-to-weight-calculator-for-the-kitchen/).
