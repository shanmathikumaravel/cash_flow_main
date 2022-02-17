module CashFlow::V1::Entities
	class StudentPaymentInfo< Grape::Entity
          with_options(expose_nil: false) do
     expose :student_payment_info_id, documentation: {required:true, type:Integer, desc: 'student payment details'}
	expose :student_admissions_id, documentation: {required: true, type: Integer, desc: 'student admission id'}
     expose :academic_year, documentation: { required: true, type: String, desc: 'academic year'}
     expose :fee_master_id, documentation: {required: true, type: String, desc: 'fee master id'}
     expose :payment_date, documentation: { required: true, type: String, desc: 'date of payment'}
     expose :actual_fees, documentation: {required: true, type: Integer, desc: 'actual fees of the student'}
     expose :amount_paid, documentation: { required: true, type: Integer, desc: 'amount paid by the student'}
     expose :balance_amount, documentation: { required: true, type: Integer, desc: 'balance amount'}, default: ""
     expose :payment_mode, documentation: {required: true, type: String, desc: 'mode of payment'}
     expose :comments, documentation: { required: true, type: String, desc: 'comments and feedback'}
     expose :student_id, documentation: { required: true, type: String, desc: 'id of the student'}
     expose :grade_id, documentation: { required: true, type: String, desc: 'grade_id'}
     expose :refund, documentation: { required: true, type: Integer, desc: 'refund amount'}
          end
end
end



