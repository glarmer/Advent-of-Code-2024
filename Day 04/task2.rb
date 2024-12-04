string = File.read("input.txt")
count = string.scan(/(?=(X(.|\n){140}M(.|\n){140}A(.|\n){140}S|S(.|\n){140}A(.|\n){140}M(.|\n){140}X))/).size #Detect vertical instances of XMAS
count += string.scan(/(?=(XMAS|SAMX))/).size #Horizontal
count += string.scan(/(?=(X(.|\n){141}M(.|\n){141}A(.|\n){141}S|S(.|\n){141}A(.|\n){141}M(.|\n){141}X))/).size #Diagonal 1
count += string.scan(/(?=(X(.|\n){139}M(.|\n){139}A(.|\n){139}S|S(.|\n){139}A(.|\n){139}M(.|\n){139}X))/).size #Diagonal 2
puts count
