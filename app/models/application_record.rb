class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def title_cannot_contain_blacklist_words
    # 環境変数からブラックリストの単語を取得し、配列に変換
    blacklist = ENV['BLACKLIST_WORDS'].to_s.split(',')
    # titleが空でなく、titleの中にblacklistの用語が含まれているかをチェック
    if title.present? && blacklist.any?{ |word| title.include?(word) }
      errors.add(:contain_blacklist_words, ": 不適切な言葉は使用できません")
    end
  end
end
