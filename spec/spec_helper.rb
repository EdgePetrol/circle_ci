# frozen_string_literal: true

require 'pathname'
ROOT = Pathname.new(File.expand_path('..', __dir__))
$:.unshift("#{ROOT}lib")
$:.unshift("#{ROOT}spec")

require 'bundler/setup'

require 'rspec'

require 'simplecov'
require 'simplecov-json'
require 'simplecov-shield-json'

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::JSONFormatter,
    SimpleCov::Formatter::ShieldJSONFormatter
  ]
)
SimpleCov.start do
  add_filter 'spec'
end

# Use coloured output, it's the best.
RSpec.configure do |config|
  config.filter_gems_from_backtrace 'bundler'
  config.color = true
  config.tty = true
end
