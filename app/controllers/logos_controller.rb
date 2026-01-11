class LogosController < ApplicationController
  before_action :set_logo, only: [:show, :edit, :update, :destroy]

  def index
    @logos = Logo.all
  end

  def show
  end

  def new
    @logo = Logo.new
  end

  def create
    @logo = Logo.new(logo_params)
    if @logo.save
      redirect_to new_logo_path, notice: "Logo uploaded successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @logo.update(logo_params)
      redirect_to @logo, notice: "Logo updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @logo.destroy
    redirect_to logos_path, notice: "Logo deleted!"
  end

  private

  def set_logo
    @logo = Logo.find(params[:id])
  end

  def logo_params
    params.require(:logo).permit(:image)
  end
end