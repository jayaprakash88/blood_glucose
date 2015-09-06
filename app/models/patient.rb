class Patient < ActiveRecord::Base
	has_many :glucose_readings
  
    
end
