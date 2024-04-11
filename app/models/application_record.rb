class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def title_cannot_contain_blacklist_words
    #blacklist.ymlから不適切な言葉を読み取る
    blacklist = YAML.load_file('./config/blacklist.yml')
    #titleが空でなく、titleの中にblacklistの用語が含まれているかを追加
    if title.present? && blacklist.any?{ |word| title.include?(word) }
      errors.add(:contain_blacklist_words, ": 不適切な言葉は使用できません")
# エラー時「title_blacklist_words　: 不適切な言葉は使用できません」と表示される。
    end
  end
end
