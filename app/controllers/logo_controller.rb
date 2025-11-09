class LogoController < ApplicationController
    def new
        @logo = Logo.new
    end

    def create 
        @logo = Logo.first_or_initialize
        @logo.image.purge if @logo.image.attached
        @logo.image.attach(params[:logo][:image])
        @logo.save
        redirect_to logo_new_path, notice: "logo uploaded!"
    end
    def show
        @logo = Logo.first
    end

end
