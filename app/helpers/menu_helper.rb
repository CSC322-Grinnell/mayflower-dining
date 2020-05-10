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

  #finds the dishes for a given day
  # spits out an array in the format [Menu]
  def find_menus(date)
    begin
      day = convert_date_to_day(date)
    rescue => e
        error = "Some dishes of day #{day} not found. DB is in trouble!!"
    end
    return error, Menu.get_by_day(day)
  end
end
