# frozen_string_literal: true

require_relative "ke2daira/version"
require "suika"

# Ke2daira is a library to ke2dairanize
module Ke2daira
  SEPARATOR = " "
  private_constant :SEPARATOR

  TAGGER = Suika::Tagger.new
  private_constant :TAGGER

  SuikaToken = Data.define(:surface_form, :pos, :pos_detail1, :pos_detail2, :pos_detail3, :conjugated_type,
    :conjugated_form, :basic_form, :reading, :pronunciation)
  private_constant :SuikaToken

  # Ke2dairanize the givin name
  # @param fullname [String]
  # @return [String] ke2dairanized name
  def self.ke2dairanize(fullname) # rubocop:disable Metrics/AbcSize
    names = fullname.strip.split(SEPARATOR)
    yomis = names.map { |name| to_yomi(name) }

    return yomis[0] if yomis.length == 1

    first_word = yomis[0]
    last_word = yomis[-1]

    # swap first characters of first and last name
    yomis[0] = last_word[0] + first_word[1..]
    yomis[-1] = first_word[0] + last_word[1..]
    yomis.join(SEPARATOR)
  end

  class << self
    private

    # Tokenize the givin sentence
    # @param sentence [String] Japanese text to be tokenized
    # @return [Array<SuikaToken>]
    def tokenize(sentence)
      raw_tokens = TAGGER.parse(sentence)
      raw_tokens.map { |raw_token| raw_token2suikatoken(raw_token) }
    end

    # Convert Suika raw token to SuikaToken
    # @param raw_token [String] Suika raw token
    # @return [SuikaToken]
    def raw_token2suikatoken(raw_token)
      surface_form, rest_raw_token = raw_token.split("\t")
      pos, pos_detail1, pos_detail2, pos_detail3, conjugated_type, conjugated_form,
        basic_form, reading, pronunciation = rest_raw_token.split(",")
      SuikaToken.new(surface_form, pos, pos_detail1, pos_detail2, pos_detail3, conjugated_type,
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
end
