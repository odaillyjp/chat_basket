module WordBasket
  module StringExtension
    refine String do
      # NOTE: 「カタカナ」を「ひらがな」に変換する
      def hiraganaize
        self.tr('ァ-ン', 'ぁ-ん')
      end

      # NOTE: 濁点や半濁点を清音に変換する
      def seionize
        self.chars.map { |char| char.to_nfd.split('').first }.join
      end

      # NOTE: 捨て仮名をナミ字に変換する（「カタカナ」は未対応）
      def namijilize
        sutegana = 'ぁぃぅぇぉっゃゅょゎ'
        namiji   = 'あいうえおつやゆよわ'

        self.tr(sutegana, namiji)
      end

      # NOTE: 母音に変換する（「カタカナ」は未対応）
      def boinize
        char_maps = {
          %w(あ か さ た な は ま や ら わ) => 'あ',
          %w(い き し ち に ひ み    り   ) => 'い',
          %w(う く す つ ぬ ふ む ゆ る   ) => 'う',
          %w(え け せ て ね へ め    れ   ) => 'え',
          %w(お こ そ と の ほ も よ ろ   ) => 'お'
        }

        str = self

        char_maps.each do |chars, boin|
          str = str.gsub(/[#{chars.join}]/, boin)
        end

        str
      end
    end
  end
end
