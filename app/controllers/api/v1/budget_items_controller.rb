class Api::V1::BudgetItemsController < ApplicationController
  before_action :authorize_request
  before_action :set_budget_item, only: [:show, :update, :destroy]

  def index
    @budget_items = current_user.budget_items

    total_income = @budget_items.sum(:income)
    total_spent = @budget_items.sum(:spent) # spent should always be stored as negative
    total = @budget_items.sum(COALESCE(income, 0) + COALESCE(spent, 0))

    render json: {
      budget_items: @budget_items,
      total_income: total_income.to_s,
      total_spent: total_spent.to_s
      total: total
    }
  end

  def show
    render json: @budget_item
  end

  def create
    # Ensure spent is stored as negative if provided
    if budget_item_params[:spent].present?
      spent_value = -budget_item_params[:spent].to_f.abs
      updated_params = budget_item_params.merge(spent: spent_value)
    else
      updated_params = budget_item_params
    end

    @budget_item = current_user.budget_items.build(updated_params)

    if @budget_item.save
      render json: @budget_item, status: :created
    else
      render json: @budget_item.errors, status: :unprocessable_entity
    end
  end

  def update
    # Ensure spent stays negative
    if budget_item_params[:spent].present?
      updated_params = budget_item_params.merge(spent: -budget_item_params[:spent].to_f.abs)
    else
      updated_params = budget_item_params
    end

    if @budget_item.update(updated_params)
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
    params.require(:budget_item).permit(:title, :income, :spent, :category, :date, :notes)
  end
end
