# frozen_string_literal: true

require 'net/http'

# Wrapper around circle ci api
class CircleCiWrapper
  CIRCLE_CI_API_URL = 'https://circleci.com/api/v1.1/project/github'

  def self.report_urls_by_branch(branch_name, build_name = 'build')
    url = "#{base_url}/tree/#{branch_name}?circle-token=#{ENV['CIRCLE_TOKEN']}&limit=6&filter=completed"

    return nil if Net::HTTP.get_response(URI.parse(url)).code != '200'

    latest_build_num = latest_build(url, build_name)

    return nil unless latest_build_num

    [
      report_url("#{base_url}/#{ENV['CIRCLE_BUILD_NUM']}/artifacts?circle-token=#{ENV['CIRCLE_TOKEN']}"),
      report_url("#{base_url}/#{latest_build_num}/artifacts?circle-token=#{ENV['CIRCLE_TOKEN']}", branch_name)
    ]
  end

  def self.report_url(url, branch_name = nil)
    return nil if Net::HTTP.get_response(URI.parse(url)).code != '200'

    artifacts = JSON.parse(URI.parse(url).read).map { |a| a['url'] }

    coverage_url = artifacts.find { |artifact| artifact&.end_with?('coverage/coverage.json') }

    return nil unless coverage_url

    "#{coverage_url}?circle-token=#{ENV['CIRCLE_TOKEN']}&branch=#{branch_name}"
  end

  def self.base_url
    "#{CIRCLE_CI_API_URL}/#{ENV['CIRCLE_PROJECT_USERNAME']}/#{ENV['CIRCLE_PROJECT_REPONAME']}"
  end

  def self.latest_build(url, build_name)
    JSON.parse(URI.parse(url).read).select do |build|
      build&.[]('build_parameters')&.[]('CIRCLE_JOB') == build_name
    end&.first&.[]('build_num')
  end
end
