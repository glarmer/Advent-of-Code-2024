string = File.read("input.txt")
count = string.scan(/(?=(X(.|\n){140}M(.|\n){140}A(.|\n){140}S|S(.|\n){140}A(.|\n){140}M(.|\n){140}X))/).size #Detect vertical instances of XMAS
count += string.scan(/(?=(XMAS|SAMX))/).size #Horizontal
count += string.scan(/(?=(X(.|\n){141}M(.|\n){141}A(.|\n){141}S|S(.|\n){141}A(.|\n){141}M(.|\n){141}X))/).size #Diagonal 1
count += string.scan(/(?=(X(.|\n){139}M(.|\n){139}A(.|\n){139}S|S(.|\n){139}A(.|\n){139}M(.|\n){139}X))/).size #Diagonal 2

count2 = string.scan(/(?=(M.S(.|\n){139}A(.|\n){139}M.S))/).size # M_S / _A_ / S_M
count2 += string.scan(/(?=(S.M(.|\n){139}A(.|\n){139}S.M))/).size # S_M / _A_ / M_S
count2 += string.scan(/(?=(M.M(.|\n){139}A(.|\n){139}S.S))/).size # M_M / _A_ / S_S
count2 += string.scan(/(?=(S.S(.|\n){139}A(.|\n){139}M.M))/).size # S_S / _A_ / M_M
puts "Part 1: " + count.to_s + " Part 2: " + count2.to_s
