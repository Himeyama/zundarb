# frozen_string_literal: true

require 'net/http'
require 'json'
require 'uri'
require 'win32/sound'
require 'digest'
require 'fileutils'
require 'socket'
require 'optparse'
require_relative 'zundarb/version'

# Zundarb class
class Zundarb
  # class Error < StandardError; end
  # Your code goes here...

  def auto_host
    return if @host

    hostname = Socket.gethostname unless @host
    hosts = Socket.getaddrinfo(hostname, nil)
    hosts.each do |host|
      @host = host[3] if host[3] =~ /^192\.168\./
    end
  end

  def query(text, verbose: false, speaker_id: 1, volume: 0.15, speed: 1.25)
    @volume = volume || 0.15
    @speed = speed || 1.25
    @speaker_id = speaker_id || 1
    auto_host
    @text = text
    @enc_text = URI.encode_www_form_component(text)
    uri = URI("http://#{@host}:50021/audio_query?speaker=#{@speaker_id}&text=#{@enc_text}")
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
    auto_host
    uri = URI("http://#{@host}:50021/synthesis")
    params = {
      speaker: @speaker_id.to_s
    }
    uri.query = URI.encode_www_form(params)
    req = Net::HTTP::Post.new(uri)
    req.content_type = 'application/json'
    @query_body['volumeScale'] = @volume
    @query_body['speedScale'] = @speed
    req.body = JSON.pretty_generate(@query_body)
    @md5_text = Digest::MD5.hexdigest(@text)
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

    FileUtils.mkdir_p('voice')
    @filename = "voice/#{@md5_text}.wav"
    File.open(@filename, 'wb') do |f|
      f.print res.body
    end
  end

  def play
    Win32::Sound.play(@filename)
  end

  attr_accessor :host
end
