class Api::V1::TasksController < ApplicationController
  before_action :authorize_request
  before_action :set_task, only: %i[show update destroy]

  # GET /api/v1/tasks
  def index
    @tasks = current_user.tasks
    render json: @tasks
  end

  # GET /api/v1/tasks/:id
  def show
    render json: @task
  end

  # POST /api/v1/tasks
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      render json: @task, status: :created, location: api_v1_task_url(@task)
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tasks/:id
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tasks/:id
  def destroy
    @task.destroy
    head :no_content
  end

  private

  # Ensure task belongs to current_user
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    render json: { error: 'Not found' }, status: :not_found unless @task
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed, :category, :due_date)
  end
end
