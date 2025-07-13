# frozen_string_literal: true

require "suika"

class Ke2daira::Ke2dairanizer
  def initialize(tagger: ::Suika::Tagger.new, separator: " ")
    @tagger = tagger
    @separator = separator
  end

  attr_reader :tagger, :separator

  # Ke2dairanize the givin name
  # @param fullname [String]
  # @return [String] ke2dairanized name
  def ke2dairanize(fullname) # rubocop:disable Metrics/AbcSize
    names = fullname.strip.split(separator)
    yomis = names.map { |name| to_yomi(name) }

    return yomis[0] if yomis.length == 1

    first_word_moras = ::Ke2daira::Kana2Mora.katakana2mora(yomis[0])
    first_word_head = first_word_moras[0]
    first_word_tail = first_word_moras[1..]

    last_word_moras = ::Ke2daira::Kana2Mora.katakana2mora(yomis[-1])
    last_word_head = last_word_moras[0]
    last_word_tail = last_word_moras[1..]

    new_first_word = last_word_head + first_word_tail.join
    new_last_word = first_word_head + last_word_tail.join

    yomis[0] = new_first_word
    yomis[-1] = new_last_word
    yomis.join(separator)
  end

  private

  # Tokenize the givin sentence
  # @param sentence [String] Japanese text to be tokenized
  # @return [Array<SuikaToken>]
  def tokenize(sentence)
    raw_tokens = tagger.parse(sentence)
    raw_tokens.map { |raw_token| raw_token2suikatoken(raw_token) }
  end

  # Convert Suika raw token to SuikaToken
  # @param raw_token [String] Suika raw token
  # @return [SuikaToken]
  def raw_token2suikatoken(raw_token)
    surface_form, rest_raw_token = raw_token.split("\t")
    pos, pos_detail1, pos_detail2, pos_detail3, conjugated_type, conjugated_form,
      basic_form, reading, pronunciation = rest_raw_token.split(",")
    Ke2daira::SuikaToken.new(surface_form, pos, pos_detail1, pos_detail2, pos_detail3, conjugated_type,
      conjugated_form, basic_form, reading, pronunciation)
  end

  # Convert the givin word to its reading
  # @param word [String] a Japanese word
  # @return [String] reading of the word
  def to_yomi(word)
    tokens = tokenize(word)
    # fallback to the surface form when the reading is missing
    tokens.map do |token|
      token.reading || token.surface_form
    end.join
  end
end
