# frozen_string_literal: true

require 'zundarb'

z = Zundarb.new
z.host = '192.168.0.14'
z.query('こんにちは、ずんだもんなのだ')
z.wave
