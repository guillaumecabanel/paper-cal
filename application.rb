# frozen_string_literal: true

require "date"
require "active_support"
require "active_support/core_ext"
require "sinatra"

require_relative "lib/cell"
require_relative "lib/row"
require_relative "lib/month"

get "/" do
  redirect "/#{Date.today}", 303
end

get "/:date" do
  date = Date.parse(params["date"])
  headers "Content-Type" => "text/plain, charset=UTF-8"
  headers "X_NEXT_MONTH_URI" => "/#{date.next_month}"
  headers "X_PREVIOUS_MONTH_URI" => "/#{date.prev_month}"

  month = Month.new(date)
  month.to_s
end
