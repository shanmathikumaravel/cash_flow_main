class YearOfFee < ApplicationRecord
    self.table_name = "year_of_fees"
    # before_create :year_of_fees
    # validates_uniqueness_of :grade 
    # def grade 
    #     if :grade.present? same :academic_year then false
    #     end
    # end

    
    # before_update :year_of_fees 
	# validates :academic_year, 
    # numericality: { greater_than:2020, greater_than_or_equal_to: -> { current.year } }
end




