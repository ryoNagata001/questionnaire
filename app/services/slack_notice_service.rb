class SlackNoticeService
  def initialize(url, text)
    @url = url
    @text = text
  end

  def notification
    HTTParty.post(url, body: { text: text }.to_json)
  end

  private

    attr_reader :url, :text
end

