class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def create
    user = find_user
    new_item = user.items.create(item_params)
    render json: new_item, status: :created
  end

  def show
    item = find_user.items.find(params[:id])
    render json: item, status: :ok
  end
    

  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def find_user
    User.find(params[:user_id])
  end

  def not_found_response
    render json: { error: "Resource not found" }, status: :not_found
  end

end
