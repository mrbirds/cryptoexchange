module Cryptoexchange::Exchanges
  module Bigone
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output["data"])
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bigone::Market::API_URL}/asset_pairs/#{market_pair.base.upcase}-#{market_pair.target.upcase}/ticker"
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bigone::Market::NAME
          ticker.last      = NumericHelper.to_d(output['close'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(HashHelper.dig(output, 'bid', 'price'))
          ticker.ask       = NumericHelper.to_d(HashHelper.dig(output, 'ask', 'price'))
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.change    = NumericHelper.to_d(output['daily_change'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
