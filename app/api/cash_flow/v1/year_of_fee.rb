class CashFlow::V1::YearOfFee < Grape::API
  include CashFlow::V1::Defaults
  helpers CashFlow::V1::Helpers::SharedParams


 resource :year_of_fee do 
  
  desc 'year_of_fees show all API' do
    detail "
      List of year_of_fees

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
    total = YearOfFee.count
    year_of_fees = YearOfFee.page(params[:page]).per(params[:per_page])
    
    present :status, 200
    present :page, params[:page]
    present :per_page, params[:per_page]      
    present :total_records, total
    present :total_page, get_total_pages_count(total, params[:per_page])
    present :year_of_fees, year_of_fees
  end
     
     
     desc "Search by grade&year"
     params do 
     requires :academic_year, type: String, default: ""
     requires :grade, type: String, default: ""
     optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
     end
     get '/search_by_grade&year', http_codes: [
       { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
       { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
     ]do
      if params[:academic_year] && params[:grade].present?
         year_of_fees = YearOfFee.where("academic_year = ? && grade = ?", 
         params[:academic_year], params[:grade])
      end 
     end
   desc "Create a New Year of Fee"
   params do
     optional :academic_year, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
     optional :grade, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
     optional :fee_amount, type: String , documentation: { param_type: 'body', post_body: "body" }, default: ""
     optional :fee_master_id, type:String, documentation: { param_type: 'body', post_body: "body" }, default: ""
     optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
   end
   post '/create', http_codes: [
    { code: 200, message: 'Success', model: CashFlow::V1::Entities::YearOfFee},
    { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
    { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
  ] do
        YearOfFee.create({
       academic_year:params[:academic_year],
       grade:params[:grade],
       fee_amount:params[:fee_amount],
       fee_master_id:params[:fee_master_id]
       })
     end
   
    desc "Delete an Year Of Fee"
    params do
    requires :id, type: String
    optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 

  end
  delete '/delete' do
 YearOfFee.find(params[:id]).destroy!
  end
  
  desc "update an Year Of Fee"
  params do
     requires :year_of_fees_id, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
     optional :academic_year, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
     optional :grade, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
     optional :fee_amount, type: String , documentation: { param_type: 'body', post_body: "body" }, default: ""
     optional :fee_master_id, type:String, documentation: { param_type: 'body', post_body: "body" }, default: ""
     optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
  end
put '/update', http_codes: [
  { code: 200, message: 'Success', model: CashFlow::V1::Entities::YearOfFee},
  { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
  { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
] do 
  
YearOfFee.find(params[:year_of_fees_id]).update({
 year_of_fees_id:params[:year_of_fees_id],
 academic_year:params[:academic_year],
       grade:params[:grade],
       fee_amount:params[:fee_amount],
       fee_master_id:params[:fee_master_id]
})
 
end
end
end



