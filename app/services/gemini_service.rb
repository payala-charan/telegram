class GeminiService
  include HTTParty
  base_uri "https://generativelanguage.googleapis.com/v1/models"

  def initialize(message)
    @message = message
    @api_key = ENV["GEMINI_API_KEY"]
  end

  def call
    response = self.class.post(
      "/gemini-2.0-flash:generateContent?key=#{@api_key}",
      headers: { "Content-Type" => "application/json" },
      body: {
        contents: [
          {
            parts: [
              { text: @message }
            ]
          }
        ]
      }.to_json
    )

    if response.success?
      response["candidates"][0]["content"]["parts"][0]["text"]
    else
      "Sorry, AI is not responding."
    end
  end
end
