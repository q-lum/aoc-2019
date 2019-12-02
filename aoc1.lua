local masses =
    {95065, 129298, 145573, 95743, 59139, 78323, 124445, 69015, 81990, 83254,
    139274, 92101, 74245, 104038, 61955, 80642, 110376, 89992, 84392, 117830,
    140144, 80076, 111285, 107135, 98741, 103753, 141922, 130503, 60409, 73891,
    84781, 118319, 93610, 143228, 99616, 65353, 102388, 123813, 88335, 95459,
    133635, 108771, 101999, 73850, 106490, 53396, 110330, 140258, 73958, 60273,
    101401, 128995, 61495, 114674, 71955, 107049, 79374, 52359, 107925, 91789,
    69174, 133966, 85063, 62856, 96965, 97100, 81638, 104488, 131368, 59015,
    149357, 65193, 61489, 126089, 141224, 100596, 93144, 109421, 121988, 135890,
    70141, 53531, 59900, 98981, 66796, 113700, 109535, 100721, 87240, 99883,
    81637, 80064, 143154, 75778, 64835, 59235, 103907, 121637, 118525, 125730}

local total_fuel_required = 0

local modules = {}
for i, mass in pairs(masses) do
    modules[mass] = 0
end

function fuelEquation(mass)
    
    local fuel = math.floor(mass/3) - 2
    return fuel

end

function calculateFuel(cargo_mass)
    
    local total_mass = cargo_mass
    local fuel_to_add = fuelEquation(cargo_mass)
    local total_fuel_required = 0

    while fuel_to_add > 0 do
        total_mass = total_mass + fuel_to_add
        fuel_to_add = fuelEquation(fuel_to_add)
    end
    
    total_module_fuel = total_mass - cargo_mass
    return total_module_fuel

end

for mass, fuel in pairs(modules) do

    modules[mass] = calculateFuel(mass)
    total_fuel_required = total_fuel_required + modules[mass]

end

-- show all fuel amounts separately:
-- table.foreach(modules, print)

print("Total fuel required: " .. total_fuel_required)