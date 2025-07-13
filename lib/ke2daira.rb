# frozen_string_literal: true

require_relative "ke2daira/kana2mora"
require_relative "ke2daira/ke2dairanizer"
require_relative "ke2daira/suika_token"
require_relative "ke2daira/version"

# Ke2daira is a library to ke2dairanize
module Ke2daira
  def self.ke2dairanize(fullname)
    @ke2dairanizer ||= Ke2dairanizer.new
    @ke2dairanizer.ke2dairanize(fullname)
  end
end
