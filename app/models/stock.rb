class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.client
    IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iex_client[:publishable_token],
        secret_token: Rails.application.credentials.iex_client[:secret_token],
        endpoint: 'https://sandbox.iexapis.com/v1'
    )
  end

  def self.create_new(ticker)
    new(
        name: client.company(ticker).company_name,
        ticker: ticker,
        last_price: client.price(ticker)
    )
  end

  def self.find_already_existing(ticker)
    where(ticker: ticker).first
  end
end
