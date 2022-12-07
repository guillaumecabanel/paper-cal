# frozen_string_literal: true

require "date"
require "active_support"
require "active_support/core_ext"
require "sinatra"

require_relative "lib/cell"
require_relative "lib/row"
require_relative "lib/month"

get "/" do
  headers "Content-Type" => "text/plain, charset=utf-8"

  month = Month.new(Date.today)
  month.add_event("Xmas", Date.parse("2022-12-25"))
  month.to_s
end
