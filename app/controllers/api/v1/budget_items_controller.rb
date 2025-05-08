class Api::V1::BudgetItemsController < ApplicationController
  before_action :authorize_request
  before_action :set_budget_item, only: [:show, :update, :destroy]

  def index
    @budget_items = current_user.budget_items

    # Calculate total budgeted and total spent
    total = @budget_items.sum(:amount)
    spent = @budget_items.where("amount < 0").sum(:amount).abs # Assuming you have a 'spent' field to track actual spending

    # Render the budget items along with summary info
    render json: {
      budget_items: @budget_items,
      total: total.to_s,
      spent: spent.to_s
    }
  end

  def show
    render json: @budget_item
  end

  def create
    @budget_item = current_user.budget_items.build(budget_item_params)
    if @budget_item.save
      render json: @budget_item, status: :created
    else
      render json: @budget_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @budget_item.update(budget_item_params)
      render json: @budget_item
    else
      render json: @budget_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @budget_item.destroy
    head :no_content
  end

  private

  def set_budget_item
    @budget_item = current_user.budget_items.find_by(id: params[:id])
    render json: { error: 'Not found' }, status: :not_found unless @budget_item
  end

  def budget_item_params
    params.require(:budget_item).permit(:title, :income, :category, :date, :notes, :spent) # Added `spent` as an expected parameter
  end
end
