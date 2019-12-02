-- handling 0-indexed arrays in lua is easy with this one weird trick
local program = {[0]=1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,6,19,1,5,19,23,1,
    23,6,27,1,5,27,31,1,31,6,35,1,9,35,39,2,10,39,43,1,43,6,47,2,6,47,51,
    1,5,51,55,1,55,13,59,1,59,10,63,2,10,63,67,1,9,67,71,2,6,71,75,1,5,75,
    79,2,79,13,83,1,83,5,87,1,87,9,91,1,5,91,95,1,5,95,99,1,99,13,103,1,
    10,103,107,1,107,9,111,1,6,111,115,2,115,13,119,1,10,119,123,2,123,6,
    127,1,5,127,131,1,5,131,135,1,135,6,139,2,139,10,143,2,143,9,147,1,
    147,6,151,1,151,13,155,2,155,9,159,1,6,159,163,1,5,163,167,1,5,167,
    171,1,10,171,175,1,13,175,179,1,179,2,183,1,9,183,0,99,2,14,0,0}

-- wait what?? i have to copy it??? 
function clone(org)
    return {[0]=org[0], unpack(org)}
end

function intcode(input, noun, verb)

    local array = clone(input)

    local current = 0
    array[1] = noun
    array[2] = verb

    function skip(x) current = current + x end

    while true do

        if array[current] == 99 then
            break
        elseif array[current] == 1 then
            array[array[current+3]] = array[array[current+1]] + array[array[current+2]]
            skip(4)
        elseif array[current] == 2 then
            array[array[current+3]] = array[array[current+1]] * array[array[current+2]]
            skip(4)
        else
            io.write("\nError at opcode ",current,": ",array[current],"\n")
            error("invalid opcode")
        end
    end

    return array[0]

end



-- 1202 protocol
--[[

function printarray(a)
    for i = 0, table.getn(a) do io.write(a[i], ", ") end
end

printarray(program)
intcode(program, 12, 2)
print("\n-----------------")
printarray(program)

]]

-- Begin the search for 19690720

io.write("NOUN\tVERB\tRESULT\n")
for i = 0,99 do
    for j = 0,99 do
        local result = intcode(program,i,j)
        if result == 19690720 then
            io.write(i,"\t",j,"\t",result,"\n")
        end
    end
end
