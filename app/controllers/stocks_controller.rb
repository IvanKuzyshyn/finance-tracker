class StocksController < ApplicationController

  def search
    stock_symbol = params[:stock]

    if stock_symbol.present?
      render_stock_search_result(stock_symbol)
    else
      render_no_stock_provided
    end
  end

  private

  def render_stock_search_result(stock_symbol)
    client = Stock.client
    begin
      @stock = Stock.new(
          name: client.company(stock_symbol).company_name,
          ticker: stock_symbol,
          last_price: client.price(stock_symbol)
      )

      render "users/portfolio"
    rescue
      flash[:alert] = "Please provide valid Stock name"
      redirect_to portfolio_path
    end
  end

  def render_no_stock_provided
    flash[:alert] = "Please provide Stock name"
    redirect_to portfolio_path
  end
end
