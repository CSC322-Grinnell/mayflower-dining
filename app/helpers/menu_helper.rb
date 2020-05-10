require 'date'

module MenuHelper
  # Takes a day in dd/mm/yyyy (or y/m/d) format and converts it to the number of days
  # since 20/01/1999 mod 49, since dishes are stored from days 0-48
  def convert_date_to_day(date)
    #standardize separator
    date = date.gsub('-','/')
    begin
      parse_string = "%d/%m/%Y"
      start_date = Date.strptime("22/12/2011", parse_string)
      curr_date = Date.strptime(date, parse_string)
      return (curr_date - start_date).to_i % 49
    rescue
      parse_string = "%Y/%m/%d"
      start_date = DateTime.strptime("2011/12/22", parse_string)
      curr_date = DateTime.strptime(date, parse_string)
      return (curr_date - start_date).to_i % 49
    end
  end
end
