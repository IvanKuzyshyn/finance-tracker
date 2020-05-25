class UserStocksController < ApplicationController

  def create
    stock = Stock.find_already_existing(params[:ticker])

    if stock.blank?
      stock = Stock.create_new(params[:ticker])
      stock.save
    end

    UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "New Stock #{stock.name} has been tracked!"

    redirect_to portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first

    user_stock.destroy
    flash[:notice] = "Tracking of #{stock.name} is stopped!"
    redirect_to portfolio_path
  end

end
