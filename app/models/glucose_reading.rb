class GlucoseReading < ActiveRecord::Base
	belongs_to :patient
	validates :reading, presence: true, numericality: {greater_than: 0}
scope :today, -> { where("date(created_at) = ?", Time.now.strftime("%Y-%m-%d").to_date) }
    
	before_create :reading_count

	def reading_count
		
		total_count = GlucoseReading.where("date(created_at) = ? and patient_id =?",Date.today,self.patient_id).count
		if (total_count <= 4)
		 return true 
		else 
			 return false
			end
   end
   def self.get_daily_report
       report = self.today
      return report
	end
end
