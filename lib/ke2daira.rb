# frozen_string_literal: true

require_relative "ke2daira/ke2dairanizer"
require_relative "ke2daira/version"

# Ke2daira is a library to ke2dairanize
module Ke2daira
  SuikaToken = Data.define(:surface_form, :pos, :pos_detail1, :pos_detail2, :pos_detail3, :conjugated_type, :conjugated_form, :basic_form, :reading, :pronunciation)

  def self.ke2dairanize(fullname)
    @ke2dairanizer ||= Ke2dairanizer.new
    @ke2dairanizer.ke2dairanize(fullname)
  end
end
