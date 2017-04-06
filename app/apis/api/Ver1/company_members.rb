module API
  module Ver1
    class CompanyMembers < Grape::API
      # `companies`resource配下にすることで
      # /api/v1/companiesのapiとしてアクセスできる
      resource :companies do

        # GET /api/v1/companies/{:company_id}
        desc 'Return number of company members'
        params do
          requires :company_id, type: Integer, desc: 'company id'
        end
        get '/' do
          company = Company.find(params[:company_id])
          render company, serializer: CompanySerializer
        end

      end
    end
  end
end
