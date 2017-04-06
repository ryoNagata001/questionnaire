module API
  class Root < Grape::API
    # http://localhost:3000/api/
    # Rootクラスのpathを定義する
    prefix 'api'

  # API::RootにAPI::V1::Rootをマウントしている
    mount API::Ver1::Root
    #mount API::Ver2::Root
  end
end
