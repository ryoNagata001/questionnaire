module API
  module Ver1
    class Root < Grape::API
      # http://localhost:3000/api/v1/
      # versionを定義することでhttp://[host]/api/v1のpathを構成できる
      version 'v1'
      # formatでAPIのレスポンスデータのフォーマットをjsonに指定しています
      format :json

      mount API::Ver1::CompanyMembers
    end
  end
end
