class Api::V1::BudgetItemsController < ApplicationController
  before_action :set_budget_item, only: [:show, :update, :destroy]
  before_action :authorize_request

  def index
    @budget_items = BudgetItem.all
    render json: @budget_items
  end

  def show
    render json: @budget_item
  end

  def create
    @budget_item = BudgetItem.new(budget_item_params)
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
    @budget_item = BudgetItem.find(params[:id])
  end

  def budget_item_params
    params.require(:budget_item).permit(:title, :amount, :category, :date, :notes)
  end
end
