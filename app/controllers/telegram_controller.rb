class TelegramController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    Rails.logger.info "🔥 TELEGRAM WEBHOOK HIT 🔥"
    Rails.logger.info params.inspect
    message = params.dig(:message, :text)
    chat_id = params.dig(:message, :chat, :id)

    return head :ok unless message.present?

    # Call Gemini
    ai_response = GeminiService.new(message).call

    send_message(chat_id, ai_response)

    head :ok
  end

  private

  def send_message(chat_id, text)
    token = ENV["TELEGRAM_BOT_TOKEN"]

    HTTParty.post(
      "https://api.telegram.org/bot#{token}/sendMessage",
      body: {
        chat_id: chat_id,
        text: text
      }
    )
  end
end
