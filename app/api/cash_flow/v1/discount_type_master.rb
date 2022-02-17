class CashFlow::V1::DiscountTypeMaster < Grape::API
	include CashFlow::V1::Defaults
  helpers CashFlow::V1::Helpers::SharedParams


	resource :discount_type_masters do    
    desc "Search by dis_feetype_id or dis_feetype_name, it renders associated discount_type_masters data"
    params do 
    optional :dis_feetype_id, type: String, default: ""
    optional :dis_feetype_name, type: String, default: ""
    optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
    end
    get '/search', http_codes: [
      { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
      { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
    ]do
     if params[:dis_feetype_id] or params[:dis_feetype_name].present?
        discount_type_masters = DiscountTypeMaster.where("dis_feetype_id = ? OR dis_feetype_name= ?", 
        params[:dis_feetype_id], params[:dis_feetype_name])
     end 
    end
    desc 'discount_type_master show all API' do
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
      total = DiscountTypeMaster.count
      discount_type_masters = DiscountTypeMaster.page(params[:page]).per(params[:per_page])
      
      present :status, 200
      present :page, params[:page]
      present :per_page, params[:per_page]      
      present :total_records, total
      present :total_page, get_total_pages_count(total, params[:per_page])
      present :discount_type_masters, discount_type_masters
    end

  
    desc "Create a New Discount Type Master"
    params do
      requires :dis_feetype_name, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
     
      optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
    end
    post '/create', http_codes: [
      { code: 200, message: 'Success', model: CashFlow::V1::Entities::DiscountTypeMaster},
      { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
      { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
    ] do
      DiscountTypeMaster.create({
        dis_feetype_name:params[:dis_feetype_name]
        })
      end
    
     desc "Delete an Discount Type Master"
     params do
     requires :dis_feetype_id, type: Integer
     optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 

   end
   delete '/delete' do
  DiscountTypeMaster.find(params[:dis_feetype_id]).destroy!
   end
   desc "update an Discount Type Master"
   params do
    requires :dis_feetype_id, type: Integer, documentation: { param_type: 'body', post_body: "body" }, default: ""
    requires :dis_feetype_name, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
   optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 

   end
 put '/update', http_codes: [
  { code: 200, message: 'Success', model: CashFlow::V1::Entities::DiscountTypeMaster},
  { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
  { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
] do
DiscountTypeMaster.find(params[:dis_feetype_id]).update({
  dis_feetype_id:params[:dis_feetype_id],
  dis_feetype_name:params[:dis_feetype_name]     
})
  end
 end
end



