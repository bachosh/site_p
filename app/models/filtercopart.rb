class Filtercopart < ApplicationRecord
    
  before_save :default_values

	def default_values
	  self.year = '1900' if self.year.nil?
	  self.to_year = '2100' if self.to_year.nil?
	  self.odometer = 0 if self.odometer.nil?
	  self.to_odometer = 9999999 if self.to_odometer.nil?
	end


	def correct_year(year_p)
          year_from = self.year ||= 1900
          year_to = self.to_year ||= 2100
          year_csv = year_p ||= year_from
          year_csv = year_csv.to_i 

	  if year_from.to_i <= year_csv && year_to.to_i >= year_csv
	    then true
	  else
	    false
	  end
	end


	def correct_odo(odo_p)
          odo_from = self.odometer ||= 0
          odo_to = self.to_odometer ||= 9999999
          odo_csv = odo_p ||= odo_from
          odo_csv = odo_csv.to_i
	  if odo_from <= odo_csv && odo_to >= odo_csv
	    then true
	  else
	    false
	  end
	end
end
