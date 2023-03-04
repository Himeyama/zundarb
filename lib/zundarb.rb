# frozen_string_literal: true

require 'net/http'
require 'json'
require 'uri'
require_relative 'zundarb/version'

# Zundarb class
class Zundarb
  # class Error < StandardError; end
  # Your code goes here...

  def query(text, verbose: false)
    @text = text
    @enc_text = URI.encode_www_form_component(text)
    uri = URI("http://#{@host}:50021/audio_query?speaker=1&text=#{@enc_text}")
    req = Net::HTTP::Post.new(uri)
    req_options = {
      use_ssl: uri.scheme == 'https'
    }
    res = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(req)
    end
    @query_code = res.code
    @query_body = JSON.parse(res.body)
    puts JSON.pretty_generate(@query_body) if verbose
  end

  def wave
    uri = URI("http://#{@host}:50021/synthesis")
    params = {
      speaker: '1'
    }
    uri.query = URI.encode_www_form(params)

    req = Net::HTTP::Post.new(uri)
    req.content_type = 'application/json'

    # req.body = File.read('query.json').delete("\n")
    req.body = JSON.pretty_generate(@query_body)

    req_options = {
      use_ssl: uri.scheme == 'https'
    }
    res = Net::HTTP.start(
      uri.hostname,
      uri.port,
      req_options
    ) do |http|
      http.request(req)
    end

    File.open('hello.wav', 'wb') do |f|
      f.print res.body
    end
  end

  attr_accessor :host
end
