class Patient < ActiveRecord::Base
	has_many :glucose_readings, :dependent => :destroy
  
    
end
