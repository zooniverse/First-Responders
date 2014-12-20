require 'csv'
existing_tiles = CSV.read('./tiles_all.csv')

`rm -rf ./outputs`
`mkdir -p ./outputs`

source_files = %w(multispectral.tif panchromatic.tif)

source_files.each.with_index do |source_file, source_index|
  source_type = File.basename(source_file, '.tif')
  `mkdir -p ./outputs/#{source_type}`

  # Arbitrary location, but the offset was eyeballed in QGIS. This just converts it to a pixel value.
  offset_one = `gdallocationinfo -geoloc #{source_file} 717801.7 1244165.2`.split("\n")[1].match(/\((\d+)P,(\d+)L\)/)[1..2].map(&:to_i)
  offset_two = `gdallocationinfo -geoloc #{source_file} 717785.6 1244150.7`.split("\n")[1].match(/\((\d+)P,(\d+)L\)/)[1..2].map(&:to_i)

  x_offset = offset_one[0] - offset_two[0]
  y_offset = offset_one[1] - offset_two[1]

  existing_tiles.each.with_index do |tile, index|
    next if index == 0

    pieces = tile[0].split("_")
    next if pieces[2].to_i != 7
    # next if (pieces[3].split("x") & ["5"]).count == 0
    # next unless pieces[4].to_i == 16

    puts "#{source_file} - #{index} / #{existing_tiles.length}%"

    upper_left = `gdallocationinfo -wgs84 #{source_file} #{tile[1]} #{tile[4]}`.split("\n")[1].match(/\((\d+)P,(\d+)L\)/)[1..2].map(&:to_i)

    lower_right = `gdallocationinfo -wgs84 #{source_file} #{tile[2]} #{tile[3]}`.split("\n")[1].match(/\((\d+)P,(\d+)L\)/)[1..2].map(&:to_i)

    width = lower_right[0] - upper_left[0]
    height = lower_right[1] - upper_left[1]

    upper_left[0] = upper_left[0] - x_offset
    upper_left[1] = upper_left[1] - y_offset

    dest_filename = "#{File.basename(tile[0], '.jpg')}_#{source_type}"

    `convert "./#{source_file}" -quiet -crop #{width}x#{height}+#{upper_left[0]}+#{upper_left[1]} +repage -resize 800 ./outputs/#{source_type}/#{dest_filename}.jpg`
  end
end

puts "Done!"
