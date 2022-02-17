class CashFlow::V1::GradeSection < Grape::API
	include CashFlow::V1::Defaults
  helpers CashFlow::V1::Helpers::SharedParams


	resource :grade_section do     
    desc "Search by grade_section_id or grade or section, it renders associated grade_section data"
    params do 
    optional :grade_section_id, type: String, default: ""
    optional :grade, type: String, default: ""
    optional :section, type: String, default: ""
    optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
    end
    get '/search', http_codes: [
      { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
      { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
    ]do
     if params[:grade_section_id] or params[:grade] or [:section].present?
        grade_sections = GradeSection.where("grade_section_id = ? OR grade = ? OR section = ?", 
        params[:grade_section_id], params[:grade], params[:section])
     end 
    end
  
    desc 'grade_section show all API' do
      detail "
        List of grade_section
  
        Request parameter:
        'page': (Optional)pagination number. Default: 1
        'per_page': (Optional)Item to be displayed per page. Default: 50
        'Authorization': (Required) Auth token obtained from session API
      "
    end
    params do
      use :pagination
      optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
    end
  
    get '/show_all' do
      total = GradeSection.count
      grade_sections = GradeSection.page(params[:page]).per(params[:per_page])
      
      present :status, 200
      present :page, params[:page]
      present :per_page, params[:per_page]      
      present :total_records, total
      present :total_page, get_total_pages_count(total, params[:per_page])
      present :grade_sections, grade_sections
    end
       

      desc "Show all grade"
      params do         
        optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
      end
      get '/show_grade_only' do
      grade_section = GradeSection.select(:grade)
      end

      

    desc "Create a New Grade and Section"
    params do
      requires :academic_year, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
      requires :grade, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
      requires :section, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
      
      optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
    end
    post '/create', http_codes: [
      { code: 200, message: 'Success', model: CashFlow::V1::Entities::GradeSection},
      { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
      { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
    ] do
      GradeSection.create({
        academic_year:params[:academic_year],
        grade:params[:grade],
        section:params[:section]
        })
      
      end
    
     desc "Delete an Grade section"
     params do
     requires :id, type: String
     optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 

   end
   delete '/delete' do
    GradeSection.find(params[:id]).destroy!
   end
   desc "update an Grade Section"
   params do
      requires :grade_section_id, type: Integer, documentation: { param_type: 'body', post_body: "body" }, default: ""
      requires :grade, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
      requires :section, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
   optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
   end
 put '/update', http_codes: [
  { code: 200, message: 'Success', model: CashFlow::V1::Entities::GradeSection},
  { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
  { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
] do
GradeSection.find(params[:grade_section_id]).update({
  grade_section_id:params[:grade_section_id],
  grade:params[:grade],   
  section:params[:section]  
})
  end
end
end



