class CashFlow::V1::Student < Grape::API
	include CashFlow::V1::Defaults
  helpers CashFlow::V1::Helpers::SharedParams

	resource :student_admissions_search do    
   
    desc "Search student by student_id or student_name or phone_number which renders records of student_admissions, 
    student_payment_info and student_allocations"
    params do 
    optional :student_id, type: String, default: ""
    optional :student_name, type: String, default: ""
    optional :phone_number, type: String, default: ""
    optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
    end

    get '/', http_codes: [
    #{ code: 200, message: 'Success', model: CashFlow::V1::Entities::StudentAdmissionSearch},
      { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
      { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
    ]do
    
     if params[:student_id] or params[:student_name] or params[:phone_number].present?
        student_admissions = StudentAdmission.where("student_id = ? OR student_name= ? OR phone_number = ?", 
        params[:student_id], params[:student_name], params[:phone_number])
        present student_admissions
     end 
    end
    desc "Search by student_id"
    params do 
    requires :student_id, type: String, default: ""
    optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
    end
    get '/search', http_codes: [
      { code: 200, message: 'Success', model: CashFlow::V1::Entities::StudentAdmissionSearch},
      { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
      { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
    ]do
     if params[:student_id].present?
        student_admissions = StudentAdmission.where("student_id = ?", 
        params[:student_id]), 
        StudentPaymentInfo.where(academic_year: params[:academic_year], grade_id: params[:from_grade_id], section: params[:from_section_id])
     end 
    end
  end
end

