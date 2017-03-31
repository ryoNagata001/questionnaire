class SlackNoticeService
  def initialize(url, comment)
    @url = url
    @comment = comment
  end

  def notification
    HTTParty.post(url, body: { "text": comment }.to_json)
  end

  private

    attr_reader :url, :comment
end
