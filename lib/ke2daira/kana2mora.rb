# frozen_string_literal: true

module Ke2daira::Kana2Mora
  SUTEKANA = Set["ァ", "ィ", "ゥ", "ェ", "ォ", "ャ", "ュ", "ョ", "ヮ"]

  # converts Katakana into a list of mora.
  def self.katakana2mora(katakana)
    chars = katakana.chars
    moras = []
    chars.each do |char|
      if SUTEKANA.include?(char)
        previous_char = moras.pop || ""
        mora = previous_char + char
        moras << mora
        next
      end
      moras << char
    end
    moras
  end
end
