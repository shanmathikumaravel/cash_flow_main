class CashFlow::V1::FeeMaster < Grape::API
	include CashFlow::V1::Defaults
  helpers CashFlow::V1::Helpers::SharedParams


	resource :fee_master do    

    desc "Search by fee_master_id or fee_type_name or order_id, it renders associated fee_master data"
    params do 
    optional :fee_master_id, type: String, default: ""
    optional :fee_type_name, type: String, default: ""
    optional :order_id, type: String, default: ""
    optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
    end
    get '/search', http_codes: [
      { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
      { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
    ]do
     if params[:fee_master_id] or params[:fee_type_name] or params[:order_id].present?
        fee_masters = FeeMaster.where("fee_master_id = ? OR fee_type_name= ? OR order_id = ?", 
        params[:fee_master_id], params[:fee_type_name], params[:order_id])
     end 
    end
  

      desc "Show all Fee Master"
      params do 
        use :pagination
        optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
      end
      get '/show_all',http_codes: [
        { code: 200, message: 'Success', model: CashFlow::V1::Entities::FeeMaster},
        { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
        { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
      ] do
      total = FeeMaster.count
      fee_masters = FeeMaster.page(params[:page]).per(params[:per_page])
      
      present :status, 200
      present :page, params[:page]
      present :per_page, params[:per_page]      
      present :total_records, total
      present :total_page, get_total_pages_count(total, params[:per_page])
      present :fee_masters, fee_masters
      end
    
      
    desc "Create a Fee Master"
    params do
      requires :academic_year, type: String, documentation: { param_type: 'body', post_body: "body"}, default: ""
      requires :fee_type_name, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
      optional :order_id, type: Integer, documentation: { param_type: 'body', post_body: "body" }, default: ""
      optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
    end
    post '/create', http_codes: [
      { code: 200, message: 'Success', model: CashFlow::V1::Entities::FeeMaster},
      { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
      { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
    ] do
      FeeMaster.create({
        academic_year:params[:academic_year],
        fee_type_name:params[:fee_type_name],
        order_id:params[:order_id]
        })
      end
    
     desc "Delete an Fee Master"
     params do
     requires :id, type: String, default: ""
     optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 
   end
   delete '/delete' do
  FeeMaster.find(params[:id]).destroy!
   end
   desc "update an Fee Master"
   params do
    requires :fee_master_id, type: Integer, documentation: { param_type: 'body', post_body: "body" }, default: ""
      requires :fee_type_name, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
      requires :order_id, type: String, documentation: { param_type: 'body', post_body: "body" }, default: ""
   optional :Authorization, type: String, documentation: { param_type: 'header' }, default: "" 

   end
 put '/update', http_codes: [
  { code: 200, message: 'Success', model: CashFlow::V1::Entities::FeeMaster},
  { code: 422, message: 'Validation Errors', model: CashFlow::V1::Entities::ApiValidationError },
  { code: 500, message: 'Internal Server Error', model: CashFlow::V1::Entities::ApiError}
] do
  FeeMaster.find(params[:fee_master_id]).update({
  fee_master_id:params[:fee_master_id],
  order_id:params[:order_id],
  fee_type_name:params[:fee_type_name]     
})
  end
end
end

