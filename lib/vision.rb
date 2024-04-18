require "base64"
require "json"
require "net/https"

module Vision
  class << self
    def image_analysis(icon_file)
      #APIキーの取得
      vision_api_key = Rails.application.credentials.vision_api_key

      #APIキーを使ったURL
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{vision_api_key}"



      #icon_fileの一時的保存先から読み出しBase64 形式にエンコードする
      base64_image = Base64.encode64(icon_file.tempfile.read)

      #VisionAPIに送信するためのjson形式のパタメーターの設定
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: "SAFE_SEARCH_DETECTION"
            }
          ]
        }]
      }.to_json


      #URIオブジェクトの生成
      uri = URI.parse(api_url)
      #HTTP接続の初期化
      https = Net::HTTP.new(uri.host, uri.port)
      #SSL/TLSを使用することを指定(セキュリティ)
      https.use_ssl = true

      #postリクエストの作成
      request = Net::HTTP::Post.new(uri.request_uri)
      request["Content-Type"] = "application/json"

      #リクエストの送信とレスポンス
      response = https.request(request, params)
      #レスポンスのbodyの変換
      result = JSON.parse(response.body)

      #"LIKELY"か"VERY_LIKELY"の判定を受けるとfalseを返す
      if result["responses"].nil? || result["responses"].empty?
        raise "No responses or empty response received from the API."
      elsif (error = result["responses"][0]["error"]) && error.present?
        raise error["message"]
      else
        result_arr = result["responses"].flatten.map do |parsed_image|
          parsed_image["safeSearchAnnotation"].values
        end.flatten
        if result_arr.include?("LIKELY") || result_arr.include?("VERY_LIKELY")
          false
        else
          true
        end
      end
    end
  end
end