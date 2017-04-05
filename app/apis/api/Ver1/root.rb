module API
  module Ver1
    class Root < Grape::API
      # http://localhost:3000/api/v1/
      # versionを定義することでhttp://[host]/api/v1のpathを構成できる
      version 'v1'
      # formatでAPIのレスポンスデータのフォーマットをjsonに指定しています
      format :json

      # Use ActiveModelSerializers
      use Grape::Middleware::Globals
      require 'grape/active_model_serializers'
      include Grape::ActiveModelSerializers
      formatter :json, Grape::Formatters::ActiveModelSerializers

      mount API::Ver1::CompanyMembers
    end
  end
end
