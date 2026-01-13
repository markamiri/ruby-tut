class LogosController < ApplicationController
  def new
    @logo = Logo.first_or_create!
  end

  def create
    @logo = Logo.create!
    attach_image(@logo)
    redirect_to new_logo_path, notice: "Logo uploaded!"
  end

  def update
    @logo = Logo.first
    attach_image(@logo)
    redirect_to new_logo_path, notice: "Logo updated!"
  end

  def destroy
    Logo.first&.destroy
    redirect_to new_logo_path, notice: "Logo deleted!"
  end

  private

  def attach_image(logo)
    logo.image.purge if logo.image.attached?
    logo.image.attach(logo_params[:image])
  end

  def logo_params
    params.require(:logo).permit(:image)
  end
end