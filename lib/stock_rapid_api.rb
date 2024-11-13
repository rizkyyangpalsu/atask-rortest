require 'net/http'
require 'json'

module StockRapidApi
  API_URL = "https://latest-stock-price.p.rapidapi.com/"

  def self.fetch_stock_data(symbol = nil, all = false)
    Rails.logger.info "asdasd"

    uri = URI("#{API_URL}/latest-stock-price")
    request = Net::HTTP::Get.new(uri)
    request['x-rapidapi-host'] = 'latest-stock-price.p.rapidapi.com'
    request['x-rapidapi-key'] = 'a4ad6d50d7msh623a2f84cb24a4ep1fba51jsnc252b1b11e82'

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      stock_data = JSON.parse(response.body)
      Rails.logger.pretty_print(stock_data)
      stock_data.each do |data|
        # Use 'symbol' as the unique identifier if 'identifier' is missing or nil
        identifier = data['symbol']

        # Find or create the stock by identifier (symbol if identifier is missing)
        stock = Stock.find_or_create_by(identifier: identifier)

        # Update stock attributes, using default values for missing fields
        stock.update(
          identifier: data['symbol'] || '',
          change: data['change'] || 0,
          day_high: data['dayHigh'] || 0,
          day_low: data['dayLow'] || 0,
          last_price: data['lastPrice'] || 0,
          last_update_time: data['lastUpdateTime'] ? DateTime.parse(data['lastUpdateTime']) : nil,
          open: data['open'] || 0,
          p_change: data['pChange'] || 0,
          per_change_30d: data['perChange30d'] || 0,
          per_change_365d: data['perChange365d'] || 0,
          previous_close: data['previousClose'] || 0,
          symbol: data['symbol'],
          total_traded_value: data['totalTradedValue'] || 0,
          total_traded_volume: data['totalTradedVolume'] || 0,
          year_high: data['yearHigh'] || 0,
          year_low: data['yearLow'] || 0
        )
      end
    else
      Rails.logger.error("Failed to fetch stock data: #{response.message}")
    end
  end
end
