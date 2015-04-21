require "pry"

string = "ddddddwwwwwwaaaaaasssssssssssssseddddddddddddddddddewwawwawwawwawwawwawwaedddssssssddddssssssssewwdwwdwwdwwdwwddssdssdssdssdsswwdwwdwwdwwdwwdwwdwwdassassassassassassassedddddddddddddddewwwwwwwwwwwwwwdssdssdssdssdssdssdsswwwwwwwwwwwwwwssssssssssssssedddddddddddewwwwwwwwwwwwweddddddddddessssssssssssssedddddddewwwwwwwwwwwwwweaaaaaaaedssdssdssdssdssdssdssewdwdwdddwddwdwwddwddwddwddewawwawawaaasasassasssasssdsssdsddsddddwdwwdwwwaaaessdddsddsddddsddddewdwdwdwdwdwdwdwawawawawawawaedddddddddddddddeddddddddaaaaaaaasssssssssssssswwwwwwwwdddddeddddddddeddddddwwwwwwaaaaaassssssssssssssedddddddddddddwwesdsddsdddwddwdwwwawwawawaawaawawwdwwdwdddsddsdsedddwwwdddesssssssssesssssess"

binding.pry

letter = []
breakdown = []

count = 0
current_char = string.chars.first

string.chars.each do |char|
  if current_char != char
    breakdown << [current_char, count]
    current_char = char
    count = 1
  else
    count += 1
  end
end

breakdown.each do |pair|
  if pair[0] == "e"
    puts "=" * 80
  else
    puts "#{pair[0]}  #{pair[1]}"
  end
end
