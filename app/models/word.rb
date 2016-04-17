class Word
  using WordBasket::StringExtension

  attr_reader :head, :last

  def initialize(name)
    @name = name
    kana = name.hiraganaize.namijilize.seionize
    @head = kana.first
    @last = take_last_kana(kana)
  end

  def length
    @name.length
  end

  private

  def take_last_kana(kana)
    if kana.last == 'ー'
      # NOTE: 最後の文字が長音符（ー）のときは、直前の文字の母音を抽出する
      kana.delete('ー').last.boinize
    else
      # NOTE: それ以外のときは、静音を抽出する
      kana.last
    end
  end
end
