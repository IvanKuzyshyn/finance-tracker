class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker)
    stock = Stock.find_already_existing(ticker)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stocks_limit?
    stocks.count < 5
  end

  def can_track_stocks?(ticker)
    under_stocks_limit? && !stock_already_tracked?(ticker)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
