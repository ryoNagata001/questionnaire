module API
  module Ver1
    class CompanyMembers < Grape::API
      resource :company_members do

        # GET /api/v1/company_members/{:company_id}
        desc 'Return number of company members'
        params do
          requires :company_id, type: Integer, desc: 'company id'
        end
        get ':company_id' do
          company = Company.find(params[:company_id])
          company.users.count
        end

      end
    end
  end
end
