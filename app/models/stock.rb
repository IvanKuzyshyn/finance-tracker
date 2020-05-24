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
end
