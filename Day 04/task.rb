string = File.read("input.txt")
lineLength = string.lines.first.length - 1
count = string.scan(/(?=(X(.|\n){#{lineLength}}M(.|\n){#{lineLength}}A(.|\n){#{lineLength}}S|S(.|\n){#{lineLength}}A(.|\n){#{lineLength}}M(.|\n){#{lineLength}}X))/).size #Detect vertical instances of XMAS
count += string.scan(/(?=(XMAS|SAMX))/).size #Horizontal
count += string.scan(/(?=(X(.|\n){#{lineLength+1}}M(.|\n){#{lineLength+1}}A(.|\n){#{lineLength+1}}S|S(.|\n){#{lineLength+1}}A(.|\n){#{lineLength+1}}M(.|\n){#{lineLength+1}}X))/).size #Diagonal 1
count += string.scan(/(?=(X(.|\n){#{lineLength-1}}M(.|\n){#{lineLength-1}}A(.|\n){#{lineLength-1}}S|S(.|\n){#{lineLength-1}}A(.|\n){#{lineLength-1}}M(.|\n){#{lineLength-1}}X))/).size #Diagonal 2

count2 = string.scan(/(?=(M.S(.|\n){#{lineLength-1}}A(.|\n){#{lineLength-1}}M.S))/).size # M_S / _A_ / S_M
count2 += string.scan(/(?=(S.M(.|\n){#{lineLength-1}}A(.|\n){#{lineLength-1}}S.M))/).size # S_M / _A_ / M_S
count2 += string.scan(/(?=(M.M(.|\n){#{lineLength-1}}A(.|\n){#{lineLength-1}}S.S))/).size # M_M / _A_ / S_S
count2 += string.scan(/(?=(S.S(.|\n){#{lineLength-1}}A(.|\n){#{lineLength-1}}M.M))/).size # S_S / _A_ / M_M
puts "Part 1: " + count.to_s + " Part 2: " + count2.to_s
