class OpenaiService
  require 'open-uri'
  require 'fileutils'
  include HTTParty

  DALLE_API_URL = 'https://api.openai.com/v1/images/generations'

  def self.icon_prompt(icon)
    base_prompt = "#{icon.title}の円形のアイコン"

    case icon.taste
    when "cute"
      prompt = "'#{base_prompt}'をアニメスタイルで、可愛らしい表情のキャラクターとして表現する。"
    when "cool"
      prompt = "'#{base_prompt}'をリアリズムで、シャープな輪郭と冷たい色調の背景を持つ印象的なキャラクターとして表現する。"
    when "simple"
      prompt = "'#{base_prompt}'をミニマリズムで、シンプルで洗練されたデザインのキャラクターとして表現する。"
    else
      # 予期しない`taste`値の場合のデフォルトプロンプト
      prompt = "'#{base_prompt}'を多様なスタイルと色で表現する。具体的な描画方法は指定しない。"
    end
    return prompt
  end

  def self.generate_icon_with_dalle3(icon)
    api_key = Rails.application.credentials.chatgpt_api_key
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{api_key}"
    }

    prompt= icon_prompt(icon)

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
      image_url = generate_icon_with_dalle3(prompt)
      file = URI.open(image_url)
      # 現在のタイムスタンプをフォーマットして取得
      timestamp = Time.now.strftime("%Y%m%d_%H%M%S")

      # ファイル名にタイムスタンプを追加
      filename = "icon_#{timestamp}.webp"

      blob = ActiveStorage::Blob.create_and_upload!(
        io: file,
        filename: filename,
        content_type: 'image/webp'
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