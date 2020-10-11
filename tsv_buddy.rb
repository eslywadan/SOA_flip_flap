# Module that can be included (mixin) to take and output TSV data
module TsvBuddy

  #Named constants
  TAB = "\t"
  NEWLINE = "\n"
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv_data)
    rows = tsv_data.split(NEWLINE).map { |line| line.split(TAB) }
    headers = rows.first
    data_rows = rows[1..-1]
    @data = data_rows.map { |row| row_to_table(headers, row) }
  end

  def row_to_table(headers, row)
    row.map.with_index { |cell, i| [headers[i], cell] }.to_h
  end

  def convert_tsv_line(h_s)
    h_s.reduce {|l, r| "#{l}#{TAB}#{r}" } + NEWLINE
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    header = convert_tsv_line(@data[0].keys)
    content = @data.map { |cell| convert_tsv_line(cell.values) }
    header + content.reduce { |l, r| l += r }
  end
end