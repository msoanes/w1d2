# class FileShuffler
#   def initialize
# end
#
print "Enter a file name: "
filename = gets.chomp
lines = File.readlines(filename)
shuffled_lines = lines.shuffle

File.open("#{filename}-shuffled.txt", "w") do |shuffled_file|
  shuffled_lines.each do |line|
    shuffled_file.puts(line)
  end
end
