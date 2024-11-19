class Telegram::Base
  def initialize
    @telegram_api = ENV['TELEGRAM_API_URL'] || 'https://api.telegram.org'
  end

  def send_message(text, token, chat_id, use_parse_mode = false)
    payload = { chat_id: chat_id, text: text }
    payload.merge!({ parse_mode: 'MarkdownV2' }) if use_parse_mode
    begin
      HTTParty.post("#{@telegram_api}/bot#{token}/sendMessage", body: payload.to_json, headers: headers).parsed_response
    rescue StandardError => e
      {}
    end
  end

  private

  def headers
    { 'Content-Type': 'application/json' }
  end
end
