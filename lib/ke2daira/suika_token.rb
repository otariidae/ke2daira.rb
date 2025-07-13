# frozen_string_literal: true

module Ke2daira
  SuikaToken = Data.define(:surface_form, :pos, :pos_detail1, :pos_detail2, :pos_detail3, :conjugated_type, :conjugated_form, :basic_form, :reading, :pronunciation) do
    # Convert Suika raw token to SuikaToken
    # @param raw_token [String] Suika raw token
    # @return [SuikaToken]
    def self.from_raw_token(raw_token)
      surface_form, rest_raw_token = raw_token.split("\t")
      pos, pos_detail1, pos_detail2, pos_detail3, conjugated_type, conjugated_form, basic_form, reading, pronunciation = rest_raw_token.split(",")
      new(surface_form, pos, pos_detail1, pos_detail2, pos_detail3, conjugated_type, conjugated_form, basic_form, reading, pronunciation)
    end
  end
end
