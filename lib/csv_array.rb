
require 'date'
require 'csv'

DEBUG = false

def array_to_csv_file filepath, an_array
  date = DateTime.now
  CSV.open filepath , "w" do |csv|
    an_array.each_with_index do |row, index|
      csv << [index,row].flatten
    end
  end
end


def csv_file_to_array filepath
  STDERR.puts "WARNING : csv_file_to_array from csv_array.rb : output array will only contain strings" if DEBUG
  output = Array.new
  CSV.open filepath, "r" do |csv|
    csv.each do |row|
      output << row
    end
  end
  output
end


=begin
#TEST
@a =  [[11122, 2434], [11185, 2511], [11301, 2653], [11462, 2851], [11662, 3096], [11895, 3381], [12156, 3700], [12441, 4048], [12746, 4421], [13068, 4815], [13404, 5227], [13752, 5654], [14111, 6094], [14479, 6545], [14855, 7005], [15237, 7473], [15624, 7948], [16016, 8429], [16412, 8915], [16811, 9405], [17213, 9898]]
@d =  [[17617, 10394], [17960, 10815], [18251, 11172], [18498, 11475], [18707, 11732], [18884, 11950], [19034, 12135], [19161, 12292], [19268, 12425], [19358, 12538], [19434, 12634], [19498, 12715], [19552, 12783], [19597, 12840], [19635, 12888], [19667, 12928], [19694, 12962], [19716, 12990], [19734, 13013]]
array_to_csv_file './acceleration.csv', @a
array_to_csv_file './decceleration.csv', @d
@a_read = csv_file_to_array './acceleration.csv'
@b_read = csv_file_to_array './decceleration.csv'

puts "@a === @a_read = #{@a === @a_read} (should be false).  @a_read =#{@a_read}"
puts "@b === @b_read = #{@b === @b_read} (should be false).  @b_read =#{@b_read}"
=end
