class Card
  # NOTE: 「わ」だけ2枚ある
  CHAR = %w(あ い う え お
            か き く け こ
            さ し す せ そ
            た ち つ て と
            な に ぬ ね の
            は ひ ふ へ ほ
            ま み む め も
            や    ゆ    よ
            ら り る れ ろ
            わ わ)

  def self.all
    # NOTE: インスタンス作りべきか悩んだけど、メリット薄そうなので、ただのStringに
    CHAR
  end
end
