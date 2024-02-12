class OpenaiService
  require 'open-uri'
  require 'fileutils'
  include HTTParty

  DALLE_API_URL = 'https://api.openai.com/v1/images/generations'

  def self.generate_image_with_dalle3(prompt)
    api_key = Rails.application.credentials.chatgpt_api_key
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{api_key}"
    }

    body = {
      model: "dall-e-3",
      prompt: "#{prompt}",
      n: 1,
      size: "1024x1024"
    }

    response = HTTParty.post(DALLE_API_URL, body: body.to_json, headers: headers, timeout: 100)
    raise response['error']['message'] unless response.code == 200

    response['data'][0]['url']
  end

  def self.download_image(prompt)
    begin
      image_url = generate_image_with_dalle3(prompt)
      file = URI.open(image_url)
      
      blob = ActiveStorage::Blob.create_and_upload!(
        io: file,
        filename: file.base_uri.to_s.split('/').last,
        content_type: 'image/png'
      )

      file.close
      blob.key
    rescue StandardError => e
      Rails.logger.error "Image download failed: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      nil
    end
  end
end