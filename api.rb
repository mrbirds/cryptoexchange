#!/usr/bin/env ruby

require 'bundler/setup'
require 'cryptoexchange'
require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
    client = Cryptoexchange::Client.new
    result = Hash.new
    result["pairs"] = Array.new 
    pairs = client.pairs(params[:dce])
    pairs.each {|p|
        result['pairs'] << { 'symbol' => p.base + '-' +p.target}
    }
    result.to_json
end

get '/ticker' do
    client = Cryptoexchange::Client.new
    result = Hash.new
    result['ticker'] = Array.new
    pair = Cryptoexchange::Models::MarketPair.new(base: params[:base], target: params[:target], market: params[:market])
    ticker = client.ticker(pair)
    result['ticker'] << {
        'last' => ticker.last.to_f,
        'bid' => ticker.bid.to_f,
        'ask' => ticker.ask.to_f,
        'high' => ticker.high.to_f,
        'low' => ticker.low.to_f,
        'change' => ticker.change.to_f,
        'volume' => ticker.volume.to_f
    }
    result.to_json
end    
