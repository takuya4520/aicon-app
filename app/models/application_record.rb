class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def title_cannot_contain_blacklist_words
    # 環境変数からブラックリストの単語を取得し、配列に変換
    blacklist = ENV['BLACKLIST_WORDS'].to_s.split(',')

    # titleが空でなく、titleの中にblacklistの用語が含まれているかをチェック
    title_words = title.downcase.split(/\s+/)
    if title.present? && blacklist.any? { |word| title_words.include?(word.downcase.strip) }
      errors.add(:title, "不適切な言葉は使用できません")
    end
  end

end
