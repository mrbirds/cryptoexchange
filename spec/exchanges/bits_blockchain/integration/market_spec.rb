require 'spec_helper'

RSpec.describe 'Bits Blockchain integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:atmc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ATMC', target: 'usd', market: 'bits_blockchain') }

  it 'fetch pairs' do
    pairs = client.pairs('bits_blockchain')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bits_blockchain'
  end

  it 'fetch ticker' do
    ticker = client.ticker(atmc_usd_pair)

    expect(ticker.base).to eq 'ATMC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'bits_blockchain'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(atmc_usd_pair)

    expect(order_book.base).to eq 'ATMC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'bits_blockchain'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be >= 1
    expect(order_book.bids.count).to be >= 1
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
