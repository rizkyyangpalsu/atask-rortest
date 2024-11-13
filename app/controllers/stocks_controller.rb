class StocksController < ApplicationController
  # Render all stocks as JSON in the response
  def fetch_stock_data
    StockRapidApi.fetch_stock_data

    stocks = Stock.all

    render json: stocks, status: :ok
  rescue StandardError => e
    render json: { error: "Failed to fetch stock data: #{e.message}" }, status: :unprocessable_entity
  end
end
