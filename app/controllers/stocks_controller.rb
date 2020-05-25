class StocksController < ApplicationController

  def search
    stock_symbol = params[:stock]

    if stock_symbol.present?
      render_stock_search_result(stock_symbol)
    else
      render_flash_error("Stock name should not be empty")
    end
  end

  private

  def render_stock_search_result(stock_symbol)
    begin
      @stock = Stock.create_new(stock_symbol)

      if @stock
        respond_to do |format|
          format.js { render partial: "users/stock_search_result" }
        end
      end
    rescue
      render_flash_error("Please provide valid Stock name")
    end
  end

  def render_flash_error(message)
    flash.now[:alert] = message
    respond_to do |format|
      format.js { render partial: "users/stock_search_result" }
    end
  end
end
