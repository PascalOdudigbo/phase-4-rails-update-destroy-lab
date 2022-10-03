class PlantsController < ApplicationController
  wrap_parameters format: []
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  #PATCH /plants/:id
  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant, status: :accepted
  end

   #DELETE /plants/:id
  def destroy
    plant = find_plant
    plant.destroy
    render json: {}, status: :no_content
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
    Plant.find_by(id: params[:id])
  end

  def render_record_not_found
    render json: {error: "plant not found"}, status: :not_found
  end
end
